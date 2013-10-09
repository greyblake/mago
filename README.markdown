# Mago

Tool to detect magic numbers in ruby code.


## Installation

```
gem install mago
```


## Usage

Detect magic numbers in particular ruby file:
```sh
mago ./path/to/file.rb
```

In all ruby files inside directory:
```sh
mago ./path/to/project/
```

## Example

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


## Copyright

Copyright (c) 2013 Sergey Potapov. See LICENSE.txt for
further details.

