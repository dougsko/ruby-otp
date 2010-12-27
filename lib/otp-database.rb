#!/usr/bin/env ruby
#
#
# set up database
#
require 'rubygems'
require 'datamapper'
require 'dm-timestamps'

DataMapper.setup(:default, {
    :adapter => "sqlite3", 
    :database => "data/ropiekeys",
})

class User
    include DataMapper::Resource

    property :id, Serial
    property :name, String

    has n, :keys
end

class Key
    include DataMapper::Resource

    property :id, Serial
    property :algo, String
    property :seq_num, Integer
    property :seed, String
    property :key, String
    property :created_at, DateTime
    property :updated_at, DateTime


    belongs_to :user
end

#DataMapper.auto_migrate!
