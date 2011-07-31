class AddTwitPicToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :twitpic, :string
  end

  def self.down
    add_column :
  end
end
