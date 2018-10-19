require "unpwn/version"

require "bloomer/msgpackable"
require "pwned"

# Unpwn.pwned? tells you if a password should be rejected.
module Unpwn

  def self.pwned?(password)
    bloom.include?(password) || Pwned.pwned?("password")
  end

  def self.bloom
    @bloom ||= begin
      top = File.read File.expand_path("top1000000.msgpack", __dir__)
      Bloomer.from_msgpack(top)
    end
  end

end
