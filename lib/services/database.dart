import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import '../app/products/upload_model.dart';

class Fields {
  static const String itemName = 'product_name';
  static const String itemBrand = 'product_brand';
  static const String itemPrice = 'product_price';
  static const String discountPrice = 'discount_price';
  static const String haveDiscount = 'haveDiscount';
  static const String description = 'product_desc';
  static const String category = 'category';
  static const String imgs = 'imgs';
  static const String pID = 'pId';
  static const String date = 'dateAdded';
}

const String productsPath = 'itemsList';

class FirestoreProvider {
  FirestoreProvider({
    required this.firestore,
  });

  final FirebaseFirestore firestore;
  final auth = FirebaseAuth.instance;
  final RegExp notValidDocId = RegExp(r'[ (){}\/*+^%#@!&$]');

  Future<void> addData({
    required String path,
    required ProductModel fromModel,
    required List<String> imgUrls,
  }) async {
    await EasyLoading.show(status: 'Adding Product...');
    final reference = firestore.collection(path).doc(
          fromModel.name.replaceAll(notValidDocId, '_'),
        );
    reference.set({
      Fields.itemName: fromModel.name,
      Fields.itemBrand: fromModel.brand,
      Fields.itemPrice: fromModel.price,
      Fields.discountPrice: fromModel.discountPrice,
      Fields.haveDiscount: fromModel.haveDiscount,
      Fields.description: fromModel.description,
      Fields.category: fromModel.category,
      Fields.pID: fromModel.pID,
      Fields.date: DateTime.now().toString(),
      Fields.imgs: imgUrls,
      'Employee': {
        "name": 'not loggeg in', //auth.currentUser!.displayName ?? '',
        "uid": 'not loggeg in', // auth.currentUser!.uid,
      },
    });
    await EasyLoading.showSuccess('Product Added');
  }

  Query<ProductModel> getAppProducts() {
    final reference = firestore.collection(productsPath);
    return reference.withConverter(
      fromFirestore: ((snapshot, options) =>
          ProductModel.fromJson(snapshot.data()!)),
      toFirestore: (model, options) => model.toJson(),
    );
  }

  Query<ProductModel> filteSingelProdut({
    required String filterWith,
    required String matchingField,
  }) {
    final reference = firestore.collection(productsPath);
    return reference.where(matchingField, isEqualTo: filterWith).withConverter(
          fromFirestore: ((snapshot, options) =>
              ProductModel.fromJson(snapshot.data()!)),
          toFirestore: (model, options) => model.toJson(),
        );
  }

  Future<void> updateData(
      {required String path, required Map<String, dynamic> data}) async {
    final reference = firestore.collection(path);
    reference.add(data);
  }

  Future<void> deleteData({required String path, required docPath}) async {
    final reference = firestore.collection(path).doc(docPath);
    reference.delete();
  }
}

class StorageProvider {
  StorageProvider({
    required this.storage,
  });

  final FirebaseStorage storage;

  get getProgres => progres;

  double progres = 0.0;

  Future<String> uploadSingelImage({
    required String path,
    required String fileName,
    required XFile img,
  }) async {
    String finalurl = '';

    await EasyLoading.show(status: 'Uploading images');
    final reference =
        storage.ref().child('$path/$fileName').child('${fileName}_');
    // reference.putFile(File(img.path));
    final uptask = reference.putData(
      await img.readAsBytes(),
      SettableMetadata(contentType: 'image/jpeg'),
    );

    final url = await uptask.then(
      (snap) => snap.ref.getDownloadURL(),
    );
    finalurl = url;
    await EasyLoading.showSuccess('Image Uploaded');

    return finalurl;
  }

  Future<List<String>> uploadMultiImage({
    required String path,
    required String fileName,
    required List<XFile> imgs,
  }) async {
    List<String> urls = [];
    for (final img in imgs) {
      await EasyLoading.show(
          status:
              'Uploading ${imgs.indexOf(img)} out of ${imgs.length} images');
      final reference = storage
          .ref()
          .child('$path/$fileName')
          .child('${fileName}_' + imgs.indexOf(img).toString());
      // reference.putFile(File(img.path));
      final uptask = reference.putData(
        await img.readAsBytes(),
        SettableMetadata(contentType: 'image/jpeg'),
      );

      final url = await uptask.then(
        (snap) => snap.ref.getDownloadURL(),
      );
      urls.add(url);
      await EasyLoading.showSuccess('Image Uploaded');
    }
    return urls;
  }
}

class ImgSelector {
  ImgSelector({
    required this.imagePicker,
  });

  final ImagePicker imagePicker;

  Future<List<XFile>?> getMultiImgs({
    required String path,
    required String fileName,
  }) async {
    final pickedFile = await imagePicker.pickMultiImage();
    if (pickedFile != null) {
      List<XFile> selectedImgs = [];
      for (final xfile in pickedFile) {
        selectedImgs.add(xfile);
      }
      return selectedImgs;
    }
    return null;
  }

  Future<XFile?> getImg({
    required String path,
    required String fileName,
  }) async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      XFile selectedImg = pickedFile;

      return selectedImg;
    }
    return null;
  }
}
