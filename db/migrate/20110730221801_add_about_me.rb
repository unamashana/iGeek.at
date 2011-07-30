class AddAboutMe < ActiveRecord::Migration
  def self.up
    add_column  :users, :about_me, :text
    add_column  :users, :github_username, :string
    add_column  :users,  :hn_username, :string
    add_column  :users,  :blog_url, :text
  end

  def self.down
    remove_column  :users, :about_me
    remove_column  :users, :github_username
    remove_column  :users,  :hn_username
    remove_column  :users,  :blog_url
  end
end
