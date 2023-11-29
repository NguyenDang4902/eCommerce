import 'package:e_commerce_ui/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecentProductScreen extends StatefulWidget {
  const RecentProductScreen({Key? key}) : super(key: key);

  @override
  State<RecentProductScreen> createState() => _RecentProductScreenState();
}

class _RecentProductScreenState extends State<RecentProductScreen> {
  List<Products>? productsList;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<List<Products>?> getProducts() async {
    var client = http.Client();
    var uri = Uri.parse('https://62d7812d51e6e8f06f1d61ef.mockapi.io/api/v1/Recent');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return productsFromJson(json);
    }
  }

  getData() async {
    productsList = await getProducts();
    if (productsList != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Text('Recently viewed'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        height: height,
        width: width,
        color: Colors.grey[300],
        child: Visibility(
          replacement: Center(child: CircularProgressIndicator(),),
          visible: isLoaded,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10,
              childAspectRatio: 3 / 4,
            ),
            itemCount: productsList?.length,
            itemBuilder: (context, index) {
              final prd = productsList![index];
              /*return Container(
                  color: Colors.yellow,
                );*/
              return Container(
                color: Colors.white,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            prd.image,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            '\$${prd.productPrice}',
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.red
                            ),
                          ),
                          Text(
                            prd.productName,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            prd.productDetails,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      height: 45,
                      width: 190,
                      bottom: 0,
                      child: ElevatedButton(
                        onPressed: (){
                          setState(() {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${prd.productName} is added to Cart'.toUpperCase()),
                                )
                            );
                            /*myFavoriteList.add(prd);*/
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red
                        ),
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 0.4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          setState((){
                            prd.isWishlist = !prd.isWishlist;
                            if (prd.isWishlist == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${prd.productName} is added to Wishlist'.toUpperCase()),
                                  )
                              );
                              /*myWishlist.add(prd);*/
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${prd.productName} is removed from Wishlist'.toUpperCase()),
                                  )
                              );
                              /*myWishlist.remove(prd);*/
                            }
                          });
                        },
                        icon: Icon(
                          Icons.favorite,
                          size: 30,
                          color: prd.isWishlist ? Colors.red : Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
