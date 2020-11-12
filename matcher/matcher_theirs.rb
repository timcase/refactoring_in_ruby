class Matcher

  def clip(array, limit)
    array.map { |val| [val, limit].min }
  end

  def similar_values?(actual, expected, delta)
    ! actual.zip(expected).detect { |m| (m[0] - m[1]).abs > delta }
  end

  def match(expected, actual, clip_limit, delta)
    actual = clip(actual, clip_limit)
    actual.length == expected.length and
      similar_values?(actual, expected, delta)
  end
end
