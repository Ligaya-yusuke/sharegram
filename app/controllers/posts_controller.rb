class PostsController < ApplicationController
  # サインイン済ユーザーのみアクセス許可
  # before_actonメソッドで実行前に読み込み
  before_action :authenticate_user!

  # 重複コードのリファクタリング
  before_action :set_post, only: %i(show destroy)

    # 投稿ページ一覧表示
  def index
    # limitメソッドでレコード数の上限を指定
    # orderメソッドで降順(最新の日時順位並ぶ)
    # includesメソッドでN+1問題解決
    @posts = Post.limit(10).includes(:photos, :user).order('created_at DESC')
  end

  def new
    # .newでインスタンスを作成
    @post = Post.new
    # .buildでインスタンスを作成。モデルを関連づける時はbuildを使用(PostとPhotoモデル)
    @post.photos.build
  end

  def create
    # newメソッドでインスタンスを作成し、post_paramsメソッドで引数呼び出し
    @post = Post.new(post_params)
    # 投稿の写真が存在するか？nilまたは空でtrueを返す
    if @post.photos.present?
      # saveメソッドでオブジェクトをdbへ保存
      @post.save
      redirect_to root_path
      flash[:notice] = "投稿が保存されました"
    else
      redirect_to root_path
      flash[:alert] = "投稿が失敗ました"
    end
  end

  # 投稿詳細ページ
  def show
    # @post = Post.find_by(id: params[:id])
  end

  def destroy
    # HTTPリクエストからidを判別し、@postへ代入
    # @post = Post.find_by(id: params[:id])
    # 投稿したユーザーとサインインしてるユーザーが等しい場合真
    if @post.user == current_user
        # if @post.destroy
        #   flash[:notice] = "投稿が削除されました" 
        # end
      flash[:notice] = "投稿が削除されました" if @post.destroy
    else
      flash[:alert] = "投稿の削除に失敗しました"
    end
    redirect_to root_path
  end
  # private内ではレシーバ（オブジェクト.メソッド)を指定できない。外部から呼び出しできない
  private
  
    def post_params
      # params:送られてきたリクエストの情報をひとまとめ
      # require:受けとる値のキー
      # permit:変更を加えられるキー
      # merge:２つのハッシュを投稿、誰が投稿したかというuser_id情報を統合

      params.require(:post).permit(:caption, photos_attributes: [:image]).merge(user_id: current_user.id)
    end

    def set_post
      @post = Post.find_by(id: params[:id])
    end
end
