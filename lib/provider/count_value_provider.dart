import 'package:flutter/cupertino.dart';

import '../constants.dart';

class CountValueProvider with ChangeNotifier {
  int _countValue = 1;

  int get countValue => _countValue;

  Future<void> fetchCountValue() async {
    try {
      final value = await firestore.collection("countValue").doc("count").get();
      if (value.exists) {
        _countValue = int.parse(value.get("counter").toString());
      } else {
        _countValue = 1;
      }
      notifyListeners();
    } catch (e) {
      print("Error fetching count value: $e");
    }
    notifyListeners();
  }

  Future<void> updateCountValue({required count}) async {
    try {
      await firestore
          .collection("countValue")
          .doc("count")
          .update({"counter": count.toString()});
      notifyListeners();
    } catch (e) {
      print("Error fetching count value: $e");
    }
    notifyListeners();
  }

  // category firebase collection
  Future<void> uploadAnnoucement(
      {required name, required description}) async {
    DateTime time = DateTime.now();
    var id  = firestore.collection(Constant.COLLECTION_ANNOUNCEMENT).doc().id;
    try {
      await firestore
          .collection(Constant.COLLECTION_ANNOUNCEMENT)
          .doc(id.toString())
          .set({
        Constant.KEY_ANNOUCEMENT_ID: id.toString(),
        Constant.KEY_ANNOUCEMENT_TITLE: name.toString().toLowerCase(),
        Constant.KEY_ANNOUCEMENT_DESC: description.toString(),
        "timeStamp": time.millisecondsSinceEpoch.toString(),
      });
      notifyListeners();
    } catch (e) {
      print("Error fetching count value: $e");
    }
    notifyListeners();
  }

  Future<void> updateAnnoucement(
      {required code, required name, required description}) async {
    try {
      await firestore
          .collection(Constant.COLLECTION_ANNOUNCEMENT)
          .doc(code.toString())
          .update({
        Constant.KEY_ANNOUCEMENT_TITLE: name.toString().toLowerCase(),
        Constant.KEY_ANNOUCEMENT_DESC: description.toString(),
      });
      notifyListeners();
    } catch (e) {
      print("Error fetching count value: $e");
    }
    notifyListeners();
  }

  Future<void> deleteCategory({required id}) async {
    try {
      await firestore
          .collection(Constant.COLLECTION_ANNOUNCEMENT)
          .doc(id.toString())
          .delete();
      notifyListeners();
    } catch (e) {
      print("Error fetching count value: $e");
    }
    notifyListeners();
  }
}
