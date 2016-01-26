module DrunkenMathematician
  module_function

  def prime?(argument)
    iterate = 2

    while iterate < argument
      return false if argument % iterate == 0
      iterate += 1
    end

    if argument == 1
      false
    else
      true
    end
  end

  def prime_group?(number)
    if prime?(number.numerator) or prime?(number.denominator)
      true
    else
      false
    end
  end

  def meaningless(argument)
    group_1 = RationalSequence.new(argument).select { |n| prime_group? n }
    group_2 = RationalSequence.new(argument).select { |n| !prime_group? n }

    group_1.reduce(1) {|a, b| a * b} / group_2.reduce(1) {|a, b| a * b }
  end

  def aimless(argument)
    array = PrimeSequence.new(argument).to_a
    count = 1
    rational_primes = []

    while count <= argument
      if count == argument
        rational_primes << Rational(array[count - 1], 1)
      else
        rational_primes << Rational(array[count - 1], array[count])
      end
      count += 2
    end

    rational_primes.reduce(0) {|a, b| a + b }
  end

  def worthless(argument)
    max = FibonacciSequence.new(argument).to_a[-1]
    section = 0

    rational_sum = RationalSequence.new(section).reduce(0) {|a, b| a + b }

    while rational_sum <= max
      section += 1
      rational_sum = RationalSequence.new(section).reduce(0) {|a, b| a + b }
    end

    RationalSequence.new(section - 1).to_a

  end
end

class RationalSequence
  include Enumerable
  include DrunkenMathematician

  def initialize(limit)
    @limit = limit
    @numerator = 1
    @denominator = 1
    @direction = false
  end

  def each
    count = 0

    while count < @limit
      current = Rational(@numerator, @denominator)
      if current.inspect == "(#{@numerator}/#{@denominator})"
        yield current
        count += 1
      end

      next_rational
    end
  end

  def next_rational
    if @denominator == 1 and @direction == false
      @numerator += 1
      @direction = true
    elsif @numerator == 1 and @direction == true
      @denominator += 1
      @direction = false
    elsif @direction == true
      @numerator -= 1
      @denominator += 1
    else
      @numerator += 1
      @denominator -= 1
    end
  end
end

class PrimeSequence
  include Enumerable
  include DrunkenMathematician

  def initialize(limit)
    @limit = limit
  end

  def each
    current = 2
    count = @limit

    while count > 0
      if prime? current
        yield current
        count -= 1
      end

      current += 1
    end
  end
end

class FibonacciSequence
  include Enumerable
  include DrunkenMathematician

  def initialize(limit, first: 1, second: 1)
    @limit, @first, @second = limit, first, second
  end

  def each
    current, previous = @second, @first
    count = @limit

    while count > 0
      count -= 1
      yield previous
      current, previous = current + previous, current
    end
  end
end
