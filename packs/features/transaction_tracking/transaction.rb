module TransactionTracking
  class Transaction
    attr_accessor :tx_hash, :protocol, :details, :status

    DATABASE = []

    def initialize(attrs)
      @attrs = attrs
      attrs.each { |k, v| send("#{k}=", v) if respond_to?("#{k}=") }
    end

    def self.create(attrs)
      DATABASE << new(attrs)
    end
  end
end
