# Mago

Tool to detect magic numbers in ruby code.


## Installation

```
gem install mago
```

## Usage example

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

### Ignoring specific numbers

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

* Support for `--expl-var` (`-e`) option to ignore explaining variables.
* Add intro about magic numbers to README.
* Create GIF with some famous probject to show how it works.

## Copyright

Copyright (c) 2013 Sergey Potapov. See LICENSE.txt for
further details.

