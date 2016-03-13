require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

# Store path to data.csv as constant
DATA_PATH = File.dirname(__FILE__) + "/../data/data.csv"

	# Class method to initailize Product as wel as write Product to csv file
  def self.create(attributes = nil)

  	# Initialize new product
  	object = self.new(attributes)

  	# Check to see if the id field is empty.
  	if attributes[:id] == nil
  		# Append product data to csv data file.
  		CSV.open(DATA_PATH, "ab") do |csv|
  			csv << [object.id, object.brand, object.name, object.price.to_f]
  		end
  	end
  	# Retrun object
  	object
	end

	# Class method to return all objects in csv file
	def self.all
		object_array = []
    csv_table = get_table
    csv_table.each do |row|
    	object_array << self.create(row)
    end
    object_array
	end

	# Class method to return the first n number of objects
	def self.first(n = 1)
    object_array = self.all
    array_length = object_array.length
   	first_array = object_array.first(n)

   	# If only the first object was requested then return object, else return array of objects
		n ==1 ? first_array[0] : first_array
	end

	# Class method to return the last n number of objects
	def self.last(n = 1)
		object_array = self.all
    last_array = object_array.last(n)
		# If only the last object was requested then return object, else return array of objects
		n ==1 ? last_array[0] : last_array
	end

	# Class method to find an object by ID
 	def self.find(number)
 		object_array = self.all
 		id_array = object_array.map {|obj|obj.id}
 		# Raise an error if id doesn't exist
 		if id_array.include? number
			tmp = object_array.find {|row| row.id == number}
		else
			raise ProductNotFoundError, "ID: #{number} does not exit"
 		end

 	end

 	# Class method to delete Product from CSV and return the Product
 	def self.destroy(number)
 		obj = self.find(number)
 		object_array = self.all
 		object_array.delete_if do |row|
 			row.id == number
 		end

 		# Write new CSV file without deleted Product
    CSV.open(DATA_PATH, "wb") do |csv|
      csv << ["id", "brand", "product", "price"]
      object_array.each do |row|
      	csv << [row.id, row.brand, row.name, row.price.to_f]
      end
    end
 		obj
 	end

 	# Method to return all of the objects by brand or by name
 	# TODO - work on DRYing the conditional
 	def self.where(arg)
 		object_array = self.all
 		object_array_filtered = []
 		if arg[:brand]
 			object_array_filtered = object_array.select {|row| row.brand == arg[:brand]}
 		elsif arg[:name]
 			object_array_filtered = object_array.select {|row| row.name == arg[:name]}
 		end
 		object_array_filtered
 	end

 	# Method to update the value of a Product and write out to CSV
 	def update(options = {})
 		object = Product.destroy(self.id)
 		object_array = Product.all
 		obj_id = object.id
 		obj_brand = options[:brand].nil? ? object.brand : options[:brand]
 		obj_name = options[:name].nil? ? object.name : options[:name]
 		obj_price = options[:price].nil? ? object.price : options[:price]
 		new_product = Product.new(id: obj_id, brand: obj_brand, name: obj_name, price: obj_price)
 		object_array.push(new_product)
 		object_array.sort! { |x,y| x.id <=> y.id }
 		CSV.open(DATA_PATH, "wb") do |csv|
      csv << ["id", "brand", "product", "price"]
      object_array.each do |row|
      	csv << [row.id, row.brand, row.name, row.price.to_f]
      end
    end
  	Product.find(obj_id)
 	end


  private
  	# Method to store the CSV file into a Table
	  def self.get_table
	    csv_table = CSV.read(DATA_PATH, {encoding: "UTF-8",headers: true, header_converters: :symbol, converters: :all})
	    # Loop to fix the mismatch in CSV header "product" and Product variable "name"
	    csv_table.each do |row|
    		row[:name] = row[:product]
      end
      csv_table
	  end
end
