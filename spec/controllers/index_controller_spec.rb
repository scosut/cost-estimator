require 'spec_helper'

describe "Our Index Controller" do
  include SpecHelper

  it "responds with a view titled 'Home' when we visit /" do
    get("/")
    expect(last_response.body.include?("Home")).to be(true)
  end
end