class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not valid")
    end
  end
end

class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :auth2step, :provider, :uid, :email, :login, :password, :password_confirmation, :password_digest

  belongs_to :role

  validates :login, :presence => true,
                    :uniqueness => { :case_sensitive => false },
                    :length => { :within => 3..30 }
  validates :password_digest, :presence => true,
                              :confirmation => true
  validates :email, :presence => true,
                    :uniqueness => { :case_sensitive => false },
                    :email => true

  before_save :set_role, :fields_downcase

  def self.authenticate_with_cookies(id, cookie_password)
    user = find_by_id(id)
    return nil  if user.nil?
    return user if user.password == cookie_password
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.login = auth["info"]["nickname"]+".twitter"
      user.email = "#{auth["info"]["nickname"]}@twitter.com"
      user.password = Faker::Lorem.words.join("")[0..10]
    end
  end

  private

  def set_role
    User.all.count > 0 ? self.role = Role.user : self.role = Role.admin
  end

  def fields_downcase
    self.email = self.email.downcase
    self.login = self.login.downcase
  end

end