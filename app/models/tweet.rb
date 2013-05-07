class Tweet < ActiveRecord::Base
  belongs_to :twitter_user
  # Remember to create a migration!

  scope :recent, order('id DESC').limit(10)
end
