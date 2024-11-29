require '../common'

LINES = getData('./test.txt', /\n/)

hash = {}
conjunctions = []
LINES.each do |line| 
  name = line.scan(/\w+(?= ->)/)
  type = line.scan(/[%&]/)
  type = name if type.empty?
  destination = line.scan(/(?<=-> ).+/)[0].split(", ")
  subHash = {"type" => type[0], "destination" => destination, "from" => [], "on" => false, "lastSent" => ""}
  hash[name[0]] = subHash
  conjunctions << name[0] if type[0] == "&"
end

# p hash
# p conjunctions

hash.each do |key, value|
  value["destination"].each do |destination|
    if conjunctions.include?(destination)
      hash[destination]["from"] << key
    end
  end
end

# p hash

PULSES = []

def push(hash)
  currentModules = [["broadcaster", "low"]]
  while !currentModules.empty?
    nextModules = []
    currentModules.each do |mod|
      name = mod[0]
      pulseReceived = mod[1]
      # p pulseReceived
      if hash[name].nil?
        break
      end
      type = hash[name]["type"]
      destinations = hash[name]["destination"]
      PULSES << "low" if pulseReceived == "low"
      PULSES << "high" if pulseReceived == "high"
      pulseToSend = ""
      if type == "%"
        if pulseReceived == "low"
          if hash[name]["on"]
            pulseToSend = "low"
            hash[name]["lastSent"] = "low"
            hash[name]["on"] = false
          elsif !hash[name]["on"]
            pulseToSend = "high"
            hash[name]["lastSent"] = "high"
            hash[name]["on"] = true
          end
        end
      end
      if type == "broadcaster"
        pulseToSend = "low"
        hash[name]["lastSent"] = "low"
      end
      if type == "&"
        allHigh = true
        hash[name]["from"].each do |from|
          if hash[from]["lastSent"] == "low" || hash[from]["lastSent"] == ""
            allHigh = false
          end
          if allHigh
            pulseToSend = "low"
            hash[name]["lastSent"] = "low"
          else
            pulseToSend = "high"
            hash[name]["lastSent"] = "high"
          end
        end
      end
      destinations.each do |destination|
        nextModules << [destination, pulseToSend]
      end
    end
    currentModules = nextModules
  end
  return hash
end

newHash = hash
1000.times do
  newHash = push(newHash)
end

p PULSES.count("high")
p PULSES.count("low")

# % = flipflop
# ignore hi pulses
# only if low
# if off turn on and send hi pulses
#   if on turn off and send low pulse

# & = conjunction
# connects multiple together
# remembers what it recived from each
# first updtaes memory ofwhat it receives
# if all high in memory then send low
# else send high