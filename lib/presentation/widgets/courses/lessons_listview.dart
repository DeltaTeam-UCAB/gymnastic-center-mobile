import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';

class LessonsListView extends StatefulWidget {
  final void Function(
    Lesson lesson
  ) onPressedLesson;
  final List<Lesson> lessons;
  LessonsListView({Key? key, required this.lessons, required this.onPressedLesson}) : super(key: key) {
    lessons.sort((a, b) => a.order.compareTo(b.order));
  }

  @override
  State<LessonsListView> createState() => _LessonsListViewState();
}

class _LessonsListViewState extends State<LessonsListView> {
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
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Lessons of the course',
              style: textStyles,
            ),
          ),
        ),
        ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.lessons.length,
          itemBuilder: (context, index) {
            final lesson = widget.lessons[index];
            return ExpansionPanelList(
              expansionCallback: (panelIndex, expanded) {
                setState(() {
                  _expansionStates[index] = !_expansionStates[index];
                });
              },
              children: [
                ExpansionPanel(
                  backgroundColor: 
                    Colors.transparent
                  ,
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: Text(
                              lesson.title,
                              overflow: (isExpanded) ? TextOverflow.clip : TextOverflow.ellipsis,
                            ),
                      leading: const Icon(Icons.video_library),
                    );
                  },
                  body: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                          onPressed: () async{
                            
                            widget.onPressedLesson(lesson);
                          },
                          icon: const Icon(Icons.play_circle_fill),
                          label: Text(lesson.content))),
                  isExpanded: _expansionStates[index],
                  canTapOnHeader: true,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
