require 'singleton'

class MyLogger
  include Singleton

  def initialize
    @mylog = File.open("my_log.txt", "a")
  end

  def log(message)
    @mylog << "\n#{message}"
    puts "Logging #{message}"
  end
end
