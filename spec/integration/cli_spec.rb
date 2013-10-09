require 'spec_helper'

describe 'mago command' do
  def mago(args = '')
    cmd = "cd #{FIXTURES_PATH} && #{MAGO_BIN} #{args}"
    %x"#{cmd}"
  end

  describe 'arguments' do
    it 'without arguments should look through ruby files in the current directory' do
      output = mago('')

      output.should include('./square.rb')
      output.should include('./math/fibonacci.rb')
      output.should include('./invalid.rb')
    end

    it 'when directory passed should inspect all ruby files inside' do
      output = mago('./math/')

      output.should include('./math/fibonacci.rb')
      output.should_not include('square')
    end
  end

  context 'ruby file with invalid syntax' do
    it 'should report files with syntax errors' do
      output = mago('./invalid.rb')
      output.should include('ERROR: ./invalid.rb has invalid ruby code')
    end
  end


  describe 'options' do
    context 'without options' do
      it 'should detect magic number except 0 and 1' do
        mago('./square.rb').should ==
          "./square.rb:3 detected magic number 5\n" \
          "./square.rb:4 detected magic number 2\n"
      end
    end

    describe '--ignore option' do
      it 'should ignore passed numbers' do
        expected = "./square.rb:3 detected magic number 5\n"\
                   "./square.rb:3 detected magic number 1\n"

        mago('--ignore 0,2 ./square.rb').should == expected
        mago('-i 0,2 ./square.rb').should == expected
      end
    end
  end
end
