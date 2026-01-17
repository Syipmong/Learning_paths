class SmartPhone{
  String brand;
  double storageGB;
  bool isOn = false;

  SmartPhone({required this.brand, required this.storageGB});

  void powerOn() {
    isOn = true;
  
  print("$brand is now ON");

  }
  

}

void main(){
  var samsung = SmartPhone(brand: "Samsung", storageGB: 128.0);
  print(samsung.storageGB);
  samsung.powerOn();
}