import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class LaporanSppdPage extends StatefulWidget {
  final String path;
  const LaporanSppdPage({super.key, required this.path});

  @override
  State<LaporanSppdPage> createState() => _LaporanSppdPageState();
}

class _LaporanSppdPageState extends State<LaporanSppdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sppd'),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey),
        padding: const EdgeInsets.all(20),
        child: PDFView(
          filePath: widget.path,
          enableSwipe: true,
          autoSpacing: true,
          pageFling: false,
          onError: (error) {
            print(error.toString());
          },
          onPageError: (page, error) {
            print('$page: ${error.toString()}');
          },
        ),
      ),
    );
  }
}
