class Trail < ActiveRecord::Base
  belongs_to :user #creating a foreign key to another table.
  validates :name, :length, :duration, :location, :difficulty, presence: true
end
