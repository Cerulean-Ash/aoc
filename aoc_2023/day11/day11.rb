require '../common'

LINES = getData('./input.txt', /\n/)

length = LINES[0].length
emptyLine = "." * length
emptyLineIndexes = []
emptyColumn = Array.new(length) {|i| i }

# get empty rows and columns
LINES.each_with_index do |line, index|
  if line == emptyLine
    emptyLineIndexes << index
  end
  line.split("").each_with_index do |el, innerIndex|
    if el == "#"
      emptyColumn.delete(innerIndex)
    end
  end
end

EMPTYCOLUMNS = emptyColumn
EMPTYLINEINDEXES = emptyLineIndexes

numCounter = 0
hash = {}

# get coords of numbers
numberedGrid = LINES.each_with_index.map do |line, index|
  line.split("").each_with_index.flat_map do |el, innerIndex|
    if el == "#"
      numCounter += 1
      hash[numCounter] = [index, innerIndex]
      el = numCounter
    end
    el
  end
end

def emptiesBetween(x, y)
  horizontalCount = 0
  verticalCount = 0
  EMPTYCOLUMNS.each do |coord|
    horizontalCount += 1 if (x[1] > coord && y[1] < coord) || (x[1] < coord && y[1] > coord)
  end
  EMPTYLINEINDEXES.each do |coord|
    verticalCount += 1 if (x[0] > coord && y[0] < coord) || (x[0] < coord && y[0] > coord)
  end
  return horizontalCount, verticalCount
end

def shortestDistance(x, y, multiplier)
  horizontalCount, verticalCount = emptiesBetween(x, y)
  verticalLength = (x[0] - y[0]).abs() + verticalCount * (multiplier - 1)
  horizontalLength = (x[1] - y[1]).abs() + horizontalCount * (multiplier - 1)
  if x[0] == y[0]
    # same row
    return horizontalLength
  elsif x[1] == y[1]
    # same column
    return verticalLength
  else
    horizontalLength + verticalLength
  end
end

nums = (1..hash.length).to_a

distancesPart1 = nums.each_with_index.map do |num, index|
  coord1 = hash[num]
  nums[index+1...nums.length].map do |number2|
    # part1
    shortestDistance(hash[num], hash[number2], 2)
  end
end

distancesPart2 = nums.each_with_index.map do |num, index|
  coord1 = hash[num]
  nums[index+1...nums.length].map do |number2|
    # part2
    shortestDistance(hash[num], hash[number2], 1000000)
  end
end

p distancesPart1.flatten.sum
p distancesPart2.flatten.sum