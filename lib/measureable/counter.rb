require 'thread'

module Measureable
  class Counter

    def initialize value = 0
      @counter = value
    end

    def mutex
      @mutex ||= Mutex.new
    end

    def value
      mutex.synchronize do
        @counter
      end
    end

    def increment amount = 1
      mutex.synchronize do
        @counter += amount
      end
    end

    def decrement amount = 1
      mutex.synchronize do
        @counter -= amount
      end
    end

    def reset
      mutex.synchronize do
        @counter = nil
      end
    end

  end
end