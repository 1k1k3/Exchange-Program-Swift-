import Foundation

// Define the exchange rate for each currency
let USD_TO_EUR = 0.83
let USD_TO_GBP = 0.72
let USD_TO_JPY = 105.44

// Ask the user for input
print("Enter an amount in US dollars:")
let input = readLine()

// Convert the input to a Double
guard let dollars = Double(input ?? "") else {
    print("Invalid input.")
    exit(1)
}

// Perform the conversions
let euros = dollars * USD_TO_EUR
let pounds = dollars * USD_TO_GBP
let yen = dollars * USD_TO_JPY

// Print the results
print(String(format: "$%.2f is equivalent to €%.2f, £%.2f, and ¥%.2f", dollars, euros, pounds, yen))
