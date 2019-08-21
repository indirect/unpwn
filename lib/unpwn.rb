require "unpwn/version"

require "bloomer"
require "bloomer/msgpackable"
require "pwned"

# Unpwn.pwned? tells you if a password should be rejected.
class Unpwn
  attr_reader :min, :max, :request_options

  def initialize(min: 8, max: nil, request_options: nil)
    raise ArgumentError if min && min < 8
    raise ArgumentError if max && max < 64

    @min = min
    @max = max
    @request_options = request_options || {}
  end

  def acceptable?(password)
    return false if min && password.size < min
    return false if max && password.size > max

    !pwned?(password)
  end

  def pwned?(password)
    bloom.include?(password) || Pwned.pwned?(password, request_options)
  end

  def bloom
    @bloom ||= begin
      top = File.read File.expand_path("top1000000.msgpack", __dir__)
      Bloomer.from_msgpack(top)
    end
  end

end
