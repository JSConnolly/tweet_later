class UpdateTwitterUsersTable < ActiveRecord::Migration
  def change
    add_column :twitter_users, :twitter_id, :integer
  end
end
