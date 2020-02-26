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
end
