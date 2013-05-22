require_relative '../../spec_helper'

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
  end
end

