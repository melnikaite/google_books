require 'spec_helper'

describe Book do
  context 'search', :vcr => { :cassette_name => 'Book' } do
    subject { Book.search_and_paginate(Yetting.default_query) }
    let (:volume) { subject.first.first }

    it 'return array' do
      should be_a(Array)
    end

    it 'return array with 2 items' do
      subject.length.should == 2
    end

    it 'has list of items' do
      subject.first.should be_an(Array)
    end

    it 'has total items' do
      #value saved in cassette
      subject.last.should == 771
    end

    it 'item has title' do
      #value saved in cassette
      title = "Head First Rails"
      volume['volumeInfo']['title'].should == title
    end

    it 'item has authors' do
      #value saved in cassette
      authors = ["David Griffiths"]
      volume['volumeInfo']['authors'].should == authors
    end

    it 'item has thumbnail' do
      #value saved in cassette
      thumbnail = "http://bks3.books.google.com/books?id=jMCO096qlRsC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
      volume['volumeInfo']['imageLinks']['thumbnail'].should == thumbnail
    end

    it 'list of items have pagination attributes' do
      subject.first.per_page.should == Yetting.per_page
    end
  end
end
