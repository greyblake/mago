# Mago

[![Build Status](https://travis-ci.org/greyblake/mago.png?branch=master)](https://travis-ci.org/greyblake/mago)
<img src="https://d2weczhvl823v0.cloudfront.net/greyblake/mago/trend.png" width="0px" height="0px"/>

Magic numbers detector for Ruby source code.

![Mago - magic numbers detector for Ruby](http://i1078.photobucket.com/albums/w484/greyblake/ruby-mago.png)

## Magic numbers

Magic numbers (unnamed constants) are considered as a bad programming practice. Extracting them into constants or explaining variables usually provides the following advantages:
* It is easier to read and understand.
* It is easier to alter the value of the number, as it is not duplicated.
* It may facilitate parameterization.
* It helps to detect typos.

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


## Using API


See [complete documentation](http://rubydoc.info/gems/mago/) at rubydoc.
Here is a simple example:

```ruby
require 'mago'

# Initialize detector with ruby files and options
detector = Mago::Detector.new(['./square.rb', './math/fibonacci.rb'], :ignore => [1,2,3])

# Run detector it to build a report
report = detector.run  # => #<Mago::Report ...>

# Use report as you want. The following code provides an output like this:
#  ./square.rb
#      Line 3:  5
#      Line 6:  0
#  ./math/fibonacci.rb
#      Line 1:  0.0
#      Line 6:  5.0
report.files.each do |file|
  puts file.path
  file.magic_numbers.each do |number|
    puts "    Line #{number.line}:  #{number.value}"
  end
end

report.errors.each do |error|
  puts "ERROR: #{error}"
end
```
## Copyright

Copyright (c) 2013 Sergey Potapov. See LICENSE.txt for
further details.

