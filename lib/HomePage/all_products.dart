import 'package:e_commerce_ui/details.dart';
import 'package:e_commerce_ui/product.dart';
import 'package:e_commerce_ui/remote_service.dart';
import 'package:flutter/material.dart';

class displayProducts extends StatefulWidget {
  const displayProducts({Key? key}) : super(key: key);

  @override
  State<displayProducts> createState() => _displayProductsState();
}

class _displayProductsState extends State<displayProducts> {
  List<Products>? productsList;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    productsList = await RemoteService().getProducts();
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
        centerTitle: true,
        title: const Text('Details'),
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
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(product : prd),
                        ));
                  },
                  child: Container(
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
                  ),
                );
              },
          ),
        ),
      ),
    );
  }
}
