require '../common'

LINES = getData('./input.txt', /\n/).map {|line| line.split("")}
UNSPLIT_LINES = getData('./input.txt', /\n/)

lengthsArray = []
directionsArray = []

UNSPLIT_LINES.each do |line|
  lengthsArray << line.scan(/ \d+ /)[0].to_i
  directionsArray << line.scan(/[RDLU] /)[0].strip
end
width = lengthsArray.max
length = directionsArray.length

GRID = []
gridSize = 500
gridSize.times {|i| GRID << Array.new(gridSize, ".")}

def goLeft(currentColumn, currentLine, length)
  length.times do |i|
    GRID[currentColumn][currentLine - (i + 1)] = "-"
  end
  position = [currentColumn, currentLine  - length]
end

def goRight(currentColumn, currentLine, length)
  length.times do |i|
    GRID[currentColumn][currentLine + (i + 1)] = "-"
  end
  position = [currentColumn, currentLine  + length]
end

def goUp(currentColumn, currentLine, length)
  length.times do |i|
    GRID[currentColumn - (i + 1)][currentLine] = "#"
  end
  position = [currentColumn - length, currentLine]
end

def goDown(currentColumn, currentLine, length)
  length.times do |i|
    GRID[currentColumn + (i + 1)][currentLine] = "#"
  end
  position = [currentColumn + length, currentLine]
end

currentPosition = [0, 0]

lengthsArray.each_with_index do |distance, index|
  case directionsArray[index]
  when "U"
    currentPosition = goUp(currentPosition[0], currentPosition[1], distance)
  when "D"
    currentPosition = goDown(currentPosition[0], currentPosition[1], distance)
  when "L"
    currentPosition = goLeft(currentPosition[0], currentPosition[1], distance)
  when "R"
    currentPosition = goRight(currentPosition[0], currentPosition[1], distance)
  else
    p "error"
  end
end

GRID.delete(Array.new(gridSize, "."))
# GRID.each {|line| p line}
newlength = GRID.length
insiders = []
GRID.each_with_index do |line, outerIndex|
  line.each_with_index do |el, innerIndex|
    if el != "#" && el != "-" && outerIndex != 0 && outerIndex != newlength-1
      if line[..innerIndex].count("#")%2 == 1 
        insiders << [outerIndex, innerIndex]
      end
    end
  end
end

insiders.each do |coords|
  GRID[coords[0]][coords[1]] = "#"
end

total = 0
GRID.each {|line| p line}
GRID.each do |line|
  total += line.count("#")
  total += line.count("-")
end

p total