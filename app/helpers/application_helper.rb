module ApplicationHelper
  include Pagy::Frontend
  # 構築記事の未設定状態を表示する
  def display_or_default(value, default = '未設定')
    value.present? ? value : default
  end

  def display_image_if(image_url, size: "60")
    image_tag(image_url, size:) if image_url.present?
  end
end
