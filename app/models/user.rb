class User < ApplicationRecord
##has_secure_passwordのメリットは以下の通り
  #パスワードの暗号化、暗号化されたパスワードはpassword_digestというカラムに保存されるので、同一名称のカラムを用意しておく必要がある
# passwordとpassword_confirmationの双方が一致しているかのバリデーションが自動で追加さ
# authenticate()メソッドの追加
# パスワードの最大文字数が72文字になる
#新規会員登録の時だけ入力必須を検証してくれるバリデーションが追加される。これにより、パスワード更新のバリデーションがより簡単になる
  has_secure_password

  validates :name, presence: true,
    length: { maximum: 30, allow_blank: true }

  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
  validates :password, presence: true,
                       length: { minimum: 8 },
                       format: {
                         with: VALID_PASSWORD_REGEX,
                         message: :invalid_password
                       },
                       allow_nil: true

end
