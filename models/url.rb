require 'securerandom'

class Url < Sequel::Model
  def before_create
    self.short_code ||= generate_unique_code
    self.created_at ||= Time.now
    super
  end

  private

  def generate_unique_code
    loop do
      code = SecureRandom.alphanumeric(6)
      return code unless Url.where(short_code: code).first
    end
  end
end 