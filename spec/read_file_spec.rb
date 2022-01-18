require 'spec_helper'
require_relative "../lib/read_file"

describe '#open_file' do
  it 'must have the text' do
    first_line = ReadFile.new.open_file('spec/test_file.log')

    expect(first_line).to eq('0:00 ------------------------------------------------------------')

  end

  it 'must return error' do
    first_line = ReadFile.new.open_file('games.txt')

    expect(first_line).to eq('error: not the right file')
  end
end
