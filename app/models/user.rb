class User < ActiveRecord::Base
  validates_uniqueness_of :number
	has_many :messages
end
