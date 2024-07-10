import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/suscriptions/trending-progress/trending_progress_bloc.dart';
import 'package:gymnastic_center/domain/entities/suscription/course_progress.dart';
import 'package:gymnastic_center/presentation/widgets/suscriptions/course_circular_progress.dart';
import 'package:timeago/timeago.dart';

class TredingCourseProgressSummary extends StatelessWidget {
  final CourseProgress trendingCourseProgress;
  const TredingCourseProgressSummary(this.trendingCourseProgress, {super.key});

  @override
  Widget build(BuildContext context) {
    const height = 128.0;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<TrendingProgressBloc, TrendingProgressState>(
      builder: (context, state) {
        if ( state.status == TrendingProgressStatus.loading){
          return const SizedBox(
            width: double.infinity,
            height: height,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return InkWell(
          onTap: () {
            if (trendingCourseProgress.courseId == '') return ; 
            context.push('/course/${trendingCourseProgress.courseId}/no-lesson');
          },
          child: Container(
            padding: const EdgeInsets.all(18),
            height: height,
            width: width,
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      SizedBox(
                        width: width * 0.6,
                        child: Text(
                          (trendingCourseProgress.courseTitle == '')
                          ? 'Get Started now!'
                          : trendingCourseProgress.courseTitle,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: textTheme.titleLarge!.color,
                            fontSize: textTheme.titleLarge!.fontSize  ,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.6,
                        child: Text(
                          (trendingCourseProgress.courseTitle == '')
                          ? 'Discover courses for a healthier body!'
                          : 'Last Update ${format(trendingCourseProgress.lastTime, locale: 'en').replaceFirst('about', '')}',
                          overflow: TextOverflow.clip,
                        ),
                      ),
                  ],
                ),
                const Spacer(),
                if (trendingCourseProgress.courseTitle == '')
                Image.asset(
                  'assets/icon/trending_course_empty.png',
                  width: 96,
                  height: 961,
                )
                else CourseCirularProgress(percent: trendingCourseProgress.percent),
              ],
              
            ),
          ),
        );
      },
    );
  }
}
