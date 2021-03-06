# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  body       :text(65535)      not null
#  images     :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Post < ApplicationRecord
  belongs_to :user
  mount_uploaders :images, PostImageUploader
  serialize :images, JSON
  validates :images, presence: true
  validates :body, presence: true, length: { maximum: 1000 }
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  scope :body_contain, ->(word) { where('body LIKE ?', "%#{word}%") }
  # scope :by_comment, ->(comment) { joins(:comments).where('comments.body LIKE ?', "%#{comment}%") }
end
