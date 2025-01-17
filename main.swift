import Foundation

// Prices and Initial Stock
var stock = ["Cereal": 100, "Milk": 100, "Syrup": 100, "Cups": 100]
let prices = ["Cereal": 4.99, "Milk": 4.99, "Syrup": 3.99, "Cups": 2.99]
var cart = ["Cereal": 0, "Milk": 0, "Syrup": 0, "Cups": 0]
var cartTotal: Double = 0.0
let adminID = "0000"

// Function: Display Main Menu
func displayMenu() {
    print("""
    Main Menu:
    1. Add item to cart
    2. Remove item from cart
    3. Check if an item is in stock
    4. Admin Menu
    5. Checkout
    6. Empty Cart
    7. Exit
    """)
}

// Function: Add Item to Cart
func addItemToCart() {
    print("Available items: \(stock.keys.joined(separator: ", "))")
    print("Enter the item you want to add: ", terminator: "")
    if let item = readLine(), stock.keys.contains(item) {
        print("Enter quantity to add: ", terminator: "")
        if let quantityStr = readLine(), let quantity = Int(quantityStr), quantity > 0 {
            if quantity <= stock[item]! {
                cart[item]! += quantity
                stock[item]! -= quantity
                cartTotal += Double(quantity) * prices[item]!
                print("\(quantity) \(item)(s) added to your cart. Current total: $\(String(format: "%.2f", cartTotal))")
            } else {
                print("Insufficient stock. Only \(stock[item]!) \(item)(s) available.")
            }
        } else {
            print("Invalid quantity. Please try again.")
        }
    } else {
        print("Invalid item. Please try again.")
    }
}

// Function: Remove Item from Cart
func removeItemFromCart() {
    print("Your cart contains: \(cart.filter { $0.value > 0 })")
    print("Enter the item you want to remove: ", terminator: "")
    if let item = readLine(), cart.keys.contains(item), cart[item]! > 0 {
        print("Enter quantity to remove: ", terminator: "")
        if let quantityStr = readLine(), let quantity = Int(quantityStr), quantity > 0 {
            if quantity <= cart[item]! {
                cart[item]! -= quantity
                stock[item]! += quantity
                cartTotal -= Double(quantity) * prices[item]!
                print("\(quantity) \(item)(s) removed. Current total: $\(String(format: "%.2f", cartTotal))")
            } else {
                print("You cannot remove more than \(cart[item]!) \(item)(s) from the cart.")
            }
        } else {
            print("Invalid quantity. Please try again.")
        }
    } else {
        print("Item not found in the cart or invalid input. Please try again.")
    }
}

// Function: Check Stock
func checkStock() {
    print("Current stock levels:")
    for (item, quantity) in stock {
        print("\(item): \(quantity)")
    }
}

// Function: Empty Cart
func emptyCart() {
    cart = ["Cereal": 0, "Milk": 0, "Syrup": 0, "Cups": 0]
    cartTotal = 0.0
    print("Your cart has been emptied. Total: $\(String(format: "%.2f", cartTotal))")
}

// Function: Checkout
func checkout() {
    print("Checkout Summary:")
    for (item, quantity) in cart where quantity > 0 {
        print("\(item): \(quantity) @ $\(prices[item]!) each")
    }
    let tax = cartTotal * 0.0925
    let totalWithTax = cartTotal + tax
    print("Subtotal: $\(String(format: "%.2f", cartTotal))")
    print("Tax (9.25%): $\(String(format: "%.2f", tax))")
    print("Total: $\(String(format: "%.2f", totalWithTax))")
    cart = ["Cereal": 0, "Milk": 0, "Syrup": 0, "Cups": 0]
    cartTotal = 0.0
    print("Thank you for shopping!")
}

// Function: Admin Menu
func adminMenu() {
    print("Enter Admin ID: ", terminator: "")
    if let id = readLine(), id == adminID {
        print("""
        Admin Menu:
        1. Restock Inventory
        2. Generate Reports
        3. Check Stock Levels
        4. Exit to Main Menu
        """)
        if let choice = readLine() {
            switch choice {
            case "1":
                print("Enter item to restock: ", terminator: "")
                if let item = readLine(), stock.keys.contains(item) {
                    print("Enter quantity to add: ", terminator: "")
                    if let quantityStr = readLine(), let quantity = Int(quantityStr), quantity > 0 {
                        stock[item]! += quantity
                        print("\(quantity) \(item)(s) added to stock.")
                    } else {
                        print("Invalid quantity.")
                    }
                } else {
                    print("Invalid item.")
                }
            case "2":
                print("Reports: \(stock)")
            case "3":
                checkStock()
            case "4":
                return
            default:
                print("Invalid choice. Returning to main menu.")
            }
        }
    } else {
        print("Invalid Admin ID.")
    }
}

// Main Program Loop
while true {
    displayMenu()
    print("Enter your choice: ", terminator: "")
    if let choice = readLine() {
        switch choice {
        case "1": addItemToCart()
        case "2": removeItemFromCart()
        case "3": checkStock()
        case "4": adminMenu()
        case "5": checkout()
        case "6": emptyCart()
        case "7": 
            print("Goodbye!")
            break
        default: print("Invalid choice. Please try again.")
        }
    }
}
