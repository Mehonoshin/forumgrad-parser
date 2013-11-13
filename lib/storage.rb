class Storage
  include Singleton

  DB_FILE = 'db.txt'

  def init
    File.open(DB_FILE, 'w') { |file| file.write("============DUMP STARTS HERE===============") }
  end

  def save_post(post_hash)
    File.open(DB_FILE, 'a') { |f| f.write(post_hash) }
  end
end
