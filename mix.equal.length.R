mix.equal.length <- function(sig.path, noise.path, ratio){
  
  # This function takes a signal and a noise file, cuts the noise file
  # to the length of the signal file, and then mixes them together with the
  # volume of the signal set by 'ratio'
  
  sig = tuneR::readWave(sig.path)
  noise = tuneR::readWave(noise.path)
  
  # Normalize both inputs
  sig2 <- normalize(sig, unit = "16", pcm = TRUE, rescale = TRUE)
  noise <- normalize(noise, unit = "16", pcm = TRUE, rescale = TRUE)
  
  if(length(sig) > length(noise)){
    print("Background noise file must be longer than signal!")
    return(NA)
  }
  
  # Figure out how much silence we need to add
  length.diff <- length(noise) - length(sig)
  
  split.point <- round(runif(1, max = length.diff))
  
  noise <- extractWave(noise,
                       from = split.point, 
                       to = split.point + length(sig) - 1)
  
  
  # Mix signal into noise at given ratio
  output <- Wave(left = sig@left * ratio + noise@left * (1 - ratio),
                 right = sig@right * ratio + noise@right * (1 - ratio),
                 samp.rate = 44100, bit = 16)
  
  # Renormalize output
  output <- normalize(output, unit = "16", pcm = TRUE, rescale = TRUE)
  
  return(output)
}


