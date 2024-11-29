require '../common'

LINES = getData('./input.txt', /\n/).flat_map {|line| line.scan(/(?<=\d: ).*/)}.map {|line| line.split('|').map {|subline| subline.split(" ")}}

# part 1 
scores = []

LINES.each_with_index do |l, index|
  score = 0
  l[1].each do |num|
    if l[0].include?(num)
      if score == 0
        score = 1
      else
        score *= 2
      end
    end
  end
  scores << score
end

p scores.sum()

# part 2
card_matches = {}
card_count = {}

LINES.each_with_index do |l, index|
  score = 0
  l[1].each do |num|
    if l[0].include?(num)
      score += 1
    end
  end
  card_count[index] = 1
  card_matches[index] = score
end

card_matches.each do |key, value|
  value.times do |num|
    card_count[key + num + 1] += 1 * card_count[key]
  end
end

total = 0
card_count.each do |key, value|
  total += value
end

p total
