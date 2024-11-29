
require '../common'

LINES = getData('./input.txt', /\n/)

def part1(lines)

  times = lines[0].scan(/\d+/).map {|time| time.to_i}
  distances = lines[1].scan(/\d+/).map {|distance| distance.to_i}


  time_ranges = []
  error_array = []

  distances.each_with_index do |distance, index|
    min = 0
    max = times[index]
    max.times do |time|
      distance_travelled = (times[index] - time) * time
      if distance_travelled > distance
        min = time
        break
      end
    end
    margin_of_error = times[index] - 2 * min + 1
    error_array << margin_of_error
    time_ranges << [min, times[index] - min]
  end

  total = 1
  time_ranges
  error_array.each do |num|
    total *= num
  end

  p total

end


def part2(lines)
  time = lines[0].scan(/\d+/).join.to_i
  distance = lines[1].scan(/\d+/).join.to_i
  
  
  time_ranges = []
  error_array = []

  min = 0
  max = time
  max.times do |sec|
    distance_travelled = (time - sec) * sec
    if distance_travelled > distance
      min = sec
      break
    end
  end
  margin_of_error = time - 2 * min + 1
  error_array << margin_of_error
  time_ranges << [min, time - min]
  time_ranges
  p error_array
end

part1(LINES)
part2(LINES)


# smarter algorithm - sort of
# evens
# range = (1/2 * 1/2 ) - distance
# 1/2 +- range - 1


# odds
# range = ((1/2(int) * 1/2(int) ) - distance)rounded
# upper = 1/2 +- (range)
# lower = 1/2 +- (range - 1)
