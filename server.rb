# server.rb
require 'socket'
require 'securerandom'
require 'pstore'
ND_PORT = 21415

server = TCPServer.new(ND_PORT)
system("nohup iperf -s -u >> /projects/net-detect/.iperfs/log 2>&1 &")

def validate()
  return true
end

class String
  def padd(size, padstr=' ')
    self[0...size].ljust(size, padstr) #or ljust
  end
end

def generate_key
  return "ndd-rand" + SecureRandom.urlsafe_base64
end

def store_client(name, result)
  db = PStore.new("/srv/ndd/clients/#{name}")
  db.transaction do
    db["#{Time.now}"] = result
  end
end

# NDD::COMM.start_ftp_server('/etc/ndd/clients')

loop {
  puts "Accepting client"
  client = server.accept
  loop {
    data = client.recv(30).gsub("\n","")
    header = data[0...7]
    p header unless header == ""
    if header == "ND-INIT"
      #Validate()
      client.send("ND-VALD:#{generate_key}:".padd(40),0)
    elsif header == "ND-RESP"

      puts "Our speed is #{data.split(':')[1]}"
      store_client("Schylar", 50)
    elsif header == "ND-EXIT"
      client.close
      break
    end
  }

}
