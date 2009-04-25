#!/usr/bin/env ruby
#
#
# set up database
#
require 'rubygems'
require 'datamapper'

DataMapper.setup(:default, {
    :adapter => "sqlite3", 
    :database => "data/ropiekeys",
})

class KeyEntry
    include DataMapper::Resource

    property :id, Serial
    property :name, String
    property :algo, String
    property :seq_num, Integer
    property :seed, String
    property :key, String
    property :date, DateTime
end

#DataMapper.auto_migrate!
