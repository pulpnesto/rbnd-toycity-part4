module Analyzable
  def average_price(object_array)
  	length = object_array.length
  	(object_array.inject(0){|sum,el| sum + el.price} / length).round(2)
  end

  # Method to count occurences of a brand in an array
  # Used code found at jerodsanto.net
  def count_by_brand(object_array)
  	object_array.each_with_object(Hash.new(0)) {|obj,counts| counts[obj.brand] += 1}
  end

  def count_by_name(object_array)
  	object_array.each_with_object(Hash.new(0)) {|obj,counts| counts[obj.name] += 1}
  end

  def print_report(object_array)
  	average = average_price(object_array)
  	brand_hash = count_by_brand(object_array)
  	name_hash = count_by_name(object_array)
  	avg_string = "Average price: #{average.to_s}\n"

  	brand_string = "Inventory by Brand:\n"
  	brand_hash.each do |k,v|
  		brand_string = brand_string + "  - #{k}: #{v.to_s} \n"
  	end

  	name_string = "Inventory by Name:\n"
  	name_hash.each do |k,v|
  		name_string = name_string + "  - #{k}: #{v.to_s} \n"
  	end
  	avg_string + brand_string + name_string

  end

end
