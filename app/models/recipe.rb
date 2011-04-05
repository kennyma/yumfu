class Recipe 
  include MongoMapper::Document
  include MongoMapperExt::Filter
  include MongoMapperExt::Slugizer
  include MongoMapperExt::Tags
  
  ensure_index :tags  
  
  key :_id, String
  key :short_description, String, :default => "", :required => false, :limit => 250    
  key :slugs, Array, :index => true  
  key :views_count, Integer, :default => 0, :required => true  
  key :user_id, String, :index => true, :required => true
  key :title, String
  key :ingredients, String
  key :instructions, String
  
  slug_key :title, :unique => true, :min_length => 8
  
  filterable_keys :title
    
  belongs_to :user
      
  validates_presence_of :user, :message => "Who is this?"
  validates_presence_of :title, :message => "Please give your recipe a title."  
  validates_length_of :title, :within => 5..100, :message => "Please enter a title that's between 5 and 100 characters."
  validates_presence_of :ingredients, :message => "Please give us the ingredients for this recipe."
  validates_length_of :ingredients, :maximum => 3000, :message => "Wow! that's a lot of ingredients. Please use less than 3000 characters for your ingredients."
  validates_presence_of :instructions, :message => "Please tell us how to make this recipe. "
  validates_length_of :instructions, :maximum => 3000, :message => "Wow! that's a lot of instructions. Please use less than 3000 characters for your instructions."
  validates_uniqueness_of :slug, :scope => :_id, :case_sensitive => false  
  validates_length_of :short_description, :maximum => 250, :message => "Please use less than 250 characters for the description."
    
  timestamps!
  
  def tags=(t)
    if t.kind_of?(String)
      t = t.downcase.split(",").join(" ").split(" ").uniq
    end

    self[:tags] = t
  end
end
