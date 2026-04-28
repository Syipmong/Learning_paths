import 'dart:convert';
import 'package:http/http.dart' as http;
// Don't forget to import your new model!
import '../models/quote.dart'; 

class ApiService {
  
  Future<Quote> fetchRandomQuote() async {
    // 1. Parse the URL: 'https://dummyjson.com/quotes/random'
    
    // 2. Await the http.get request
    final response = await http.get(
      Uri.parse('https://dummyjson.com/quotes/random'),
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
      }
    );
    
    // 3. Check if response.statusCode == 200
   
    
    // 4. If success: jsonDecode the body, and pass it to Quote.fromJson()
     if(response.statusCode == 200){
      Map<String, dynamic> quotes = jsonDecode(response.body);
      return Quote.fromJson(quotes);
    }
    
    // 5. If fail: throw an Exception
    else{
      throw Exception('Server Error ${response.statusCode}');
    }
  }
}