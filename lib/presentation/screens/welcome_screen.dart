import 'package:flutter/material.dart';
import 'package:gymnastic_center/infrastructure/local_storage/local_storage.dart';
import 'package:gymnastic_center/presentation/widgets/welcome_screen/welcome_screen_next_button.dart';
import 'package:gymnastic_center/presentation/widgets/welcome_screen/welcome_screen_page.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen(
      {super.key, this.onPressSkip, this.onPressNextInLastPage});

  final void Function()? onPressSkip;
  final void Function()? onPressNextInLastPage;

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  int pageCount = 0;
  int selectedIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  List<Widget> pages = [];

  void initializePages() {
    pages = [
      const WelcomeScreenPage(
          svgPictureAssetLocation: 'assets/welcome/yoga1.svg',
          gradientText: 'Yoga',
          titleText: 'Daily Yoga',
          descriptionText:
              'Do your practice of physical exercise and relaxation make healthy'),
      const WelcomeScreenPage(
          svgPictureAssetLocation: 'assets/welcome/yoga2.svg',
          gradientText: 'Meditation',
          titleText: 'Yoga Classes',
          descriptionText:
              'Meditation is the key to Productivity.\nHappiness & Longevity'),
      const WelcomeScreenPage(
          svgPictureAssetLocation: 'assets/welcome/yoga3.svg',
          gradientText: 'Meets',
          titleText: 'Community',
          descriptionText:
              'Do your practice of physical exercise and relaxation make healthy'),
    ];
  }

  @override
  void initState() {
    initializePages();
    pageController = PageController(initialPage: 0);
    pageCount = pages.length;

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LocalStorageService().getValue<bool>('initialized').then((value) {
      if (value != null && value) widget.onPressSkip?.call();
    });
    final colors = Theme.of(context).colorScheme;

    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colors.background,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.78,
            child: PageView.builder(
                controller: pageController,
                itemCount: pageCount,
                onPageChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                itemBuilder: (_, pageIndex) {
                  return pages[pageIndex];
                }),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.14,
            child: Align(
                alignment: Alignment.topCenter,
                child: WelcomeScreenNextButton(
                    onClickFunction: nextPressedCallback)),
          ),
          const Divider(
            color: Color.fromRGBO(0, 0, 0, 0.07),
            thickness: 0,
            height: 1,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08 - 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: skipPressedCallback,
                    child: Text(
                      'Skip',
                      style: TextStyle(
                          color: isDarkMode
                              ? Colors.white
                              : const Color(0xff677294),
                          fontSize: 16),
                    )),
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: pageCount,
                  padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                  itemBuilder: (_, index) {
                    return Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: (selectedIndex == index
                                ? (isDarkMode
                                    ? const Color(0xffbdbdbd)
                                    : const Color(0xff222222))
                                : (isDarkMode
                                    ? Colors.white
                                    : const Color(0xff677294)))),
                        margin: const EdgeInsets.all(5),
                        width: 5,
                        height: 5,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void animateToNextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  void lastPageCallback() {
    LocalStorageService().setKeyValue('initialized', true);
    widget.onPressNextInLastPage?.call();
  }

  void nextPressedCallback() {
    if (selectedIndex == pageCount - 1) {
      lastPageCallback();
    } else {
      animateToNextPage();
    }
  }

  void skipPressedCallback() {
    LocalStorageService().setKeyValue('initialized', true);
    widget.onPressSkip?.call();
  }
}
