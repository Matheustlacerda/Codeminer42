require 'spec_helper'
require_relative "../main"

describe 'Main' do
  it 'must have the text' do
    first_line = Main.new.open_file('games.log')

    expect(first_line).to eq('0:00 ------------------------------------------------------------')

  end

  it 'must return error' do
    first_line = Main.new.open_file('games.txt')

    expect(first_line).to eq('error: not the right file')
  end
end