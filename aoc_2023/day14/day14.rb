#

require '../common'

input = "./input.txt"


LINES = getData(input, /\n/)
LENGTH = LINES.length

def splitAndTranspose(array)
  array.map {|line| line.split("")}.transpose
end

LINES_TRANSPOSED = splitAndTranspose(LINES)
TRANSPOSED_LENGTH = LINES_TRANSPOSED.length

tiltNorthTransposed = []


def goNorth(array)
  tiltNorthTransposed = []
  array.each do |line|
    tiltNorthTransposed << line.join().split("#").map{|group| group.split("").sort.reverse.join()}.join("#")
  end
  tiltNorthTransposedComplete = addMissingBlocks(tiltNorthTransposed, LENGTH).map {|line| line.join()}
  tiltNorthComplete = addMissingBlocks(tiltNorthTransposed, LENGTH).transpose.map {|line| line.join()}
  return tiltNorthComplete, tiltNorthTransposedComplete
end

def goSouth(array)
  tiltSouthTransposed = []
  array.each do |line|
    tiltSouthTransposed << line.join().split("#").map{|group| group.split("").sort.join()}.join("#")
  end
  tiltSouthTransposedComplete = addMissingBlocks(tiltSouthTransposed, LENGTH).map {|line| line.join()}
  tiltSouthComplete = addMissingBlocks(tiltSouthTransposed, LENGTH).transpose.map {|line| line.join()}
  return tiltSouthComplete, tiltSouthTransposedComplete
end

def goWest(array)
  tiltWest = []
  array.each do |line|
    tiltWest << line.split("#").map{|group| group.split("").sort.reverse.join()}.join("#")
  end
  tiltWestComplete = addMissingBlocks(tiltWest, TRANSPOSED_LENGTH).map {|line| line.join()}
  return tiltWestComplete
end

def goEast(array)
  tiltEast = []
  array.each do |line|
    tiltEast << line.split("#").map{|group| group.split("").sort.join()}.join("#")
  end
  tiltEastComplete = addMissingBlocks(tiltEast, TRANSPOSED_LENGTH).map {|line| line.join()}
  return tiltEastComplete
end

LINES_TRANSPOSED.each do |line|
  tiltNorthTransposed << line.join().split("#").map{|group| group.split("").sort.reverse.join()}.join("#")
end

tiltNorthCompleteTransposed = tiltNorthTransposed.map do |line| 
  line = line.split("")
  if line.length < LENGTH
    line = line + Array.new(LENGTH - line.length, "#")
  end
  line
end


def addMissingBlocks(array, length)
  array.map do |line| 
    line = line.split("")
    if line.length < length
      line = line + Array.new(length - line.length, "#")
    end
    line
  end
end


tiltNorthComplete = addMissingBlocks(tiltNorthTransposed, LENGTH).transpose.map {|line| line.join()}

tiltNorthComplete = tiltNorthCompleteTransposed.transpose.map {|line| line.join()}

p tiltNorthComplete


# part2 not working yet
# cycles = 10**9

# northTranspose = []
# north = []
# west = []
# south = []
# east = LINES

# cycle_cache = {}
# cycle_repeater = 0

# cycles.times do |i|
#   north, northTranspose = goNorth(splitAndTranspose(east))

#   west = goWest(north)

#   south, southTransposed = goSouth(splitAndTranspose(west))

#   east = goEast(south)

#   if cycle_cache[[north, west, south, east]]
#     break
#   else
#     cycle_cache[[north, west, south, east]] = true
#     cycle_repeater += 1
#   end
#   # east.each {|line| p line}
#   # p "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
# end
# p cycle_repeater
# # p cycle_cache

# p cycles%cycle_repeater






# finalNorth = splitAndTranspose(east).map {|line| line.join()}
# p finalNorth

# north, northTranspose = goNorth(LINES_TRANSPOSED)

# west = goWest(north)

# south, tiltSouthTransposed = goSouth(splitAndTranspose(west))

# east = goEast(south)


# east.each {|line| p line}




sum = 0

tiltNorthTransposed.each_with_index do |line|
  line.split("").each_with_index { |el, index| sum += LENGTH - index if el == "O"} 
end

# northTranspose.each_with_index do |line|
#   line.split("").each_with_index { |el, index| sum += LENGTH - index if el == "O"} 
# end

# finalNorth.each_with_index do |line|
#   line.split("").each_with_index { |el, index| sum += LENGTH - index if el == "O"} 
# end

p sum