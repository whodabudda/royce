require 'test_helper'

class ImageContainersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image_container = image_containers(:one)
  end

  test "should get index" do
    get image_containers_url
    assert_response :success
  end

  test "should get new" do
    get new_image_container_url
    assert_response :success
  end

  test "should create image_container" do
    assert_difference('ImageContainer.count') do
      post image_containers_url, params: { image_container: { name: @image_container.name } }
    end

    assert_redirected_to image_container_url(ImageContainer.last)
  end

  test "should show image_container" do
    get image_container_url(@image_container)
    assert_response :success
  end

  test "should get edit" do
    get edit_image_container_url(@image_container)
    assert_response :success
  end

  test "should update image_container" do
    patch image_container_url(@image_container), params: { image_container: { name: @image_container.name } }
    assert_redirected_to image_container_url(@image_container)
  end

  test "should destroy image_container" do
    assert_difference('ImageContainer.count', -1) do
      delete image_container_url(@image_container)
    end

    assert_redirected_to image_containers_url
  end
end
