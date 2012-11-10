require 'digest'
class Discount < ActiveRecord::Base
	belongs_to :user
	belongs_to :client

	def self.generate_cupon(user_id,client_id)
		influence = User.where(:client_id => client_id).influence
		if client_id = "test1"
			if influence = 1
				hash=Discount.create_cupon(user_id, client_id, "asdfasdfasdf")
				return "localhost:3000/discount/" + "#{hash}"
			end
			if influence = 2
				hash=Discount.create_cupon(user_id, client_id, "asdfasdfasdf")
				return "localhost:3000/discount/" + "#{hash}"
			end
			if influence = 3
				hash=Discount.create_cupon(user_id, client_id, "asdfasdfasdf")
				return "localhost:3000/discount/" + "#{hash}"
			end
		end
		if client_id = "test2"
			if influence = 1
				hash=Discount.create_cupon(user_id, client_id, "asdfasdfasdf")
				return "localhost:3000/discount/" + "#{hash}"
			end
			if influence = 2
				hash=Discount.create_cupon(user_id, client_id, "asdfasdfasdf")
				return "localhost:3000/discount/" + "#{hash}"
			end
			if influence = 3
				hash=Discount.create_cupon(user_id, client_id, "asdfasdfasdf")
				return "localhost:3000/discount/" + "#{hash}"
			end
		end
	end

	def secure_hash (string)
    Digest::SHA2.hexdigest(string)
  end

  def self.create_cupon(user_id,client_id, discount_text)
  	new_discount = Discount.new
  	new_discount.description = discount_text
  	new_discount.client_id = client_id
  	new_discount.user_id = user_id
  	new_discount.used = false
  	new_discount.save
  	hash_prep = "#{new_discount.id}" + "#{client_id}" + "#{user_id}"
  	new_discount.hash = secure_hash (hash_prep)
  	new_discount.save
  	return new_discount.hash
  end	


end
