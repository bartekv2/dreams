module CommentsHelper

def get_comment_author_and_time(comment)
  simple_format "<strong class=\"tracking-wide\">" + comment.name + "</strong> " + "<span class=\"text-gray-600 text-xs\">" + distance_of_time_in_words(Time.now, comment.created_at) + " ago</span>"
end

end
