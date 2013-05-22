require_relative '../unix_rb'

module UnixRb
  class Tail
    def initialize opts={}
      @config = { input:     "",
                  mode:   :default,
                  number: 10
                }.merge! opts
    end

    private
      def method_missing m, *a, &b
        @config.fetch(m) { super }
      end
  end
end
