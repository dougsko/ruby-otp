$:.unshift(File.dirname($0)+"/../lib")
require "otp"
require "yaml"
require "spec_helper"

def testit(algo)
    fixture = @fixtures[algo]
    fixture.each do |expected_otp|
        otp = OTP.new(expected_otp["seq_num"], expected_otp["seed"], expected_otp["passphrase"], algo)
        otp.to_s
    end
end

describe "OTP" do
    before do
        @fixtures = YAML::load_file(File.dirname(__FILE__)+"/fixtures.yml")
    end
    
    def testit(algo)
        fixture = @fixtures[algo]
        fixture.each do |expected_otp|
            otp = OTP.new(expected_otp["seq_num"], expected_otp["seed"], expected_otp["passphrase"], algo)
            yield otp.to_s, expected_otp["sentence"]
        end
    end
    
    it "Tests MD4" do
        testit("md4") do |result, expected|
            result.should == expected
        end
    end

    it "Tests MD5" do
        testit("md5") do |result, expected|
            result.should == expected
        end
    end
    it "Tests SHA1" do
        testit("sha1") do |result, expected|
            result.should == expected
        end
    end
end
