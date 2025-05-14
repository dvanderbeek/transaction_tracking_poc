require_relative "status"

module TransactionTracking
  class Tracker
    def self.for(protocol)
      name = "#{protocol.capitalize}::TransactionTracking::Tracker"
      Object.const_get(name)
    end

    def status_for(tx_hash)
      raise NotImplementedError
    end
  end
end
