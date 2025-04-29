module FakeRPC
  extend self

  def status_for(tx_hash)
    @calls ||= {}
    @calls[tx_hash] = (@calls[tx_hash] || 0) + 1

    return "pending" if @calls[tx_hash] < 5
    "1"
  end
end
