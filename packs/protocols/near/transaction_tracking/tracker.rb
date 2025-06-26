require_relative "../../../features/transaction_tracking/tracker"
require_relative "../../../features/transaction_tracking/status"

module Near
  module TransactionTracking
    class Tracker
      include ::TransactionTracking::Tracker

      def status_for(transaction)
        status = [::TransactionTracking::Status::PENDING, ::TransactionTracking::Status::CONFIRMED].sample
        puts "[NEAR] fetching status: #{status} (sender address = #{transaction.details[:account_address]})"
        status
      end
    end
  end
end
