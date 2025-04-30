require_relative "tracker"

module TransactionTracking
  extend self

  # This represents the public API for TransactionTracking
  def track(protocol:, tx_hash:, &block)
    Tracker.new(protocol: protocol).track(tx_hash, &block)
  end
end
