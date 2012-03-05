class User
  include Mongoid::Document
  field :email, :type => String
  field :password_hash, :type => String
  field :password_salt, :type => String
  field :name, :type => String
  field :username, :type => String
  field :douban, :type => String
  field :weibo, :type => String
  field :profie, :type => String

  attr_accessor :password
  before_save :encrypt_password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  def encrypt_password  
    if password.present?  
      self.password_salt = BCrypt::Engine.generate_salt  
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)  
    end  
  end

  def self.authenticate(email, password)  
    user = self.where(:email => email).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)  
      user  
    else  
      nil  
    end  
  end  
  
  
end
