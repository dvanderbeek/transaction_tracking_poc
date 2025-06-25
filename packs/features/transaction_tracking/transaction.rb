module TransactionTracking
  class Transaction
    attr_accessor :tx_hash, :protocol, :details, :status

    def initialize(attrs)
      @attrs = attrs
      attrs.each { |k, v| send("#{k}=", v) if respond_to?("#{k}=") }
    end
  end
end
