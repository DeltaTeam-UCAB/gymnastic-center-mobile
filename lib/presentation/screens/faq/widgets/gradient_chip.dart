import 'package:flutter/material.dart';
import 'package:gymnastic_center/common/either.dart';

class GradientChip extends StatefulWidget {
  const GradientChip(
      {super.key,
      required this.label,
      required this.onTap,
      required this.selected,
      required this.fill,
      required this.selectedFill});

  final Widget label;
  final Function() onTap;
  final bool selected;
  final Either<Gradient, Color> fill;
  final Either<Gradient, Color> selectedFill;

  @override
  State<StatefulWidget> createState() => GradientChipState();
}

class GradientChipState extends State<GradientChip> {
  @override
  Widget build(BuildContext context) {
    Either<Gradient, Color> containerFill;
    if (widget.selected) {
      containerFill = widget.selectedFill;
    } else {
      containerFill = widget.fill;
    }

    BoxDecoration containerDecoration;
    if (containerFill.isLeft()) {
      containerDecoration = BoxDecoration(
          borderRadius: BorderRadius.circular(1000),
          gradient: containerFill.getLeft());
    } else if (containerFill.isRight()) {
      containerDecoration = BoxDecoration(
          borderRadius: BorderRadius.circular(1000),
          color: containerFill.getRight());
    } else {
      throw Exception(
          'GradientChipState: fills must have at least one value each');
    }

    return GestureDetector(
        onTap: widget.onTap,
        child: IntrinsicHeight(
            child: IntrinsicWidth(
                child: Stack(
          children: [
            Container(
                decoration: containerDecoration,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: widget.label)),
            Center(child: widget.label)
          ],
        ))));
  }
}
