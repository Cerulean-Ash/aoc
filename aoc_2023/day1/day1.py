import re

def solution_part_1(file):
  f = file
  with open(f) as file:
    s = file.read().strip()
    lines = s.split('\n')


  numbers = []


  def getNumber(line):
    digits = re.findall(r"\d", line)
    number = int(digits[0] + digits[-1])
    return number

  numbers = list(map(getNumber,lines))

  total = sum(numbers)

  return total

def solution_part_2(file):
  f = file
  with open(f) as file:
    s = file.read().strip()
    lines = s.split('\n')

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

  numbers = []

  total = 0
  for line in lines:
    numbers.append(re.findall(r"(?=(one|two|three|four|five|six|seven|eight|nine|\d))", line))
  for array in numbers:
    total += num_lookup[array[0]]*10 + num_lookup[array[-1]]

  return total



  # def getNumber(line):
  #   digits = re.findall(r"(?=(one|two|three|four|five|six|seven|eight|nine|\d))", line)
  #   numerals = []
  #   for digit in digits:
  #     if len(digit) == 1:
  #       numerals.append(int(digit))
  #     else:
  #       numerals.append(num_lookup[digit])
  #   number = numerals[0]*10+numerals[-1]
  #   return number

  # numbers = list(map(getNumber,lines))
  # # print(numbers)
  # # total = getNumber('mh4')
  # total = sum(numbers)
  # return total



# test
print(f"the solution to part 1 test is: {solution_part_1('./test1.txt')}")
print(f"the solution to part 2 test is: {solution_part_2('./test2.txt')}")

# answer
print(f"the solution to part 1 input is: {solution_part_1('./input.txt')}")
print(f"the solution to part 2 input is: {solution_part_2('./input.txt')}")

def anotherway():
  map_table = {
      'one': 1, '1': 1,
      'two': 2, '2': 2,
      'three': 3, '3': 3,
      'four': 4, '4': 4,
      'five': 5, '5': 5,
      'six': 6, '6': 6,
      'seven': 7, '7': 7,
      'eight': 8, '8': 8,
      'nine': 9, '9': 9
  }

  pattern = re.compile(f'(?=({"|".join(map_table)}))')
  total = 0
  for line in open('input.txt'):
      values = [map_table[v] for v in re.findall(pattern, line)]
      total += values[0] * 10 + values[-1]
  print(total)

# anotherway()
# 55358