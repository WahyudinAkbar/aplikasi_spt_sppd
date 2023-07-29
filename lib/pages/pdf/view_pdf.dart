import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:permission_handler/permission_handler.dart';

class PdfView extends StatefulWidget {
  String path;
  VoidCallback callback;

  PdfView({required this.path, required this.callback, super.key});

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                var status = await Permission.storage.status;
                if (!status.isGranted) {
                  await Permission.storage.request();
                } else {
                  widget.callback();
                }
              },
              icon: Icon(Icons.download))
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade500,
                  offset: const Offset(1, 1),
                  blurRadius: 7,
                  spreadRadius: 1,
                ),
                BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(-1, -1),
                    blurRadius: 7,
                    spreadRadius: 1)
              ], borderRadius: BorderRadius.circular(8)),
              child: PDFView(
                filePath: widget.path,
                enableSwipe: true,
                pageFling: true,
                pageSnap: true,
                fitPolicy: FitPolicy.BOTH,
                // autoSpacing: false,
                // pageFling: false,
                onError: (error) {
                  print(error.toString());
                },
                onPageError: (page, error) {
                  print('$page: ${error.toString()}');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
