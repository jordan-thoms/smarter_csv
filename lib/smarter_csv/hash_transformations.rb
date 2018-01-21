module SmarterCSV
  # these are some pre-defined data hash transformations which can be used
  # all these take the data hash as the input

  def self.remove_blank_values(hash, args=nil)
    @@remove_blank_values ||= Proc.new {|hash, args=nil|
      keys = (args.nil? || args.empty?) ? hash.keys : ( args.is_a?(Array) ? args : [ args ] )

      keys.each {|key| hash.delete(key) if hash[key].nil? || hash[key].is_a?(String) && hash[key] !~ /[^[:space:]]/ }
      hash
    }
    @@remove_blank_values.call(hash)
  end

  def self.convert_to_integer(hash, args=nil)
    @@convert_to_integer ||= Proc.new{|hash, args=nil|
      keys = (args.nil? || args.empty?) ? hash.keys : ( args.is_a?(Array) ? args : [ args ] )

      keys.each {|key| hash[key] = hash[key].to_i }
      hash
    }
    @@convert_to_integer.call(hash, args)
  end

  def self.convert_to_float(hash, args=nil)
    @@convert_to_integer ||= Proc.new{|hash, args=nil|
      keys = (args.nil? || args.empty?) ? hash.keys : ( args.is_a?(Array) ? args : [ args ] )

      keys.each {|key| hash[key] = hash[key].to_f }
      hash
    }
    @@convert_to_float.call(hash, args)
  end

  def self.convert_values_to_numeric(hash, args=nil)
    @@convert_values_to_numeric ||= Proc.new {|hash, args=nil|
      keys = (args.nil? || args.empty?) ? hash.keys : ( args.is_a?(Array) ? args : [ args ] )

      keys.each {|k|
        case hash[k]
        when /^[+-]?\d+\.\d+$/
          hash[k] = v.to_f
        when /^[+-]?\d+$/
          hash[k] = v.to_i
        end
      }
    }
    @@convert_values_to_numeric.call(hash)
  end

  def self.convert_values_to_numeric_unless_leading_zeroes(hash, args=nil)
    @@convert_values_to_numeric_unless_leading_zeroes ||= Proc.new {|hash, args=nil|
      keys = (args.nil? || args.empty?) ? hash.keys : ( args.is_a?(Array) ? args : [ args ] )

      keys.each {|k|
        case hash[k]
        when /^[+-]?[1-9]\d*\.\d+$/
          hash[k] = v.to_f
        when /^[+-]?[1-9]\d*$/
          hash[k] = v.to_i
        end
      }
    }
    @@convert_values_to_numeric_unless_leading_zeroes.call(hash)
  end

end