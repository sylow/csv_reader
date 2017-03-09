require 'spec_helper'

RSpec.describe CsvReader::Reader do
  let(:csv) {
    StringIO.new(
      <<~CSV
        head1, head2
        data11, data12
        data21, N/A, superfluous
      CSV
    )
  }

  let(:mapping) { nil }
  let(:reader) { CsvReader::Reader.new(csv, mapping: mapping) }


  it "reads in the header" do
    expect(reader.header[0]).to eq('head1')
    expect(reader.header[1]).to eq('head2')
  end

  it "reads in the data" do
    expect(reader.data.first[0]).to eq('data11')
    expect(reader.data.first[1]).to eq('data12')
    expect(reader.data.last[0]).to  eq('data21')
    expect(reader.data.last[1]).to  eq(nil)
  end

  it "connects the data to the header" do
    expect(reader.data.first).to have_header
    expect(reader.data.last).to have_header
  end

  it "can enumerate over the data" do
    reader.each do |row|
      expect(row).to be_present
    end
  end


  context "with a mapping" do
    let(:mapping) {
      {
        h1: 'head1',
        h2: 'head2'
      }.to_proc
    }

    it "forwards the mapping to its data" do
      expect(reader.data.first.mapping).to eq(mapping)
    end
  end


  context "with DOS style line endings" do
    let(:csv) { super().string.gsub("\n", "\r\n") }

    it "still works" do
      expect(reader.data.first[0]).to eq('data11')
      expect(reader.data.first[1]).to eq('data12')
    end
  end

  context "with faulty DOS style line endings with double \r" do
    let(:csv) { super().string.gsub("\n", "\r\r\n") }

    it "still works" do
      expect(reader.data.first[0]).to eq('data11')
      expect(reader.data.first[1]).to eq('data12')
    end
  end

end
