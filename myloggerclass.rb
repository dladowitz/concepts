class MyLogger
  def self.log(message)
    mylog =  File.open("my_log.txt", "a")
    mylog << "\n#{message}"
    puts "Logging #{message}"
    mylog.close
  end

  private_class_method :new
end
