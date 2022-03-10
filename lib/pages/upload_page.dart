import 'dart:io';
import 'package:cat_api/pages/main_page.dart';
import 'package:cat_api/services/http_service.dart';
import 'package:cat_api/services/util_service.dart';
import 'package:flutter/material.dart';

class UploadPage extends StatefulWidget {
  static String id = "/upload_page";
  File? file;
  UploadPage({this.file, Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {

  void upload() async {
    Network.MULTIPART(Network.API_UPLOAD, widget.file!.path, Network.bodyUpload(widget.file!.hashCode.toString())).then((value) {
      if(value != null) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainPage()), (route) => route.isFirst);
      } else {
        Utils.fireSnackBar("Something error", context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: FileImage(widget.file!),
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.7,
            ),
            MaterialButton(
              onPressed: upload,
              child: Text("Upload"),
              textColor: Colors.white,
              shape: StadiumBorder(),
              height: 55,
              minWidth: MediaQuery.of(context).size.width * 0.7,
              color: Colors.blueAccent,
            )
          ],
        ),
      ),
    );
  }
}
