class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  # user_idとpost_idの組合が重複しない(uniquness)->投稿1にAさんが1回だけ押せえる
  validates :user_id, uniqueness: { scope: :post_id }
end
