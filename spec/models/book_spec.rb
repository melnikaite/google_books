require 'spec_helper'

describe Book do
  it { should allow_mass_assignment_of :author }
  it { should allow_mass_assignment_of :thumbnail }
  it { should allow_mass_assignment_of :title }
end
