# Mago

Tool to detect magic numbers in ruby code.

![Mago - magic numbers detector for Ruby](http://i1078.photobucket.com/albums/w484/greyblake/ruby-mago.png)

## Installation

```
gem install mago
```

## Usage

Ruby code in `square.rb`:
```ruby
P = 3.14

r = 5
square = P * r ** 2
```

Run:
```sh
mago ./square.rb
./square.rb:3 detected magic number 5
./square.rb:4 detected magic number 2
```

### Ignore specific numbers

Use `--ignore` or `-i` option to ignore specific numbers. By default 0 and 1 are ignored.

```sh
mago -i 2,3 ./square.rb
./square.rb:3 detected magic number 5
```

### Show source code

Use `--source` or `-s` option to show line of source code where magic number was found.

```sh
mago -s ./square.rb
./square.rb:3| r = 5
./square.rb:4| square = P * r ** 2
```

### Color output

Use `--color` or `-c` option to colorize output.

## TODO

* Add intro about magic numbers to README.
* Create GIF with some famous probject to show how it works.

## Copyright

Copyright (c) 2013 Sergey Potapov. See LICENSE.txt for
further details.

