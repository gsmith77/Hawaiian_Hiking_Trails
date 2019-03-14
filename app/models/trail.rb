class Trail < ActiveRecord::Base
  belongs_to :user
  validates :name, :length, :duration, :location, :difficulty, presence: true
end
