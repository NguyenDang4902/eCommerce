import 'package:e_commerce_ui/details.dart';
import 'package:e_commerce_ui/product.dart';
import 'package:e_commerce_ui/remote_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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

  Future<void> _pullRefresh() async {
    List<Products> freshProducts = await getData();
    setState(() {
      productsList = freshProducts;
    });
  }

/*  String returnTotalAmount(List<Products>? productsList) {
    double total = 0;
    if (productsList!.length > 0) {
      for (int i = 0; i < productsList!.length; i++) {
        if (productsList![i].isFavorite == true) {
          total += double.parse(productsList![i].productPrice) * productsList![i].count;
        }
      }
    }
    return total.toString();
  }*/

  Widget cartProductsList() => Container(
        height: 400,
        margin: const EdgeInsets.only(top: 10),
        child: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: ListView.builder(
            itemCount: productsList?.length,
            itemBuilder: (context, index) {
              final prd = productsList![index];
              if (prd.isFavorite == true) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
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
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    prd.productName,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const Text(
                                  'More details...',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.grey,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  prd.quantity++;
                                });
                              },
                              child: const Icon(
                                Icons.add_circle,
                                size: 30,
                                color: Colors.blue,
                              ),
                            ),
                            Text('${prd.quantity}'),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (prd.quantity <= 1) {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        content: const Text(
                                            'Do you want to remove this item'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'No'),
                                            child: const Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              productsList?.removeAt(index);
                                              setState(() {});
                                              Navigator.pop(context, 'Yes');
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    '${prd.productName} deleted'
                                                        .toUpperCase()),
                                                action: SnackBarAction(
                                                  label: 'Undo item',
                                                  onPressed: () {
                                                    productsList?.insert(
                                                        index, prd);
                                                    setState(() {});
                                                  },
                                                ),
                                              ));
                                            },
                                            child: const Text('Yes'),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    prd.quantity--;
                                  }
                                });
                              },
                              child: const Icon(
                                Icons.remove_circle,
                                size: 30,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    double total = 0;
    if (productsList != null) {
      for (int i = 0; i < productsList!.length; i++) {
        if (productsList![i].isFavorite == true) {
          total += double.parse(productsList![i].productPrice) *
              productsList![i].quantity;
        }
      }
    }

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Your cart',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        height: height,
        width: width,
        child: Visibility(
          visible: isLoaded,
          replacement: Center(child: CircularProgressIndicator()),
          child: Stack(
            children: [
              cartProductsList(),
              Positioned(
                bottom: 0.0,
                child: ClipPath(
                  clipper: CustomClipperDesign(),
                  child: Container(
                      height: 120,
                      width: width,
                      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${total}',
                                style: TextStyle(
                                    color: Colors.red.shade800,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 40,
                            width: 200,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue.shade500),
                              child: const Text(
                                'Continue to checkout',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomClipperDesign extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.moveTo(width, height);
    path.lineTo(width, height - 120);
    path.quadraticBezierTo(width / 2, 0, 0, height - 120);
    path.lineTo(0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
