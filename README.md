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

<br>

## Polymorphism
Polymorphism is useful when you have one class that can `belongs_to` multiple classes. 

For example say you are Facebook and you want to create a class called "Pages". 
A page can belong to either a single User or a Business. 

Instead of the Pages class having multiple foriegn keys like `user_id` and `business_id` we use polymorphism like this:

```ruby
# migration file
create_table 'pages' do |t|
  t.integer 'pageable_id'
  t.string 'pageable_type'
  t.string 'primary_photo_url'
  t.boolean 'private'
end

# /app/models/page.rb
class Page < ActiveRecord::Base
  belongs_to :pageable, polymorphic: true
end
```

Our User and Business classes both get their own db tables (unlike STI) and class definitions

```ruby
create_table 'users' do |t|
  t.integer 'name'
end

# /app/models/user.rb
class User < ActiveRecord::Base
  has_one :page, as: :pageable
end

create_table 'businesses' do |t|
  t.integer 'name'
end

# /app/models/business.rb
class Business < ActiveRecord::Base
  has_one :page, as: :pageable
end

```

In this was we can instantiate a new page for both a User or a Business with:
`User.first.build_page` or `Business.first.build_page`

## Polymorphism Vs Single Table Inheritance
A polymorphic association is used when a class can belong to more than one other class. In this case each of the three or more classes have their own DB tables, their own attributes (which may not overlap) and thier own ruby class definition. None of the classes inherit from the other classes. <br>
**Ex: A Comment can belong to an BlogPost or a Video.**

Single Table Inheritance is used when multiple classes will have similiar attributes and you want them all to store records in one database table. At the same time you want them to have different methods or functionality. 
Here classes inherit from the superclass which is the only class that has a matching DB table. <br>
**EX: A Cat and Dog class can inherit from an Animal class. All classes store records in the Animals table**


## Modules Vs Classes
- A class is a way to create copies of an object and give them all different states. 
- A Module is a way to share methods between classes. 
- Modules cannot be instantiated and updated. So they have no *state* while classes do. An instance of a class can have it's instance variables changed over time. 
- Both Modules and Classes can have constants
- Modules can have both Module Methods and Instnace methods. 
- A Modules Instance methods can only be called if the module is  included (mixedin) to a class.

- Modules cannot be saved to a database so they will not persist (though since they cannot change state, their is really nothing to persist). 










