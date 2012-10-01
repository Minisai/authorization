module UsersHelper

  def gravatar_for(email)
    image_tag "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}?d=wavatar"
  end

end
