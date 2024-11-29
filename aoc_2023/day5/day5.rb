require '../common'

LINES = getData('./test.txt', /\n/)

LINES.delete("")

# p LINES

seeds = LINES.map {|line| line.match(/(?<=seeds: )[\d ]*/)}[0][0].split.map {|seed| seed.to_i}

seed_ranges = []
seeds.each_with_index do |seed, index|
  if index%2 == 0
    seed_ranges << [seed, seed + seeds[index+1] -1 ]
  end
end

p seed_ranges
def overlap(enumFrom, enumTo)
  lowerFrom = enumFrom[0]
  upperFrom = enumFrom[1]
  lowerTo = enumTo[0]
  upperTo = enumTo[1]

  if (lowerFrom >= lowerTo && lowerFrom <= upperTo) || (upperFrom <= upperTo && upperFrom >= lowerTo)
    return true
  else
    return false
  end
end






seed_to_soil = {}
soil_to_fertilizer = {}
fertilizer_to_water = {}
water_to_light = {}
light_to_temperature = {}
temperature_to_humidity = {}
humidity_to_location = {}
other = {}

line_breakdown = {}
breakdownArray = []
regex = /[a-z\- ]*:/

def between(enumFrom, enumTo, first, range)
  is_between = false
  enumFrom.each do |key, value|
    if value < (first + range) && value >= first
      is_between = true
    else
      enumTo[value] = value
    end
  end
  return is_between
end

def lookBack(enumFrom, enumTo)
  enumFrom.each do |key, value|
    nextValue = enumTo[value] ? enumTo[value] : value
    enumTo[value] = nextValue
  end
end


def update(enumFrom, enumTo, first, second, range)
  is_between = false
  enumFrom.each do |key, value|
    if value < (first + range) && value >= first
      is_between = true
      enumTo[value] = second - first + value
    end
  end
end




LINES.each_with_index do |line, index|
  if line.match?(regex)
    line_breakdown[line.match(regex)[0]] = index
    breakdownArray << [line.match(regex)[0], index]
  else
    first = line.split[1].to_i
    second = line.split[0].to_i
    range = line.split()[2].to_i
    case breakdownArray[-1][0]

    when "seed-to-soil map:"



    when "soil-to-fertilizer map:"
  

    when "fertilizer-to-water map:"


    when "water-to-light map:"

    when "light-to-temperature map:"

    when "temperature-to-humidity map:"


    when "humidity-to-location map:"

    else
    end
  end
end






















# part 1 works below part 2 above still not working properly


# # p LINES.length()

# LINES.each_with_index do |line, index|
#   # p index
#   if line.match?(regex)
#     line_breakdown[line.match(regex)[0]] = index
#     breakdownArray << [line.match(regex)[0], index]
#   else
#     first = line.split[1].to_i
#     second = line.split[0].to_i
#     range = line.split()[2].to_i
#     case breakdownArray[-1][0]

#     when "seed-to-soil map:"
#       p "seed-to-soil map"
#       seed_between = false
#       seeds.each do |seed|
#         if seed < (first + range) && seed >= first
#           seed_between = true
#           seed_to_soil[seed] = second - first + seed
#         end
#       end

#     when "soil-to-fertilizer map:"
#       p "soil-to-fertilizer map"
#       seeds.each do |seed|
#         soil = seed_to_soil[seed] ? seed_to_soil[seed] : seed
#         seed_to_soil[seed] = soil
#       end

#       update(seed_to_soil, soil_to_fertilizer, first, second, range)

#     when "fertilizer-to-water map:"
#       p "fertilizer-to-water map"

#       lookBack(seed_to_soil, soil_to_fertilizer)

#       update(soil_to_fertilizer, fertilizer_to_water, first, second, range)

#     when "water-to-light map:"
#       p "water-to-light map"
#       lookBack(soil_to_fertilizer, fertilizer_to_water)
#       update(fertilizer_to_water, water_to_light, first, second, range)

#     when "light-to-temperature map:"
#       p "light-to-temperature map"
#       lookBack(fertilizer_to_water, water_to_light)
#       update(water_to_light, light_to_temperature, first, second, range)

#     when "temperature-to-humidity map:"
#       p "temperature-to-humidity map"
#       lookBack(water_to_light, light_to_temperature)
#       update(light_to_temperature, temperature_to_humidity, first, second, range)

#     when "humidity-to-location map:"
#       p "humidity-to-location map"
#       lookBack(light_to_temperature, temperature_to_humidity)
#       update(temperature_to_humidity, humidity_to_location, first, second, range)
#     else
#       lookBack(temperature_to_humidity, humidity_to_location)
#     end
#     lookBack(temperature_to_humidity, humidity_to_location)
#   end
# end

# p humidity_to_location.values.min()








# # p seed_to_soil
# # p soil_to_fertilizer

# # locations = []

# # seeds.each do |seed|
# #   soil = seed_to_soil[seed] ? seed_to_soil[seed] : seed
# #   fertilizer = soil_to_fertilizer[soil] ? soil_to_fertilizer[soil] : soil
# #   water = fertilizer_to_water[fertilizer] ? fertilizer_to_water[fertilizer] : fertilizer
# #   light = water_to_light[water] ? water_to_light[water] : water
# #   temperature = light_to_temperature[light] ? light_to_temperature[light] : light
# #   humidity = temperature_to_humidity[temperature] ? temperature_to_humidity[temperature] : temperature
# #   location = humidity_to_location[humidity] ? humidity_to_location[humidity] : humidity
# #   locations << location
# # end

# # p locations