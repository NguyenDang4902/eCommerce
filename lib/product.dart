// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

List<Products> productsFromJson(String str) => List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  Products({
    required this.image,
    required this.productName,
    required this.productPrice,
    required this.productDetails,
    required this.isWishlist,
    required this.isFavorite,
    required this.quantity,
    required this.remainder,
    this.id,
  });

  String image;
  String productName;
  String productPrice;
  String productDetails;
  bool isWishlist;
  bool isFavorite;
  int quantity;
  int remainder;
  String? id;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    image: json["image"],
    productName: json["productName"],
    productPrice: json["productPrice"],
    productDetails: json["productDetails"],
    isWishlist: json["isWishlist"],
    isFavorite: json["isFavorite"],
    quantity: json["quantity"],
    remainder: json["remainder"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "productName": productName,
    "productPrice": productPrice,
    "productDetails": productDetails,
    "isWishlist": isWishlist,
    "isFavorite": isFavorite,
    "quantity": quantity,
    "remainder": remainder,
    "id": id,
  };
}
