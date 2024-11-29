require '../common'

LINES = getData('./input.txt', /\n/)

def hashAndStartBuilder(part2)
  start = ""
  hash = {}
  start_array = []
  LINES.each_with_index do |line, index|
    if index > 1
      array = line.split(" = ")
      key = array[0]
      if part2 == true
        start_array << key if key.end_with?('A')
      else
        start = key if key == "AAA"
      end
      coords = array[1].gsub(/[(),]/, "").split()
      hash[key] = {"L" => coords[0],
                    "R" => coords[1]
                  }
    end
  end
  if part2 == true
    return hash, start_array
  else
    return hash, start
  end
end

def solve_part1
  instructions = LINES[0].scan(/[RL]/)
  count = 0
  counter = 0
  length = instructions.length
  hash, start = hashAndStartBuilder(false)
  nextCoord = start

  while counter < length
    move = instructions[counter]
    nextCoord = hash[nextCoord][move]
    
    count += 1
    break if nextCoord == 'ZZZ'

    counter += 1
    if counter == (length)
      counter = 0
    end
  end
  return count
end


def solve_part2
  instructions = LINES[0].scan(/[RL]/)
  part2 = true
  start = ""

  hash, start_array = hashAndStartBuilder(part2)

  count = 0
  counter = 0
  length = instructions.length
  nextCoords = start_array
  loopTime = {}
    
  while counter < length
    move = instructions[counter]
    newNextCoords = []
    nextCoords.each_with_index do |coord, index|
      newCoord = hash[coord][move]
      if coord.end_with?("Z")
        loopTime[index] = count
      end
      newNextCoords << newCoord
    end
    nextCoords = newNextCoords
    count += 1
    counter += 1

    if counter == (length)
      counter = 0
    end

    if loopTime.values.length() == start_array.length
      return loopTime.values.reduce(1, :lcm)
    end
  end
end

p solve_part1

p solve_part2