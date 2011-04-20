require "digest/sha1"

class User
  include Mongoid::Document
  field :login,           :type => String
  field :hashed_password, :type => String
  field :email,           :type => String
  field :salt,            :type => String
  field :created_at,      :type => DateTime
  attr_protected :hashed_password, :salt
  
  validates_length_of :login,    :mininum => 3, :maximum => 20
  validates_length_of :password, :mininum => 6, :maximum => 20
  validates_uniqueness_of :login, :email
  validates_confirmation_of :password
  validates_presence_of :login, :email, :password, :password_confirmation, :salt
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

  attr_protected :id, :salt
  attr_accessor :password, :password_confirmation

  def self.authenticate(login, pass)
    u = where(:login => login).first
    return nil if u.nil?
    return u if User.encrypt(pass, u.salt) == u.hashed_password
    nil
  end  

  def password=(pass)
    @password = pass
    self.salt = User.random_string(10) if !self.salt?
    self.hashed_password = User.encrypt(@password, self.salt)
  end
  
  private

  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass+salt)
  end

  def self.random_string(len)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end

end