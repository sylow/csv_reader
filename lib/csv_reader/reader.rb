module CsvReader

  class Reader
    attr_accessor :header, :data, :mapping

    include Enumerable

    def initialize(input, mapping: nil)
      data = input.is_a?(Array) ? input : CSV.new(input).read
      if data.count >= 1
        self.header = Row.new(data[0])
        header.header = header
      end
      self.data = data[1..-1].map {|row| Row.new(row, header: header, mapping: mapping) }
    end


    def each(&block)
      data.each {|row| block.call(row) }
    end

  end

end
