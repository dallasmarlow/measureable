# measureable
$:.unshift File.join File.dirname(__FILE__), 'measureable'
require 'counters'

module Measureable
  def self.latency counter
    checkpoint = Time.now
    yield
    counter.increment Time.now - checkpoint
  end
end
