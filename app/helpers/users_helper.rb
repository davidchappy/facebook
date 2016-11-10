module UsersHelper

  def gravatar_for(user, options = { size: 80 })
    hashed_email = Digest::MD5::hexdigest(user.email.strip.downcase)
    gravatar_url = "https://www.gravatar.com/avatar/#{hashed_email}?s=#{options[:size]}"
    image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end

end
