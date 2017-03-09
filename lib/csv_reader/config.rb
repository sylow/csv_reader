module CsvReader

  def self.config
    @_config
  end

  def self.reset_config!
    @_config = {
      process_value: ->(val) { val }
    }
  end

  self.reset_config!

end
