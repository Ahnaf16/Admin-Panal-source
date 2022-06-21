import 'package:gngm_web/services/database.dart';
import 'package:image_picker/image_picker.dart';

class ProductModel {
  const ProductModel({
    required this.name,
    required this.price,
    required this.discountPrice,
    this.images,
    this.imgUrls,
    required this.description,
    required this.category,
    required this.pID,
    required this.brand,
    required this.haveDiscount,
  });

  ProductModel.fromJson(Map<String, dynamic> json)
      : this(
          name: json[Fields.itemName] as String,
          price: json[Fields.itemPrice] as int,
          discountPrice: json[Fields.discountPrice] as int,
          imgUrls: json[Fields.imgs] as List,
          description: json[Fields.description] as String,
          category: json[Fields.category] as String,
          pID: json[Fields.pID] as String,
          brand: json[Fields.itemBrand] as String,
          haveDiscount: json[Fields.haveDiscount] as bool,
        );

  final String name;
  final String brand;
  final int price;
  final int discountPrice;
  final List<XFile>? images;
  final List? imgUrls;
  final String description;
  final String category;
  final String pID;
  final bool haveDiscount;

  Map<String, dynamic> toJson() => {
        'product_name': name,
        'product_brand': brand,
        'product_price': price,
        'discount_price': discountPrice,
        'imgs': imgUrls,
        'product_desc': description,
        'category': category,
        'pID': pID,
        'haveDiscount': haveDiscount,
      };
}
//----------------------------

