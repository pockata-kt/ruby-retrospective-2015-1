class Integer
  def prime?
    return false if self == 1
    2.upto(self ** 0.5).all? {|n| self % n != 0 }
  end
end

module DrunkenMathematician
  module_function

  def prime_group?(rational)
    rational.numerator.prime? or rational.denominator.prime?
  end

  def meaningless(number)
    sequence = RationalSequence.new(number)
    group_1, group_2 = sequence.partition { |n| prime_group? n }

    group_1.reduce(1, :*) / group_2.reduce(1, :*)
  end

  def aimless(argument)
    array = PrimeSequence.new(argument)
    array.each_slice(2).map {|a, b| Rational(a, b || 1) }.reduce(:+)
  end

  def worthless(argument)
    max = FibonacciSequence.new(argument).to_a.last
    rational_sum = 0

    RationalSequence.new(max ** 2).take_while do |current|
      rational_sum += current
      rational_sum <= max
    end
  end
end

class RationalSequence
  include Enumerable

  def initialize(limit)
    @limit = limit
    @direction = false
  end

  def each(&block)
    enum_for(:generate).lazy.take(@limit).each(&block)
  end

  private

  def generate
    numerator = 1
    denominator = 1

    loop do
      current = Rational(numerator, denominator)
      yield current if current.inspect == "(#{numerator}/#{denominator})"
      numerator, denominator = next_rational(numerator, denominator)
    end
  end

  def next_rational(numerator, denominator)
    if denominator == 1 and @direction == false
      numerator += 1
      @direction = true
    elsif numerator == 1 and @direction == true
      denominator += 1
      @direction = false
    elsif @direction == true
      numerator -= 1
      denominator += 1
    else
      numerator += 1
      denominator -= 1
    end
    [numerator, denominator]
  end
end

class PrimeSequence
  include Enumerable

  def initialize(limit)
    @limit = limit
  end

  def each(&block)
    enum_for(:generate).lazy.take(@limit).each(&block)
  end

  private

  def generate
    current = 2

    loop do
      yield current if current.prime?
      current += 1
    end
  end
end

class FibonacciSequence
  include Enumerable

  def initialize(limit, first: 1, second: 1)
    @limit, @first, @second = limit, first, second
  end

  def each(&block)
    enum_for(:generate).lazy.take(@limit).each(&block)
  end

  private

  def generate
    current, previous = @second, @first

    loop do
      yield previous
      current, previous = current + previous, current
    end
  end
end
