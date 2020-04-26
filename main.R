library(readr)
library(stringr)
lib <- modules::use("R")

rm(out.file)
file.names <- dir(path="data", pattern="*.csv", full.names=TRUE)
for(i in 1:length(file.names)){
  print(file.names[i])
  inputFile  = as.data.frame(read_csv(file.names[i]))
  result <- lib$mr_presso$mr_presso(BetaOutcome = "betaoutcome", BetaExposure = "betaexposure", SdOutcome = "seoutcome", SdExposure = "seexposure", OUTLIERtest = TRUE, DISTORTIONtest = TRUE, data = inputFile, NbDistribution = 10000,  SignifThreshold = 0.05)
  row.names(result) <- str_replace(file.names[i], ".*?_(.*)\\.csv", "\\1")
  if (exists("out.file")) {
    out.file <- rbind(out.file, result)
  } else {
    out.file <- result
  }
}
write.csv(out.file,"mr_presso_output.csv")
