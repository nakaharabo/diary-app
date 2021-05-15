class History < ApplicationRecord
  belongs_to :message
  belongs_to :user
  has_one :order
end
