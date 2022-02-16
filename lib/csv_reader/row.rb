module CsvReader

  class Row
    class NoHeader < StandardError; end

    include Enumerable

    attr_accessor :fields, :header, :mapping


    def initialize(fields, header: nil, mapping: nil)
      self.fields = fields.map { |field|
        CsvReader::Field(field)
      }
      self.header  = header
      self.mapping = mapping || Proc.new(&:to_s)
    end


    ##### Enumeration
    def each(&block)
      fields.each {|field| block.call(field) }
    end

    def has_na?
      any?(&:na?)
    end


    ##### Access to fields
    def [](key, *args)
      case key
      when Integer
        args.none? ?
          fields[key] :
          Row.new(fields[key, args.first], header: header && header[key, args.first])
      when Range
        Row.new(fields[key], header: header && header[key])
      else
        mapped = mapping.(key)
        mapped.respond_to?(:call) ?
          self[*Array(mapped.(*args))] :
          mapped.is_a?(Integer) ? self[mapped] : to_h[mapped]
      end
    end

    def value(key)
      self[key]&.value
    end
    def values(keys)
      Hash[keys.map {|key|
        [key, value(key)]
      }]
    end

    def method_missing(key, *args)
      self[key, *args]
    end

    def to_h
      raise NoHeader unless has_header?
      Hash[header.map(&:value).zip(fields)]
    end


    def has_header?
      !!header
    end

  end

end
