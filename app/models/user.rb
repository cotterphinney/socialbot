class User < ActiveRecord::Base
  validates_uniqueness_of :phone_number
	has_many :messages
end
