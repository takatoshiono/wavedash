# Wavedash [![Build Status](https://travis-ci.org/takatoshiono/wavedash.svg?branch=master)](https://travis-ci.org/takatoshiono/wavedash)

Normalize characters that problem occurs when encoding.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'wavedash'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wavedash

## Usage

### #configure

Configure destination encoding that your application needs.

```ruby
require 'wavedash'

Wavedash.configure.destination_encoding = 'eucjp-ms'
```

### #normalize

Normalize characters like "WAVE DASH (U+301C)"

```ruby
str = "こんにちは\u{301C}" # => "こんにちは〜"
str.encode('eucjp-ms') # => Encoding::UndefinedConversionError: U+301C from UTF-8 to eucJP-ms

normalized = Wavedash.normalize(str) # => "こんにちは～"
normalized.encode('eucjp-ms') # => "\x{A4B3}\x{A4F3}\x{A4CB}\x{A4C1}\x{A4CF}\x{A1C1}" ("こんにちは～")
```

### #invalid?

Detect unencodable characters

```ruby
str = "こんにちは\u{301C}" # => "こんにちは〜"
Wavedash.invalid?(str) # => true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

