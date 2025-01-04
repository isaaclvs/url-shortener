require_relative '../test_helper'

class ShortenerFeatureTest < Minitest::Test
  include Rack::Test::Methods

  def app
    App
  end

  def setup
    Url.dataset.delete
  end

  def test_shortening_and_redirecting
    get '/'
    assert last_response.ok?
    assert_includes last_response.body, 'URL Shortener'

    post '/shorten', url: 'https://www.google.com'
    assert last_response.redirect?
    follow_redirect!
    assert last_response.ok?

    url = Url.first
    assert_equal 'https://www.google.com', url.original_url
    assert url.short_code

    get "/#{url.short_code}"
    assert last_response.redirect?
    assert_equal 'https://www.google.com', last_response.location
  end

  def test_url_access_count
    post '/shorten', url: 'https://www.youtube.com'
    url = Url.first
    assert_equal 0, url.access_count

    3.times do
      get "/#{url.short_code}"
      follow_redirect!
    end

    url.refresh
    assert_equal 3, url.access_count
  end
end 