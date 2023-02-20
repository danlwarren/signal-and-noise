library(tuneR)
tuneR::setWavPlayer('/usr/bin/afplay')
source("~/GitHub/signal and noise/mix.equal.length.R")

target.call.files <- list.files("/Volumes/bucket/EconomoU/OKEON/Acoustic data enrichment/input data/target calls/",
                                full.names = TRUE, recursive = TRUE, pattern = ".wav")

nontarget.call.files <- list.files("/Volumes/bucket/EconomoU/OKEON/Acoustic data enrichment/input data/non-target calls/",
                                full.names = TRUE, recursive = TRUE, pattern = ".wav")

background.noise.files <- list.files("/Volumes/bucket/EconomoU/OKEON/Acoustic data enrichment/input data/background noise/",
                                     full.names = TRUE, recursive = TRUE, pattern = ".wav")

test.dir <- ("/Volumes/bucket/EconomoU/OKEON/Acoustic data enrichment/simulated data/test/")

train.dir <- ("/Volumes/bucket/EconomoU/OKEON/Acoustic data enrichment/simulated data/train/")

test.prop <- 0.3

for(i in 1:length(target.call.files)){
  for(j in 1:length(background.noise.files)){
    print(target.call.files[i])
    print(background.noise.files[j])
    this.wave <- mix.equal.length(target.call.files[i], 
                                  background.noise.files[j], 
                                  0.7)
    if(!is.na(this.wave)){
      if(runif(1) < test.prop){
        writeWave(this.wave, paste0(test.dir, "target_", i, "_", j, ".wav" ))   
      } else {
        writeWave(this.wave, paste0(train.dir, "target_", i, "_", j, ".wav" )) 
      }
    }
  }
}


for(i in 1:length(nontarget.call.files)){
  for(j in 1:length(background.noise.files)){
    print(nontarget.call.files[i])
    print(background.noise.files[j])
    this.wave <- mix.equal.length(nontarget.call.files[i], 
                                  background.noise.files[j], 
                                  0.7)
    if(!is.na(this.wave)){
      if(runif(1) < test.prop){
        writeWave(this.wave, paste0(test.dir, "nontarget_", i, "_", j, ".wav" ))   
      } else {
        writeWave(this.wave, paste0(train.dir, "nontarget_", i, "_", j, ".wav" )) 
      }
    }
  }
}
