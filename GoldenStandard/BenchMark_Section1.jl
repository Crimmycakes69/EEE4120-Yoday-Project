#using WAV, TickTock, Plots

#Read audio file into array
#array, fs = wavread("GuassianNoise5s.wav", format = "float")

#h = Plots.histogram(array, xlabel = "number generated", ylabel = "frequency", title = "random number distribution")
#Plots.display(h)
#readline()

using CSV, DataFrames, TickTock, Plots

CSVFile = CSV.read("SineWave1s.csv",DataFrame)
freq = 48000
duration = 1
audSize = freq*duration
array = zeros(Int64, audSize)
for i in 1:audSize
    array[i] = convert(Int64, CSVFile[i,1])
end
#p = plot(1:audSize,array)
#Plots.display(p)
#readline()
println("Number of samples: ",length(array))

tick()
Len = length(array)
arrMax = array[1]
arrMin = array[1]

for i in 1:Len
    if array[i] > arrMax 
      global arrMax = array[i]
    elseif array[i] < arrMin
       global arrMin = array[i]
    end
end
t = tock()
println("Minimum: ",arrMin)
println("Maximum: ",arrMax)