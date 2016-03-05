require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

DATA_PATH = File.dirname(__FILE__) + "/../data/data.csv"

	# Class method to initailize Product as wel as write Product to csv file
  def self.create(attributes = nil)

  	# Initialize new product
  	object = self.new(attributes)

  	if attributes[:id] == nil
  		# Append product data to csv data file.
  		CSV.open(DATA_PATH, "ab") do |csv|
  			csv << [object.id, object.brand, object.name, object.price]
  		end
  	end
  	# Retrun product
  	object

  # If the object's data is already in the database
  # create the object
  # return the object

  # If the object's data is not in the database
  # create the object
  # save the data in the database
  # return the object
	end

	def self.all
		object_array = []
	  tmp_array = CSV.read(DATA_PATH, {encoding: "UTF-8",headers: true, header_converters: :symbol, converters: :all})
    tmp_array.each do |row|
    	row[:name] = row[:product]
    	object_array << Product.create(row)
    end
    object_array
	end

end
