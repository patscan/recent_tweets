class Tweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :status
      t.datetime :tweet_created_at
      t.references :twitter_user
    end
  end
end
