require_relative "status"

module TransactionTracking
  class Tracker
    def status_for(tx_hash)
      raise NotImplementedError
    end
  end
end
