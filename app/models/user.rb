class User < ActiveRecord::Base
  attr_accessible :auth2step, :email, :login, :password, :salt

  before_save :encrypt_password

  def valid_password?(submitted_password)
    password = encrypt(submitted_password)
  end

  private

  def encrypt_password
    self.salt = make_salt if new_record?
    self.password = ecrypt(password)
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
