require 'socket'
require 'ftpd'
require_relative 'misc/monkey_patch'
require_relative 'misc/ftp'

module NDD
  module COMM
    class << self
      def get_key
        init_sock
        sock_puts("ND-INIT")
        data = sock_gets(40)
        header = data[0...7]
        if header == "ND-VALD"
          return data.split(":")[1]
        else
          return false
        end
      end

      def init_sock
        begin
          @@conn ||= TCPSocket.open('localhost', 21415)
          return true
        rescue
          puts "Error connecting to server"
          return false
        end
      end

      def sock_puts(data)
        begin
          @@conn.puts(data.padd(30))
          return true
        rescue
          return false
        end
      end

      def sock_gets(size)
        return @@conn.gets(size)
      end

      def sock_exit()
        sock_puts("ND-EXIT".padd(30))
      end

      def send_results(dl)
        init_sock
        sock_puts("ND-RESP:#{dl}".padd(30))
        sock_exit
      end

      def start_ftp_server(dir)
        #dir should be in loaded config
        server = NDD::FTP::Server.new(dir, 21416)
      end

      def ftp_get_file(remote_file, local_file)
        client = NDD::FTP::Client.new
        client.gets(remote_file, local_file)
      end

    end
  end
end
