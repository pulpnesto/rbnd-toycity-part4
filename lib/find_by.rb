class Module
  def create_finder_methods(*attributes)
    # Your code goes here!
    # Hint: Remember attr_reader and class_eval
    attributes.each do |attribute|
    	self.class_eval("def find_by_#{attribute}(#{attribute});
    	                 object_array = self.all;
 											 object = object_array.find do |row|;
 												row.#{attribute} == #{attribute};
 												end;
 												end;")
    end
  end
  self.create_finder_methods("brand","name")
end
