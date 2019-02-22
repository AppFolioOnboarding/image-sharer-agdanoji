require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @url0 = 'https://albertonrecord.co.za/wp-content/uploads/sites/35/2018/03/OnlineCartoonsTom_12731-520x390.jpg'
    @url1 = 'https://image.freepik.com/free-vector/sad-businessman-without-money_23-2147619715.jpg'
    @url2 = 'https://image.freepik.com/free-vector/aim-manager-ideas-worker-telephone_1302-4833.jpg'
    @image0 = Image.create(url: @url0)
    @image1 = Image.create(url: @url1)
    @image2 = Image.create(url: @url2)
  end

  test 'should get index' do
    get images_url
    assert_select 'img', count: 3
    assert_select 'img' do |images|
      assert_equal(@url0, images[0].attributes['src'].value)
      assert_equal(@url1, images[1].attributes['src'].value)
      assert_equal(@url2, images[2].attributes['src'].value)
    end
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
    assert_response :success
  end
end
