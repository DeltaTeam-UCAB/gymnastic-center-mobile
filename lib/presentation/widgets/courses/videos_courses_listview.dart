import 'package:flutter/material.dart';

class VideosCoursesListView extends StatefulWidget {
 final List<Map<String, String>> lessons;
 const VideosCoursesListView({super.key, required this.lessons});

 @override
 State<VideosCoursesListView> createState() => _VideosCoursesListViewState();
}

class _VideosCoursesListViewState extends State<VideosCoursesListView> {
 late List<bool> _expansionStates;

 @override
 void initState() {
    super.initState();
    _expansionStates = List.generate(widget.lessons.length, (index) => false);
 }

 @override
 Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme.titleMedium;

    return Column(
      children: [
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10),
            child: Text('Lecciones del curso', style: textStyles,),
          ),
        ),
        ...widget.lessons.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, String> lesson = entry.value;
          return ExpansionPanelList(
            expansionCallback: (panelIndex, expanded) {
              setState(() {
                _expansionStates[index] = !_expansionStates[index];
              });
            },
            children: [
              ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                 return ListTile(
                    title: Text(lesson['titulo']!),
                    leading: const Icon(Icons.video_library),
                 );
                },
                body: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: (){}, 
                    icon: const Icon(Icons.play_circle_fill), 
                    label: const Text('Subtitulo')
                  )
                ),
                isExpanded: _expansionStates[index],
                canTapOnHeader: true,
              ),
            ],
          );
        }).toList(),
      ],
    );
 }
}
