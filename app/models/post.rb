class Post < ActiveRecord::Base
  attr_accessible :body, :title, :topic
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  belongs_to :user
  belongs_to :topic
  default_scope order('rank DESC')

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true 

  after_create :create_vote
     
  def up_vote
    update_vote(1)
    redirect_to :back
  end

  def down_vote
    update_vote(-1)
    redirect_to :back
  end

  def points
    self.votes.sum(:value).to_i
  end 

  def update_rank
    age = (self.created_at - Time.new(1970,1,1)) / 86400
    new_rank = points + age

    self.update_attribute(:rank, new_rank)
  end

  private

  #Post automatically upvoted when created
  def create_vote
    user.votes.create(value: 1, post: self)
  end 
end