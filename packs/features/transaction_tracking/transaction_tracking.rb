require_relative "tracker"

module TransactionTracking
  extend self

  # This represents the public API for TransactionTracking
  def track(tracker:, tx_hash:, &block)
    loop do
      status = tracker.status_for(tx_hash)
      if status.terminal?
        block.call(status)
        break
      end
      sleep 1
    end
  end
end
