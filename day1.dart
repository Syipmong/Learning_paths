void main() {
  // 1. Strings
  String name = "Future Developer";
  print("Hello, $name"); // The $ allows us to put variables inside text!

  // 2. Numbers
  int age = 25;
  double height = 5.9;

  // TASK A: Create a variable called 'dogYears'
  // Calculate it: Multiply 'age' by 7.
  // int dogYears = ... ?
  int dogYears = age * 7;

  print("I am $age years old, which is $dogYears in dog years.");

  // 3. Booleans (True/False)
  bool isLearning = true;

  // 4. Control Flow (If/Else)
  if (isLearning) {
    print("Keep going!");
  } else {
    print("Start today!");
  }

  // TASK B: Write an if/else statement.
  // If 'height' is greater than 6.0, print "You are tall".
  // Otherwise, print "You are average height".

  if (height > 6){
    print("You are tall");
  }else{
    print("You are average height");
  }
}