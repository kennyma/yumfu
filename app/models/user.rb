class User
  include MongoMapper::Document         

  devise :database_authenticatable, :recoverable, :registerable, :rememberable         
         
  key :_id, String   
  key :bio, String, :required => false, :limit => 300
  key :name, String, :required => false, :limit => 100    
  
  has_many :recipes
  
  validates_length_of :bio, :maximum => 300, :message => "Bio cannot be longer than 300 characters."
  validates_length_of :name, :maximum => 100, :message => "Name cannot be longer than 100 characters."
  
  timestamps!
end