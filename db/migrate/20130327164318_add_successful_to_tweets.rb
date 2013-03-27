class AddSuccessfulToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :successful, :boolean
  end
end
