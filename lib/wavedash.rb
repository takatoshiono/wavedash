require "wavedash/version"

module Wavedash
  @@destination_encoding = nil

  CHARACTER_CODE_MAPPING = {
    'eucjp-ms' => {
      # source => destination
      "\u{301C}" => "\u{FF5E}",
      "\u{2212}" => "\u{FF0D}",
    },
    'euc-jp' => {
      "\u{FF5E}" => "\u{301C}",
      "\u{FF0D}" => "\u{2212}",
    },
  }

  def self.destination_encoding=(encoding)
    @@destination_encoding = encoding
  end

  def self.normalize(str)
    mapping = CHARACTER_CODE_MAPPING[@@destination_encoding]
    return str unless mapping
    str.tr(mapping.keys.join, mapping.values.join)
  end

  def self.invalid?(str)
    return false unless str.is_a?(String)
    mapping = CHARACTER_CODE_MAPPING[@@destination_encoding]
    return false unless mapping
    str.each_char.any? { |c| mapping[c] }
  end
end
