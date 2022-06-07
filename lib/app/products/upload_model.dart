import 'package:image_picker/image_picker.dart';

class ProductUploadModel {
  const ProductUploadModel({
    required this.name,
    required this.price,
    required this.discountPrice,
    required this.images,
    this.imgUrls,
    required this.description,
    required this.category,
    required this.pID,
    required this.brand,
    required this.haveDiscount,
  });

  final String name;
  final String brand;
  final int price;
  final int discountPrice;
  final List<XFile> images;
  final List<String>? imgUrls;
  final String description;
  final String category;
  final String pID;
  final bool haveDiscount;
}
