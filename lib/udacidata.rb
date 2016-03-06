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
    	row[:name] = row[:product]
    	object_array << self.create(row)
    end
    object_array
	end

	# Class method to return the first n number of objects
	def self.first(n = 1)
		object_array = []
    csv_table = get_table
    rows = csv_table.first(n)
    rows.each do |row|
			row[:name] = row[:product]
			object_array << self.create(row)
		end
		# If only the first object was requested then return object, else return array of objects
		n ==1 ? object_array[0] : object_array
	end

#	def self.first(number)
	#end

  private
	  def self.get_table
	    CSV.read(DATA_PATH, {encoding: "UTF-8",headers: true, header_converters: :symbol, converters: :all})
	  end
end


#puts csv.find {|row| row['NAME'] == 'Tom'}