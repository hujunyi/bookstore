class User < ActiveRecord::Base
  has_secure_password
  validates :password, length: {minimum: 6,maximum: 72}
  validates :password, confirmation: true
  after_destroy :ensure_an_admin_remains
  def ensure_an_admin_remains 
    if User.count.zero?
      raise "Can't delete last user"
    end 
  end
end
