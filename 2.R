square_funtction<-function(n)
{
  n^2
}
square_funtction(4)
x <- c(5, 7, 4, 8, 12, 16, 15)

barplot(
  x,
  main = "Number of Customers Visited in the Stores",
  xlab = "Days",
  ylab = "Number of Customers",
  names.arg = c("M", "T", "W", "Th", "F", "Sat", "Sun"),
  col = rainbow(length(x)),
  density = seq(10, 70, 10)
)


x<-c(10,20,30,40,50,60,70)

barplot(x,main = "No of coustomers visited in the stores")


districts<-c("Colombo","Kandy","Jaffna","Anuradhapura","Batticallo")
