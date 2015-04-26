library(shiny)
library(randomForest)
wine<-read.table("winequality-red.csv",sep=";",header=T)
set.seed(12345)
fit.rf<-randomForest(quality~.,data=wine)

cols<-c("#666666","#666666","#006600","#99FF99","#FFCC00","#FF6600","#FF0000","#0033FF")
p<-"#000000"


shinyServer(
	function (input, output) {
	output$colLegend<-renderPlot({
	  par(mar=c(3.1,3.1, 2.1, 2.1))
		image(3:8, 1, as.matrix(3:8), col = cols[3:8],ylab="",main="Wine quality from 3 (poor) to 8 (excellent)",yaxt="n",bty="n",xlab="",xlim=c(3,8))
    },height = 80)
	output$plot1<-renderPlot({
	  par(mar=c(5.1, 4.1, 0, 0))
		plot(wine$fixed.acidity, wine$volatile.acidity,col=cols[wine$quality],pch=20,
			xlab=expression(paste("Fixed Acidity (tartaric acid) - g/",dm^3,sep="")),
			ylab=expression(paste("Volatile  Acidity (acetic acid) - g/",dm^3,sep="")))
		abline(v=input$crit1, h=input$crit2,col=p)
		points(input$crit1,input$crit2,pch=20,cex=3,col=p)
		},height = 300)
	output$plot2<-renderPlot({
	  par(mar=c(5.1, 4.1, 0, 0))
	  plot(wine$citric.acid,wine$pH,col=cols[wine$quality],pch=20,
	       ylab="pH",
	       xlab=expression(paste("Citric Acid (freshness & flavor) - g/",dm^3,sep="")))
	  abline(v=input$crit3, h=input$crit4,col=p)
	  points(input$crit3,input$crit4,pch=20,cex=3,col=p)
	},height = 300)
	output$plot3<-renderPlot({
	  par(mar=c(4.1, 4.1, 0, 0))
	  plot(wine$pH, wine$sulphates,col=cols[wine$quality],pch=20,
	       xlab="pH",
	       ylab=expression(paste("Sulphates (additive) - g/",dm^3,sep="")))
	  abline(v=input$crit4, h=input$crit5,col=p)
	  points(input$crit4,input$crit5,pch=20,cex=3,col=p)
	},height = 300)
	output$plot4<-renderPlot({
	  par(mar=c(4.1, 4.1, 0, 0))
		plot(wine$residual.sugar, wine$chlorides,col=cols[wine$quality],pch=20,
			xlab=expression(paste("Residual Sugar (sweetness) - g/",dm^3,sep="")),
			ylab=expression(paste("Sodium Chloride (salt) - g/",dm^3,sep="")))
		abline(v=input$crit6, h=input$crit7,col=p)
		points(input$crit6,input$crit7,pch=20,cex=3,col=p)
		},height = 300)
	output$plot5<-renderPlot({
	  par(mar=c(5.1, 4.1, 0, 0))
		plot(wine$free.sulfur.dioxide, wine$total.sulfur.dioxide,col=cols[wine$quality],pch=20,
			xlab=expression(paste("Free Sulfur Dioxide SO2 (against oxydation & microbs) - mg/",dm^3,sep="")),
			ylab=expression(paste("Total Sufur Dioxide SO2 - mg/",dm^3,sep="")))
		abline(v=input$crit8, h=input$crit9,col=p)
		points(input$crit8,input$crit9,pch=20,cex=3,col=p)
		},height = 300)
	output$plot6<-renderPlot({
	  par(mar=c(5.1, 4.1, 0, 0))
		plot(wine$density , wine$alcohol ,col=cols[wine$quality],pch=20,
			xlab=expression(paste("Density - g/",cm^3,sep="")),
			ylab="Alcohol - % by volume")
		abline(v=input$crit10, h=input$crit11,col=p)
		points(input$crit10,input$crit11,pch=20,cex=3,col=p)
		},height = 300)
	
	
	##output$estquality<-renderText({
	  ##input$estimate
	  ##if (input$estimate == 0)
	  ##  return()
	  ##myselection<-isolate(c(input$crit1,input$crit2,input$crit3,input$crit4,input$crit5,input$crit6,input$crit7,input$crit8,input$crit9,input$crit10,input$crit11,0))
	  ##e<-rbind(wine,myselection)
    ##predict(fit.rf,newdata=e[nrow(e),1:11])
	  ##})
	estq<-reactive({
	  input$estimate
    myselection<-isolate(c(input$crit1,input$crit2,input$crit3,input$crit4,input$crit5,input$crit6,input$crit7,input$crit8,input$crit9,input$crit10,input$crit11,0))
	  e<-rbind(wine,myselection)
	  predict(fit.rf,newdata=e[nrow(e),1:11])
	})
  ##output$pred<-renderText({estq()})
	output$estquality<-renderPlot({
    input$estimate
    ##myselection<-isolate(c(input$crit1,input$crit2,input$crit3,input$crit4,input$crit5,input$crit6,input$crit7,input$crit8,input$crit9,input$crit10,input$crit11,0))
    ##e<-rbind(wine,myselection)
    image(3:8, 1, as.matrix(3:8), col = cols[3:8],ylab="",main=round(estq(),2),yaxt="n",bty="n",xlab="",xlim=c(3,8))
    abline(v=estq(),lwd=5)
	},height=160)
    ##image(3:8, 1, as.matrix(3:8), col = "black")
	  ##hist(rnorm(10))
	  ##input$estimate
	      
	  #
	  ##abline(v=estq,col="black",lwd=5)
	
	}
)