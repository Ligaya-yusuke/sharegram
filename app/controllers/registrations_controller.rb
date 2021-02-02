# パスワード入力せずにプロフィール編集
class RegistrationsController < Devise::RegistrationsController

  protected

  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end
  # アカウントを更新した後にプロフィールページへリダイレクト
  def after_update_path_for(resource)
    user_path(resource)
  end
end
