require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image = images(:one)
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
    get image_url(@image)
    assert_response :success
  end
end
