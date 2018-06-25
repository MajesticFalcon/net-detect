require 'pstore'

module NDD
  module DB
    class << self
      def load_db
        db = PStore.new("/etc/ndd/store")
        db.transaction do
          server = db['server']
        end
        return db
      end

      def db_exists
        if File.exists?("/etc/ndd/store")
          return true
        else
          return false
        end
      end

      def create_db
        begin
          File.new("/etc/ndd/store",  "w+")
          db = PStore.new("/etc/ndd/store")
          db.transaction do
            db['server'] = ''
            db['identity'] = ''
            db['key'] = ''
            db['bw'] = ''
            db['interval'] = ''
          end
        rescue => x
          puts x
          return false
        end
        return db
      end

      def load
        @@db = db_exists ? load_db : create_db
      end

      def save(key,val)
        @@db.transaction do
          @@db[key] = val
        end
      end

      def gets(key)
        @@db.transaction do
          return @@db[key] == "" ? false : @@db[key]
        end
      end
    end
  end
end
