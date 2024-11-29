def getData(file, regex)
  lines = File.read(file).split(regex)
  return lines
end

def getRowsandColumns(file, regex)
  getData(file, regex).map {|line| line.split("")}
end