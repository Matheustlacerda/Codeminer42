require_relative "../lib/log_parser"

json_object = {
    "./spec/fixtures/test_file.log": {
    "lines": 10,
    "players": ["Isgalamido", "Mocinha", "Dono da Bola", "Zeh"],
    "kills": ["Dono da Bola"=> 1, "Isgalamido"=> 2],
    "total_kills": 2
    }
  }

describe '#read_first_line' do
  it 'file must exist' do 
    expect { LogParser.new('games.txt') }.to raise_error("File not found")
  end

  it 'must have the text' do 
    data = LogParser.new('./spec/fixtures/test_file.log')
    expect(data.read_first_line).to eq("  0:00 ------------------------------------------------------------\n")
  end
end

describe '#json_output' do
  it 'should return the number of lines, players, players kill and total kill in a json object' do
    data = LogParser.new('./spec/fixtures/test_file.log')
    expect(data.json_output).to eq(json_object)
  end
end
