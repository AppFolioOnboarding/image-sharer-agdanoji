require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  def test_url__nil
    image = Image.new(url: nil)
    assert_not image.valid?
  end

  def test_url__blank
    image = Image.new(url: ' ')
    assert_not image.valid?
  end

  def test_url__invalid_start
    image = Image.new(url: 'htp:/domain.jpg')
    assert_not image.valid?
  end

  def test_url__invalid_end
    image = Image.new(url: 'http:/domain')
    assert_not image.valid?
  end
end
