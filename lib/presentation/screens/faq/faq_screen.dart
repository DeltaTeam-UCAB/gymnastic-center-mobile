import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';
import 'package:gymnastic_center/common/either.dart';
import 'package:gymnastic_center/injector.dart';
import 'package:gymnastic_center/presentation/screens/faq/widgets/gradient_chip.dart';
import 'package:gymnastic_center/presentation/widgets/shared/gradient_text.dart';

const _faqCategories = ['Prenatal', 'Confidence', 'Amount', 'FAQ'];
const _faqQuestions = {
  'Prenatal': [
    {
      'question': 'What are the benefits during pregnancy?',
      'answer': 'Lorem ipsum'
    },
    {'question': 'Can I do yoga while pregnant?', 'answer': 'Lorem ipsum'}
  ],
  'Confidence': [
    {
      'question': 'Can I do yoga if I\'m not flexible?',
      'answer': 'Yes, of course\nSample text'
    },
    {'question': 'What does namaste mean?', 'answer': 'Lorem ipsum'},
    {
      'question': 'What are the benefits of yoga?',
      'answer':
          'Complete Beginners should start here. This bundle  will teach basic yoga poses to fill with energy and joy. Hop on your mat and start to build...'
    }
  ],
  'Amount': [
    {
      'question': 'How much do courses cost?',
      'answer': 'All of our courses are free'
    },
    {'question': 'Do you plan on adding pricing?', 'answer': 'Maybe'},
  ],
  'FAQ': [
    {
      'question': 'What is this app?',
      'answer':
          'Gymnastic Center is an app for teaching people how to bodybuild'
    },
  ]
};

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => FaqScreenState();
}

class FaqScreenState extends State<FaqScreen> {
  int _chipSelected = -1;

  @override
  Widget build(BuildContext context) {
    var isDarkMode = getIt<ThemesBloc>().isDarkMode;
    var contextWidth = MediaQuery.of(context).size.width;
    var contextHeight = MediaQuery.of(context).size.height;
    var selectedQuestions =
        _chipSelected >= 0 ? _faqCategories[_chipSelected] : '';
    List<Map<String, String>> questions = [];
    if (selectedQuestions.isEmpty) {
      _faqQuestions.forEach((key, value) {
        questions.addAll(value);
      });
    } else {
      questions = _faqQuestions[selectedQuestions]!;
    }

    var gradientChipUnselectedTextGradient = isDarkMode
        ? const LinearGradient(colors: [Color(0xffffffff), Color(0xffffffff)])
        : const LinearGradient(colors: [Color(0xff4f14a0), Color(0xff8066ff)]);
    var gradientChipSelectedTextGradient = isDarkMode
        ? const LinearGradient(colors: [Color(0xff4f14a0), Color(0xff8066ff)])
        : const LinearGradient(colors: [Color(0xffffffff), Color(0xffffffff)]);
    Either<Gradient, Color> gradientChipUnselectedBg = isDarkMode
        ? Either.right(const Color(0xff4E546A))
        : Either.left(const LinearGradient(
            colors: [Color(0x1f4f14a0), Color(0x1f8066ff)]));
    Either<Gradient, Color> gradientChipSelectedBg = isDarkMode
        ? Either.right(Colors.white)
        : Either.left(const LinearGradient(
            colors: [Color(0xff4f14a0), Color(0xff8066ff)]));

    var accordionRightArrowIconColor =
        isDarkMode ? Colors.white : const Color(0xff677294);
    var accordionSectionSeparatorColor =
        isDarkMode ? Colors.white : const Color(0x0f222222);
    return Scaffold(
        appBar: AppBar(
          title: const Text('We are happy to help'),
        ),
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
                padding: EdgeInsets.fromLTRB(contextWidth * 0.0417,
                    contextHeight * 0.0249, contextWidth * 0.0417, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Frequently Asked Questions',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: contextWidth * 0.05,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _faqCategories.map((e) {
                          var index = _faqCategories.indexOf(e);
                          return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: GradientChip(
                                  label: GradientText(
                                      textWidget: Text(e),
                                      gradient: _chipSelected == index
                                          ? gradientChipSelectedTextGradient
                                          : gradientChipUnselectedTextGradient),
                                  onTap: () {
                                    setState(() {
                                      _chipSelected = index;
                                    });
                                  },
                                  selected: _chipSelected == index,
                                  fill: gradientChipUnselectedBg,
                                  selectedFill: gradientChipSelectedBg));
                        }).toList(),
                      ),
                    ),
                    Accordion(
                        headerBackgroundColor: Theme.of(context).canvasColor,
                        contentBackgroundColor: Theme.of(context).canvasColor,
                        contentBorderColor: Theme.of(context).canvasColor,
                        contentBorderRadius: 0,
                        contentBorderWidth: 0,
                        headerBackgroundColorOpened:
                            Theme.of(context).canvasColor,
                        headerBorderColor: Theme.of(context).canvasColor,
                        headerBorderColorOpened: Theme.of(context).canvasColor,
                        headerBorderRadius: 0,
                        headerBorderWidth: 0,
                        paddingBetweenOpenSections: 0,
                        paddingBetweenClosedSections: 0,
                        rightIcon: Icon(Icons.keyboard_arrow_down,
                            color: accordionRightArrowIconColor, size: 20),
                        children: questions.map((e) {
                          return AccordionSection(
                              header: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color:
                                                  accordionSectionSeparatorColor,
                                              width: 1))),
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: contextHeight * 0.013),
                                      child: Text(e['question']!,
                                          style: TextStyle(
                                              fontSize:
                                                  contextWidth * 0.0444)))),
                              content: Container(
                                  width: double.infinity,
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    e['answer']!,
                                    style: TextStyle(
                                        fontSize: contextWidth * 0.0417),
                                    textAlign: TextAlign.start,
                                  )));
                        }).toList()),
                    Row(children: [
                      Expanded(
                          child: FilledButton(
                        onPressed: _chipSelected != -1
                            ? () {
                                setState(() {
                                  _chipSelected = -1;
                                });
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDarkMode
                              ? Colors.white
                              : const Color.fromARGB(255, 88, 27, 173),
                          padding: const EdgeInsets.symmetric(),
                        ),
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                0,
                                MediaQuery.of(context).size.height * 0.0192,
                                0,
                                MediaQuery.of(context).size.height * 0.0192),
                            child: GradientText(
                                textWidget: const Text('See all',
                                    style: TextStyle(fontSize: 20)),
                                gradient: LinearGradient(
                                    colors: isDarkMode
                                        ? ([
                                            const Color(0xff4f14a0),
                                            const Color(0xff8066ff),
                                          ])
                                        : ([
                                            Colors.white,
                                            Colors.white,
                                          ]),
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight))),
                      )),
                    ])
                  ],
                ))));
  }
}

/**
 * 
 */
