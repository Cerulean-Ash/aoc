def get_data(file, regex)
  File.read(file).split(regex)
end

def get_rows_and_columns(file, regex)
  getData(file, regex).map { |line| line.split('') }
end

def split_file_of_two_lists_side_by_side_seperated_by_spaces_alt(file)
  data = File.read(file).split("\n")

  array1, array2 = data.map { |line| line.split.map(&:to_i) }.transpose
  return array1, array2
end

def split_file_of_two_lists_side_by_side_seperated_by_spaces(file)
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
