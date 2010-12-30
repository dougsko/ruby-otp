require "otp"
require "spec_helper"

describe "OTP" do
    # These are tests from RFC 2289.
    it "Tests md4 hex encoding" do
        otp = OTP.new(99, "alpha1", "AbCdEfGhIjK", "md4")
        otp.to_hex.should == "D150C82CCE6F62D1"
    end

    it "Tests md4 sentence encoding" do
        otp = OTP.new(99, "alpha1", "AbCdEfGhIjK", "md4")
        otp.to_s.should == "ROIL FREE COG HUNK WAIT COCA"
    end

    it "Tests md5 hex encoding" do
        otp = OTP.new(99, "alpha1", "AbCdEfGhIjK", "md5")
        otp.to_hex.should == "5AA37A81F212146C"
    end

    it "Tests md5 sentence encoding" do
        otp = OTP.new(99, "alpha1", "AbCdEfGhIjK", "md5")
        otp.to_s.should == "BODE HOP JAKE STOW JUT RAP"
    end

    it "Tests md5 sentence encoding" do
        otp = OTP.new(0, "TeSt", "This is a test.", "md5")
        otp.to_s.should == "INCH SEA ANNE LONG AHEM TOUR"
    end

    it "Tests seed generator" do
        10.times do
            OTP.generate_seed.should =~ /^[a-z]{2}\d{4}$/
        end
    end

    it "Tests password too short" do
        expect{OTP.new(99, "iamvalid", "Too_short", "md5")}.to raise_error(ArgumentError)
    end

    it "Tests password too long" do
        expect{ OTP.new(99, "iamvalid", "1234567890123456789012345678901234567890123456789012345678901234", "md5")}.to raise_error(ArgumentError)
    end

    it "Tests seed is alphanumeric" do
        expect{ OTP.new(99, "Length_0kay", "A_Valid_Passphrase", "md5")}.to raise_error(ArgumentError)
    end

    it "Tests seed length" do
        expect{OTP.new(99, "LengthOfSeventeen", "A_Valid_Passphrase", "md5")}.to raise_error(ArgumentError)
    end

    it "Tests that the seed have no spaces" do
        expect{OTP.new(99, "A Seed", "A_Valid_Passphrase", "md5")}.to raise_error(ArgumentError)
    end

    it "Tests parity" do
        otp = OTP.new(99, "AValidSeed", "A_Valid_Pass_Phrase", "md5")
        otp.to_s.should == "FOWL KID MASH DEAD DUAL OAF"
    end

end
