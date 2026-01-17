void main(){

  Map<String, double> menu = {
  "Pizza": 10.0,
  "Coke": 2.0,
  "Chicken": 70.99
};

List<String> order = ["water","Stew","Jollof", "Pizza","Coke"];

double total = 0.0;

for ( var item in order){
  if (menu.containsKey(item)){
    total += menu[item]!;
  }else{
    print("$item not in the Menu");
  }
}
print("The total is: $total");

}