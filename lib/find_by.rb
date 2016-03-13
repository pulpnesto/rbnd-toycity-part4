class Module
  def create_finder_methods(*attributes)
  	# Method to create find_by_ methods using meta-programming
    attributes.each do |attribute|
    	self.class_eval("def find_by_#{attribute}(#{attribute});
    	                 object_array = self.all;
 											 object = object_array.find do |row|;
 												row.#{attribute} == #{attribute};
 												end;
 												end;")
    end
  end
  # Create the two find_by_ methods
  self.create_finder_methods("brand","name")
end
