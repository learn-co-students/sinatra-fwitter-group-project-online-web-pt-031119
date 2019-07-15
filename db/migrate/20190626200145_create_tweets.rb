class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |aspects|
      aspects.string :content
      aspects.integer :user_id
    end
  end
end