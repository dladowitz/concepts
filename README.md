# Concept Review

## Singleton

Singletons are used when you need to limit a class to only intantiating one instance of itself that can be used throughout an application. 

Typical usages are for logging, connecting to a database, or working with a third party system. 

Here is an example of a singleton logging system:


```ruby

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
```
