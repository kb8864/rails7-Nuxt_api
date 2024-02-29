class EmailValidator < ActiveModel::EachValidator
# EmailValidatorは、emailで呼び出しが可能
  def validate_each(record, attribute, value)
    # recordここにはユーザーオブジェクトが入ります。メソッド呼び出しなどに使用
    # attributeこれには属性が入ります。この属性はエラーメッセージにも使わる
    # valueユーザーが入力した値が入る
    max = 255
    record.errors.add(attribute, :too_long, count: max) if value.length > max

    # 書式をチェックするバリデーションを追加(これは.や@などが正しい場所にあるか確認する正規表現を行う)

    format = /\A\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*\z/
    record.errors.add(attribute, :invalid) unless format =~ value

    # email_activated? ... 登録したメールアドレスと同じメールアドレスの認証済みユーザーが既にいる場合、trueを返すメソッド
    record.errors.add(attribute, :taken) if record.email_activated?
  end
end