import 'package:e_commerce_ui/product.dart';
import 'package:e_commerce_ui/remote_service.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class DetailsPage extends StatefulWidget {
  Products product;
  DetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  List<Products>? relatedProducts;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
    RemoteService().recentProduct(widget.product.image, widget.product.productName, widget.product.productPrice, widget.product.productDetails, widget.product.isWishlist, widget.product.isFavorite, widget.product.quantity, widget.product.remainder);
  }

  getData() async {
    relatedProducts = await RemoteService().getProducts();
    if (relatedProducts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  Widget relatedItemsList() => Visibility(
    visible: isLoaded,
    child: Container(
      height: 135,
      width: 360,
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: relatedProducts?.length,
        itemBuilder: (context, index) {
          final prd = relatedProducts![index];
          if (prd != widget.product) {
            return GestureDetector(
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(product : prd),
                    ));
              },
              child: Container(
                height: 100,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              prd.productName.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${prd.productPrice}',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.red,
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
          } else {
            return Container();
          }
        },
      ),
    ),
  );

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
        height: height,
        width: width,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.network(
                          widget.product.image,
                          height: 230,
                          width: 230,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              widget.product.productName,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 55,
                            child: ReadMoreText(
                              widget.product.productDetails,
                              trimLines: 2,
                              colorClickableText: Colors.white,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Show more',
                              trimExpandedText: ' Show less',
                              moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            )
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '\$${widget.product.productPrice}',
                            style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.product.isWishlist = !widget.product.isWishlist;
                        });
                      },
                      icon: Icon(
                        Icons.favorite,
                        size: 30,
                        color: widget.product.isWishlist ? Colors.red : Colors.grey.shade400,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 370,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Related items',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        relatedItemsList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 50,
                width: width,
                alignment: Alignment.center,
                color: Colors.blue,
                child: const Text(
                  'Add to cart',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
