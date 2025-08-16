import 'package:flutter/material.dart';
import 'package:news/data/model/article.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FullArticle extends StatelessWidget {
  final Article article;
  const FullArticle({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          children: [
            WebViewWidget(
              controller: WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..loadRequest(Uri.parse(article.url ?? "")),
            ),
          ],
        ),
      ),
    );
  }
}
