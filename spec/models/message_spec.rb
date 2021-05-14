require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end
  describe '写真投稿機能' do
    context '商品出品できるとき' do
      it 'image,name,description,priceが存在すれば登録できる' do
        expect(@message).to be_valid
      end
      
    end
    context '商品出品できないとき' do
      it 'imageが空では登録できない' do
        @message.image = nil
        @message.valid?
        expect(@message.errors.full_messages).to include "Image can't be blank"
      end
      it 'nameが空では登録できない' do
        @message.name = ''
        @message.valid?
        expect(@message.errors.full_messages).to include "Name can't be blank"
      end
      it 'discriptionが空では登録できない' do
        @message.description = ''
        @message.valid?
        expect(@message.errors.full_messages).to include "Description can't be blank"
      end
      
      it 'priceが空では登録できない' do
        @message.price = ''
        @message.valid?
        expect(@message.errors.full_messages).to include "Price can't be blank"
      end
      it 'priceの価格範囲が100円~500円以外では登録できない' do
        @message.price= 50
        @message.valid?
        expect(@message.errors.full_messages).to include('Price is not included in the list')
      end
      it 'priceの価格範囲が100円~500円以外では登録できない' do
        @message.price= 1000
        @message.valid?
        expect(@message.errors.full_messages).to include('Price is not included in the list')
      end
      it '販売価格が全角数字では登録できない' do
        @message.price = '３００'
        @message.valid?
        expect(@message.errors.full_messages).to include('Price is not included in the list')
      end
      it '販売価格が半角英数混合では登録できない' do
        @message.price = 'abc123'
        @message.valid?
        expect(@message.errors.full_messages).to include('Price is not included in the list')
      end
      it '販売価格が半角英語だけでは登録できない' do
        @message.price = 'abcdef'
        @message.valid?
        expect(@message.errors.full_messages).to include('Price is not included in the list')
      end
    end
  end
end