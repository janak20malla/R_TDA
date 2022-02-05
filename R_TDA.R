# install.packages("rameritrade")
# 
# # Install development version - fixes for cronR and price history
# install.packages("devtools")
# devtools::install_github("exploringfinance/rameritrade")

#hiding the key using a different script file
source('~/Desktop/R_TDA/Key.R')


#Step 1:
# callbackURL = 'callbackURL'
# consumerKey = consumerKey
# rameritrade::td_auth_loginURL(consumerKey, callbackURL)
# 
# #Step 2:
# authCode = 'authCode'
# refreshToken = rameritrade::td_auth_refreshToken(consumerKey, callbackURL, authCode)
# saveRDS(refreshToken,'~/Desktop/R_TDA/refreshToken')
# 
# #Step 3: 
# refeshToken = readRDS('~/Desktop/R_TDA/refreshToken')
# accessToken = rameritrade::td_auth_refreshToken(consumerKey, codeToken = refreshToken)
# 
# saveRDS(refreshToken,'~/Desktop/R_TDA/refreshToken')
# 

#Get acount information
library(rameritrade)
refreshToken = readRDS('~/Desktop/R_TDA/refreshToken')
consumerKey = 'consumerKey'
accessToken = rameritrade::td_auth_accessToken(consumerKey, refreshToken)

#Account information
# actDF = td_accountData(output = 'df')
# View(actDF)

# actList = td_accountData('list')
# str(actList)

#Get Quote prices

SP500Qt = rameritrade::td_priceQuote(c('SPY', 'IVV', 'VOO', 'AMZN', 'TSLA'))
str(SP500Qt)
View(SP500Qt)

#Get Quote Prices for Options
SPY441 = rameritrade::td_priceQuote('SPY_020422P441')
str(SPY441)
View(SPY441)


#Get Historical prices
SP500H = rameritrade::td_priceHistory(c(c('SPY','IVV','VOO', 'AMZN', 'TSLA')))
View(SP500H)

#Time Series data
rameritrade::td_priceHistory('AAPL', startDate = '2022-01-27', freq='5min')


#Placing Trades
accountnumber = '' #Provide account number inside quotation.

# Market Order for STOCKS
# Ord0 = rameritrade::td_placeOrder(accountNumber,
#                                   ticker = 'PSLV',
#                                   quantity = 1,
#                                   instruction = 'BUY')
# rameritrade::td_cancelOrder(Ord0$orderId, accountNumber)
# [1] "Order Cancelled"

# Order for Options
Ord3 = rameritrade::td_placeOrder(accountNumber = accountNumber,
                                  ticker = 'SLV_091820P24.5',
                                  quantity = 1,
                                  instruction = 'BUY_TO_OPEN',
                                  duration = 'Day',
                                  orderType = 'LIMIT',
                                  limitPrice = .02,
                                  assetType = 'OPTION')
rameritrade::td_cancelOrder(Ord3$orderId, accountNumber)



# View Options Chains
SPY = td_optionChain('SPY',
                     strikes = 12,
                     endDate = Sys.Date() + 180)
View(data.frame(SPY$fullChain))
str(SPY$underlying)
