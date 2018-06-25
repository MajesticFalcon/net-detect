# client.rb
require 'socket'
require 'humanize-bytes'
require_relative 'db'
require_relative 'comm'


NDD::DB.load
auth_key = NDD::DB.gets('key') || NDD::COMM.get_key
NDD::DB.save('key', auth_key)

a = `iperf -c localhost -u -b 53m --reportstyle C`
result = (Humanize::Byte.new(a.split(",")[8].to_i).to_m).to_s.to_i.round(2).to_s
NDD::COMM.send_results(result)

# NDD::COMM.ftp_get_file("test.txt", "/123123123")
