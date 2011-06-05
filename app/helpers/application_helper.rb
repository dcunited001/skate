module ApplicationHelper

  def default_image
    'http://wsajam.com/images/wsa-logo.jpg'
  end

  def avatar_url(member)
#TODO: MODIFY TO AUTOMATICALLY USE FACEBOOK AVATAR?
#    if user.avatar_url.present?
#      user.avatar_url
#    else
#      default_url = "#{root_url}images/guest.png"
#      gravatar_id = Digest::MD5::hexdigest(user.email).downcase
#      "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}"
#    end
    gravatar_id = Digest::MD5::hexdigest(member.email.downcase).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=200&d=" + CGI::escape(default_image)
  end

  def small_avatar_url(member)
    gravatar_id = Digest::MD5::hexdigest(member.email.downcase).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=" + CGI::escape(default_image)
  end
end
