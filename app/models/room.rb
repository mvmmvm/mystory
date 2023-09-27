class Room < ApplicationRecord
  belongs_to :story
  belongs_to :character
end
