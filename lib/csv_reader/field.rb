module CsvReader

  class Field
    attr_accessor :str

    def initialize(str)
      self.str = String(str).strip
    end


    def value
      return nil if na? || str.blank?
      str
    end

    def to_s
      value.to_s
    end

    def ==(other)
      value == other
    end

    # TODO let the client do this via config/callback
    def na?
      str.downcase == "n/a"
    end

  end


  def self.Field(field)
    field.is_a?(Field) ? field : Field.new(field)
  end

end
