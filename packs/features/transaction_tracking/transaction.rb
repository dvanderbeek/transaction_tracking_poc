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
        status = tracker.status_for(self)
        self.status = status
        if status.terminal?
          block.call(status) if block_given?
          break
        end
        sleep 1
      end
    end

    def tracker
      Tracker.for(protocol).new
    rescue NameError
      puts "Transaction Tracking not implemented for #{protocol}"
    end
  end
end
