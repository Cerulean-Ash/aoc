steps = File.read("./input.txt").split(",")

def hashIt(step)
  base = 0
  step.split("").each_with_index do |char, index|
    value = ((char.ord + base) * 17)%256
    base = value
  end
  base
end

# part 1
part1 = steps.map do |step|
  hashIt(step)
end
p part1.sum

# part2
HASH_MAP = {}

steps.each do |step|
  label = step.gsub(/[=-]\d?/, "")
  box = hashIt(label)
  matches = step.match(/([-=])(\d)?/)
  operator = matches[1]
  focal_length = matches[2]
  HASH_MAP[box] = {} if HASH_MAP[box] == nil
  if operator == "="
    HASH_MAP[box][label] = focal_length.to_i
  elsif operator == "-"
    HASH_MAP[box].delete(label)
  end
end

focusingPowers = []
HASH_MAP.each do |key, value|
  counter = 1
  value.each do |innerKey, innerValue|
    focusingPowers << (key + 1) * counter * innerValue
    counter += 1
  end
end

p focusingPowers.sum