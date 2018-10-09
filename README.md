# Unpwn

A gem to help you make sure that passwords are good, and not likely to be guessed or hacked, as suggested by [NIST SP-800-63B](https://pages.nist.gov/800-63-3/).

Unpwn checks passwords locally against the top one million passwords, as provided by the [nbp](https://cry.github.io/nbp/) project. Then, it uses the [haveibeenpwned](https://haveibeenpwned.com) API to check proposed passwords against the largest corpus of publicly dumped passwords in the world.

Inspired by @codahale's [passpol](https://github.com/codahale/passpol), and uses prior work from [nbp](https://cry.github.io/nbp/) and [devise-pwned\_password](https://github.com/michaelbanfield/devise-pwned_password).

## Installation

Add `unpwn` to your `Gemfile`:

```ruby
gem "unpwn", "~> 1.0"
```

## Usage

```ruby
require "unpwn"
# Default length requirement is 8 characters minimum, no maximum
Unpwn.acceptable?("abc123") # => false
# Min and max can be set manually, but only as low as 8 and 64 respectively.
Unpwn.new(min: 10, max: 64).acceptable?("visit raven follow disk") # => true
```

### With Rails + Devise

```ruby
class User < ApplicationRecord
  devise :database_authenticatable, :unpwnable
end
```

Users trying to set a password that has already been used and leaked in a public breach will see a validation error, informing them that their password has appeared in a public data breach and should not be used.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/indirect/unpwn. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Unpwn project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/indirect/unpwn/blob/master/CODE_OF_CONDUCT.md).
