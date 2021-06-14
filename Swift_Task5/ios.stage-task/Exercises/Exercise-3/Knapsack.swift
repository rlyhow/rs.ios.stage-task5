import Foundation

public typealias Supply = (weight: Int, value: Int)

public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        findMaxKilometres()
    }
    
    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }
    
    func findMaxKilometres() -> Int {
        
        let countOfFood = foods.count
        let countOfDrink = drinks.count
        
        let food = knapSack(W: maxWeight, wt: foods, val: foods, n: countOfFood)
        let drink = knapSack(W: maxWeight, wt: drinks, val: drinks, n: countOfDrink)
        
        var maxKilometres = [Int]()
        for i in 0...maxWeight {
            maxKilometres.append(min(food[countOfFood][i], drink[countOfDrink][maxWeight-i]))
        }
        
        return maxKilometres.max() ?? 0
    }
    
    func knapSack(W :Int, wt: [Supply], val: [Supply], n: Int) -> [[Int]] {
        
        var K = Array(repeating: Array(repeating: 0, count: W + 1), count: n + 1)
        
        for i in 0...n {
            for w in 0...W  {
                if i == 0 || w == 0 {
                    K[i][w] = 0
                } else if wt[i-1].weight <= w {
                    K[i][w] = max(val[i-1].value + K[i-1][w - wt[i-1].weight],  K[i-1][w]);
                } else {
                    K[i][w] = K[i-1][w]
                }
            }
        }
        return K;
    }
}
