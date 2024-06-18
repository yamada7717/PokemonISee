module ApplicationHelper
  # 構築記事の未設定状態を表示する
  def display_or_default(value, default = '未設定')
    value.present? ? value : default
  end
end
