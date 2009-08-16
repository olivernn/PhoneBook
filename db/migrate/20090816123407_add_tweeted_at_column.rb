class AddTweetedAtColumn < ActiveRecord::Migration
  def self.up
    add_column :tweets, :tweeted_at, :timestamp
  end

  def self.down
    remove_column :tweets, :tweeted_at
  end
end
