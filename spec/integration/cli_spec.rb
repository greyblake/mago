require 'spec_helper'

describe 'mago command' do
  # Run mago command. Return stdout and stderr.
  def mago(args = '')
    cmd = "cd #{FIXTURES_PATH} && #{MAGO_BIN} #{args}"

    stdin, stdout, stderr, thread = Open3.popen3(cmd)
    thread.join

    [stdout.read, stderr.read]
  end



  describe 'arguments' do
    it 'without arguments should look through ruby files in the current directory' do
      stdout, stderr = mago('')

      stdout.should include('./square.rb')
      stdout.should include('./math/fibonacci.rb')
      stderr.should include('./invalid.rb')
    end

    it 'when directory passed should inspect all ruby files inside' do
      stdout, stderr = mago('./math/')

      stdout.should include('./math/fibonacci.rb')
      stdout.should_not include('square')
    end
  end

  context 'ruby file with invalid syntax' do
    it 'should report files with syntax errors' do
      stdout, stderr = mago('./invalid.rb')
      stderr.should include('ERROR: ./invalid.rb has invalid ruby code')
    end
  end


  describe 'options' do
    context 'without options' do
      it 'should detect magic number except 0 and 1' do
        stdout, stderr = mago('./square.rb')

        stdout.should include("./square.rb:3 detected magic number 5\n")
        stdout.should include("./square.rb:4 detected magic number 2\n")
      end
    end

    describe '--ignore' do
      it 'should ignore passed numbers' do
        expected = "./square.rb:3 detected magic number 5\n"\
                   "./square.rb:3 detected magic number 1\n"

        stdout, stderr = mago('--ignore 0,2 ./square.rb')
        stdout.should == expected

        stdout, stderr = mago('-i 0,2 ./square.rb')
        stdout.should == expected
      end
    end
  end

  describe '--source' do
    it 'should show lines of source code with magic numbers' do
      expected = "./square.rb:3| radius = 5 - 1\n" \
                 "./square.rb:4| square = P * radius ** 2\n"

      stdout, stderr = mago('--source ./square.rb')
      stdout.should == expected

      stdout, stderr = mago('-s ./square.rb')
      stdout.should == expected
    end
  end
end
