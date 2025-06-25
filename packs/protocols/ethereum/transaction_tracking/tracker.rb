require_relative "../../../features/transaction_tracking/tracker"
require_relative "../../../features/transaction_tracking/status"
require_relative "../support/fake_rpc"

module Ethereum
  module TransactionTracking
    class Tracker < ::TransactionTracking::Tracker
      # Maps an Ethereum-specific transaction status (from RPC or indexer)
      # to a standardized, canonical status defined in TransactionTracking::Status.
      #
      # @param tx_hash [String] the transaction hash to look up
      # @return [Symbol] one of {TransactionTracking::Status}
      #   - :pending
      #   - :confirmed
      #   - :failed
      #   - :dropped
      #   - :replaced (not used in Ethereum)
      #
      # @raise [RuntimeError] if the raw status cannot be mapped
      def status_for(transaction)
        case raw_status_for(transaction.tx_hash)
        when "pending", "0"
          ::TransactionTracking::Status::PENDING
        when "1", "confirmed", "success"
          ::TransactionTracking::Status::CONFIRMED
        when "failed", "error"
          ::TransactionTracking::Status::FAILED
        when "not_found", "dropped"
          ::TransactionTracking::Status::DROPPED
        else
          raise "Unknown Ethereum tx status: #{raw_status_for(transaction.tx_hash).inspect}"
        end
      end

      # Fetches protocol-specific status from external system (via fake RPC client)
      def raw_status_for(tx_hash)
        status = FakeRPC.status_for(tx_hash)
        puts "[ETH] fetching status: #{status}"
        status
      end
    end
  end
end
