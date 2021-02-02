# ApplicationControllerは全てのコントローラーが読まれる前に読む
class ApplicationController < ActionController::Base

  # Railsで生成されるすべてのフォームとAjaxリクエストにセキュリティトークンが自動的に含まれます。セキュリティトークンがマッチしない場合には例外
protect_from_forgery with: :exception

before_action :configure_permitted_parameters, if: :devise_controller?

protected
  # sign_upとaccount_update時だけnameカラムを保存
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
