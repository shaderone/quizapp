import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

//This controller is for the admin
class DataUploader extends GetxController {
  @override
  // This function is called only once.(in the app lifetime or when it restores)
  // This 'controller' should be called from the UI

  void onReady() {
    uploadData();
    super.onReady();
  }

  Future<void> uploadData() async {
    print("Data Uploading...");
    // to upload files :
    // ** how 'context' is accessible here, - through getX, but how?
    // the loadString() will load the 'assets' key from pubspec.yaml (which includes every directory mentioned under assets:)
    final manifestContent = await DefaultAssetBundle.of(Get.context!).loadString("AssetManifest.json");
    //now the whole data is loaded into 'manifestContent', and next we need to decode the json data to read its content, (it will return a MAP)
    final Map<String, dynamic> manifestContentMap = json.decode(manifestContent);
    //now to filter out the specific data that's requried (in this case we only need the json files stored in under assets/DB/paper, however the result has all data under 'assets:'), we need to get the keys
    // ** what is the difference between 'Iterable' and 'List'
    final manifestContentFilteredIterable = manifestContentMap.keys.where((path) => path.startsWith("assets/DB/paper") && path.contains(".json"));
    // this data is what admin manages
    final papersInAssets = manifestContentFilteredIterable.toList();
    print(papersInAssets);

    // ? NEXT : loop through the filtered data.
  }
}
