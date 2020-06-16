require "application_system_test_case"

class DrawingsTest < ApplicationSystemTestCase
  setup do
    @drawing = drawings(:one)
  end

  test "visiting the index" do
    visit drawings_url
    assert_selector "h1", text: "Drawings"
  end

  test "creating a Drawing" do
    visit drawings_url
    click_on "New Drawing"

    fill_in "Comment", with: @drawing.comment
    fill_in "Created on date", with: @drawing.created_on_date
    fill_in "Moniker", with: @drawing.moniker
    fill_in "Picture", with: @drawing.picture
    fill_in "Title", with: @drawing.title
    click_on "Create Drawing"

    assert_text "Drawing was successfully created"
    click_on "Back"
  end

  test "updating a Drawing" do
    visit drawings_url
    click_on "Edit", match: :first

    fill_in "Comment", with: @drawing.comment
    fill_in "Created on date", with: @drawing.created_on_date
    fill_in "Moniker", with: @drawing.moniker
    fill_in "Picture", with: @drawing.picture
    fill_in "Title", with: @drawing.title
    click_on "Update Drawing"

    assert_text "Drawing was successfully updated"
    click_on "Back"
  end

  test "destroying a Drawing" do
    visit drawings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Drawing was successfully destroyed"
  end
end
