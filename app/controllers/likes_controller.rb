class LikesController < ApplicationController
  # サインイン済みのユーザーのみアクセス許可を与える
  before_action :authenticate_user!

  def create
    # @like ={id: nil, post_id: 5, user_id: 1, created_at: nil, updated_at: nil}
    @like = current_user.likes.build(like_params)
    @post = @like.post
    if @like.save
      # 返すレスポンスのフォーマットをjsに設定。リアルタイムで反映
      respond_to :js
    end
  end

  def destroy
    # 受け取ったHTTPリクエストからidを判別し、指定のレコードを@likeに代入
    @like = Like.find_by(id: params[:id])
    @post = @like.post
    if @like.destroy
      respond_to :js
    end
  end

  private
  def like_params
    # paramsでリクエスト情報をひとまとめにして送る。permitで変更キーを指定。いいねを押した時に、どの投稿にいいねを押したかpost_idの情報を変更可能
    params.permit(:post_id)
  end
end
