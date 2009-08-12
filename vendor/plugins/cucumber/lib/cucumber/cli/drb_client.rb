require "drb/drb"
# This code was taken from the RSpec project and slightly modified.

module Cucumber
  module Cli
    class DRbClientError < StandardError
    end
    # Runs features on a DRB server, originally created with Spork compatibility in mind.
    class DRbClient
      def self.run(args, error_stream, out_stream)
        # See http://redmine.ruby-lang.org/issues/show/496 as to why we specify localhost:0
        DRb.start_service("druby://localhost:0")
        feature_server = DRbObject.new_with_uri("druby://127.0.0.1:8990")
        cloned_args = [] # I have no idea why this is needed, but if the regular args are sent then DRb magically transforms it into a DRb object - not an array
        args.each { |arg| cloned_args << arg }
        feature_server.run(cloned_args, error_stream, out_stream)
      rescue DRb::DRbConnError
        raise DRbClientError, "No DRb server is running."
      end
    end
  end
end
