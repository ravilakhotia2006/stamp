# these events are sent via communication module

class Event
  class << self
    def notify(*args)
      puts "sending event with args #{args.join(', ')}"
    end
  end
end
