require 'rails_helper'

RSpec.describe "breeds/edit", type: :view do
  before(:each) do
    @breed = assign(:breed, Breed.create!(
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit breed form" do
    render

    assert_select "form[action=?][method=?]", breed_path(@breed), "post" do

      assert_select "input#breed_name[name=?]", "breed[name]"

      assert_select "textarea#breed_description[name=?]", "breed[description]"
    end
  end
end
