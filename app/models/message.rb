class Message 
  include ActiveModel::Validations
  include ActiveModel::Conversion
  attr_accessor :name,:email,:content

  validates :name,presence: true
  validates :email,presence: true
  validates :content,presence: true
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end


  def persisted?
    false
  end
end

