require 'digest'
class Discount < ActiveRecord::Base
	belongs_to :user
	belongs_to :client

	def self.generate_cupon(user_id,client_id)
		influence = User.where(:id => user_id).first.influence
		puts "fuck"
		if client_id = "1"
			if influence <= 7.0
				hash=Discount.create_cupon(user_id, client_id, "asdfasdfasdf121")
				return "localhost:3000/discount/" + "#{hash}"
			end
			if influence == 2.0
				hash=Discount.create_cupon(user_id, client_id, "asdfasdfasdf2")
				return "localhost:3000/discount/" + "#{hash}"
			end
			if influence == 3.0
				hash=Discount.create_cupon(user_id, client_id, "asdfasdfasdf3")
				return "localhost:3000/discount/" + "#{hash}"
			end
		end
		if client_id = "test2"
			if influence == 1.0
				hash=Discount.create_cupon(user_id, client_id, "asdfasdfasdf4")
				return "localhost:3000/discount/" + "#{hash}"
			end
			if influence == 1.0
				hash=Discount.create_cupon(user_id, client_id, "asdfasdfasdf5")
				return "localhost:3000/discount/" + "#{hash}"
			end
			if influence == 1.0
				hash=Discount.create_cupon(user_id, client_id, "asdfasdfasdf6")
				return "localhost:3000/discount/" + "#{hash}"
			end
		end
	end

  def self.create_cupon(user_id,client_id, discount_text)
  	new_discount = Discount.new
  	new_discount.description = discount_text
  	new_discount.client_id = client_id
  	new_discount.user_id = user_id
  	new_discount.used = false
  	new_discount.save
  	discount_id = new_discount.id
  	puts "yeah"
  	hash_prep = "#{discount_id}" + "#{client_id}" + "#{user_id}"
  	new_discount.hash_key = secure_hash (hash_prep)
  	new_discount.save
  	return new_discount.hash_key
  end	

	def self.secure_hash (string)
    Digest::SHA2.hexdigest(string)
  end

  def checked
  	self.used = true
  	self.save
  end



end
