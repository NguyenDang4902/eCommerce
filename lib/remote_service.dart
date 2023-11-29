import 'package:e_commerce_ui/product.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class RemoteService {
  Future<List<Products>?> getProducts() async {
    var client = http.Client();
    var uri = Uri.parse('https://62d7812d51e6e8f06f1d61ef.mockapi.io/api/v1/Products');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return productsFromJson(json);
    }
  }
  void recentProduct(String image, String productName, String productPrice, String productDetails, bool isWishlist, bool isFavorite, int quantity, int remainder) async {
    try {
      Response response = await post(
          Uri.parse('https://62d7812d51e6e8f06f1d61ef.mockapi.io/api/v1/Recent'),
          body: {
            "image" : image,
            "productName" : productName,
            "productPrice" : productPrice,
            "productDetails" : productDetails,
            "isWishlist" : isWishlist,
            "isFavorite" : isFavorite,
            "quantity" : quantity,
            "remainder" : remainder
          }
      );
      if (response.statusCode == 201) {
        print('Added to Recently viewed');
      } else {
        print('Error(s) occured!');
      }
    } catch(e) {
      print(e.toString());
    }
  }
}