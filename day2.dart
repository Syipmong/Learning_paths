void main() {
  // Scenario: A user is checking out.
  double itemPrice = 100.0;
  
  // 1. Call the function (Complete this line)
  // We want to calculate the total cost with a tax rate of 5% (0.05).
  double finalPrice = calculateTotal( itemPrice , 0.05 );
  
  print("Total to pay: \$$finalPrice");

  // 2. Null Safety Experiment
  // This variable represents a user's discount code. It is null because they don't have one.
  String? discountCode = null; 

  // TASK: usage of '??' (If-Null operator)
  // Create a variable 'activeCode'. 
  // If discountCode is null, activeCode should be "NO_CODE".
  String activeCode = discountCode??"NO_CODE";
  
  print("Active Discount: $activeCode");
}

// 3. Define the Function
// Create a function named 'calculateTotal'.
// It should take two 'double' inputs: 'price' and 'taxRate'.
// It should return a 'double' (price + (price * taxRate)).

double calculateTotal( double price, double taxRate ) {
  price += price * taxRate;
  return price;
}