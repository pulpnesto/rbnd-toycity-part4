module Analyzable
  # Your code goes here!
  def average_price(object_array)
  	length = object_array.length
  	(object_array.inject(0){|sum,el| sum + el.price} / length).round(2)

  end
end
