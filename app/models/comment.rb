class Comment < ActiveRecord::Base
  belongs_to :post
  attr_accessible :body, :user_id

  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true
end
