require_relative "tracker"

module TransactionTracking
  class Transaction
    attr_accessor :tx_hash, :protocol, :details, :status

    DATABASE = []

    def initialize(attrs)
      @attrs = attrs
      attrs.each { |k, v| send("#{k}=", v) if respond_to?("#{k}=") }
    end

    def self.create(attrs)
      DATABASE << new(attrs)
    end

    def self.select(&block)
      DATABASE.select &block
    end

    def track(&block)
      loop do
        self.status = tracker.status_for(self)
        if status.terminal?
          block.call(status) if block_given? # Using a block as a callback here, but we would probably do something like the `.confirm!` method or emit an event
          break
        end
        sleep 1
      end
    rescue NameError
      puts "Transaction Tracking not implemented for #{protocol}"
    end

    def tracker
      Tracker.for(protocol).new
    end
  end
end
