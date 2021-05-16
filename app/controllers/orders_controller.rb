class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_params, only: [:index, :create]
  before_action :redirect_root, only:[:index]



  def index
    @order_history = OrderHistory.new
   
  end


  def create
    @order_history = OrderHistory.new(order_params)
    if @order_history.valid?
      pay_item
      @order_history.save
      redirect_to root_path
    else
      render action: :index
    end
  end
  
  private
 def order_params
  params.require(:order_history).permit(:name).merge(user_id: current_user.id, token: params[:token], message_id:params[:message_id])
 end

 def find_params
  @message = Message.find(params[:message_id])
end
def redirect_root
  redirect_to root_path if current_user.id == @message.user_id
end

def pay_item
  Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @message.price,
        card: order_params[:token],
        currency: 'jpy' 
      )
  end
end
