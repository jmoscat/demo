class User < ActiveRecord::Base
	has_many :user_client_joins
	has_many :discounts
	has_many :visits
  has_many :clients, :through => :user_client_joins
end
