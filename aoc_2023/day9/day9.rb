require '../common'

LINES = getData('./input.txt', /\n/).map {|line| line.split().flat_map {|s| s.to_i}}

def solve_part1()
  hash = {}
  LINES.each_with_index do |line, index|
    hash[index] = [line]
    while true
      next_layer = []
      line.each_with_index do |num, index|
        if index > 0
          diff = num - line[index - 1]
          next_layer << diff
        end
      end
      hash[index] << next_layer
      if next_layer.uniq.length == 1
        break
      end
      line = next_layer
    end

    increase = 0
    hash[index].reverse.each_with_index do |layer, i|
      if i > 0
        hash[index].reverse[i] << increase + hash[index].reverse[i][-1]
      end
      increase = layer[-1]
    end
  end
  histories =  hash.values.map {|line| line[0][-1]}
  p histories.sum
end

def solve_part2()
  hash = {}
  LINES.each_with_index do |line, index|
    hash[index] = [line]
    while true
      next_layer = []
      line.each_with_index do |num, index|
        if index > 0
          diff = num - line[index - 1]
          next_layer << diff
        end
      end
      hash[index] << next_layer
      if next_layer.uniq.length == 1
        break
      end
      line = next_layer
    end

    decrease = 0
    hash[index].reverse.each_with_index do |layer, i|
      if i > 0
        hash[index].reverse[i].unshift(hash[index].reverse[i][0] - decrease)
        # hash[index].reverse[i] << increase + hash[index].reverse[i][-1]
      end
      decrease = layer[0]
    end
  end
  histories =  hash.values.map {|line| line[0][0]}
  p histories.sum
end


solve_part1()
solve_part2()