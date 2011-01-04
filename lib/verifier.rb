#!/usr/bin/env ruby
#
# Verifies OTP hashes
#

require 'digest'
require "openssl"
require 'yaml'
require 'lib/opie'


module OTP
class Verifier
    def initialize(known, candidate, hash_algo)
        @known = known
        @candidate = candidate
        @algo = OTP::ALGO_MAP[hash_algo]
    end

    def opie
        if @candidate.match(/\d/)
            number = @candidate.to_i(16)
            @hash = ["#{number}"].pack("H*")
            
            # run hashing algo once
            regs = @algo.digest(@hash).unpack("V*")
            times_to_fold = regs.size - 2
            0.upto(times_to_fold - 1) do |i|
                regs[i%2] ^= regs[i+2]
            end
            @hash = [regs[0], regs[1]].pack("V2")
            @hex = @hash.unpack('H*')[0].to_i(16).to_s(16).upcase
            @sentence = hash_to_sentence
            puts @hex
            end
            #return true if @hash == hex_to_hash(known)
        end
        return false
    end

    def hash_to_sentence
        parity = 0
        wi = tmplong = @hash.unpack('H*')[0].to_i(16)
        sentence = ""

        32.times do |i|
            parity += tmplong & 3
            tmplong >>= 2
        end

        4.downto(0) do |i|
            sentence << OTP::WORDS[ ((wi >> (i * 11 + 9)) & 0x7ff)] + " "
        end
        sentence << OTP::WORDS[ ((wi << 2) & 0x7fc) | (parity & 3) ]
        sentence
    end
end
end
