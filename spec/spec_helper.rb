require_relative '../lib/unix_rb'

module Helpers
  # Fake stdin with StringIO
  def fake_stdin(*args)
    begin
      $stdin = StringIO.new
      $stdin.puts(args.shift) until args.empty?
      $stdin.rewind
      yield
    ensure
      $stdin = STDIN
    end
  end
end

RSpec.configure {|conf| conf.include(Helpers)}
