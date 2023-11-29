import 'package:e_commerce_ui/details.dart';
import 'package:e_commerce_ui/product.dart';
import 'package:e_commerce_ui/remote_service.dart';
import 'package:flutter/material.dart';

class SearchProducts extends StatefulWidget {
  SearchProducts({Key? key}) : super(key: key);

  @override
  State<SearchProducts> createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
  List<Products>? productsList;
  List searchResults = [];
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

  void updateList(String search) {
    setState(() {
      searchResults = productsList!.where((element) => element.productName.contains(search.toUpperCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: BackButton(
            color: Colors.black
        ),
        title: Container(
          height: 40,
          color: Colors.grey[200],
          alignment: Alignment.center,
          // padding: EdgeInsets.only(left: 10, bottom: 3),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          child: TextField(
            onChanged: ((value) => updateList(value)),
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              hintText: 'Search Products',
              hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 15
              ),
              suffixIcon: GestureDetector(
                onTap: (){},
                child: const Icon(
                  Icons.search,
                  size: 20,
                  color: Colors.grey,
                ),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: Center(child: CircularProgressIndicator()),
        child: Container(
          height: height,
          width: width,
          color: Colors.grey[200],
          child: ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              final prd = searchResults[index];
              return GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DetailsPage(product: prd))
                  );
                },
                child: ListTile(
                  leading: Image.network(
                    prd.image,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    '${prd.productName}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),
                  subtitle: Text(
                    '\$${prd.productPrice}',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.red
                    ),
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
