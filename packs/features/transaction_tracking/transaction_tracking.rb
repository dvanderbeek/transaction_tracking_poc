require_relative "tracker"
require_relative "transaction"

module TransactionTracking
  extend self

  def create(db, attrs)
    db << Transaction.new(attrs)
  end

  # This represents the public API for TransactionTracking
  def track(transaction:, &block)
    protocol = transaction.protocol
    tracker = Tracker.for(protocol).new

    loop do
      status = tracker.status_for(transaction)
      transaction.status = status
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
