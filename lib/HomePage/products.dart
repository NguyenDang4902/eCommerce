import 'package:e_commerce_ui/HomePage/search_page.dart';
import 'package:e_commerce_ui/HomePage/all_products.dart';
import 'package:e_commerce_ui/details.dart';
import 'package:e_commerce_ui/product.dart';
import 'package:e_commerce_ui/remote_service.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Map<String, dynamic>> iconImage = [
    {
      'image': 'wired_icon.png',
      'type': 'Wired',
      'color': Colors.blue.shade200,
      'height': 50.0
    },
    {
      'image': 'wireless_icon.png',
      'type': 'Wireless',
      'color': Colors.blue.shade200,
      'height': 70.0
    },
  ];
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

  Widget shimmerLoadingEffect() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.messenger,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SearchProducts(),
                            ));
                      },
                      child: Container(
                        height: 40,
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Search products',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 15
                              ),
                            ),
                            Icon(
                              Icons.search,
                              color: Colors.grey[400],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: iconImage.length,
                  itemBuilder: (context, index) {
                    final iconImg = iconImage[index];
                    return Container(
                      width: 70,
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue.shade200,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            'assets/${iconImg['image']}',
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            iconImg['type'],
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.black
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              titleLabelWidget('new arrivals', Colors.blue.shade500),
              newArrivalsListView(),
              titleLabelWidget('best sellers', Colors.blue.shade500),
              bestSellersList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget bestSellersList() => Container(
    height: 250,
    child: Visibility(
      visible: isLoaded,
      replacement: shimmerLoadingEffect(),
      child: ListView.builder(
        itemCount: productsList?.length,
        itemBuilder: (context, index) {
          final prd = productsList![index];
          return GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => DetailsPage(product: prd),
                ));
            },
            child: Container(
              width: 100,
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.network(
                        prd.image,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${prd.productPrice}',
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.red,
                            ),
                          ),
                          Text(
                            prd.productName.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const Text(
                            'More details...',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.grey,
                              fontSize: 12
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            prd.isWishlist = !prd.isWishlist;
                            if (prd.isWishlist == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${prd.productName} is added to Wishlist'.toUpperCase()),
                                  )
                              );
                              /*myWishList.add(prd);*/
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${prd.productName} is removed from Wishlist'.toUpperCase()),
                                  )
                              );
                              /*myWishList.remove(prd);*/
                            }
                          });
                        },
                        child: Icon(
                          Icons.favorite,
                          color: prd.isWishlist ? Colors.red : Colors.grey.shade400,
                        ),
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            prd.isFavorite = !prd.isFavorite;
                            if (prd.isFavorite == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${prd.productName} is added to Cart'.toUpperCase()),
                                  )
                              );
                              /*myFavoriteList.add(prd);*/
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${prd.productName} is removed from Cart'.toUpperCase()),
                                  )
                              );
                              /*myFavoriteList.remove(prd);*/
                            }
                          });
                        },
                        child: Icon(
                          Icons.add_shopping_cart,
                          color: prd.isFavorite ? Colors.blue : Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );

  Widget newArrivalsListView() => Container(
    height: 250,
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Visibility(
      visible: isLoaded,
      replacement: shimmerLoadingEffect(),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productsList?.length,
        itemBuilder: (context, index) {
          final prd = productsList![index];
          return GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(product: prd),
                  ));
            },
            child: Container(
              width: 180,
              color: Colors.white,
              margin: const EdgeInsets.only(right: 10),
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
                    width: 180,
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
                            /*myWishList.add(prd);*/
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${prd.productName} is removed from Wishlist'.toUpperCase()),
                                )
                            );
                            /*myWishList.remove(prd);*/
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
  );

  Widget titleLabelWidget(String title, Color color) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        alignment: Alignment.center,
        height: 30,
        width: 100,
        color: color,
        child: Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      TextButton(
        onPressed: (){
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => displayProducts(),
              ));
        },
        child: Text(
          'see all'.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            color: color,
          ),
        ),
      ),
    ],
  );
}
