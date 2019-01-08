RSpec.describe Unpwn do
  it "has a version number" do
    expect(Unpwn::VERSION).not_to be nil
  end

  it "accepts min and max" do
    Unpwn.new(min: 8, max: 64)
  end

  it "errors with min under 8" do
    expect { Unpwn.new(min: 7) }.to raise_error(ArgumentError)
  end

  it "errors with a max under 64" do
    expect { Unpwn.new(max: 63) }.to raise_error(ArgumentError)
  end

  describe "#acceptable?" do
    it "is false under min" do
      expect(Unpwn.new(min: 8).acceptable?("1234567")).to be false
    end

    it "is false over max" do
      expect(Unpwn.new(max: 64).acceptable?("1" * 65)).to be false
    end

    it "is false when in the bloom filter" do
      expect(Unpwn.new.acceptable?("password1")).to be false
    end

    it "is false when in the pwned API" do
      expect(Pwned).to receive(:pwned?).with("merge mad basic brake").and_return(true)
      expect(Unpwn.new.acceptable?("merge mad basic brake")).to be false
    end

    it "is true when not in the pwned API" do
      expect(Pwned).to receive(:pwned?).with("merge mad basic brake").and_return(false)
      expect(Unpwn.new.acceptable?("merge mad basic brake")).to be true
    end
  end
end
