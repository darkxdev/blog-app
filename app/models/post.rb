class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def increment_comment_counter
    update(comments_counter: comments_counter + 1)
  end

  def increment_like_counter
    update(likes_counter: likes_counter + 1)
  end
end
