# Lexigrapher

Find the type of a string. In some cases, you have a data type in a string, and you know exactly what it is. Now Ruby can too!

It's as simple as:

```ruby
Lexigrapher::Parser.new('0xFFF').type
```

...and voila! You get your type as a symbol!

```ruby
:integer
```
