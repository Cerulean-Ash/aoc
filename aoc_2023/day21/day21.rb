require '../common'

GRID = getRowsandColumns('./input.txt', /\n/)

sCoords = []
columnLength = GRID.length
lineLength = GRID[0].length

GRID.each_with_index do |line, outerIndex|
  line.each_with_index do |point, innerIndex|
    if point == "S"
      sCoords = [outerIndex, innerIndex]
    end
  end
end

# p sCoords






def checkPlot(rowIndex, columnIndex, lineLength, columnLength, currentLine)
  openPlots = []
  if columnIndex < lineLength - 1
    openPlots << [rowIndex, columnIndex + 1] if lookRight(currentLine, columnIndex)
  end
  if columnIndex > 0
    openPlots << [rowIndex, columnIndex - 1] if lookLeft(currentLine, columnIndex)
  end
  if rowIndex > 0
    openPlots << [rowIndex - 1, columnIndex] if lookAbove(GRID[rowIndex - 1], columnIndex)
  end
  if rowIndex <columnLength - 1
    openPlots << [rowIndex + 1, columnIndex] if lookBelow(GRID[rowIndex + 1], columnIndex)
  end
  return openPlots
end

def lookLeft(line, index)
  return line[index - 1] != "#" ? true : false
end

def lookRight(line, index)
  return line[index + 1] != "#" ? true : false
end

def lookAbove(lineAbove, index)
  return lineAbove[index] != "#" ? true : false
end

def lookBelow(lineBelow, index)
  return lineBelow[index] != "#" ? true : false
end



# startCoords = [sCoords]
# newCoords = []

# startCoords.each do |coord|
#   row = coord[0]
#   column = coord[1]
#   line = GRID[row]
#   newCoords << checkPlot(row, column, lineLength, columnLength, line)
# end

# p newCoords.flatten(1)


numTimes = 64
startCoords = [sCoords]

numTimes.times do
  newCoords = []
  startCoords.each do |coord|
    row = coord[0]
    column = coord[1]
    line = GRID[row]
    newCoords << checkPlot(row, column, lineLength, columnLength, line)
  end
  startCoords = newCoords.flatten(1).uniq
end

p startCoords.count