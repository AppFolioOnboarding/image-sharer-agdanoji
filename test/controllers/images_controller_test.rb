require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image0 = Image.create(url: 'http://www.toca-ch.com/data/walls/13/21748875.jpg', tag_list: '')
    @image1 = Image.create(url: 'https://i.ytimg.com/vi/I6mAvvG3Hmw/maxresdefault.jpg', tag_list: 'businessman')
    @image2 = Image.create(url: 'https://i.ytimg.com/vi/ViKQRKlQSpw/hqdefault.jpg', tag_list: 'manager, man')
  end

  test 'should get index' do
    get images_url
    assert_select 'img', count: 3
    assert_select 'img' do |images|
      assert_equal('https://i.ytimg.com/vi/ViKQRKlQSpw/hqdefault.jpg', images[0].attributes['src'].value)
      assert_equal('https://i.ytimg.com/vi/I6mAvvG3Hmw/maxresdefault.jpg', images[1].attributes['src'].value)
      assert_equal('http://www.toca-ch.com/data/walls/13/21748875.jpg', images[2].attributes['src'].value)
    end
    assert_select 'a.tag_name' do |tags|
      assert_equal('manager, man', tags[0].text)
      assert_equal('businessman', tags[1].text)
      assert_equal('', tags[2].text)
    end
  end

  test 'should get all images for empty search tag' do
    # empty tag filter should display all images
    get images_url, params: { search: '' }
    assert_select 'img' do |images|
      assert_equal(images.length, Image.count)
    end
    assert_response :success
  end

  test 'should give no images for unknown search tag' do
    get images_url, params: { search: 'hello' }
    list = css_select('img')
    assert_equal(list.count, 0)
    assert_response :success
  end

  test 'should give valid images for known search tag' do
    get images_url, params: { search: 'businessman' }
    assert_select 'img' do |images|
      assert_equal(images.length, 1)
    end
    assert_response :success
  end

  test 'should get new' do
    get new_image_url
    assert_response :success
  end

  test 'should create image' do
    assert_difference('Image.count') do
      post images_url,
           params: {
             image: {
               url: 'https://cdn.pixabay.com/photo/2013/08/22/19/18/rose-174817__340.jpg'
             }
           }
    end
    assert_redirected_to image_path(Image.last)
  end

  test 'invalid url should redirect to new' do
    assert_no_difference('Image.count') do
      post images_url,
           params: {
             image: {
               url: ''
             }
           }
    end
  end

  test 'should show image' do
    get image_url(@image1)
    assert_select 'p.tag_name' do |tag|
      assert_equal('businessman', tag[0].text)
    end
    assert_response :success
  end
end
