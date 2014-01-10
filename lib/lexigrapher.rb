#require "lexigrapher/version"

require 'date'

module Lexigrapher
  class Parser
    attr_reader :v, :type

    def initialize(value)
      @v    = value
      @type = value ? try_types(methods) : :nil
    end

    def try_types(methods)
      method, remaining = methods.first, methods[1..-1]
      type = self.send method

      type ? type : try_types(remaining)
    end

    # Define the fallthrough order. I would rather be explicit here, so as for customization.
    def methods
      [:int?, :float?, :symbol?, :date?, :hash?, :array?, :str?, :nil?, :unknown?]
    end

    def int?
      :integer if Integer(v) rescue nil
    end

    def float?
      :float if Float(v) rescue nil
    end

    def symbol?
      :symbol if v[0] == ':'
    end

    def hash?
      :hash if v[0] == '{' && v[1] == '}'
    end

    def array?
      :array if v[0] == '[' && v[1] == ']'
    end

    def date?
      :date if Date.parse(v) rescue nil
    end

    def nil?
      :nil if v.nil?
    end

    def unknown?
      :unknown
    end

    def str?
      :str if v
    end
  end
end
