require 'date'
require './app/models/feed'

describe Feed do
  describe '.format_time' do
    context 'When difference is less than a minute' do
      it "returns 'Just now'" do
        DateTime.stub_chain(:now, :new_offset).and_return(DateTime.parse('2013-05-20T17:51:51+00:00'))
        time = DateTime.parse('Mon, 20 May 2013 17:50:55 UTC +00:00')
        expect(Feed.format_time(time)).to eq 'Just now'
      end
    end

    context 'When the difference is less than an hour but great than a minute' do
      it "returns '[minutes] minutes ago'" do
        DateTime.stub_chain(:now, :new_offset).and_return(DateTime.parse('2013-05-20T17:59:51+00:00'))
        time = DateTime.parse('Mon, 20 May 2013 17:55:55 UTC +00:00')
        expect(Feed.format_time(time)).to eq '3 minutes ago'
      end
    end

    context 'When the difference is less than a day but at least an hour' do
      it "returns '[hours] hours ago'" do
        DateTime.stub_chain(:now, :new_offset).and_return(DateTime.parse('2013-05-20T19:55:51+00:00'))
        time = DateTime.parse('Mon, 20 May 2013 17:55:55 UTC +00:00')
        expect(Feed.format_time(time)).to eq '1 hour ago'
      end
    end

    context 'When the difference is a day or more' do
      it 'returns the date it was published' do
        DateTime.stub_chain(:now, :new_offset).and_return(DateTime.parse('2013-08-20T17:59:51+00:00'))
        time = DateTime.parse('Mon, 20 May 2013 17:55:55 UTC +00:00')
        expect(Feed.format_time(time)).to eq '20 May'
      end
    end
  end
end
