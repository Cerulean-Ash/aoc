require '../common'

LINES = getData('./input.txt', /\n/)

def structureData
  timesShown = 0
  games = LINES.map do |line|
    gameId = line.split(/:|;/)[0].scan(/\d+/)[0].to_i
    rounds = line.scan(/(?<=: ).+/).flat_map {|round| round.split(/;/)}
    blues = rounds.map do |round|
      blue = round.scan(/\d+ (?=blue)/)
      blue = blue.empty? ? [0] : blue.flat_map {|num| num.to_i}
    end
    reds = rounds.map do |round|
      red = round.scan(/\d+ (?=red)/)
      red = red.empty? ? [0] : red.flat_map {|num| num.to_i}
    end
    greens = rounds.map do |round|
      green = round.scan(/\d+ (?=green)/)
      green = green.empty? ? [0] : green.flat_map {|num| num.to_i}
    end
    timesShown = blues.length if blues.length > timesShown
    rounds = []
    timesShown.times do |i|
        rounds << {
          red: reds[i] == nil ? 0 : reds[i][0],
          blue: blues[i] == nil ? 0 : blues[i][0],
          green: greens[i] == nil ? 0 : greens[i][0]
        }
    end

    {
      id: gameId,
      rounds: rounds
    }
  end
end

def part1
  games = structureData()
  possibleGames = []

  limit = {
    red: 12,
    green: 13,
    blue: 14
  }

  games.each do |game|
    possible = true
    game[:rounds].each do |round|
      possible = false if round[:red] > limit[:red]
      possible = false if round[:blue] > limit[:blue]
      possible = false if round[:green] > limit[:green]
    end
    possibleGames << game[:id] if possible == true
  end
  possibleGames.sum
end

def part2
  games = structureData()

  powers = games.map do |game|
    minRed = 0
    minBlue = 0
    minGreen = 0
    game[:rounds].each do |round|
      minRed = round[:red] if round[:red] > minRed
      minBlue = round[:blue] if round[:blue] > minBlue
      minGreen = round[:green] if round[:green] > minGreen
    end
    power = minRed * minBlue * minGreen
  end
  powers.sum()
end

p part1()
p part2()


