
import Foundation

var balanceUSD: Double = 1000.0
var buyPrice: Double = 0.0
var coinBTC: Double = 0.0
let iterationsCount: Int = 10

for i in 0..<iterationsCount {
    let randomPrice: Double = 800 + Double.random(in: -200...200)
    
    if coinBTC > 0 {
        if randomPrice >= buyPrice * 1.2 {
            let incomeUSD = coinBTC * randomPrice
            balanceUSD += incomeUSD
            coinBTC = 0.0
            print("Итерация \(i+1): ПРОДАЖА FORM = \(String(format: "%.2f", buyPrice)) -> TO = \(String(format: "%.2f", randomPrice)), INCOME = \(String(format: "%.2f", incomeUSD)) USD")
        } else {
            print("Итерация \(i+1): Держим. Цена = \(String(format: "%.2f", randomPrice)), цель =~ \(String(format: "%.2f", buyPrice * 1.2))")
        }
    } else {
        if randomPrice < 800 {
            let incomeBTC = balanceUSD / randomPrice
            coinBTC = incomeBTC
            buyPrice = randomPrice
            balanceUSD = 0.0
            print("Итерация \(i+1): ПОКУПКА FORM = \(String(format: "%.2f", buyPrice)) -> TO = \(String(format: "%.2f", randomPrice)), INCOME = \(String(format: "%.2f", incomeBTC)) BTC")
        } else {
            print("Итерация \(i+1): Ждём. Цена = \(String(format: "%.2f", randomPrice)), вход<800")
        }
    }
}

print("Финальный баланс BTC: \(String(format: "%.2f", coinBTC))")
print("Финальный баланс USD: \(String(format: "%.2f", balanceUSD))")
