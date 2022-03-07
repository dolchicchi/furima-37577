require 'rails_helper'

RSpec.describe User, type: :model do
  
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '必要な情報が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'ニックネームが空だと登録できない' do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが空だと登録できない' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it ' メールアドレスは、@を含む必要があること' do
        @user.email = Faker::Lorem.characters(number: 5)
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'パスワードが空だと登録できない' do
        @user.password = ""
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードは、6文字以上での入力がないと登録できない' do
        @user.password = Faker::Lorem.characters(number: 5, min_alpha: 1, min_numeric: 1)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'パスワードは、半角数字のみでは登録できない' do
        @user.password = Faker::Number.number(digits: 6)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it 'パスワードは、半角英字のみでは登録できない' do
        @user.password = Faker::Alphanumeric.alpha(number: 6)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it 'パスワードとパスワード（確認）が一致していないと登録できない' do
        @user.password = Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1)
        @user.password_confirmation = Faker::Lorem.characters(number: 7, min_alpha: 1, min_numeric: 1)
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '名字(全角)が空だと登録できない' do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it '名前(全角)が空だと登録できない' do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it '名字(全角)の半角入力は登録できない' do
        @user.last_name = Faker::Name.last_name
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid. Input full-width characters")
      end
      it '名前(全角)の半角入力は登録できない' do
        @user.first_name = Faker::Name.first_name
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters")
      end
      it '名字(カナ)が空だと登録できない' do
        @user.kana_last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana last name can't be blank")
      end
      it '名前(カナ)が空だと登録できない' do
        @user.kana_first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana first name can't be blank")
      end
      it '名字(カナ)の半角入力は登録できない' do
        @user.kana_last_name = Faker::Name.last_name
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana last name is invalid. Input full-width katakana characters")
      end
      it '名前(カナ)の半角入力は登録できない' do
        @user.kana_first_name = Faker::Name.first_name
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana first name is invalid. Input full-width katakana characters")
      end
      it '名字(カナ)のひらがな入力は登録できない' do
        @user.kana_last_name = Gimei.name.last.hiragana
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana last name is invalid. Input full-width katakana characters")
      end
      it '名前(カナ)のひらがな入力は登録できない' do
        @user.kana_first_name = Gimei.name.first.hiragana
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana first name is invalid. Input full-width katakana characters")
      end
      it '生年月日が空だと登録できない' do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
