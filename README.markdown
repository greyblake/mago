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

## TODO

* Support for `--color`(`-c`) option to colorize numbers.
* Support for `--show-source`(`-s`) option to show line of source code with magic number.

## Copyright

Copyright (c) 2013 Sergey Potapov. See LICENSE.txt for
further details.

