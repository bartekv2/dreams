module ApplicationHelper
  def show_footer
    simple_format "<p>© #{DateTime.now.year} all rights reserved</p>".upcase
  end

  def get_number_of_dreams
    Post.all.count
  end

  def get_number_of_dreamers
    User.all.count
  end

  def get_number_of_private_dreams
    Post.where(private: true).count
  end

  def get_author_and_time(post)
    link_to(get_author_by_post_id(post.id), {:controller => "posts", :action => "userdreams", :user_id => post.user_id }) + " " + distance_of_time_in_words(Time.now, post.created_at) + " ago"
  end

  def get_header_info(user)
    if current_page?(action: 'mydreams')
      "<h2>Showing your dreams only</h2>".html_safe
    elsif current_page?(action: 'userdreams')
      "<h2>Showing dreams of ".html_safe + user + "</h2>".html_safe
    end
  end
end
