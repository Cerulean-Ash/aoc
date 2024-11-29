def part1(file)
  file_data = File.read(file).split
  regex = /\d/

  digits = file_data.map do |line|
    numbers = line.scan(regex)
    (numbers[0]+numbers[-1]).to_i
  end

  digits.sum()
end

def part2(file)
  file_data = File.read(file).split
  regex = /(?=(one|two|three|four|five|six|seven|eight|nine|\d))/
  num_lookup = {
    'one': 1,
    '1': 1,
    'two': 2,
    '2': 2,
    'three': 3,
    '3': 3,
    'four': 4,
    '4': 4,
    'five': 5,
    '5': 5,
    'six': 6,
    '6': 6,
    'seven': 7,
    '7': 7,
    'eight': 8,
    '8': 8,
    'nine': 9,
    '9': 9
}

  digits = file_data.map do |line|
    numbers = line.scan(regex)
    num_lookup[numbers.flatten[0].to_sym]*10 + num_lookup[numbers.flatten[-1].to_sym]
  end

  digits.sum()
end

puts part1("test1.txt")
puts part1("input.txt")

puts part2("test2.txt")
puts part2("input.txt")