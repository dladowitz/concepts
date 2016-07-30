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
Single Table Inheritance is usefull when you have a few classes that have similiar attributes, but different functionality. You can use one table to store all records, but use multiple classes to define varying functionality within methods. 

An example would be to create one Employees table:

```ruby
create_table 'employees' do |t|
  t.integer 'employee_id'
  t.string 'name'
  t.string  'type'
  t.string 'location'
  t.integer 'salary'
end
```

And four classes:

```ruby
# app/models/employee.rb
class Employee < ActiveRecord::Base
end

# app/models/executive.rb
class Executive < Emmployee

	def fund_raise
		puts "I'll give you 10% for $2,000,000"
	end
end

# app/models/maneger.rb
class Manager < Employee
	def ask_for_overtime(contributor)
		puts "Yeah...#{contributor.name}...I'm gonna need you to come in on Saturday."
	end
end

# app/models/contributor.rb
class Contributor < Employee
	def do_word
		puts "I just stare at my desk, but it looks like I'm working."
	end
end
```

In this way we can store all the records for employees in one table, but also have different funtionality for different types of employees. 

To create and use objects we can do the following:

```ruby
bill = Manager.new(name: "Bill Lumbergh", employee_id: 101, location: "Headquarters", salary: 100000)

peter = Contributor.new(name: "Peter Gibbons", employee_id: 124, location: "Boise", salary: 50000)

bill.ask_for_overtime(peter)
#> Yeah...Peter Gibbons...I'm gonna need you to come in on Saturday.

peter.do_work
#> I just stare at my desk, but it looks like I'm working.

```





