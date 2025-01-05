require_relative '../test_helper'

class UrlTest < Minitest::Test
  def setup
    Url.dataset.delete
  end

  def test_validates_presence_of_url
    url = Url.new
    refute url.valid?
    assert url.errors.has_key?(:original_url)
  end

  def test_validates_url_format
    url = Url.new(original_url: 'not a url')
    refute url.valid?
    assert url.errors.has_key?(:original_url)
  end

  def test_generates_short_code
    url = Url.create(original_url: 'https://example.com')
    assert url.short_code
    assert_equal 6, url.short_code.length
  end

  def test_short_code_is_unique
    url1 = Url.create(original_url: 'https://example.com')
    url2 = Url.create(original_url: 'https://example.org')
    refute_equal url1.short_code, url2.short_code
  end
end