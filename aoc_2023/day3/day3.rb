require '../common'

LINES = getData('./test1.txt', /\n/)

map = LINES.each_with_index.map do |line, index|

  values = {}
  line.split("").each_with_index do |value, index|
    values[index] = value
  end
  collection = {
    index: index,
    values: values
}
end

# p map

map.map do |line|
  indexes = []
  numbers = {}
  symbols = {}
  number = ''

  line[:values].each do |key, value|
    if key == 0
      if value.match?(/\d/)
        number << value 
        indexes << [line[:index],key]
      elsif value.match?(/[^\d.]/)
        symbols
      end
    # elsif key > 0 && key < hash.length() - 1
    #   if value.match?(/\d/)
    #     number << value 
    #     indexes << key
    #   elsif value.match?(/[^\d.]/)
    #     symbols

      # end
    # else
    # end



  end

  p indexes

end


x = [
  {
    :index=>0, 
    :values=>{
      0=>"4",
      1=>"6", 
      2=>"7", 
      3=>"."
    }
  }, 
  {
    :index=>1,
    :values=>{
      0=>".",
      1=>".",
      2=>".",
      3=>"*", 
      4=>".", 
      5=>".", 
      6=>".", 
      7=>".", 
      8=>".", 
      9=>"."
    }
  }
]

# [
#   0: {
#     0: .,
#     1: "."
#   },
#   1: {

#   }
# ]

# [
#   123: [[1,2], [2,3], [8,6]]
# ]