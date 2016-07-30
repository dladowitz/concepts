# Ruby/Rails Concepts

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

In this case you can log messages using 

```ruby 
MyLogger.instance.log("Hello World")
```
<br>

**Class Methods:** We could also achieve similar results with a class that prevents instantiation and only had one class method: 

```ruby
class MyLogger
  def self.log(message)
    @@mylog ||=  File.open("my_log.txt", "a")
    @mylog << "\n#{message}"
    puts "Logging #{message}"
  end
end
```

We log like this:

```ruby 
MyLogger.log("Hello World")
```
<br>

**Module:** Additionaly we can use a module to mimic the class method version as modules don't allow instantiaion. 

``` ruby
module MyLogger
  def self.log(message)
    @@mylog ||=  File.open("my_log.txt", "a")
    @mylog << "\n#{message}"
    puts "Logging #{message}"
  end
end
```

And we log exactly the same as the class method:

```ruby 
MyLogger.log("Hello World")
```
<br>

## Single Table Inheritance
