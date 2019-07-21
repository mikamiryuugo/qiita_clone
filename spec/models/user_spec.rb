RSpec.describe User, type: :model do
  context "emailとpasswordを指定しているとき" do
    let(:user) { create(:user) }
    #user = User.create と同じような意味

    it "userのレコードが作成される" do
      expect(user).to be_valid
    end
  end

  context "emailを指定していないとき" do
    let(:user) { build(:user, email: nil) }
    #emailがnilだとuserを生成できないのでbuild(emailがpresence: trueなので)
    #{ build(:user, email: nil) } ← userでmodel指定、右側でカラムの値指定

    it "エラーする" do
      user.valid?
      expect(user.errors.messages[:email]).to include "can't be blank"
      # valid?でfalse判定になると、errorsにエラーメッセージが代入される
    end
  end

  context "passwordを指定していないとき" do
    let(:user) { build(:user, password: nil) }
    #userがnilだとuserを生成できないのでbuild(passwordがpresence: trueなので)
    #{ build(:user, password: nil) } ← userでmodel指定、右側でカラムの値指定

    it "エラーする" do
      user.valid?
      expect(user.errors.messages[:password]).to include "can't be blank"
      # valid?でfalse判定になると、errorsにエラーメッセージが代入される
    end
  end

  context "emailが重複する時" do
    let(:user1) { create(:user) }
    let(:user2) { build(:user, email: user1.email) }
    #userのpasswordが重複すると生成できないので、user2はbuild

    it "エラーする" do
      user2.valid?
      expect(user2.errors.messages[:email]).to include "has already been taken"
      # valid?でfalse判定になると、errorsにエラーメッセージが代入される
    end
  end

end