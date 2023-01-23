import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class ReportViewPage extends StatefulWidget {
  final String path;
  const ReportViewPage({super.key, required this.path});

  @override
  State<ReportViewPage> createState() => _ReportViewPageState();
}

class _ReportViewPageState extends State<ReportViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spt'),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey),
        padding: const EdgeInsets.all(20),
        child: PDFView(
          filePath: widget.path,
          enableSwipe: true,
          swipeHorizontal: true,
          autoSpacing: false,
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
