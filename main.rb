$LOAD_PATH.unshift(File.expand_path("packs", __dir__))
$LOAD_PATH.unshift(File.expand_path("packs/features/transaction_tracking", __dir__))
$LOAD_PATH.unshift(File.expand_path("support", __dir__))

require "transaction_tracking"

Dir.glob("packs/protocols/**/*.rb").each { |f| require_relative(f) }

# Simulating a database of transactions
database = []

[
  { tx_hash: "0xabc", status: nil, protocol: :ethereum },
  { tx_hash: "solana-tx-hash", status: nil, protocol: :solana },
  { tx_hash: "cosmos-tx-hash", status: nil, protocol: :cosmos },
  { tx_hash: "near-tx-hash", status: nil, protocol: :near, details: { account_address: "address-123" } },
].each do |attrs|
  TransactionTracking.create(database, attrs)
end

# Simulating a scheduled job to check for transactions that need to be monitored
database.select { |tx| tx.status.nil? }.each do |tx|
  puts "[TRACKING] Starting to monitor #{tx.tx_hash}..."

  TransactionTracking.track(transaction: tx) do |new_status|
    puts "[TRACKING] Status updated to: #{new_status}"
  end
end
