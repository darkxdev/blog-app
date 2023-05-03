class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def last_three_posts
    posts.order(created_at: :desc).limit(3)
  end

  def increment_post_counter
    update(post_counter: post_counter + 1)
  end
end
