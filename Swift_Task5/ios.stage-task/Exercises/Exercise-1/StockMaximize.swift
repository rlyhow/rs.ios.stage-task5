import Foundation

class StockMaximize {
    
    func countProfit(prices: [Int]) -> Int {
        var sumOfBought = 0
        var countOfStocks = 0
        var finalProfit = 0
        
        for i in prices.indices {
            if i == prices.count-1 {
                finalProfit += prices[i] * countOfStocks - sumOfBought
                break
            }
            if prices[i] <= prices[i+1] {
                sumOfBought += prices[i]
                countOfStocks+=1
            } else {
                finalProfit += prices[i] * countOfStocks - sumOfBought
                countOfStocks = 0
                sumOfBought = 0
            }
        }
        return finalProfit
    }
}
