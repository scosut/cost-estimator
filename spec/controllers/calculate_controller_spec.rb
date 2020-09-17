require 'spec_helper'

describe "Our Calculate Controller" do
  include SpecHelper

  it "responds with a view titled 'Calculate' when we visit /calculate" do
    get("/calculate")
    expect(last_response.body.include?("Calculate")).to be(true)
  end
end