require 'spec_helper'
require 'main.rb'

describe "Main" do
  it "must have the text" do
    expect(main.open_file).to eq("  0:00 ------------------------------------------------------------")
  end
end