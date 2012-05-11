class Forum < ActiveRecord::Base
  attr_accessible :title
  has_many :messages
  validates :title, :presence => true, :length => {:maximum => 64}
end
