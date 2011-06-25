require 'spec_helper'

describe Region do
  subject {Factory(:region)}

  it { should have_many :states }
  it { should have_many :region_states }


end