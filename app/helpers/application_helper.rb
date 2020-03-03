module ApplicationHelper
  def get_welcome_text
    simple_format "You dream about 100 minutes every night, but forget 95% of your dreams 8 minutes after waking up. This website was created so that it never happens again . Please " + active_link_to('Log in', new_user_session_path) + " or " + active_link_to("Sign up", new_user_registration_path) + " and add your first dream. You can make it public or private."
  end
  def get_footer
    simple_format "© #{DateTime.now.year} all rights reserved".upcase
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
    link_to(get_author_by_post_id(post.id), {:controller => "posts", :action => "userdreams", :user_id => post.user_id }) + " <span class=\"text-xs text-gray-600\">".html_safe + distance_of_time_in_words(Time.now, post.created_at) + " ago</span>".html_safe
  end

  def get_header_info(user)
    if current_page?(action: 'mydreams')
      "<h2>Showing your dreams only</h2>".html_safe
    elsif current_page?(action: 'userdreams')
      "<h2>Showing dreams of ".html_safe + user + "</h2>".html_safe
    end
  end

  def get_logo
    "<span class=\"text-teal-600\">D</span>ream<span class=\"text-teal-600\">D</span>iary<span class=\"text-teal-600\">.</span><span class=\"text-gray-600\">online</span>".html_safe
  end

  def get_comments_count(post)
    num = post.comments.count
    num == 1 ? com = " comment" : com = " comments"
    num.to_s + com
  end
end
