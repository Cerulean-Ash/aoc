require_relative '../common'

# Function to check if a row is safe
def safe_row?(row)
  increasing = true
  decreasing = true

  (0...row.size - 1).each do |i|
    diff = (row[i] - row[i + 1]).abs
    return false if diff < 1 || diff > 3

    if row[i] < row[i + 1]
      decreasing = false
    elsif row[i] > row[i + 1]
      increasing = false
    end
  end

  increasing || decreasing
end

# Function to check if a row can be made safe by removing one element
def can_be_made_safe?(row)
  (0...row.size).each do |i|
    new_row = row[0...i] + row[i + 1..-1]
    return true if safe_row?(new_row)
  end
  false
end

# Function to find all safe rows
def find_safe_rows(matrix)
  safe_rows = 0

  matrix.each do |row|
    safe_rows += 1 if safe_row?(row)
  end

  safe_rows
end

# Function to find all safe rows with fault tolerance
def find_safe_rows_with_tolerance(matrix)
  safe_rows = 0

  matrix.each do |row|
    if safe_row?(row) || can_be_made_safe?(row)
      safe_rows += 1
    end
  end

  safe_rows
end

def part1(file)
  matrix = get_rows_and_columns_to_int(file, /\n/, ' ')
  # Find and print safe rows
  safe_rows = find_safe_rows(matrix)
  puts "Safe rows: #{safe_rows}"
  safe_rows
end

def part2(file)
  matrix = get_rows_and_columns_to_int(file, /\n/, ' ')
  # Find and print safe rows
  safe_rows = find_safe_rows_with_tolerance(matrix)
  puts "Safe rows: #{safe_rows}"
  safe_rows
end

part1("test1.txt")
part1("input.txt")

part2("test2.txt")
part2("input.txt")
