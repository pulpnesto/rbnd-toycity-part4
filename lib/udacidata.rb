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
		object_array = []
    csv_table = get_table
    rows = csv_table.first(n)
    rows.each do |row|
			object_array << self.create(row)
		end
		# If only the first object was requested then return object, else return array of objects
		n ==1 ? object_array[0] : object_array
	end

	# Class method to return the last n number of objects
	def self.last(n = 1)
		object_array = []
		csv_table = get_table
		length = csv_table.length
		cnt = 0
		n.times do
		  obj = csv_table[length-1-cnt]
		  object_array << self.create(obj)
		  cnt = cnt + 1
		end
		n == 1 ? object_array[0] : object_array
	end

	# Class method to find an object by ID
 	def self.find(number)
 		csv_table = get_table
 		tmp = csv_table.find do |row|
 			row[:id] == number
 		end
 		self.create(tmp)
 	end

 	def self.destroy(number)
 		obj = self.find(number)
		csv_table = get_table
 		csv_table.delete_if do |row|
 			row[:id] == number
 		end

 		File.open(DATA_PATH, 'w') do |f|
 			f.write(csv_table.to_csv)
 		end
 		obj
 	end

# 	def self.find_by_brand(brand)
# 		csv_table = get_table
# 		object = csv_table.find do |row|
 #			row[:brand] == brand
# 		end
# 		self.create(object)
# 	end

 #	def self.find_by_name(name)
# 		csv_table = get_table
# 		object = csv_table.find do |row|
 #			row[:name] == name
 #		end
# 		self.create(object)
# 	end

  private
	  def self.get_table
	    csv_table = CSV.read(DATA_PATH, {encoding: "UTF-8",headers: true, header_converters: :symbol, converters: :all})
	    csv_table.each do |row|
    		row[:name] = row[:product]
      end
      csv_table
	  end
end
