class Topic < ActiveRecord::Base
  attr_accessible :description, :name, :public
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
end
