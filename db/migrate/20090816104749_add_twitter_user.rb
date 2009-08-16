class AddTwitterUser < ActiveRecord::Migration
  def self.up
    add_column :contacts, :twitter_user_name, :string
  end

  def self.down
    remove_column :contacts, :twitter_user_name, :string
  end
end
