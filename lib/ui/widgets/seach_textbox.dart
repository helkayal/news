import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/ui/screens/search/search_view_model.dart';
import 'package:news/ui/utils/extensions/build_context_extensions.dart';

class SearchTextbox extends StatefulWidget {
  const SearchTextbox({super.key});

  @override
  State<SearchTextbox> createState() => _SearchTextboxState();
}

class _SearchTextboxState extends State<SearchTextbox> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: "Search",
        hintStyle: TextStyle(color: context.secondaryColor),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.search, color: context.secondaryColor),
          onPressed: () {
            context.read<SearchViewModel>().search(_controller.text);
          },
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: context.secondaryColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: context.secondaryColor, width: 2),
        ),
      ),
    );
  }
}
