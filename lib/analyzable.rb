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
  	arg = "Hello"
  end

end
