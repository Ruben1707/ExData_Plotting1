household_power_consumption <- read.csv("C:/Users/ruben/Desktop/household_power_consumption.txt", sep=";")
consumo_energia_domestico<-household_power_consumption

## Criar Formato de data

consumo_energia_domestico$Date <- as.Date(consumo_energia_domestico$Date, "%d/%m/%Y")

## Nosso objetivo geral aqui � simplesmente examinar como o uso de energia das fam�lias varia ao longo de um per�odo de dois dias em fevereiro de 2007

consumo_energia_domestico <- subset(consumo_energia_domestico,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remover observa��o incompleta

consumo_energia_domestico <- consumo_energia_domestico[complete.cases(consumo_energia_domestico),]

## Combinar Colunas Date e Time 

dateTime <- paste(consumo_energia_domestico$Date, consumo_energia_domestico$Time)

## Nomeia o vetor

dateTime <- setNames(dateTime, "DateTime")

## Remover Colunas Date e Time

consumo_energia_domestico <- consumo_energia_domestico[ ,!(names(consumo_energia_domestico) %in% c("Date","Time"))]

## Adicionar coluna DateTime

consumo_energia_domestico <- cbind(dateTime, consumo_energia_domestico)

## Formatar coluna dateTime

consumo_energia_domestico$dateTime <- as.POSIXct(dateTime)

## Criar Grafico 4

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(consumo_energia_domestico, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

