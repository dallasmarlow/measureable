## counter

```ruby
## simple thread safe counters supporting increment, decrement, value and reset.
##
## you can optionally assign a default value for your counter at instantiation, 
## it can be a numeric value or another object that responds to increments and decrements.

counter = Measureable::Counter.new
 => #<Measureable::Counter:0x007fc3550f10c0 @counter=0>

counter.increment
 => 1

counter.decrement 20
 => -19

counter.value = 7
 => 7

counter.reset
 => 0
```

## counters

```ruby
## a collection of counters
##
## you can assign a default value for your counters at instantiation.

counters = Measureable::Counters.new
 => #<Measureable::Counters:0x007f9bfa094848 @default=0, @counters={}>

# new counters are created for you by default
counters.example_counter
 => #<Measureable::Counter:0x007f9bfa088930 @counter=0, @default=0> 

counters.another_example_counter.increment
 => 1

# counter group access
counters.counters
 => {:example_counter=>#<Measureable::Counter:0x007f9bf996add8 @counter=0, @default=0>, :another_example_counter=>#<Measureable::Counter:0x007f9bf992dfa0 @counter=1, @default=0, @mutex=#<Mutex:0x007f9bf992dbb8>}

counters.values
 => [0, 1]

## aggregate math methods 

# populate some values
keys = *'a'..'z'
(10 ** 4).times do
  counters.counter(keys.sample).increment rand
end

counters.sum
 => 5473.699595427909

counters.mean
 => 195.48927126528247

counters.median
 => 206.42217200795383

counters.variance
 => 1763.654019136207

counters.standard_deviation
 => 41.995880978212696
```

## latency
```ruby
timers = Measureable::Counters.new

# measure total time spent in sleep
10.times do
  Measureable.latency timers.sleep do
    sleep rand
  end
end

timers.sleep.value
 => 6.510800000000001

# measure time spent in each sleep
sleep_timers = Measureable::Counters.new
10.times do |i|
  Measureable.latency sleep_timers.counter i do
    sleep rand
  end
end

sleep_timers.sum
 => 4.646647

sleep_timers.mean
 => 0.4646647

sleep_timers.standard_deviation
 => 0.3255162689160113

```