using WAV, Random, TickTock, Plots, Statistics

function createWhiteN(noOfSamples)
    k = 96000 #Scaling factor
    outArray = zeros(k*noOfSamples)
    for i in 1:(k*noOfSamples)
        outArray[i] = randn()*2-1
    end  
    return outArray
end

N = 10 # Audio seconds

whiteNoiseArr = createWhiteN(N)
wavwrite(whiteNoiseArr, "GuassianNoise100s.wav", Fs=96000)

#h = Plots.histogram(whiteNoiseArr, xlabel = "number generated", ylabel = "frequency", title = "random number distribution")
#Plots.display(h)
#readline()
