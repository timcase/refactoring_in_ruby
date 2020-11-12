class Matcher
  def match(expected, actual, clip_limit, delta)

    actual = actual.map { |val| clip_too_large_values(val, clip_limit) }

    return false if length_different?(actual, expected)

    actual.each_index { |i|
      return false if within_expected_delta?(i, expected, actual, delta)
    }
    return true
  end

  def clip_too_large_values(val, clip_limit)
    [val, clip_limit].min
  end

  def length_different?(actual, expected)
    actual.length != expected.length
  end

  def within_expected_delta?(i, expected, actual, delta)
    (expected[i] - actual[i]).abs > delta
  end

end
