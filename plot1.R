household_power_consumption <- read.csv("C:/Users/ruben/Desktop/household_power_consumption.txt", sep=";")
consumo_energia_domestico<-household_power_consumption

## Criar Formato de data

consumo_energia_domestico$Date <- as.Date(consumo_energia_domestico$Date, "%d/%m/%Y")

## Nosso objetivo geral aqui é simplesmente examinar como o uso de energia das famílias varia ao longo de um período de dois dias em fevereiro de 2007

consumo_energia_domestico <- subset(consumo_energia_domestico,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remover observação incompleta

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

## Criar o Plot 1

Global_active_power_numerico<-as.numeric(consumo_energia_domestico$Global_active_power)
hist(Global_active_power_numerico, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")