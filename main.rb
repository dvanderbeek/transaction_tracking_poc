$LOAD_PATH.unshift(File.expand_path("packs", __dir__))
$LOAD_PATH.unshift(File.expand_path("packs/features/transaction_tracking", __dir__))
$LOAD_PATH.unshift(File.expand_path("support", __dir__))

require "transaction_tracking"

Dir.glob("packs/protocols/**/*.rb").each { |f| require_relative(f) }

# Simulating a database of transactions
database = [
  { tx_hash: "0xabc", status: nil, protocol: :ethereum },
  { tx_hash: "solana-tx-hash", status: nil, protocol: :solana },
]

trackers = {
  ethereum: Ethereum::TransactionTracker,
  solana: Solana::TransactionTracker
}

# Simulating a scheduled job to check for transactions that need to be monitored
database.select { |tx| tx[:status].nil? }.each do |tx|
  puts "[TRACKING] Starting to monitor #{tx[:tx_hash]}..."

  # We could use a factory method here, or a convention for what these classes should be called
  # For now, I just set up the hash above
  tracker = trackers[tx[:protocol]].new

  TransactionTracking.track(tracker: , tx_hash: tx[:tx_hash]) do |new_status|
    puts "[TRACKING] Status updated to: #{new_status}"
  end
end
