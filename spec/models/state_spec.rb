require 'spec_helper'

describe State do
  subject { Factory(:state) }

  it { should have_one :region }
  it { should have_one :region_state }
end