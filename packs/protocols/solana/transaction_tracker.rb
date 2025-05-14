require_relative "../../features/transaction_tracking/tracker"
require_relative "../../features/transaction_tracking/status"

module Solana
  class TransactionTracker < TransactionTracking::Tracker
    def status_for(tx_hash)
      status = [TransactionTracking::Status::PENDING, TransactionTracking::Status::CONFIRMED].sample
      puts "[SOL] fetching status: #{status}"
      status
    end
  end
end
