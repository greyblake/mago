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

In all ruby files of directory:
```sh
mago ./path/to/project/
```

## Example

```ruby
P = 3.14

radius = 5
square = P * radius ** 2
```

```sh
mago ./square.rb
./square.rb:3 detected magic number 5
./square.rb:4 detected magic number 2
```


## Copyright

Copyright (c) 2013 Potapov Sergey. See LICENSE.txt for
further details.

