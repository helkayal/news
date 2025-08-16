import 'package:flutter/material.dart';
import 'package:news/data/model/article.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FullArticle extends StatefulWidget {
  final Article article;
  const FullArticle({super.key, required this.article});

  @override
  State<FullArticle> createState() => _FullArticleState();
}

class _FullArticleState extends State<FullArticle> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (_) {
            setState(() => _isLoading = false);
          },
          onWebResourceError: (_) {
            setState(() => _isLoading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.article.url ?? ""));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PageView(children: [WebViewWidget(controller: _controller)]),
            if (_isLoading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
