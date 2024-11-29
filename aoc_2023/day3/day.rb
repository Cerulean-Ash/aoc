require '../common'

LINES = getData('./input.txt', /\n/)


map = LINES.each_with_index.map do |line, index|
  
  numbers = line.scan(/\d+/)

  tally = numbers.tally()
  count = 0
  nums = numbers.map do |number|
    regex = /\b#{number}\b/
    if tally[number] > 1
      if count == 0
        count = 1
        firstIndex = line.index(regex)
      else
        firstIndex = line.index(regex, line.index(regex)+1)
        count = 0
      end
    else
      firstIndex = line.index(regex)
    end
    regex = /\b#{number}\b/
    length = number.length
    lastIndex = firstIndex + length - 1
    effectiveArea = [firstIndex > 0 ? firstIndex - 1 : 0, lastIndex + 1 == line.length ? lastIndex : lastIndex + 1]
    {
      number: number,
      effectiveArea: effectiveArea
    }
  end
  map = {
    line: index,
    numbers: nums
  }
end

symbol_hash = {}

LINES.each_with_index.map do |line, index|
  symbols = line.scan(/[^\d.]/)
  area = []
  symbols.each do |symbol|
    i = -1
    all = []
    while i = line.index(symbol,i+1)
      all << i
    end
    area << all
  end
   symMap = {
    index => area.flatten
  }

  symbol_hash[index] = area.flatten.length > 0 ? area.flatten.uniq : area.flatten
end


parts = map.each_with_index.map do |line, index|
  numbers = []
  lineNumber = line[:line]
  line[:numbers].each do |number|
    # p number
    first = number[:effectiveArea][0]
    last = number[:effectiveArea][1]
    if lineNumber == 0
      sym_array = symbol_hash[lineNumber + 1] + symbol_hash[lineNumber]
    elsif lineNumber == LINES.length() - 1
      sym_array = symbol_hash[lineNumber - 1] + symbol_hash[lineNumber]
    else 
      sym_array = symbol_hash[lineNumber - 1] + symbol_hash[lineNumber] + symbol_hash[lineNumber + 1]
    end
    sym_array
    sym_array
    sym_array.each do |sym|
      if sym <= last && sym >= first
        # "between #{first} and #{last} is #{sym} for number #{number[:number]}"
        numbers << number[:number].to_i
        break
      end 
    end
  end
  numbers
end
p parts.flatten.sum









map2 = {}

LINES.each_with_index do |line, index|
  
  numbers = line.scan(/\d+/)

  tally = numbers.tally()
  count = 0
  nums = numbers.map do |number|
    regex = /\b#{number}\b/
    if tally[number] > 1
      if count == 0
        count = 1
        firstIndex = line.index(regex)
      else
        firstIndex = line.index(regex, line.index(regex)+1)
        count = 0
      end
    else
      firstIndex = line.index(regex)
    end
    regex = /\b#{number}\b/
    length = number.length
    lastIndex = firstIndex + length - 1
    effectiveArea = [firstIndex > 0 ? firstIndex - 1 : 0, lastIndex + 1 == line.length ? lastIndex : lastIndex + 1]
    {
      number: number,
      effectiveArea: effectiveArea
    }
  end
  map2[index] = nums
end
  
# p map2

star_hash = {}

LINES.each_with_index.map do |line, index|
  symbols = line.scan(/\*/)
  area = []
  symbols.each do |symbol|
    i = -1
    all = []
    while i = line.index(symbol,i+1)
      all << i
    end
    area << all
  end
   symMap = {
    index => area.flatten
  }

  def checkAdjacent(array)
    array.each do |number|
      p number[:effectiveArea]
      p number[:number]
    end

  end

  star_hash[index] = area.flatten.length > 0 ? area.flatten.uniq : area.flatten
end
# p star_hash


gear_array = []

star_hash.each do |key, value|

  value.each do |star|
    # p star
    count = 0
    number_store = []

    map2[key].each do |number|
      first = number[:effectiveArea][0]
      last = number[:effectiveArea][1]
      num = number[:number]
      if star <= last && star >= first
        count += 1
        number_store << num
      end
    end
    if key < LINES.length() - 1
      map2[key+1].each do |number|
        first = number[:effectiveArea][0]
        last = number[:effectiveArea][1]
        num = number[:number]
        if star <= last && star >= first
          count += 1
          number_store << num
        end
      end
    end
    if key > 0
      map2[key-1].each do |number|
        first = number[:effectiveArea][0]
        last = number[:effectiveArea][1]
        num = number[:number]
        if star <= last && star >= first
          count += 1
          number_store << num
        end
      end
    end
    if count > 1
      gear_array << number_store[0].to_i * number_store[1].to_i
    end
  end


end
 p gear_array.sum()