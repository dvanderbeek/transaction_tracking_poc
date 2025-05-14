require_relative "tracker"

module TransactionTracking
  extend self

  # This represents the public API for TransactionTracking
  def track(protocol:, tx_hash:, &block)
    tracker = Tracker.for(protocol).new

    loop do
      status = tracker.status_for(tx_hash)
      if status.terminal?
        block.call(status)
        break
      end
      sleep 1
    end
  rescue NameError
    puts "Transaction Tracking not implemented for #{protocol}"
  end
end
