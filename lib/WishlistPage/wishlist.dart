import 'package:e_commerce_ui/details.dart';
import 'package:e_commerce_ui/product.dart';
import 'package:e_commerce_ui/remote_service.dart';
import 'package:flutter/material.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
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

  Widget wishList() => Container(
        height: 530,
        margin: const EdgeInsets.only(top: 10),
        child: Visibility(
          visible: isLoaded,
          replacement: Center(child: CircularProgressIndicator(),),
          child: ListView.builder(
            itemCount: productsList?.length,
            itemBuilder: (context, index) {
              final prd = productsList![index];
              if (prd.isWishlist == true) {
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
                                  prd.productName,
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
                                      fontSize: 12),
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
                                  prd.isFavorite = !prd.isFavorite;
                                  if (prd.isFavorite == false) {
                                    showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              content: const Text(
                                                  'Do you want to remove this item'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () => Navigator.pop(
                                                      context, 'Cancel'),
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    productsList?.removeAt(index);
                                                    Navigator.pop(context, 'OK');
                                                    setState(() {

                                                    });
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                          content: Text('${prd.productName} deleted'.toUpperCase()),
                                                          action: SnackBarAction(
                                                            label: 'Undo item',
                                                            onPressed: (){
                                                              productsList?.insert(index, prd);
                                                              setState(() {

                                                              });
                                                            },
                                                          ),
                                                        )
                                                    );
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ));
                                  }
                                });
                              },
                              child: const Icon(
                                  Icons.favorite,
                                  size: 30,
                                  color: Colors.red
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
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Your wishlist',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      body: wishList(),
    );
  }
}
