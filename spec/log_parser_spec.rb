require_relative "../lib/log_parser"

describe '#read_first_line' do
    it 'file must exist' do 
      expect { LogParser.new('games.txt') }.to raise_error("File not found")
    end

    it 'must have the text' do 
        data = LogParser.new('games.log')
        expect(data.read_first_line).to match("  0:00 ------------------------------------------------------------\n")
    end
end
