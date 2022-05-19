using WAV, TickTock, Plots

#Read audio file into array
array, fs = wavread("GuassianNoise5s.wav", format = "float")

h = Plots.histogram(array, xlabel = "number generated", ylabel = "frequency", title = "random number distribution")
Plots.display(h)
readline()
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
println(arrMin)
println(arrMax)