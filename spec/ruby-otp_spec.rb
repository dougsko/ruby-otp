require "otp"
require "yaml"
require "spec_helper"

describe "OTP" do
    before do
        @fixtures = YAML::load_file(File.dirname(__FILE__)+"/fixtures.yml")
    end
    
    def testit(algo)
        fixture = @fixtures[algo]
        fixture.each do |expected_otp|
            otp = OTP.new(expected_otp["seq_num"], expected_otp["seed"], expected_otp["passphrase"], algo)
            yield otp, expected_otp["sentence"]
        end
    end

    ["md4", "md5", "sha1"].each do |algo|
        it "Tests #{algo}" do
            testit(algo) do |otp, expected|
                otp.to_s.should == expected
            end
        end
        it "Tests hex output" do
            testit(algo) do |otp, expected|
                otp.to_hex.should =~ /[0-9A-F]{16}$/ 
            end
        end
    end

    it "Tests seed generator" do
        10.times do
            OTP.generate_seed.should =~ /^[a-z]{2}\d{4}$/
        end
    end

    # Tests from RFC 2289
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
        otp = OTP.new(99, "AValidSeed", "A_Valid_Passphrase", "md5")
        otp.to_s.should == "FOWL KID MASH DEAD DUAL OAF"
    end

end
