import re
from math import gcd

f = "test2.txt"
with open(f) as file:
  string = file.read().strip()
  lines = string.split('\n')


def compute_lcm(values):
   lcm = 1
   for value in values:
    lcm = (value*lcm)//gcd(value,lcm)
   return lcm


DICT = {'L': {}, 'R': {}}
instructions, coords = string.split('\n\n')
for line in coords.split('\n'):
  coord, direction = line.split(" = ")
  left,right = direction.split(',')
  left = left.strip()[1:].strip()
  right = right[:-1].strip()
  DICT['L'][coord] = left
  DICT['R'][coord] = right

def solve():
  startCoords = []
  # get starter coords - coords that end with 'A'
  for coord in DICT['L']:
    if coord.endswith("A"):
      startCoords.append(coord)

  TIMES = {}
  counter = 0
  while True:
    NEWPOINTERS = []
    for index,coord in enumerate(startCoords):
      # get coord for each instruction
      coord = DICT[instructions[counter%len(instructions)]][coord]
      if coord.endswith('Z'):
        TIMES[index] = counter+1
        #  have we captured all loop times? if so do lowest common multiple
        if len(TIMES) == len(startCoords):
          print(TIMES)
          return compute_lcm(TIMES.values())
      NEWPOINTERS.append(coord)
    #  progresses the coords down for the next loop
    startCoords = NEWPOINTERS
      

    counter += 1

print(solve())