class MessagesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :find_params, only:[:show, :edit, :update, :destroy, :show ]
  before_action :redirect_root, only:[:edit, :update, :destroy]

  
  def index
    @messages = Message.all.order(created_at: "DESC")
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to root_path
    else
      render :new
    end
  end


  private
  def item_params
    params.require(:message).permit(:name, :image, :description, :price).merge(user_id: current_user.id)
  end

  def find_params
    @message = Message.find(params[:id])
  end

  def redirect_root
    redirect_to root_path unless current_user.id == @message.user_id
  end
end
