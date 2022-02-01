# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/log_parser'

describe LogParser do
  describe '#initialize' do
    it 'file must exist' do
      expect { LogParser.new('games.txt') }.to raise_error('File not found')
    end

    it 'must have the text' do
      data = LogParser.new('./spec/fixtures/test_file.log')
      expect(data.read_first_line).to eq("  0:00 ------------------------------------------------------------\n")
    end
  end

  describe '#json_output' do
    it 'must return the number of lines in a json object' do
      data = LogParser.new('./spec/fixtures/test_file.log')
      expect(data.json_output).to eq({ './spec/fixtures/test_file.log':
        { 'lines': 10, 'players': ['Isgalamido', 'Mocinha', 'Dono da Bola', 'Zeh'] } })
    end
  end
end
