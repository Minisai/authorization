class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not valid")
    end
  end
end

class User < ActiveRecord::Base
  attr_accessible :auth2step, :email, :login, :password, :salt, :password_confirmation

  belongs_to :role

  validates :login, :presence => true,
                    :uniqueness => { :case_sensitive => false },
                    :length => { :within => 3..15 }
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => { :within => 6..15 }
  validates :email, :presence => true,
                    :uniqueness => { :case_sensitive => false },
                    :email => true

  before_save :set_role, :encrypt_password

  def valid_password?(submitted_password)
    password = encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.valid_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    return nil  if user.nil?
    return user if user.salt == cookie_salt
  end

  private

  def set_role
    User.all.count > 0 ? self.role = Role.user : self.role = Role.admin
  end

  #for password encrypting
  def encrypt_password
    self.salt = make_salt if new_record?
    self.password = encrypt(password)
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

end