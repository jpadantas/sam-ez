wez_builder_kfold <- function(kfold, deg, max_interact, hold_out=0.2)
{
    ### aleatorizar
    set.seed(100)
    rnd = sample(nrow(x))
    xr = x[rnd,]
    yr = y[rnd]
    
    # obter valores minimos e maximos das variaveis
    # sempre incluir os limites minimos e maximos das variaveis nos treinamentos
    # isso e importante para evitar que o modelo faca extrapolacoes
    ilim = numeric()
    for (i in 1:ncol(xr))
    {
        id_aux = which(xr[,i] == min(xr[,i]))
        if (length(id_aux) > 1)
            ilim = c(ilim, id_aux[1])
        else
            ilim = c(ilim, id_aux)
        
        id_aux = which(xr[,i] == max(xr[,i]))
        if (length(id_aux) > 1)
            ilim = c(ilim, id_aux[1])
        else
            ilim = c(ilim, id_aux)      
    }
    ilim = unique(ilim)

    xlim = xr[ilim,]
    xmin = apply(xlim, 2, min)
    xmax = apply(xlim, 2, max)
    ylim = yr[ilim]
    
    xutil = xr[-ilim,]
    yutil = yr[-ilim]   
    
    # reservar conjunto de teste (hold out)
    itst = floor(nrow(xutil) * hold_out)
    xtst = xutil[1:itst,]
    ytst = yutil[1:itst]    
    
    # definir conjunto de treinamento
    itrn = itst + 1
    xutil = xutil[itrn:nrow(xutil),]
    yutil = yutil[itrn:length(yutil)]
    
    ###
    # models building
    len = floor(nrow(xutil)/kfold)
    
    # outputs (r2, rmse, mpe, time)
    out = matrix(rep(0, kfold*4), ncol=4)
    colnames(out) = c("R2", "RMSE", "MPE", "TIME")
    
    for (i in 1:kfold)
    {
        ini = (i-1)*len + 1
        end = ini + len - 1
        
        itest = seq(ini,end)
        
        xtrain = rbind(xutil[-itest,], xlim)
        ytrain =     c(yutil[-itest] , ylim)
        
        data_train = data.frame(cbind(xtrain, ytrain))
        colnames(data_train) = c(colnames(x), "y")
        
        t0 <- proc.time()
        model = polyFit(xy=data_train, deg=deg, maxInteractDeg=max_interact, use="lm", noisy=F)
        time = proc.time() - t0
        
        ###
        # test samples
        xtest = xutil[itest,]
        ytest = yutil[itest]
        
        ### 
        # prediction and error
        data_test = data.frame(xtest)
        colnames(data_test) = colnames(x)[1:ncol(x)]
        
        defaultW <- getOption("warn")
        options(warn = -1)
            ypred = as.numeric(predict(model, newdata=data_test))
        options(warn = defaultW)
        
        err = (ytest - ypred)
        r2 = 1.0 - sum(sum(err^2))/sum((ypred - mean(ytest))^2)
        rmse = sqrt(mean(err^2))
        mpe = mean(abs(err / ytest))
        
        out[i,] = c(r2, rmse, mpe, time[3])
    }
    
    means = c(mean(out[,1]), mean(out[,2]), mean(out[,3]), mean(out[,4]))
    sds = c(sd(out[,1]), sd(out[,2]), sd(out[,3]), sd(out[,4]))
    
    out = rbind(out, means, sds)
    
    ###
    # resultados do kfold
    print(out)
    
    ###
    # construcao do modelo "final"
    xtrain = rbind(xutil, xlim)
    ytrain =     c(yutil, ylim)

    data_train = data.frame(cbind(xtrain, ytrain))
    colnames(data_train) = c(colnames(x), "y")
    
    t0 <- proc.time()
    model = polyFit(xy=data_train, deg=deg, maxInteractDeg=max_interact, use="lm", noisy=F)
    time = proc.time() - t0
    
    ### 
    # prediction and error (hold out)
    data_test = data.frame(xtst) 
    colnames(data_test) = colnames(x)[1:ncol(x)]
    
    defaultW <- getOption("warn")
    options(warn = -1)
        ypred = as.numeric(predict(model, newdata=data_test))
    options(warn = defaultW)
    
    err = (ytst - ypred)
    r2 = 1.0 - sum(sum(err^2))/sum((ypred - mean(ytest))^2)
    rmse = sqrt(mean(err^2))
    mpe = mean(abs(err / ytst))
    print("----------")
    print(paste("Model R2: ", r2, sep=""))
    print(paste("Model RMSE: ", rmse, sep=""))
    print(paste("Model MPE: ", mpe, sep=""))
    print(paste("Model Time: ", time[3], sep=""))

    ###
    # plot
    iord = order(ytst)
    plot  (ytst[iord], ytst [iord], type="l", ylim=c(-10,max(y)), main="Real x Predited range", xlab="Real range (nm)", ylab="Predicted range (nm)")
    points(ytst[iord], ypred[iord], pch=20, col="blue") 
}
