# USpec

USpec is me playing with Ruby blocks to build a lite version of a ruby testing
framework like RSpec.

## Installation
Simply make sure you have `ruby 2.5.1`

## To run
```
ruby test_spec.rb
```

## Ideas
First we wanted to build off `test/unit`. We created a simple class to test out
the `describe` block. In order to pass that we imported a new Ruby file that
uses `describe` as a global method. The two parameters it accepts are a string
and of course a block.

The string handles the description for a given block, but the `&block` handles
the rest.

Next we wanted to implement `it`. Unfortunately, there are a few ways to do it,
but you can really see how `ruby` clicks if you create a class to handle the
block.

We create a class called `OurBlock` and that lets us add the `it` method to it. 

The first thing we do is initialize a block, this lets us take the entirety of
the block and add it to an instance variable called `@block`.

Then we realize we have a problem. `it` doesn't necessarily transfer. We can get
`it` to pass in the global namespace, but it's a little different inside a class
where we want to call `it` almost globally.

On `11`, you will see me use the method `instance_eval(&@block)`. If I remove
it, `it` will look for the `it` method on the `TestDescribe` block. It will keep
looking up the environment chain. This happens with nested blocks.

Since `it`, `describe`, and `test_that_it_can_pass` are not classes, it uses
`TestDescribe` as a class where it looks up a method for it.

With our code on `11`, you'll see that once we convert it to a proc (since
blocks aren't objects), we can then run this new line of code.

Once we call the block with `instance_eval`, it will run code as if it's a
method on `OurBlock`, which means it now has access to the `it` method.

Similarly, we build out `TestAssertion` the same way. We add a method onto the
main `Object` so `should` works like a method, and then we leave space for a
comparison object in case we want to augment this in the future. Otherwise, we
take the value we are calling the method on, craft a new comparison operator and
throw an error if == does not checkout. We obviously add `==` to
`DelayedAssertion` so we can use `should` properly and let us call `==` without
having to pollute the global namespace.

ty gb
