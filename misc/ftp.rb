require 'ftpd'
require 'net/ftp'

module NDD
  module FTP
    class Server
      #make this a timed connection. Don't use gets
      #port should be in loaded config
      def initialize(dir, port)
        driver = NDD::FTP::Driver.new(dir)
        server = Ftpd::FtpServer.new(driver)
        server.port = port
        server.start
        puts "Server listening on port #{server.bound_port}"
        gets
      end
    end

    class Client
      def initialize
        @client = Net::FTP.new
        @client.connect("localhost", 21416)
        @client.login("","")
      end

      def gets(remote_file, local_file)
        @client.getbinaryfile(remote_file, local_file)
      end
    end

    class Driver

      def initialize(dir)
        @dir = dir
      end

      def authenticate(usr, passwd)
        true
      end

      def file_system(usr)
        Ftpd::DiskFileSystem.new(@dir)
      end
    end


  end
end
