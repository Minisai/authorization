module UsersHelper

  def authorization_code
    rand(10 ** 6)
  end

end
