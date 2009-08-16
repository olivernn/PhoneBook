class MakeGuidABigint < ActiveRecord::Migration
  def self.up
    change_column :tweets, :guid, :integer, :limit => 8
  end

  def self.down
    change_column :tweets, :guid, :integer
  end
end
