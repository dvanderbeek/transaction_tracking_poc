require_relative "../../features/transaction_tracking/interfaces/transaction_status_fetcher"
require_relative "../../features/transaction_tracking/status"

module Solana
  class TransactionTracker
    include TransactionTracking::Interfaces::TransactionStatusFetcher

    def status_for(tx_hash)
      status = [TransactionTracking::Status::PENDING, TransactionTracking::Status::CONFIRMED].sample
      puts "[SOL] fetching status: #{status}"
      status
    end
  end
end
