require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

	# Class method to initailize Product as wel as write Product to csv file
  def self.create(attributes = nil)

  	# Initialize new product
  	object = self.new(attributes)

  	# Append product data to csv data file.
  	@data_path = File.dirname(__FILE__) + "/../data/data.csv"
  	CSV.open(@data_path, "ab") do |csv|
  		csv << [object.id, object.brand, object.name, object.price]
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
end
