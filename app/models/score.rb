class Score < ActiveRecord::Base
  belongs_to :user
  scope :today, ->{ where('DATE(scores.created_at) = DATE(?)',Time.zone.now)}
  default_scope ->{ includes(:user) }
end
