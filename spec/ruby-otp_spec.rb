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
            yield otp.to_s, expected_otp["sentence"]
        end
    end

    ["md4", "md5", "sha1"].each do |algo|
        it "Tests #{algo}" do
            testit(algo) do |result, expected|
                result.should == expected
            end
        end
    end
end
