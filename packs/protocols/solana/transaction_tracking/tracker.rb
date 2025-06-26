require_relative "../../../features/transaction_tracking/tracker"
require_relative "../../../features/transaction_tracking/status"

module Solana
  module TransactionTracking
    class Tracker
      include ::TransactionTracking::Tracker

      def status_for(transaction)
        status = [::TransactionTracking::Status::PENDING, ::TransactionTracking::Status::CONFIRMED].sample
        puts "[SOL] fetching status: #{status}"
        status
      end
    end
  end
end
