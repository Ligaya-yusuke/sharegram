class UsersController < ApplicationController
  def show
    # モデル.find_byは与えられた条件に合うレコードの最初のレコードだけを返す。params[:パラメータ名]を取得。
    @user = User.find_by(id: params[:id])
  end

end
