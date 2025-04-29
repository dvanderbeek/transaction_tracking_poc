module TransactionTracking
  module Interfaces
    module TransactionStatusFetcher
      def status_for(tx_hash)
        raise NotImplementedError
      end
    end
  end
end
