require "wavedash/version"

module Wavedash
  @@destination_encoding = nil

  CHARACTER_CODE_MAPPING = {
    'eucjp-ms' => {
      "\u{301C}" => "\u{FF5E}", # 'WAVE DASH' => 'FULLWIDTH TILDE'
      "\u{2212}" => "\u{FF0D}", # 'MINUS SIGN' => 'FULLWIDTH HYPHEN-MINUS'
      "\u{2016}" => "\u{2225}", # 'DOUBLE VERTICAL LINE' => 'PARALLEL TO'
      "\u{2014}" => "\u{2015}", # 'EM DASH' => 'HORIZONTAL BAR'
      "\u{00A2}" => "\u{FFE0}", # 'CENT SIGN' => 'FULLWIDTH CENT SIGN'
      "\u{00A3}" => "\u{FFE1}", # 'POUND SIGN' => 'FULLWIDTH POUND SIGN'
      "\u{00AC}" => "\u{FFE2}", # 'NOT SIGN' => 'FULLWIDTH NOT SIGN'
    },
    'euc-jp' => {
      "\u{FF5E}" => "\u{301C}", # 'FULLWIDTH TILDE' => 'WAVE DASH'
      "\u{FF0D}" => "\u{2212}", # 'FULLWIDTH HYPHEN-MINUS' => 'MINUS SIGN'
      "\u{2225}" => "\u{2016}", # 'PARALLEL TO' => 'DOUBLE VERTICAL LINE'
      "\u{FFE0}" => "\u{00A2}", # 'FULLWIDTH CENT SIGN' => 'CENT SIGN'
      "\u{FFE1}" => "\u{00A3}", # 'FULLWIDTH POUND SIGN' => 'POUND SIGN'
      "\u{FFE2}" => "\u{00AC}", # 'FULLWIDTH NOT SIGN' => 'NOT SIGN'
    },
    'cp932' => {
      "\u{301C}" => "\u{FF5E}", # 'WAVE DASH' => 'FULLWIDTH TILDE'
      "\u{2212}" => "\u{FF0D}", # 'MINUS SIGN' => 'FULLWIDTH HYPHEN-MINUS'
      "\u{2016}" => "\u{2225}", # 'DOUBLE VERTICAL LINE' => 'PARALLEL TO'
      "\u{2014}" => "\u{2015}", # 'EM DASH' => 'HORIZONTAL BAR'
      "\u{00A2}" => "\u{FFE0}", # 'CENT SIGN' => 'FULLWIDTH CENT SIGN'
      "\u{00A3}" => "\u{FFE1}", # 'POUND SIGN' => 'FULLWIDTH POUND SIGN'
      "\u{00AC}" => "\u{FFE2}", # 'NOT SIGN' => 'FULLWIDTH NOT SIGN'
    },
    'shift_jis' => {
      "\u{FF5E}" => "\u{301C}", # 'FULLWIDTH TILDE' => 'WAVE DASH'
      "\u{FF0D}" => "\u{2212}", # 'FULLWIDTH HYPHEN-MINUS' => 'MINUS SIGN'
      "\u{2225}" => "\u{2016}", # 'PARALLEL TO' => 'DOUBLE VERTICAL LINE'
      "\u{FFE0}" => "\u{00A2}", # 'FULLWIDTH CENT SIGN' => 'CENT SIGN'
      "\u{FFE1}" => "\u{00A3}", # 'FULLWIDTH POUND SIGN' => 'POUND SIGN'
      "\u{FFE2}" => "\u{00AC}", # 'FULLWIDTH NOT SIGN' => 'NOT SIGN'
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
