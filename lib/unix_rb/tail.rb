require_relative '../unix_rb'

require 'optparse'
require 'pathname'

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

  class TailOptions
    attr_reader :values

    def initialize argv
      @values = Hash.new
      parse argv
    end

    private
      def parse argv
        OptionParser.new do |opts|
          opts.banner = "Usage: tail [options] [file]"
          opts.on("-h", "--help", "Show this message") do
            puts opts
            exit
          end
          opts.on("-n number", Integer, "number of lines to display") do |n|
            @values[:number] = n
          end

          begin
            opts.parse!(argv)
          rescue OptionParser::ParseError => e
            STDERR.puts e.message, "\n", opts
            exit 1
          end
        end

        if argv.empty?
          @values[:input] = STDIN
        else
          file = Pathname.new(argv.pop)
          file.exist? ? @values[:input] = file : fail( MissingFileError, "#{file} does not exist")
        end
      end
  end
end
