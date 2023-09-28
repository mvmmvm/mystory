class Room < ApplicationRecord
  belongs_to :story
  belongs_to :character
  has_many :players
end
