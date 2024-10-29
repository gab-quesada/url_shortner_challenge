class CrawlUrlJob < ApplicationJob
  queue_as :default

  def perform(original_url, url_id)
    response = HTTParty.get(original_url)
    title = extract_title(response.body)
    
    url_record = Url.find(url_id)
    url_record.update(title: title) if url_record && title
  end

  private

  def extract_title(html)
    doc = Nokogiri::HTML(html)
    title = doc.at('title')
    title ? title.text : "No Title"
  end
end
