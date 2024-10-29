require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:original_url) }
    it { should validate_uniqueness_of(:short_url) }
  end

  describe 'callbacks' do
    it 'generates a short URL after create' do
      url = Url.create(original_url: 'http://google.com')
      expect(url.short_url).to be_present
    end

    it 'enqueues a crawl URL job after create' do
      url = Url.create(original_url: 'http://google.com')
      expect(CrawlUrlJob).to have_been_enqueued.with(url.original_url, url.id)
    end
  end

  describe '#generate_short_url' do
    it 'generates a short URL based on the ID' do
      url = Url.create(original_url: 'http://google.com')
      short_url = url.encode_to_base62(url.id)
      expect(url.short_url).to eq(short_url)
    end
  end

  describe '#increment_access_count' do
    it 'increments the access count' do
      url = Url.create(original_url: 'http://google.com', access_count: 0)
      url.increment_access_count
      expect(url.access_count).to eq(1)
    end
  end
end