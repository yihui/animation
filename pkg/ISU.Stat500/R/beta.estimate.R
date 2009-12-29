beta.estimate <-
function(x,y){
	msd=tapply(x,y,function(xx)c(mean=mean(xx),sd=sd(xx)))
	beta.est=do.call('/',as.list(rev(apply(sapply(msd,log),1,function(xx)xx[2]-xx[1]))))
	list(beta=beta.est, group=levels(y))}

