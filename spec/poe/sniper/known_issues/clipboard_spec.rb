require 'spec_helper'

RSpec.describe "cliboard" do
  it "can place ; to cliboard" do
    skip unless Gem.win_platform?
    text = "@Rabuarc Hi, I would like to buy your The Hoarder listed for 10 chaos in Incursion (stash tab D; position: left 19, top 1)"
    expect { Clipboard.set_data(text, format = Clipboard::UNICODETEXT) }.not_to raise_error
    text2 = "@WanderDay Hi, I would like to buy your The Hoarder listed for 10 chaos in Incursion (stash tab $; position: left 6, top 4)"
    expect { Clipboard.set_data(text2, format = Clipboard::UNICODETEXT) }.not_to raise_error
  end
end
