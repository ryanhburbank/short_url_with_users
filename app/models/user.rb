class User < ActiveRecord::Base
  validates :email, :uniqueness => true
  validates :email, :password, :presence => true

  def self.authenticate(email,password)
    self.find_by_email_and_password(email,password) 
  end

  #we need two class methods per the exercise or at least we need not just 
  #authentication but also validation

end
