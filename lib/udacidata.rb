require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

DATA_PATH = File.dirname(__FILE__) + "/../data/data.csv"

	# Class method to initailize Product as wel as write Product to csv file
  def self.create(attributes = nil)

  	# Initialize new product
  	object = self.new(attributes)

  	# Check to see if the id field is empty.
  	if attributes[:id] == nil
  		# Append product data to csv data file.
  		CSV.open(DATA_PATH, "ab") do |csv|
  			csv << [object.id, object.brand, object.name, object.price]
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
 		tmp = object_array.find do |row|
 			row.id == number
 		end
 	end

 	def self.destroy(number)
 		obj = self.find(number)
 		object_array = self.all
 		object_array.delete_if do |row|
 			row.id == number
 		end

    CSV.open(DATA_PATH, "wb") do |csv|
      csv << ["id", "brand", "product", "price"]
      object_array.each do |row|
      	csv << [row.id, row.brand, row.name, row.price]
      end
    end
 		obj
 	end

 	def self.where(arg)
 		object_array = []
 		if arg[:brand]
 			object_array << self.find_by_brand(arg[:brand])
 		elsif arg[:name]
 			object_array << self.find_by_name(arg[:name])
 		end
 		object_array
 	end

  private
	  def self.get_table
	    csv_table = CSV.read(DATA_PATH, {encoding: "UTF-8",headers: true, header_converters: :symbol, converters: :all})
	    csv_table.each do |row|
    		row[:name] = row[:product]
      end
      csv_table
	  end
end
