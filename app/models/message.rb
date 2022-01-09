class Message < ApplicationRecord
  varidates :content, 
  presence: true
  belongs_to :user
  belongs_to :room
end
