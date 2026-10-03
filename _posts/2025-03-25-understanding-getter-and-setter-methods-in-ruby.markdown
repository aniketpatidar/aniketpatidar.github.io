---
layout: post
title: "Understanding Getter and Setter Methods in Ruby!"
description: "What getter and setter methods are in Ruby, and how attr_reader, attr_writer, and attr_accessor create them for you."
permalink: /understanding-getter-and-setter-methods-in-ruby/
---

My notes on getter and setter methods in Ruby, and on what `attr_reader`, `attr_writer`, and `attr_accessor` generate.

Getters and setters give controlled access to an object's instance variables from outside the class. That's encapsulation: the object hides its internal state and exposes only the parts it needs to.

## What?

* **Getter Methods**: Allow reading the value of an instance variable.
* **Setter Methods**: Allow modifying the value of an instance variable.

## How?

Ruby simplifies the creation of these methods with `attr_accessor`, `attr_reader`, and `attr_writer`.
* `attr_reader`: Generates only getter methods.
* `attr_writer`: Generates only setter methods.
* `attr_accessor`: Generates both getter and setter methods.    

### Example

```ruby
class Product
  attr_reader :name     # Generates only a getter for `name`
  attr_writer :price    # Generates only a setter for `price`
  attr_accessor :stock  # Generates both getter and setter for `stock`

  def initialize(name, price, stock)
    @name = name
    @price = price
    @stock = stock
  end
end

product = Product.new("T-Shirt", 19.99, 10)
puts product.name        # Output: T-Shirt (using getter)
product.price = 24.99    # No getter for `price`, but setter allows modification
product.stock = 5        # Both getter and setter available for `stock`
```

## Listing Instance Variables and Methods

Ruby provides built-in methods to inspect an object's instance variables and methods:
* `#instance_variables`: Returns a list of instance variables.
* `#public_methods`: Returns a list of public methods.

```ruby
p product.instance_variables  # Output: [:@name, :@price, :@stock]
p product.public_methods      # Output: List of public methods, including `name`, `price=`, and `stock`
```

