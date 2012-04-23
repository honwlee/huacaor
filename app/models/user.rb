# encoding: utf-8
class User
  include Mongoid::Document
  has_many :pictures 
  has_many :comments

  field :email, :type => String
  field :password_hash, :type => String
  field :password_salt, :type => String
  field :name, :type => String
  field :username, :type => String
  field :douban_name, :type => String
  field :sina_name, :type => String
  field :desc, :type => String
  field :is_admin, :type => Boolean
  field :douban_uid, :type => String

  index :is_admin
  index :name
  attr_accessor :password
  before_save :encrypt_password, :unless => 'password.blank?'
  #validates_presence_of :password, :on => :create
  #validates_presence_of :email
  #validates_uniqueness_of :email

  #validates :password, :presence => true, :on => :create
  #validates :email, :presence => true
  #validates :email, :uniqueness => true

  #validates :name, :presence => {:message => "请输入名字"}
  #validates :name, :uniqueness => true
  #validates :username, :uniqueness => {:message => "此自定义URL已存在，请重新输入", :unless => "username.blank?"}

  def encrypt_password  
    if password.present?  
      self.password_salt = BCrypt::Engine.generate_salt  
      self.password_hash = User.encrypt(password, password_salt)  
    end  
  end

  def self.authenticate(email, password)  
    user = self.where(:email => email).first
    if user && user.password_hash == self.encrypt(password, user.password_salt)  
      user  
    else  
      nil  
    end  
  end

  def self.encrypt(password, salt)
    BCrypt::Engine.hash_secret(password, salt)
  end

  def link
    if self.username
      return "/" + self.username
    else
      return "/users/" + self.id.to_s
    end
  end

  def avatar_path(mode=:medium)
    return "http://placehold.it/50x50"
  end
end
