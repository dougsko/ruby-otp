require 'rspec'
require "opie"
require "spec_helper"

describe "OTP::Opie" do
    before(:each) do
        @opie = OTP::Opie.new
    end

    # These are tests from RFC 2289.
    it "Tests md4 hex encoding" do
        @opie.calculate(99, "alpha1", "AbCdEfGhIjK", "md4")
        @opie.hex.should == "D150C82CCE6F62D1"
    end

    it "Tests md4 sentence encoding" do
        @opie.calculate(99, "alpha1", "AbCdEfGhIjK", "md4")
        @opie.sentence.should == "ROIL FREE COG HUNK WAIT COCA"
    end

    it "Tests md5 hex encoding" do
        @opie.calculate(99, "alpha1", "AbCdEfGhIjK", "md5")
        @opie.hex.should == "5AA37A81F212146C"
    end

    it "Tests md5 sentence encoding" do
        @opie.calculate(99, "alpha1", "AbCdEfGhIjK", "md5")
        @opie.sentence.should == "BODE HOP JAKE STOW JUT RAP"
    end

    it "Tests md5 sentence encoding" do
        @opie.calculate(0, "TeSt", "This is a test.", "md5")
        @opie.sentence.should == "INCH SEA ANNE LONG AHEM TOUR"
    end

    it "Tests seed generator" do
        10.times do
            @opie.generate_seed.should =~ /^[a-z]{2}\d{4}$/
        end
    end

    it "Tests password too short" do
        expect{@opie.calculate(99, "iamvalid", "Too_short", "md5")}.to raise_error(ArgumentError)
    end

    it "Tests password too long" do
        expect{ @opie.calculate(99, "iamvalid", "1234567890123456789012345678901234567890123456789012345678901234", "md5")}.to raise_error(ArgumentError)
    end

    it "Tests seed is alphanumeric" do
        expect{ @opie.calculate(99, "Length_0kay", "A_Valid_Passphrase", "md5")}.to raise_error(ArgumentError)
    end

    it "Tests seed length" do
        expect{@opie.calculate(99, "LengthOfSeventeen", "A_Valid_Passphrase", "md5")}.to raise_error(ArgumentError)
    end

    it "Tests that the seed have no spaces" do
        expect{@opie.calculate(99, "A Seed", "A_Valid_Passphrase", "md5")}.to raise_error(ArgumentError)
    end

    it "Tests parity" do
        @opie.calculate(99, "AValidSeed", "A_Valid_Pass_Phrase", "md5")
        @opie.sentence.should == "FOWL KID MASH DEAD DUAL OAF"
    end

    it "Verifies" do
        @opie.verify("07F0DAC3F1F24760", "5AA37A81F212146C").should == true
    end
end
