$LOAD_PATH.unshift(File.expand_path("packs", __dir__))
$LOAD_PATH.unshift(File.expand_path("packs/features/transaction_tracking", __dir__))
$LOAD_PATH.unshift(File.expand_path("support", __dir__))

require "transaction_tracking"

Dir.glob("packs/protocols/**/initializer.rb").each { |f| require_relative(f) }

tx_hash = "0xabc"

puts "[TRACKING] Starting to monitor #{tx_hash}..."
TransactionTracking.track(protocol: :ethereum, tx_hash:) do |new_status|
  puts "[TRACKING] Status updated to: #{new_status}"
end

# For a new protocol, we just need to implement:
# * transaction_tracker class
# * initializer to add ^ to registry

tx_hash = "solana-hash"

puts "[TRACKING] Starting to monitor #{tx_hash}..."
TransactionTracking.track(protocol: :solana, tx_hash:) do |new_status|
  puts "[TRACKING] Status updated to: #{new_status}"
end
