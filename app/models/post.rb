class Post 
  include DataMapper::Resource
  
  property :id,       Serial
  property :title,    String,        :required => true, :length => 500
  property :body,     Text,          :required => true, :lazy => false
  property :owner,    String,        :required => true
  timestamps :at 
end