module Piglet
  class Load
    def initialize(path)
      @path = path
    end
    
    def using(method)
      @method = method
      self
    end
    
    def as(*schema)
      @schema = schema
      self
    end
    
    def to_pig_latin
      str = "LOAD '#{@path}'"
      str << " USING #{method_name}" if @method
      str << " AS (#{schema_string})" if @schema
      str
    end
  
  private
  
    def method_name
      case @method
      when :pig_storage
        'PigStorage'
      else
        @method
      end
    end
    
    def schema_string
      @schema.map do |field|
        if field.is_a?(Enumerable)
          field.map { |f| f.to_s }.join(':')
        else
          field.to_s
        end
      end.join(', ')
    end
    
  end
end