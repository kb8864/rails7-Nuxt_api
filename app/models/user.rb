class User < ApplicationRecord
require "validator/email_validator"

# メールアドレスは検証前に全て小文字にする
before_validation :downcase_email
  ##has_secure_passwordのメリットは以下の通り
  #パスワードの暗号化、暗号化されたパスワードはpassword_digestというカラムに保存されるので、同一名称のカラムを用意しておく必要がある
# passwordとpassword_confirmationの双方が一致しているかのバリデーションが自動で追加さ
# authenticate()メソッドの追加
# パスワードの最大文字数が72文字になる
#新規会員登録の時だけ入力必須を検証してくれるバリデーションが追加される。これにより、パスワード更新のバリデーションがより簡単になる
  has_secure_password
  validates :name, presence: true,
  length: { maximum: 30, allow_blank: true }
  
  validates :email, presence: true, length: { maximum: 256 }
  


  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
  validates :password, presence: true,
                       length: { minimum: 8 },
                       format: {
                         with: VALID_PASSWORD_REGEX,
                         message: :invalid_password
                       },
                       allow_nil: true

class << self
  # emailからアクティブなユーザーを返す
  def find_activated(email)
    find_by(email: email, activated: true)
  end
end

# 自分以外の同じemailのアクティブなユーザーがいる場合にtrueを返す
def email_activated?
  users = User.where.not(id: id)
  users.find_activated(email).present?
end


private 

def downcase_email
  self .email.downcase! if email
end
end
