# Wavedash ![test](https://github.com/takatoshiono/wavedash/actions/workflows/test.yaml/badge.svg)

Normalize unencodable characters that raise `Encoding::UndefinedConversionError` exception in `String#encode`.

### Support encoding

- eucjp-ms
- euc-jp
- cp932
- shift_jis

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

### destination_encoding

First af all, configure destination encoding that your application needs.

```ruby
require 'wavedash'

Wavedash.destination_encoding = 'eucjp-ms'
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

### Thought of Wavedash

Character code conversion is required when interact between softwares that treet different character code. For example, it is a situation such as the following.

- A Web application written in UTF-8 using a database saved in EUC-JP
- Exchanging data files(csv,tsv,..) between different systems

In Ruby, You can convert a character code using `String#encode`, but some characters cannot. `Encoding::UndefinedConversionError` raises when a character is undefined in the destination encoding. But `String#encode` has options. You can specify `:undef => :replace` then replace the undefined characters with the replacement character.

`Wavedash` is similar to `String#encode` with `:undef => :replace`, but it does more aggressive character conversion.

Despite some characters have resembling shape, character code point is different each other. For example, when you convert characters to EUCJP-MS from UTF-8, can convert "～" (FULLWIDTH TILDE U+FF5E) but cannot convert "〜" (WAVE DASH U+301C). The opposite will occur when you convert to EUC-JP.

| UNICODE                     | EUC-JP                             | EUCJP-MS                           |
| --------------------------- | ---------------------------------- | ---------------------------------- |
| "〜" U+301C WAVE-DASH       | 0xA1C1                             | Encoding::UndefinedConversionError |
| "～" U+FF5E FULLWIDTH TILDE | Encoding::UndefinedConversionError | 0xA1C1                             |

In Web applications, it depends on the client environment that the input character as "〜" is U+301C or U+FF5E. This cannot select by the application. What you can do with the application is only to determine the handling of the unencodable characters.

`Wavedash` offers the option that to convert unencodable characters to resembling characters.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
