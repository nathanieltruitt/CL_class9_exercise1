module PostsHelper
  def all_posts_count
    post_count = Post.all.count
    if post_count % 10 != 0
      post_count / 10 + 1
    else
      post_count / 10
    end
  end
end
