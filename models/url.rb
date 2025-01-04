require 'securerandom'

class Url < Sequel::Model
  def validate
    super
    errors.add(:original_url, 'cannot be empty') if !original_url || original_url.empty?
    errors.add(:original_url, 'must be a valid URL') unless valid_url?(original_url)
  end

  def before_create
    self.short_code ||= generate_unique_code
    self.created_at ||= Time.now
    self.access_count ||= 0
    super
  end

  def increment_access_count!
    self.update(access_count: access_count + 1)
  end

  private

  def generate_unique_code
    loop do
      code = SecureRandom.alphanumeric(6)
      return code unless Url.where(short_code: code).first
    end
  end

  def valid_url?(url)
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  rescue URI::InvalidURIError
    false
  end
end 