class Module
  def create_finder_methods(*attributes)
    # Your code goes here!
    # Hint: Remember attr_reader and class_eval
    attributes.each do |attribute|
    	self.class_eval("def find_by_#{attribute}(#{attribute});
    	                 csv_table = get_table;
 												object = csv_table.find do |row|;
 												row[:#{attribute}] == #{attribute};
 												end;
 												self.create(object);
 												end;")
    end
  end
  self.create_finder_methods("brand","name")
end
