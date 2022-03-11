require 'rails_helper'

RSpec.describe OrderDestination, type: :model do
  describe '注文情報の保存' do
    before do
      @order_destination = FactoryBot.build(:order_destination)
    end
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@order_destination).to be_valid
      end
      it 'building_nameは空でも保存できる' do
        @order_destination.building_name = ""
        expect(@order_destination).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'クレジット情報が空だと保存できない' do
        @order_destination.token = ""
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号が空だと保存できない' do
        @order_destination.post_code = ""
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Post code can't be blank")
      end
      it ' 郵便番号は全角文字だと保存できない' do
        @order_destination.post_code = Faker::Name.name
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Post code is invalid. Enter it as follows(e.g 123-4567)")
      end
      it ' 郵便番号は半角数字のみだと保存できない' do
        @order_destination.post_code = Faker::Number.number(digits: 7)
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Post code is invalid. Enter it as follows(e.g 123-4567)")
      end
      it ' region_idが1だと保存できない' do
        @order_destination.region_id = 1
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Region can't be blank")
      end
      it ' 市区町村が空だと保存できない' do
        @order_destination.city = ""
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("City can't be blank")
      end
      it ' 番地が空だと保存できない' do
        @order_destination.address = ""
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Address can't be blank")
      end
      it ' 電話番号が空だと保存できない' do
        @order_destination.tel = ""
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Tel can't be blank")
      end
      it ' 電話番号は9桁以下だと保存できない' do
        @order_destination.tel = Faker::Number.between(from: 1, to: 999999999)
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Tel is too short")
      end
    end
  end
end
