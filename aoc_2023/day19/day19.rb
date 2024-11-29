groups = File.read("./input.txt").split(/\n\n/)

workflows = groups[0]
parts = groups[1]

WORK_FLOW_HASH = {}
workflows.split(/\n/).each do |workflow|
  workFlowName = workflow.scan(/[a-z]+(?={)/)
  workFlowConditions = workflow.scan(/[xmas][<>]\d+\:[a-zA-z]+/)
  elseCase = workflow.scan(/[a-zA-Z]+(?=})/)
  subHash = {}
  workFlowConditions.each_with_index do |condition, index|
    metric = condition.scan(/[xmas]/)
    measure = condition.scan(/[<>]/)[0] == ">" ? "greater" : "less"
    value = condition.scan(/\d+/)[0].to_i
    result = condition.split(":")[1]
    hash = {"metric" => metric[0], "measure" => measure, "value" => value, "result" => result}
    subHash[index] = hash
  end
  subHash["elseCondition"] = elseCase[0]
  WORK_FLOW_HASH[workFlowName[0]] = subHash
end

# p WORK_FLOW_HASH

partsHash = {}
parts.split(/\n/).each_with_index do |part, index|
  partBreakDown = part.gsub(/[{}]/, "").split(/[,=]/)
  subHash = {}
  subHash[partBreakDown[0]] = partBreakDown[1].to_i
  subHash[partBreakDown[2]] = partBreakDown[3].to_i
  subHash[partBreakDown[4]] = partBreakDown[5].to_i
  subHash[partBreakDown[6]] = partBreakDown[7].to_i
  partsHash[index] = subHash
end

# p partsHash

approvedIndexes = []

def traverseWorkflows(part)
  nextFlow = "in"
  flowing = true
  while flowing
    WORK_FLOW_HASH[nextFlow].each do |key, value|
      if key == "elseCondition"
        nextFlow = value
      elsif value["measure"] == "greater"
        if part[value["metric"]] > value["value"]
          nextFlow = value["result"]
          break
        end
      else
        if part[value["metric"]] < value["value"]
          nextFlow = value["result"]
          break
        end
      end
    end
    if nextFlow == "A" || nextFlow == "R"
      flowing = false
    end
    if nextFlow == "A"
      return true
    elsif nextFlow == "R"
      return false
    end
  end
end


partsHash.each do |key, value|
  approvedIndexes << key if traverseWorkflows(value)
end


partRatingSum = approvedIndexes.map do |part|
  partsHash[part]["x"] + partsHash[part]["m"] + partsHash[part]["a"] + partsHash[part]["s"]
end

p partRatingSum.sum()