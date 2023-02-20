library(tuneR)
tuneR::setWavPlayer('/usr/bin/afplay')
source("~/GitHub/signal and noise/mix.equal.length.R")

rail.paths <- list.files(path = "~/GitHub/signal and noise/Okinawa Rail/",
                         pattern = ".wav",
                         full.names = TRUE)
noise.paths <- list.files(path = "~/GitHub/signal and noise/LearningBackgroundSamples/",
                          pattern = ".wav",
                          full.names = TRUE, 
                          recursive = TRUE)

for(i in 1:length(rail.paths)){
  for(j in 1:length(noise.paths)){
    print(rail.paths[i])
    print(noise.paths[j])
    this.wave <- mix.equal.length(rail.paths[i], 
                                  noise.paths[j], 
                                  0.5)
    if(!is.na(this.wave)){
      writeWave(this.wave, paste0("~/GitHub/signal and noise/output/", i, "_", j, ".wav" )) 
    }
  }
}
