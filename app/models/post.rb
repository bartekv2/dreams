class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_and_belongs_to_many :tags

  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 50, maximum: 2000 }
end
