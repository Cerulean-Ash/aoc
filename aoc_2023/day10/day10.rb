require '../common'

LINES = getData('./input.txt', /\n/).map {|line| line.split("")}
UNSPLIT_LINES = getData('./input.txt', /\n/)

HASH = {
  "above" => {
    "|" => ["|", "S", "7", "F"],
    "-" => [],
    "L" => ["|", "S", "7", "F"],
    "J" => ["|", "S", "7", "F"],
    "7" => [],
    "F" => [],
    "." => [],
    "S" => ["|", "F", "7"]
  },
  "below" => {
    "|" => ["|", "J", "L", "S"],
    "-" => [],
    "L" => [],
    "J" => [],
    "7" => ["|", "L", "J", "S"],
    "F" => ["|", "L", "J", "S"],
    "." => [],
    "S" => ["|", "L", "J"]
  },
  "left" => {
    "|" => [],
    "-" => ["L", "F", "-", "S"],
    "L" => [],
    "J" => ["L", "F", "-", "S"],
    "7" => ["L", "F", "-", "S"],
    "F" => [],
    "." => [],
    "S" => ["L", "F", "-"]
  },
  "right" => {
    "|" => [],
    "-" => ["-", "J", "7", "S"],
    "L" => ["-", "J", "7", "S"],
    "J" => [],
    "7" => [],
    "F" => ["-", "J", "7", "S"],
    "." => [],
    "S" => ["-", "J", "7"]
  }
}

def getStartCoords(lines)
  startCoord = []
  lines.each_with_index do |line, index|
    subIndex = line.index("S")
    startCoord = [index, subIndex] if subIndex
  end
  return startCoord
end

startCoords = getStartCoords(LINES)

def lookLeft(line, index, piece)
  nextPiece = line[index - 1]
  return HASH["left"][piece].include?(nextPiece) ? nextPiece : false
end

def lookRight(line, index, piece)
  nextPiece = line[index + 1]
  return HASH["right"][piece].include?(nextPiece) ? nextPiece : false
end

def lookAbove(lineAbove, index, piece)
  nextPiece = lineAbove[index]
  return HASH["above"][piece].include?(nextPiece) ? nextPiece : false
end

def lookBelow(lineBelow, index, piece)
  nextPiece = lineBelow[index]
  return HASH["below"][piece].include?(nextPiece) ? nextPiece : false
end

def checkPieces(currentPieceIndex, currentLineIndex, lineLength, currentLine, piece, from)
  if currentPieceIndex < lineLength - 1 && from != "right"
    nextPieceRight = lookRight(currentLine, currentPieceIndex, piece)
    if nextPieceRight
      return nextPieceRight, [currentLineIndex, currentPieceIndex + 1], "left"
    end
  end
  if currentPieceIndex > 0 && from != "left"
    nextPieceLeft = lookLeft(currentLine, currentPieceIndex, piece)
    if nextPieceLeft
      return nextPieceLeft, [currentLineIndex, currentPieceIndex - 1], "right"
    end
  end
  if currentLineIndex > 0 && from != "above"
    nextPieceAbove = lookAbove(LINES[currentLineIndex - 1], currentPieceIndex, piece)
    if nextPieceAbove
      return nextPieceAbove, [currentLineIndex - 1, currentPieceIndex], "below"
    end
  end
  if currentLineIndex < LINES.length - 1 && from != "below"
    nextPieceBelow = lookBelow(LINES[currentLineIndex + 1], currentPieceIndex, piece)
    if nextPieceBelow
      return nextPieceBelow, [currentLineIndex + 1, currentPieceIndex], "above"
    end
  end
  return "error"
end

currentLine = LINES[startCoords[0]]
lineLength = currentLine.length
currentLineIndex = startCoords[0]
currentPieceIndex = startCoords[1]
piece = LINES[startCoords[0]][startCoords[1]]

nextPiece = ""
counter = 0
steps = []
coordsList = []
from = ""

while nextPiece != "S"
  nextPiece, coords, from = checkPieces(currentPieceIndex, currentLineIndex, lineLength, currentLine, piece, from)
  piece = nextPiece
  steps << nextPiece
  counter += 1
  currentLine = LINES[coords[0]]
  currentLineIndex = coords[0]
  currentPieceIndex = coords[1]
  coordsList << coords
end
# p steps
p counter




#  Part 2


part2Grid = []
LINES.each_with_index do |line, outerIndex|
  newLine = []
  line.each_with_index do |el, innerIndex|
    if coordsList.include?([outerIndex, innerIndex]) == false
      el = "."
    end
    if el == "S"
      el = '|'
    end
    newLine << el
  end
  part2Grid << newLine.join
end

part2Grid = part2Grid.map do |line|
  line.gsub("-", "").gsub("LJ", "").gsub("F7", "").gsub("L7", "|").gsub("FJ", "|")
end

p part2Grid


counter = 0
insiders = []
part2Grid.each_with_index do |line, outerIndex|
  line.split("").each_with_index do |el, index|
    if el != "|"
      if line[..index].count("|")%2 == 1 
        insiders << el
      end
    end
  end
end
p insiders.count

