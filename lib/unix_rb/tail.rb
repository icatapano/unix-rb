require_relative '../unix_rb'

module UnixRb
  class Tail
    def initialize opts={}
      @config = { input:     "",
                  mode:   :default,
                  number: 10
                }.merge! opts
    end

    def run
      open.each("\n")
          .entries
          .reverse
          .take(number)
          .reverse
          .join
    end

    private
      def open
        i = input
        case i
        when String
          StringIO.new i
        when Pathname
          i.open("r")
        else
          i
        end
      end

      def method_missing m, *a, &b
        @config.fetch(m) { super }
      end
  end
end
