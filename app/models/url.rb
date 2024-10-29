class Url < ApplicationRecord
  after_create :generate_short_url

  after_create :enqueue_crawl_url_job

  validates :original_url, presence: true
  validates :short_url, uniqueness: true, allow_nil: true

  def generate_short_url
    self.update_column(:short_url, encode_to_base62(id))
  end

  def encode_to_base62(num)
    chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
    base = chars.length
    result = ''

    while num > 0
      result << chars[num % base]
      num /= base
    end

    result.reverse
  end

  # Increment the access count
  def increment_access_count
    self.increment!(:access_count)
  end

  def enqueue_crawl_url_job
    CrawlUrlJob.perform_later(original_url, id)
  end
end
