require 'spec_helper'

RSpec.describe CsvReader::Field do
  describe "#na?" do
    it "is false if the field isn't N/A" do
      expect(CsvReader::Field.new("something")).not_to be_na
    end

    it "is true if the field is N/A" do
      expect(CsvReader::Field.new("n/a")).to be_na
      expect(CsvReader::Field.new("N/A")).to be_na
      expect(CsvReader::Field.new("N/a")).to be_na
    end
  end

  describe "#value" do
    it "returns the value if it's given" do
      expect(CsvReader::Field.new("test").value).to eq("test")
    end

    it "returns nil if it's empty" do
      expect(CsvReader::Field.new(" ").value).to eq(nil)
    end

    it "returns nil if it's N/A" do
      expect(CsvReader::Field.new("N/A").value).to eq(nil)
    end
  end

  describe "#to_s" do
    it "returns the value as a string" do
      expect(CsvReader::Field.new(" ").to_s).to eq("")
      expect(CsvReader::Field.new("test ").to_s).to eq("test")
    end
  end
end
