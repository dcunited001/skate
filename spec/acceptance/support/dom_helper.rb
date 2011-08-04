module DomHelper
  def to_id(str)
    "##{str}"
  end

  def to_class(str)
    ".#{str}"
  end
end

RSpec.configuration.include DomHelper, :type => :acceptance