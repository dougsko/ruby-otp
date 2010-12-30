#!/usr/bin/env ruby
#
# HOTP - One Time Passwords 
# An implementation of RFC 4226 using Ruby's
# built-in digest SHA1.
#

require 'openssl'

module OTP

class Hotp
    attr_accessor :secret, :count, :digits
    def initialize(secret, count, digits=6, digest="sha1")
        @secret = secret
        @count = count
        @digits = digits
        @digest = OpenSSL::Digest::Digest.new(digest)
    end

    def calculate
        padded_count = [@count.chr].pack('a8').reverse
        hmac_result = OpenSSL::HMAC.digest(@digest, @secret, padded_count)
        offset = hmac_result[19] & 0xf
        bin_code = (hmac_result[offset] & 0x7f) << 24 |
            (hmac_result[offset + 1] & 0xff) << 16 |
            (hmac_result[offset + 2] & 0xff) << 8 |
            (hmac_result[offset + 3] & 0xff)
        bin_code % 10 ** @digits
    end
end
end
