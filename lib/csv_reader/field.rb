module CsvReader

  class Field
    attr_accessor :str

    def initialize(str)
      self.str = String(str).strip
    end


    def value
      return nil if str.blank?
      CsvReader.config[:process_value].(str)
    end

    def to_s
      value.to_s
    end

    def ==(other)
      value == other
    end

  end


  def self.Field(field)
    field.is_a?(Field) ? field : Field.new(field)
  end

end
