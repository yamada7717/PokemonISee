class ApplicationController < ActionController::Base
  include Pagy::Backend

  rescue_from ActiveRecord::RecordNotFound, with: :redirect_to_root
  rescue_from StandardError, with: :handle_internal_server_error

  private

  def redirect_to_root
    redirect_to root_path, alert: "ページが見つからなためトップページに戻りました"
  end

  def handle_internal_server_error(_exception)
    render 'errors/internal_server_error', status: :internal_server_error
  end
end
