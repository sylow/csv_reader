require 'spec_helper'

RSpec.describe CsvReader::Row do
  let(:header)  { CsvReader::Row.new(%w(h1 h2)) }
  let(:mapping) { nil }
  let(:row)     { CsvReader::Row.new(%w(d1 d2), header: header, mapping: mapping) }


  it "connects the data to the header" do
    expect(row['h1']).to eq('d1')
    expect(row['h2']).to eq('d2')
  end

  describe "extracting a subset of fields from a row" do
    it "works with a range" do
      expect(row[1..1]['h2']).to eq('d2')
    end

    it "works with an index and a length" do
      expect(row[1, 1]['h2']).to eq('d2')
    end

    context "with a mapping" do
      let(:mapping) {
        {
          heading: ->(i) { :"heading#{i}" },
          heading1: 'h1',
          heading2: 'h2',
        }.to_proc
      }
      it "works with an mappable key and argument" do
        expect(row[:heading, 2]).to eq('d2')
        expect(row.heading(2)).to eq('d2')
      end
    end
  end


  context "with a mapping" do
    let(:mapping) {
      {
        a: 'h1',
        b: 'h2',
        c: 'h2'
      }.to_proc
    }

    it "can refer to fields by the new mapping" do
      expect(row[:a]).to eq('d1')
      expect(row[:b]).to eq('d2')
      expect(row[:c]).to eq('d2')

      expect(row.a).to eq('d1')
      expect(row.b).to eq('d2')
      expect(row.c).to eq('d2')
    end

    it "can not refer to fields by the original headers" do
      expect(row['h1']).to be_nil
      expect(row['h2']).to be_nil
    end
  end


  describe "#has_na?" do
    context "without n/a fields" do
      it "returns false" do
        expect(CsvReader::Row.new(%w(d1 d2))).not_to have_na
      end
    end

    context "with n/a fields" do
      it "returns true" do
        expect(CsvReader::Row.new(%w(d1 N/A))).to have_na
      end
    end
  end

end
