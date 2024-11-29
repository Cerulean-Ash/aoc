require '../common'

LINES = getData('./input.txt', /\n/)

SCORE = {
  '2' => '02',
  '3' => '03',
  '4' => '04',
  '5' => '05',
  '6' => '06',
  '7' => '07',
  '8' => '08',
  '9' => '09',
  'T' => '10',
  'J' => '11',
  'Q' => '12',
  'K' => '13',
  'A' => '14'
}

SCORE_PART_2 = {
  'J' => '01',
  '2' => '02',
  '3' => '03',
  '4' => '04',
  '5' => '05',
  '6' => '06',
  '7' => '07',
  '8' => '08',
  '9' => '09',
  'T' => '10',
  'Q' => '12',
  'K' => '13',
  'A' => '14'
}

SCORED_HANDS_PART1 = {
  five: [],
  four: [],
  full: [],
  three: [],
  twoPair: [],
  onePair: [],
  high: []
}

SCORED_HANDS_PART2 = {
  five: [],
  four: [],
  full: [],
  three: [],
  twoPair: [],
  onePair: [],
  high: []
}

def solve(part)
  cardHash = LINES.map{|line| line.split(" ")}.to_h
  cards = cardHash.keys
  score = part == 'part1' ? SCORE : SCORE_PART_2
  cards.each {|hand| handType(hand, score, part)}
  scoredHands = part == "part2" ? SCORED_HANDS_PART2 : SCORED_HANDS_PART1
  orderCards = scoredHands.flat_map { |key, value| value }
  weightedScores= orderCards.reverse.each_with_index.map {|hand, index| cardHash[hand].to_i * (index + 1)}
  p weightedScores.sum
end


def compare(array, score_hash)
  array.sort! do |a, b|
    bScored = b.split("").map{|i| score_hash[i]}.join('')
    aScored = a.split("").map{|i| score_hash[i]}.join('')
    bScored <=> aScored
  end
end

def createAltHand(hand)
  highestCard = ""
  highestCount = 0
  if hand.include?('J')
    hand.split("").uniq.each do |card|
      if card != "J"
        if hand.count(card) > highestCount
          highestCard = card
          highestCount = hand.count(card)
        end
      end
    end
    altHand = highestCard == "" ? hand : hand.gsub('J', highestCard)
  else
    altHand = hand
  end
  return altHand
end

def handType(hand, score, part)
  trueHand = hand
  altHand = part == "part2" ? createAltHand(hand) : hand
  scoredHands = part == "part2" ? SCORED_HANDS_PART2 : SCORED_HANDS_PART1
  if altHand.count(altHand[0]) == 5
    scoredHands[:five] << trueHand
    compare(scoredHands[:five], score) if scoredHands[:five].length > 1
  elsif altHand.count(altHand[0]) == 4 || altHand.count(altHand[1]) == 4
    scoredHands[:four] << trueHand
    compare(scoredHands[:four], score) if scoredHands[:four].length > 1
  elsif (altHand.count(altHand[0]) == 3 && altHand.count(altHand.delete(altHand[0])[0]) == 2) || (altHand.count(altHand[0]) == 2 && altHand.count(altHand.delete(altHand[0])[0]) == 3)
    scoredHands[:full] << trueHand
    compare(scoredHands[:full], score) if scoredHands[:full].length > 1
  elsif altHand.count(altHand[0]) == 3 || altHand.count(altHand[1]) == 3 || altHand.count(altHand[2]) == 3
    scoredHands[:three] << trueHand
    compare(scoredHands[:three], score) if scoredHands[:three].length > 1
  elsif altHand.split("").uniq.length == 3
    scoredHands[:twoPair] << trueHand
    compare(scoredHands[:twoPair], score) if scoredHands[:twoPair].length > 1
  elsif altHand.split("").uniq.length == 4
    scoredHands[:onePair] << trueHand
    compare(scoredHands[:onePair], score) if scoredHands[:onePair].length > 1
  else
    scoredHands[:high] << trueHand
    compare(scoredHands[:high], score) if scoredHands[:high].length > 1
  end
end

solve("part1")
solve("part2")