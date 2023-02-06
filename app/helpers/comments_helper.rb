module CommentsHelper
  def comments_by_post(post)
    Comment.where(post_id: post)
  end
end
