module Analyzable

  # Method to calculate the average price of given Products
  def average_price(object_array)
    length = object_array.length
    (object_array.inject(0){|sum,el| sum + el.price} / length).round(2)
  end

  # Method to count occurences of a brand in an array of Products
  # Used code found at jerodsanto.net
  def count_by_brand(object_array)
    object_array.each_with_object(Hash.new(0)) {|obj,counts| counts[obj.brand] += 1}
  end

  # Method to count occurences of a name in an array of Products
  # Used code found at jerodsanto.net
  def count_by_name(object_array)
    object_array.each_with_object(Hash.new(0)) {|obj,counts| counts[obj.name] += 1}
  end

  # Method to organize Product data into a string formatted as a table
  def print_report(object_array)
    avg_string = create_avg_price_string(object_array)
    brand_string = create_brand_string(object_array)
    name_string = create_name_string(object_array)
    avg_string + brand_string + name_string
  end

  private
    # Method to calculate average price of objects
    def create_avg_price_string(object_array)
      average = average_price(object_array)
      avg_string = "Average price: #{average.to_s}\n"
    end

    # Method to create a table of Product brands and counts
    def create_brand_string(object_array)
      brand_hash = count_by_brand(object_array)
      brand_string = "Inventory by Brand:\n"
      brand_hash.each do |k,v|
        brand_string = brand_string + "  - #{k}: #{v.to_s} \n"
    end
      brand_string
    end

    # Method to create a table of Product names and counts
    def create_name_string(object_array)
      name_hash = count_by_name(object_array)
      name_string = "Inventory by Name:\n"
      name_hash.each do |k,v|
        name_string = name_string + "  - #{k}: #{v.to_s} \n"
      end
      name_string
    end
end
