#using WAV, TickTock, Plots

#Read audio file into array
#array, fs = wavread("GuassianNoise5s.wav", format = "float")

#h = Plots.histogram(array, xlabel = "number generated", ylabel = "frequency", title = "random number distribution")
#Plots.display(h)
#readline()
using CSV, DataFrames, TickTock, Plots

CSVFile = CSV.read("SineWave10s.csv",DataFrame)
freq = 48000
duration = 10
audSize = freq*duration
array = zeros(Int64, audSize)
for i in 1:audSize
    array[i] = convert(Int64, CSVFile[i,1])
end
#p = plot(1:audSize,array)
#Plots.display(p)
#readline()
println("Number of samples: ",length(array))

fs = 48000
N = 1 #Insert interval length here in seconds
tick()
Len = length(array)
intervalNumber = convert(Int64,Len/(N*fs))
arrMax = zeros(intervalNumber)
arrMin = zeros(intervalNumber)
sumMax = 0
sumMin = 0
for k in 1:intervalNumber
    Offset = convert(Int64, (k-1)*fs)
    global arrMax[k] = array[Offset + 1]
    global arrMin[k] = array[Offset + 1]
    for i in 1:convert(Int64, N*fs)
        if array[Offset + i] > arrMax[k]
            global arrMax[k] = array[Offset + i]
        elseif array[Offset + i] < arrMin[k]
            global arrMin[k] = array[Offset + i]
        end
    end
    global sumMax = sumMax + arrMax[k]
    global sumMin = sumMin + arrMin[k]
end

avgMax = sumMax/intervalNumber
avgMin = sumMin/intervalNumber

sumMaxTerms = 0
sumMinTerms = 0
for k in 1:intervalNumber
    global sumMaxTerms = sumMaxTerms + (arrMax[k] - avgMax)^2
    global sumMinTerms = sumMinTerms + (arrMin[k] - avgMin)^2
end

STDDevMax = sqrt(sumMaxTerms/intervalNumber)
STDDevMin = sqrt(sumMinTerms/intervalNumber)

for k in 1:intervalNumber
    if (arrMax[k]<(avgMax - STDDevMax))||(arrMax[k]>(avgMax + STDDevMax))
        global arrMax[k] = 0
    end
    if (arrMin[k]<(avgMin - STDDevMin))||(arrMin[k]>(avgMin + STDDevMin))
        global arrMin[k] = 0
    end
end

t = tock()

println("Minimum Average: ",avgMax)
println("Standard Deviation for Maximum: ",STDDevMax)
println("Minimum Average: ", avgMin)
println("Standard Deviation for Minimum:",STDDevMin)
println("Filtered Max element array: ",arrMax)
println("Filtered Min element array: ",arrMin)

