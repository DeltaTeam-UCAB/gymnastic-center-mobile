import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';

class SearchTags extends StatefulWidget {
  final List<String> tags;
  final void Function(List<String> selectedTags) onChangeTags;
  const SearchTags(
    this.tags, {
    super.key,
    required this.onChangeTags,
  });

  @override
  SearchTagsState createState() => SearchTagsState();
}

class SearchTagsState extends State<SearchTags> {
  final Set<String> _activeTags = {};

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.read<ThemesBloc>().isDarkMode;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Wrap(
        spacing: 9,
        runSpacing: 9,
        children: widget.tags.map((tag) {
          final bool isActive = _activeTags.contains(tag);
          return ElevatedButton(
            onPressed: () {
              setState(() {
                if (isActive) {
                  _activeTags.remove(tag);
                } else {
                  _activeTags.add(tag);
                }
                widget.onChangeTags(_activeTags.toList());
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isActive
                  ? isDark
                      ? Colors.white
                      : const Color.fromARGB(255, 93, 43, 187)
                  : isDark
                      ? Colors.grey.shade800
                      : const Color.fromARGB(255, 226, 221, 239),
              foregroundColor: isActive
                  ? isDark
                      ? Colors.deepPurple
                      : Colors.white
                  : isDark
                      ? Colors.white
                      : const Color.fromARGB(255, 93, 43, 187),
            ),
            child: Text(tag),
          );
        }).toList(),
      ),
    );
  }
}
