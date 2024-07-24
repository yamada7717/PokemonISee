class ApplicationController < ActionController::Base
  include Pagy::Backend

  rescue_from ActiveRecord::RecordNotFound, with: :redirect_to_root

  private

  def redirect_to_root
    redirect_to root_path, alert: "ページが見つからなためトップページに戻りました"
  end
end
