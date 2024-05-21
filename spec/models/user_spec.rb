require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe '#valid' do
    context '新規登録が成功する場合' do
      it '属性が有効の場合' do
        expect(user.valid?).to eq true
      end
    end

    context '新規登録が失敗する場合' do
      it '名前がない場合は無効' do
        user.name = nil
        user.valid?
        expect(user.errors[:name]).to include("を入力してください")
      end

      it '名前が16文字より多い場合は無効' do
        user.name = "a" * 17
        user.valid?
        expect(user.errors[:name]).to include("は30文字以内で入力してください")
      end

      it 'メールアドレスがない場合は無効' do
        user.email = nil
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end

      it '不正な形式のメールアドレスの場合は無効' do
        user.email = 'valid_email'
        user.valid?
        expect(user.errors[:email]).to include("の形式が不正です")
      end

      it 'パスワードが8文字より少ない場合' do
        user.password = "miss"
        user.valid?
        expect(user.errors[:password]).to include("は8文字以上である必要があります")
      end

      it 'パスワードが一致しない時は無効' do
        user.password = "password123"
        user.password_confirmation = "misspassword"
        user.valid?
        expect(user.errors[:password_confirmation]).to include("がパスワードと一致しません")
      end

      it 'メールアドレスが重複している場合は無効' do
        create(:user, email: user.email)
        user.valid?
        expect(user.errors[:email]).to include("は既に使用されています")
      end
    end
  end
end
