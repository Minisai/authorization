module UsersHelper

  def gravatar_for(user)
    image_tag "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}?d=wavatar"
  end

end
