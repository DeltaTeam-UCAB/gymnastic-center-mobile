import 'dart:async';

import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  final Future<void> Function(String term) search;
  final void Function() onClear;
  const SearchInput({super.key, required this.search, required this.onClear});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  Timer? _debounceTimer;
  final TextEditingController _textController = TextEditingController();
  bool _showCloseButton = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        _showCloseButton = _textController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black, Colors.grey],
          ),
        ),
        child: TextField(
          controller: _textController,
          onChanged: (term) {
            if (_debounceTimer?.isActive ?? false) {
              _debounceTimer?.cancel();
            }
            _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
              await widget.search(term);
            });
          },
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey.shade800),
            suffixIcon: _showCloseButton
                ? IconButton(
                    icon: Icon(Icons.close, color: Colors.grey.shade800),
                    onPressed: (){
                      _textController.clear();
                      widget.onClear();
                    },
                  )
                : Icon(Icons.search, color: Colors.grey.shade800),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15),
            ),
            contentPadding:
                const EdgeInsets.only(top: 16, bottom: 16, left: 25),
          ),
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
