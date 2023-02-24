import Foundation

// Define the exchange rate for each currency
var USD_TO_COP = 0.0 // Colombian pesos
var USD_TO_EUR = 0.0 // Euros
var USD_TO_KRW = 0.0 // Korean Won
var USD_TO_JPY = 0.0 // Japanese yen

func fetchExchangeRates() {
    // Replace YOUR_APP_ID with your Open Exchange Rates API key
    let urlString = "https://openexchangerates.org/api/latest.json?app_id=YOUR_APP_ID"
    guard let url = URL(string: urlString) else {
        print("Invalid URL.")
        return
    }
    let request = URLRequest(url: url)
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error fetching exchange rates: \(error.localizedDescription)")
            return
        }
        guard let data = data else {
            print("No data returned.")
            return
        }
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            if let rates = json?["rates"] as? [String: Double] {
                USD_TO_COP = rates["COP"] ?? 0.0
                USD_TO_EUR = rates["EUR"] ?? 0.0
                USD_TO_KRW = rates["KRW"] ?? 0.0
                USD_TO_JPY = rates["JPY"] ?? 0.0
            }
        } catch {
            print("Error parsing JSON: \(error.localizedDescription)")
        }
    }
    task.resume()
}

// Fetch the exchange rates when the program starts
fetchExchangeRates()

var shouldContinue = true

while shouldContinue {
    // Ask the user for the currency selection
    print("Enter the number of the currency to exchange.")
    print("1. Colombian pesos (COP)")
    print("2. Euros (EUR)")
    print("3. Korean Won (KRW)")
    print("4. Japanese yen (JPY)")
    print("What currency would you like to exchange?")
    let choice = readLine()

    // Ask the user for the amount to exchange
    print("Enter an amount in US dollars:")
    let input = readLine()

    // Convert the input to a Double
    guard let dollars = Double(input ?? "") else {
        print("Invalid input.")
        continue
    }

    // Perform the selected conversion
    var result: Double
    var currencySymbol: String
    switch choice {
    case "1":
        result = dollars * USD_TO_COP
        currencySymbol = "COP"
    case "2":
        result = dollars * USD_TO_EUR
        currencySymbol = "EUR"
    case "3":
        result = dollars * USD_TO_KRW
        currencySymbol = "KRW"
    case "4":
        result = dollars * USD_TO_JPY
        currencySymbol = "JPY"
    default:
        print("Invalid choice.")
        continue
    }

    // Print the results
    print(String(format: "$%.2f is equivalent to %.2f %@", dollars, result, currencySymbol))

    // Ask the user if they want to continue
    print("Do you want to exchange another currency? (y/n)")
    let answer = readLine()
    if answer?.lowercased() != "y" {
        shouldContinue = false
    }
}
// you'll need to replace "YOUR_APP_ID" with your actual Open Exchange Rates API key.