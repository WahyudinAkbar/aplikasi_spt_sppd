import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ShowPhoto extends StatefulWidget {
  final String image;
  const ShowPhoto({super.key, required this.image});

  @override
  State<ShowPhoto> createState() => _ShowPhotoState();
}

class _ShowPhotoState extends State<ShowPhoto> {
  String downloadUrl = '';
  @override
  void initState() {
    super.initState();

    getUrl();
    print(downloadUrl);
  }

  Future getUrl() async {
    String url = await FirebaseStorage.instance
        .ref()
        .child(widget.image)
        .getDownloadURL();

    setState(() {
      downloadUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          downloadUrl == ''
              ? const Center(child: CircularProgressIndicator())
              : CachedNetworkImage(
                  imageUrl: downloadUrl,
                  fit: BoxFit.fitHeight,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                    value: downloadProgress.progress,
                    strokeWidth: 2.0,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.3,
                ),
          ElevatedButton(
            onPressed: () async {
              var status = await Permission.storage.status;
              if (!status.isGranted) {
                await Permission.storage.request();
              } else {
                var response = await http.get(Uri.parse(downloadUrl));
                var externalStorageDirectory =
                    await getExternalStorageDirectory();
                externalStorageDirectory =
                    Directory('/storage/emulated/0/Download');
                File file = File(path.join(externalStorageDirectory.path,
                    path.basename(widget.image)));
                await file.writeAsBytes(response.bodyBytes);
                // ignore: use_build_context_synchronously
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('Foto Berhasil Disimpan'),
                          content: Image.file(file),
                        ));
              }
            },
            child: const Text('Save Image'),
          )
        ],
      )),
    );
  }
}
