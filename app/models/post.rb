class Post < ApplicationRecord
  # userと1対多
  belongs_to :user
  # 写真と1対多
  has_many :photos, dependent: :destroy
  # オブジェクト(投稿)が削除されると、関連オブジェクト(いいね)が削除、ActiveRecord経由で削除。descは降順で新しいいいねが上
  # has_many :likes, -> { order(created_at: :desc) }, dependent: :destroy
  
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  # 親子関係のモデル(post親、photo子)、親から子を作成・保存
  accepts_nested_attributes_for :photos

  def liked_by(user)
    # user_idとpost_idが一致するlikeを検索
    Like.find_by(user_id: user.id, post_id: id)
  end
end
