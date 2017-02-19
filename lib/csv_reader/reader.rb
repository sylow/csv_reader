module CsvReader

  class Reader
    attr_accessor :header, :data, :mapping

    include Enumerable

    def initialize(input, mapping: nil)
      data = read_csv(input)
      if data.count >= 1
        self.header = Row.new(data[0])
        header.header = header
      end
      self.data = data[1..-1].map {|row| Row.new(row, header: header, mapping: mapping) }
    end


    def each(&block)
      data.each {|row| block.call(row) }
    end


    private

      def read_csv(input)
        return input if input.is_a?(Array)

        input = input.read if input.respond_to?(:read) # File/StringIO -> String
        input = input.to_s
        input.tr!("\r", "")

        CSV.new(input).read
      end

  end

end
