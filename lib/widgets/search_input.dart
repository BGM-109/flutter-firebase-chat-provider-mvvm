import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          focusColor: Colors.transparent,
          filled: true,
          prefixIcon: const Icon(
            Icons.search,
            size: 16.0,
          ),
          fillColor: Colors.grey.shade200,
          hintText: "검색",
          hintStyle: const TextStyle(fontSize: 14.0)),
    );
  }
}
