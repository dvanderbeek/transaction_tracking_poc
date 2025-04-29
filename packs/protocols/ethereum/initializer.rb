require_relative "../../features/transaction_tracking/registry"
require_relative "transaction_tracker"

TransactionTracking::Registry.register(:ethereum, Ethereum::TransactionTracker)
