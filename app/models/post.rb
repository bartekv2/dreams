class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 50, maximum: 2000 }
end
