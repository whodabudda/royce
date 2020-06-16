require "application_system_test_case"

class ImageContainersTest < ApplicationSystemTestCase
  setup do
    @image_container = image_containers(:one)
  end

  test "visiting the index" do
    visit image_containers_url
    assert_selector "h1", text: "Image Containers"
  end

  test "creating a Image container" do
    visit image_containers_url
    click_on "New Image Container"

    fill_in "Name", with: @image_container.name
    click_on "Create Image container"

    assert_text "Image container was successfully created"
    click_on "Back"
  end

  test "updating a Image container" do
    visit image_containers_url
    click_on "Edit", match: :first

    fill_in "Name", with: @image_container.name
    click_on "Update Image container"

    assert_text "Image container was successfully updated"
    click_on "Back"
  end

  test "destroying a Image container" do
    visit image_containers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Image container was successfully destroyed"
  end
end
