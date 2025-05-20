require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order = FactoryBot.build(:order)
  end

  describe '購入情報の保存' do
    context '購入できるとき' do
      it 'すべての情報が正しく入力されていれば保存できる' do
        expect(@order).to be_valid
      end

      it '建物名が空でも保存できる' do
        @order.building = ''
        expect(@order).to be_valid
      end
    end

    context '購入できないとき' do
      it 'postal_codeが空では保存できない' do
        @order.postal_code = ''
        expect(@order).not_to be_valid
      end

      it 'prefecture_idが1では保存できない' do
        @order.prefecture_id = 1
        expect(@order).not_to be_valid
        expect(@order.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityが空では保存できない' do
        @order.city = ''
        expect(@order).not_to be_valid
      end

      it 'addressが空では保存できない' do
        @order.address = ''
        expect(@order).not_to be_valid
      end

      it 'phone_numberが空では保存できない' do
        @order.phone_number = ''
        expect(@order).not_to be_valid
      end

      it 'tokenが空では保存できない' do
        @order.token = ''
        expect(@order).not_to be_valid
      end

      it 'postal_codeにハイフンがなければ保存できない' do
        @order.postal_code = '1234567'
        expect(@order).not_to be_valid
      end

      it 'phone_numberが12桁以上では保存できない' do
        @order.phone_number = '090123456789'
        expect(@order).not_to be_valid
      end

      it 'phone_numberが英数字混合では保存できない' do
        @order.phone_number = '090abcd1234'
        expect(@order).not_to be_valid
      end
    end
  end
end
