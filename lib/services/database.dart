import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import '../app/products/upload_model.dart';

class FirestoreProvider {
  FirestoreProvider({
    required this.firestore,
  });

  final FirebaseFirestore firestore;
  final RegExp notValidDocId = RegExp(r'[ ()\/*+^%#@!&$]');

  Future<void> addData({
    required String path,
    required ProductUploadModel fromModel,
    required List<String> imgUrls,
  }) async {
    await EasyLoading.show(status: 'Adding Product...');
    final reference = firestore.collection(path).doc(
          fromModel.name.replaceAll(notValidDocId, '_'),
        );
    reference.set({
      'pID': fromModel.pID,
      'name': fromModel.name,
      'brand': fromModel.brand,
      'description': fromModel.description,
      'images': imgUrls,
      'price': fromModel.price,
      'discountPrice': fromModel.discountPrice,
      'haveDiscount': fromModel.haveDiscount,
      'category': fromModel.category,
      'date': DateTime.now(),
    });
    await EasyLoading.showSuccess('Product Added');
  }

  Stream<QuerySnapshot> streamDataCollection({
    required String path,
  }) {
    final reference = firestore.collection(path);
    return reference.snapshots();
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

  Future<List<String>> uploadImage({
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

  Future<List<XFile>?> getImage({
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
}
