# module TransactionTracking
#   module Status
#     extend self

#     PENDING   = :pending
#     CONFIRMED = :confirmed
#     FAILED    = :failed
#     DROPPED   = :dropped
#     REPLACED  = :replaced

#     ALL = [PENDING, CONFIRMED, FAILED, DROPPED, REPLACED].freeze

#     def terminal?(status)
#       [CONFIRMED, FAILED, DROPPED, REPLACED].include?(status)
#     end
#   end
# end

module TransactionTracking
  class Status
    attr_reader :name

    def initialize(name)
      @name = name
    end

    PENDING   = new(:pending)
    CONFIRMED = new(:confirmed)
    FAILED    = new(:failed)
    DROPPED   = new(:dropped)
    REPLACED  = new(:replaced)

    ALL = [PENDING, CONFIRMED, FAILED, DROPPED, REPLACED].freeze
    TERMINAL = [CONFIRMED, FAILED, DROPPED, REPLACED].freeze

    def terminal?
      TERMINAL.include?(self)
    end

    def ==(other)
      other.is_a?(Status) && name == other.name
    end

    alias eql? ==

    def hash
      name.hash
    end

    def to_s
      name.to_s
    end

    def inspect
      "#<#{self.class} #{name}>"
    end
  end
end
