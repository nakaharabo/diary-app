class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         with_options presence: true do
          validates :nickname
          validates :email, uniqueness: true
          validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }
      
          with_options format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/ } do
            validates :last_name
            validates :first_name
            validates :parent_name
          end
          with_options format: { with: /\A[ァ-ヶー－]+\z/ } do
            validates :last_name_kana
            validates :first_name_kana
          end
        end

        has_many :messages
        has_many :user_rooms
        has_many :chats
        has_many :rooms, through: :user_rooms
end
