require_relative '../../spec_helper'
require 'pathname'

module UnixRb
  describe Tail do
    it "has an associated input" do
      t = Tail.new
      t.input
    end

    it "stores a provided input" do
      t = Tail.new({ input: STDIN })
      t.input.should eq STDIN
    end

    it "knows the number of lines to display" do
      t = Tail.new
      t.number.should eq 10
    end

    it "has an operating mode" do
      t = Tail.new
      t.mode
    end

    context "#run" do
      it "should show all ten lines of input" do
        t = Tail.new({ input: "line\n"*10 })
        t.run.should eq "line\n"*10
      end

      it "should show only the last ten lines" do
        t = Tail.new({ input: "line\n"*42 })
        t.run.should eq "line\n"*10
      end

      it "should only show the last number of lines" do
        t = Tail.new({ input: "line\n"*42, number: 3})
        t.run.should eq "line\n"*3
      end

      it "works with files" do
        f = Pathname.new("testing")
        f.open("w:UTF-8"){|o| o.puts "line\n"*12 }
        t = Tail.new({ input: f })
        t.run.should eq "line\n"*10
        f.unlink
      end
    end
  end
end

