class Message < ApplicationRecord
  belongs_to :user
  has_one_attached :image


  with_options presence: true do
    validates :name
    validates :image
    validates :description
        with_options inclusion: { in: (100..500)} do
          with_options format: { with: /\A[0-9]+\z/} do
            validates :price
          end
        end

   end
end