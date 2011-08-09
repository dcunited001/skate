module RinksHelper
  def rink_name_as_link_to_website(rink)
    return link_to rink.name, rink.website if !(rink.website.empty?)
    rink.name
  end

  def rink_name_as_link_to_profile(rink)
    link_to rink.name, rink_path(rink.id)
  end

end
