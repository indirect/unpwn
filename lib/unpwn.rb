require "unpwn/version"

# Unpwn checks passwords locally against the top one million passwords, as
# provided by the nbp project. Then, it uses the haveibeenpwned API to check
# proposed passwords against the largest corpus of publicly dumped passwords in
# the world.
class Unpwn
  class << self
    # Set `offline` to true to disable requests to the haveibeenpwned.com API
    attr_accessor :offline

    # Check if a password is _not_ already published. To set options like
    # `min`, `max`, or on the Pwned API check, create a new instance of your
    # own.
    def acceptable?(password)
      new.acceptable?(password)
    end
  end

  attr_reader :min, :max, :request_options

  # Set the options for an Unpwn instance. `request_options` will be passed
  # verbatim to the `Pwned` library.
  def initialize(min: 8, max: nil, request_options: nil)
    raise ArgumentError if min && min < 8
    raise ArgumentError if max && max < 64

    @min = min
    @max = max
    @request_options = request_options || {}
  end

  # Check if a password meets the requirements and is not pwned.
  def acceptable?(password)
    return false if min && password.size < min
    return false if max && password.size > max

    !pwned?(password)
  end

  # Checks if a password is pwned, via bloom filter then `Pwned`.
  def pwned?(password)
    pwned = bloom.include?(password)

    unless self.class.offline
      require "pwned"
      pwned ||= Pwned.pwned?(password, request_options)
    end

    pwned
  end

  def bloom
    @bloom ||= begin
      require "bloomer"
      require "bloomer/msgpackable"
      top = File.read File.expand_path("top1000000.msgpack", __dir__)
      Bloomer.from_msgpack(top)
    end
  end

  def inspect
    "<UnPwn bloomed=#{@bloom ? 'yes' : 'no'}>"
  end

  alias :to_s :inspect
end
