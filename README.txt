= ruby-otp

http://ruby-otp.rubyforge.org

== DESCRIPTION:

ruby-otp is a One Time Password library 

== FEATURES/PROBLEMS:

* pure ruby
* RFC 1760 compliant 
* OPIE and S/KEY compatible

== SYNOPSIS:

  seq_num = 497
  seed = "aa3423"
  otp = OTP.new(seq_num, seed, "my really private password", "md5")
  expected_sentence = otp.to_s.downcase

  puts "please enter the sentence from your OTP calculator seq_num: #{seq_num}, seed: #{seed}"
  sentence = gets.chop

  if expected_sentence == sentence.downcase
    puts "access granted"
  else
    puts "you're not authorized"
  end

== REQUIREMENTS:

* openssl for OpenSSL::Digest::MD4

== INSTALL:

* sudo gem install ruby-otp

== LICENSE:

GPL
