module RinksHelper
  def rink_name_as_link
    return link_to name, website if website
    name
  end
end
