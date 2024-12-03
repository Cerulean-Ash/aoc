def part1(file)
  data = File.read(file).scan(/mul\(\d{1,3},\d{1,3}\)/)
  sum = 0
  data.each do |e|
    numbers = e.scan(/\d+/)
    sum += numbers[0].to_i * numbers[1].to_i
  end
  sum
end

def part2(file)
  data = File.read(file).scan(/mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\)/)
  sum = 0
  on = true
  data.each do |e|
    if e == "don't()"
      on = false
    elsif e == "do()"
      on = true
    end

    if on
      numbers = e.scan(/\d+/)
      sum += numbers[0].to_i * numbers[1].to_i
    end
  end
  sum
end

p part1("test1.txt")
p part1("input.txt")

p part2("test2.txt")
p part2("input.txt")
