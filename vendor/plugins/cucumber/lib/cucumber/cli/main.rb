require 'optparse'
require 'cucumber'
require 'ostruct'
require 'cucumber/parser'
require 'cucumber/feature_file'
require 'cucumber/formatter/color_io'
require 'cucumber/cli/language_help_formatter'
require 'cucumber/cli/configuration'
require 'cucumber/cli/drb_client'

module Cucumber
  module Cli
    class Main
      FAILURE = 1

      class << self
        def step_mother
          @step_mother
        end

        def step_mother=(step_mother)
          @step_mother = step_mother
          @step_mother.extend(StepMother)
          @step_mother.snippet_generator = StepDefinition
        end

        def execute(args)
          new(args).execute!(@step_mother)
        end
      end

      def initialize(args, out_stream = STDOUT, error_stream = STDERR)
        @args         = args
        @out_stream   = out_stream == STDOUT ? Formatter::ColorIO.new : out_stream
        @error_stream = error_stream
      end

      def execute!(step_mother)
        trap_interrupt
        if configuration.drb?
          begin
            return DRbClient.run(@args, @error_stream, @out_stream)
          rescue DRbClientError => e
            @error_stream.puts "WARNING: #{e.message} Running features locally:"
          end
        end
        step_mother.options = configuration.options

        # Feature files must be loaded before files are required.
        # This is because i18n step methods are only aliased when
        # features are loaded. If we swap the order, the requires
        # will fail.
        features = load_plain_text_features
        require_files
        enable_diffing

        visitor = configuration.build_formatter_broadcaster(step_mother)
        step_mother.visitor = visitor # Needed to support World#announce
        visitor.visit_features(features)

        failure = if exceeded_tag_limts?(features)
            FAILURE
          elsif configuration.wip?
            step_mother.scenarios(:passed).any?
          else
            step_mother.scenarios(:failed).any? ||
            (configuration.strict? && step_mother.steps(:undefined).any?)
          end
      rescue ProfilesNotDefinedError, YmlLoadError, ProfileNotFound => e
        @error_stream.puts e.message
        true
      end

      def exceeded_tag_limts?(features)
        exceeded = false
        configuration.options[:include_tags].each do |tag, limit|
          unless limit.nil?
            tag_count = features.tag_count(tag)
            if tag_count > limit.to_i
              exceeded = true
            end
          end
        end
        exceeded
      end

      def load_plain_text_features
        features = Ast::Features.new

        verbose_log("Features:")
        configuration.feature_files.each do |f|
          feature_file = FeatureFile.new(f)
          feature = feature_file.parse(configuration.options)
          if feature
            features.add_feature(feature)
            verbose_log("  * #{f}")
          end
        end
        verbose_log("\n"*2)
        features
      end

      def configuration
        return @configuration if @configuration

        @configuration = Configuration.new(@out_stream, @error_stream)
        @configuration.parse!(@args)
        @configuration
      end

      def load_files
        each_lib{|lib| load(lib)}
      end

      private

      def require_files
        each_lib{|lib| require lib}
      end

      def each_lib
        requires = configuration.files_to_require
        verbose_log("Ruby files required:")
        verbose_log(requires.map{|lib| "  * #{lib}"}.join("\n"))
        requires.each do |lib|
          begin
            yield lib
          rescue LoadError => e
            e.message << "\nFailed to load #{lib}"
            raise e
          end
        end
        verbose_log("\n")
      end

      def verbose_log(string)
        @out_stream.puts(string) if configuration.verbose?
      end

      def enable_diffing
        if configuration.diff_enabled?
          begin
            require 'spec/expectations'
            begin
              require 'spec/runner/differs/default' # RSpec >=1.2.4
            rescue ::LoadError
              require 'spec/expectations/differs/default' # RSpec <=1.2.3
            end
            options = OpenStruct.new(:diff_format => :unified, :context_lines => 3)
            ::Spec::Expectations.differ = ::Spec::Expectations::Differs::Default.new(options)
          rescue ::LoadError => ignore
          end
        end
      end

      def trap_interrupt
        trap('INT') do
          exit!(1) if $cucumber_interrupted
          $cucumber_interrupted = true
          STDERR.puts "\nExiting... Interrupt again to exit immediately."
        end
      end
    end
  end
end

Cucumber::Cli::Main.step_mother = self
