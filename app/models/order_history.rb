class OrderHistory
  include ActiveModel::Model
  attr_accessor :name, :user_id, :message_id, :token

  with_options presence: true do
    validates :name
    validates :token
    validates :user_id
    validates :message_id
  end


  def save
    history = History.create(user_id: user_id, message_id: message_id)
    Order.create(name: name, history_id: history.message_id)  
  end
end