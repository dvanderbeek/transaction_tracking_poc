require_relative "registry"
require_relative "status"

module TransactionTracking
  class Tracker
    def initialize(protocol:)
      @impl = Registry.fetch(protocol).new
    end

    def status_for(tx_hash)
      @impl.status_for(tx_hash)
    end

    def track(tx_hash, &block)
      loop do
        status = status_for(tx_hash)
        if status.terminal?
          block.call(status)
          break
        end
        sleep 1
      end
    end
  end
end
