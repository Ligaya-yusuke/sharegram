class Photo < ApplicationRecord
  belongs_to :post

  # 写真がアップロードしていないと投稿できない
  validates :image, presence: true

  # imageカラムにImageUploaderを紐付け
  mount_uploader :image, ImageUploader
end
