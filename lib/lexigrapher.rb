require "lexigrapher/version"
require "lexigrapher/regexp/regexp"

module Lexigrapher
  class Parser
    attr_reader :v, :type

    def initialize(value)
      @v    = value
      @type = value ? try_types(methods) : :nil
    end

    # Tail Recurse through all methods specified
    def try_types(methods)
      method, remaining = methods.first, methods[1..-1]
      type = self.send method

      type ? type : try_types(remaining)
    end

    # Define the fallthrough order. I would rather be explicit here, so as for customization.
    def methods
      [
        :int?, :float?, :symbol?, :hash?, :array?,                 # Primatives
        :date?, :phone?, :email?, :url?, :ipv4?, :ipv6?, :gender?, # Extensions
        :str?, :nil?, :unknown?                                    # Primitives fallback
      ]
    end

    # As much as I don't like Rescue for flow control, it is considerably nicer than the potential REGEXP
    # that would have replaced it. The same can be said for everything using Rescue below.

    def int?
      :integer if Integer(v) rescue nil
    end

    def float?
      :float if Float(v) rescue nil
    end

    def symbol?
      :symbol if v[0] == ':'
    end

    def date?
      :date if v.match(StrRegexp::DATE)
    end

    def hash?
      :hash if v.match(StrRegexp::HASH)
    end

    def array?
      :array if v.match(StrRegexp::ARRAY)
    end

    def phone?
      :phone if v.match(StrRegexp::PHONE)
    end

    def email?
      :email if v.match(StrRegexp::EMAIL)
    end

    def url?
      :url if v.match(StrRegexp::URL)
    end

    def ipv4?
      :ipv4 if v.match(StrRegexp::IPV4)
    end

    def ipv6?
      :ipv6 if v.match(StrRegexp::IPV6)
    end

    def gender?
      :gender if v.match(StrRegexp::GENDER)
    end

    # Fallbacks

    def str?
      :str if v
    end

    def nil?
      :nil if v.nil?
    end

    # Emergency Fallback

    def unknown?
      :unknown
    end
  end
end
