// Inventory Management System
import Foundation

// Initial inventory and prices for items
var cerealStock = 100
var milkStock = 100
var syrupStock = 100
var cupStock = 100

let cerealPrice: Double = 4.99
let milkPrice: Double = 4.99
let syrupPrice: Double = 3.99
let cupPrice: Double = 2.99

var cart: [String: Int] = [:] // A dictionary to store cart items and their quantities
var totalPrice: Double = 0.0

// Admin credentials (hardcoded)
let adminID = "0000"

// Function to display the main menu
func displayMainMenu() {
    print("""
    Welcome to the grocery store! Let us know how we can help you (Enter number of selection): 
    1. Add item to cart
    2. Remove item from cart
    3. Check if item is in stock
    4. Admin Menu
    5. Checkout
    """)
}

// Function to display the admin menu
func displayAdminMenu() {
    print("""
    Welcome to the Admin menu! Let us know how we can help you (Enter number of selection): 
    1. Restock inventory
    2. Generate report
    3. Check number of items
    4. Quit admin menu
    """)
}

// Function to check availability of an item
func checkAvailability(item: String) {
    switch item {
    case "Cereal":
        print("There are currently \(cerealStock) cereals in stock!")
    case "Milk":
        print("There are currently \(milkStock) milks in stock!")
    case "Syrup":
        print("There are currently \(syrupStock) syrups in stock!")
    case "Cups":
        print("There are currently \(cupStock) cups in stock!")
    default:
        print("Invalid item.")
    }
}

// Function to add an item to the cart
func addItemToCart(item: String, quantity: Int) {
    var availableStock = 0
    var pricePerItem = 0.0
    
    // Determine the stock and price of the item
    switch item {
    case "Cereal":
        availableStock = cerealStock
        pricePerItem = cerealPrice
    case "Milk":
        availableStock = milkStock
        pricePerItem = milkPrice
    case "Syrup":
        availableStock = syrupStock
        pricePerItem = syrupPrice
    case "Cups":
        availableStock = cupStock
        pricePerItem = cupPrice
    default:
        print("Invalid item.")
        return
    }
    
    // Check if the quantity is available
    if quantity > availableStock {
        print("Sorry, only \(availableStock) items are available in stock.")
    } else {
        // Add to cart
        if cart[item] == nil {
            cart[item] = 0
        }
        cart[item]! += quantity
        totalPrice += pricePerItem * Double(quantity)
        
        // Update stock
        switch item {
        case "Cereal":
            cerealStock -= quantity
        case "Milk":
            milkStock -= quantity
        case "Syrup":
            syrupStock -= quantity
        case "Cups":
            cupStock -= quantity
        default:
            break
        }
        
        print("You have added \(quantity) \(item)(s) to your cart!")
        print("Current total is: $\(totalPrice)")
    }
}

// Function to remove an item from the cart
func removeItemFromCart(item: String, quantity: Int) {
    if let currentQuantity = cart[item], currentQuantity >= quantity {
        cart[item]! -= quantity
        totalPrice -= Double(quantity) * getItemPrice(item: item)
        print("Removed \(quantity) \(item)(s) from your cart!")
        print("Current total is: $\(totalPrice)")
    } else {
        print("You don't have that many \(item) in your cart!")
    }
}

// Function to get the price of an item
func getItemPrice(item: String) -> Double {
    switch item {
    case "Cereal":
        return cerealPrice
    case "Milk":
        return milkPrice
    case "Syrup":
        return syrupPrice
    case "Cups":
        return cupPrice
    default:
        return 0.0
    }
}

// Function to checkout
func checkout() {
    print("Thanks for shopping with us!")
    print("You purchased the following:")
    for (item, quantity) in cart {
        print("\(item): \(quantity)")
    }
    let tax = totalPrice * 0.0925
    let grandTotal = totalPrice + tax
    print("Your grand total including tax (9.25%) is: $\(grandTotal)")
}

// Function to restock inventory (Admin only)
func restockInventory() {
    print("What would you like to restock? (Enter number of selection): ")
    print("1. Cereal")
    print("2. Milk")
    print("3. Syrup")
    print("4. Cups")
    
    if let restockChoice = readLine(), let choice = Int(restockChoice), choice >= 1 && choice <= 4 {
        print("How many units would you like to restock?: ")
        if let restockQuantity = readLine(), let quantity = Int(restockQuantity), quantity > 0 {
            switch choice {
            case 1:
                cerealStock += quantity
                print("Restocked \(quantity) units of cereal")
            case 2:
                milkStock += quantity
                print("Restocked \(quantity) units of milk")
            case 3:
                syrupStock += quantity
                print("Restocked \(quantity) units of syrup")
            case 4:
                cupStock += quantity
                print("Restocked \(quantity) units of cups")
            default:
                print("Invalid choice.")
            }
        } else {
            print("Invalid quantity.")
        }
    } else {
        print("Invalid choice.")
    }
}

// Function to generate admin report
func generateReport() {
    print("Summary Report:")
    print("Remaining cereals: \(cerealStock) items")
    print("Remaining milks: \(milkStock) items")
    print("Remaining syrups: \(syrupStock) items")
    print("Remaining cups: \(cupStock) items")
    let remainingInventory = cerealStock + milkStock + syrupStock + cupStock
    print("Remaining Inventory: \(remainingInventory) items")
    print("Total Sales: $\(totalPrice)")
}

// Function to check the number of items in stock
func checkItems() {
    print("What item would you like to check if it's in stock? (Enter number of selection): ")
    print("1. Cereal")
    print("2. Milk")
    print("3. Syrup")
    print("4. Cups")
    
    if let itemChoice = readLine(), let choice = Int(itemChoice), choice >= 1 && choice <= 4 {
        switch choice {
        case 1:
            print("There are currently \(cerealStock) cereals in stock!")
        case 2:
            print("There are currently \(milkStock) milks in stock!")
        case 3:
            print("There are currently \(syrupStock) syrups in stock!")
        case 4:
            print("There are currently \(cupStock) cups in stock!")
        default:
            print("Invalid choice.")
        }
    } else {
        print("Invalid choice.")
    }
}

// Main logic for the program
while true {
    displayMainMenu()
    if let choice = readLine(), let option = Int(choice) {
        switch option {
        case 1:
            print("What would you like to add to cart? (Enter number of selection)")
            print("1. Cereal")
            print("2. Milk")
            print("3. Syrup")
            print("4. Cups")
            if let itemChoice = readLine(), let item = Int(itemChoice), item >= 1 && item <= 4 {
                print("How many \(itemChoice)s would you like to add to your cart?: ")
                if let quantityStr = readLine(), let quantity = Int(quantityStr), quantity > 0 {
                    switch item {
                    case 1:
                        addItemToCart(item: "Cereal", quantity: quantity)
                    case 2:
                        addItemToCart(item: "Milk", quantity: quantity)
                    case 3:
                        addItemToCart(item: "Syrup", quantity: quantity)
                    case 4:
                        addItemToCart(item: "Cups", quantity: quantity)
                    default:
                        print("Invalid item.")
                    }
                } else {
                    print("Invalid quantity.")
                }
            } else {
                print("Invalid item selection.")
            }
        case 2:
            print("What would you like to remove from cart? (Enter number of selection): ")
            print("1. Cereal")
            print("2. Milk")
            print("3. Syrup")
            print("4. Cups")
            if let itemChoice = readLine(), let item = Int(itemChoice), item >= 1 && item <= 4 {
                print("How many \(itemChoice)s would you like to remove from your cart?: ")
                if let quantityStr = readLine(), let quantity = Int(quantityStr), quantity > 0 {
                    switch item {
                    case 1:
                        removeItemFromCart(item: "Cereal", quantity: quantity)
                    case 2:
                        removeItemFromCart(item: "Milk", quantity: quantity)
                    case 3:
                        removeItemFromCart(item: "Syrup", quantity: quantity)
                    case 4:
                        removeItemFromCart(item: "Cups", quantity: quantity)
                    default:
                        print("Invalid item.")
                    }
                } else {
                    print("Invalid quantity.")
                }
            } else {
                print("Invalid item selection.")
            }
        case 3:
            print("What item would you like to check if it's in stock? (Enter number of selection): ")
            print("1. Cereal")
            print("2. Milk")
            print("3. Syrup")
            print("4. Cups")
            if let itemChoice = readLine(), let item = Int(itemChoice), item >= 1 && item <= 4 {
                switch item {
                case 1:
                    checkAvailability(item: "Cereal")
                case 2:
                    checkAvailability(item: "Milk")
                case 3:
                    checkAvailability(item: "Syrup")
                case 4:
                    checkAvailability(item: "Cups")
                default:
                    print("Invalid item.")
                }
            } else {
                print("Invalid item selection.")
            }
        case 4:
            print("Enter Admin ID: ")
            if let enteredID = readLine(), enteredID == adminID {
                while true {
                    displayAdminMenu()
                    if let adminChoice = readLine(), let choice = Int(adminChoice) {
                        switch choice {
                        case 1:
                            restockInventory()
                        case 2:
                            generateReport()
                        case 3:
                            checkItems()
                        case 4:
                            print("Returning to normal menu")
                            break
                        default:
                            print("Invalid choice.")
                        }
                    }
                }
            } else {
                print("Invalid Admin ID.")
            }
        case 5:
            checkout()
            return
        default:
            print("Please choose an appropriate option!")
        }
    }
}
