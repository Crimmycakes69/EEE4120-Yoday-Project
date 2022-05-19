using WAV, TickTock, Plots
N = 1 #Insert interval length here in seconds

#Read audio file into array
array, fs = wavread("GuassianNoise5s.wav", format = "float")

#h = Plots.histogram(array, xlabel = "number generated", ylabel = "frequency", title = "random number distribution")
#Plots.display(h)
#readline()
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

println(avgMax)
println(STDDevMax)
println(avgMin)
println(STDDevMin)
println(arrMax)
println(arrMin)

