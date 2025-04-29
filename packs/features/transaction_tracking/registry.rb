module TransactionTracking
  module Registry
    extend self

    def register(protocol, klass)
      registry[protocol.to_sym] = klass
    end

    def fetch(protocol)
      registry.fetch(protocol.to_sym) do
        raise ArgumentError, "No tracker registered for #{protocol}"
      end
    end

    private

    def registry
      @registry ||= {}
    end
  end
end
