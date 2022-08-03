require 'spec_helper'

RSpec.describe Cart do
  it "has a version number" do
    expect(Cart::VERSION).not_to be nil
  end
end
