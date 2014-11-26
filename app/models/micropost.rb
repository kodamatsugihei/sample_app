class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  # 与えられたユーザーがフォローしているユーザーたちのマイクロポストを返す
  def self.from_users_followed_by(user)
  	followed_user_ids = "SELECT followed_id FROM relationships
  	                     WHERE follower_id = :user_id"
  	where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
  	       user_id: user.id)
  end

  # photoをattachファイルとする。stylesで画像を定義する
  has_attached_file :photo,
    :styles => { medium: "200x150>", thumb: "50x50>" }, # 画像サイズを指定
    :url => "/assets/arts/:id/:style/:basename.:extension", # 画像保存際のURL
    :path => "#{Rails.root}/public/assets/arts/:id/:style/:basename.:extension" #サーバー上の画像保存先パス

  # ファイルの拡張子を指定（これがないとエラーが発生する）
  validates_attachment :photo,
    prensence: true, # ファイルの依存チェック
    less_than: 5.megabytes, #ファイルサイズのチェック
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
