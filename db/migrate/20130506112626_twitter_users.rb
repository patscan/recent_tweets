class TwitterUsers < ActiveRecord::Migration
  def change
    create_table :twitter_users do |t|
      t.string :username
      t.datetime :cached_at
      t.integer :stale_threshold
    end
  end
end
