mix.rand <- function(sig.path, noise.path, ratio){
  
  sig = tuneR::readWave(sig.path)
  noise = tuneR::readWave(noise.path)
  
  if(length(sig) > length(noise)){
    stop("\n\nBackground noise file must be longer than signal!\n\n")
  }
  
  # Figure out how much silence we need to add
  length.diff <- length(noise) - length(sig)
  
  split.point <- round(runif(1, max = length.diff))
  
  # Create two clips of silence
  silence.1 <- silence(split.point, samp.rate = sig@samp.rate, 
                       bit = sig@bit, stereo = sig@stereo, xunit = "samples",
                       pcm = sig@pcm)
  
  silence.2 <- silence(length.diff - split.point, samp.rate = sig@samp.rate, 
                       bit = sig@bit, stereo = sig@stereo, xunit = "samples",
                       pcm = sig@pcm)
  
  # Concatenate silence.1, sig, and silence.2 in that order
  sig <- bind(silence.1, sig, silence.2)
  
  # Normalize both inputs
  sig <- normalize(sig, unit = "16", pcm = TRUE, rescale = TRUE)
  noise <- normalize(noise, unit = "16", pcm = TRUE, rescale = TRUE)
  
  # Mix signal into noise at given ratio
  output <- Wave(left = sig@left * ratio + noise@left * (1 - ratio),
                 right = sig@right * ratio + noise@right * (1 - ratio),
                 samp.rate = 44100, bit = 16)
  
  # Renormalize output
  output <- normalize(output, unit = "16", pcm = TRUE, rescale = TRUE)
  
  return(output)
}


