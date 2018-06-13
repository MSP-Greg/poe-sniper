require 'spec_helper'

RSpec.describe "cliboard" do
  it "can place ; to cliboard" do
    skip unless Gem.win_platform?
    expect { Clipboard.set_data("test;", format = Clipboard::UNICODETEXT) }.not_to raise_error
  end
end
