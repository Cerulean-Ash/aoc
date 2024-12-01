def splitFileAlt(file)
  data = File.read(file).split("\n")

  array1, array2 = data.map { |line| line.split.map(&:to_i) }.transpose
  return array1, array2
end

def splitFile(file)
  data = File.read(file).split("\n")

  array1 = []
  array2 = []

  data.each do |line|
    values = line.split
    array1 << values[0].to_i
    array2 << values[1].to_i
  end
  return array1, array2
end

def part1(file)
  array1, array2 = splitFileAlt(file)
  sortedArray1 = array1.sort
  sortedArray2 = array2.sort
  diffArray = []
  sortedArray1.length.times do |i|
    diffArray << (sortedArray1[i] - sortedArray2[i]).abs
  end
  diffArray.sum
end

def part2(file)
  array1, array2 = splitFileAlt(file)
  occurence_hash = {}
  array2.each do |e|
    occurence_hash[e] = occurence_hash[e] ? occurence_hash[e] + 1 : 1
  end

  similarity_array = []
  array1.each do |e|
    # similarity = occurence_hash[e] ? occurence_hash[e] : 0   - can use below instead
    similarity = occurence_hash[e] || 0
    similarity_array << e * similarity
  end
  similarity_array.sum
end

p part1("test1.txt")
puts part1("input.txt")

p part2("test2.txt")
puts part2("input.txt")
