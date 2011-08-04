module DomHelper
  def to_id(str)
    "##{str}"
  end

  def to_class(string)
    ".#{str}"
  end
end

RSpec.configuration.include DomHelper, :type => :acceptance