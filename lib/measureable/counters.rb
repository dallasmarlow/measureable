require 'counter'

module Measureable
  class Counters
    attr_accessor :default, :counters

    def initialize value = 0
      @default  = value
      @counters = {}
    end

    def counter counter
      counters[counter] ||= Counter.new default
    end

    def values
      counters.collect do |id, counter|
        counter.value
      end
    end

    def sum
      values.reduce :+
    end

    def mean
      sum.to_f / counters.count
    end
    alias_method :average, :mean

    def median
      values.sort[counters.count / 2]
    end

    def variance
      values.reduce {|deviation_sum, value| deviation_sum + (value - mean) ** 2} / counters.count
    end

    def standard_deviation
      Math.sqrt variance
    end

    def method_missing method, *args
      counter method
    end

  end
end