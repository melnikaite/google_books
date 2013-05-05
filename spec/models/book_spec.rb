require 'spec_helper'

describe Book do
  it { should allow_mass_assignment_of :author }
  it { should allow_mass_assignment_of :thumbnail }
  it { should allow_mass_assignment_of :title }
  context 'search', :vcr do
    subject { Book.search(Yetting.default_query) }
    let (:volume) { subject.first.first }

    it 'return array' do
      should be_a(Array)
    end

    it 'has list of items' do
      subject.first.should be_an(Array)
    end

    it 'has total items' do
      subject.last.should > 0
    end

    it 'item has title' do
      volume['volumeInfo']['title'].should be_a(String)
    end

    it 'item has authors' do
      volume['volumeInfo']['authors'].should be_a(Array)
    end

    it 'item has thumbnail' do
      volume['volumeInfo']['imageLinks']['thumbnail'].should be_a(String)
    end
  end
end
