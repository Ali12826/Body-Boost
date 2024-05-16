import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:workout_fitness_flutter_3_main/view/meal_plan/weekly_plan.dart';
import 'package:workout_fitness_flutter_3_main/view/sentimental_analysis/sentimental_analysis_screen.dart';
import '../../common/color_extension.dart';
import '../../common_widget/exercises_row.dart';
import '../../common_widget/round_button.dart';
//import '../sentiment_analysis/sentiment_analysis_page.dart';
import '../sentimental_analysis/sentimental_analysis_screen.dart'; // Import SentimentAnalysisPage

class WeeklyPlan extends StatelessWidget {
  final List<Map<String, dynamic>> dataArr = [
    {"name": "Running", "image": "assets/img/2.png"},
    {"name": "Push-Up", "image": "assets/img/3.png"},
    {"name": "Leg Extension", "image": "assets/img/5.png"}
  ];

  final List<Map<String, dynamic>> trainingDayArr = [
    {"name": "Monthly & Weekly Plan"},
    {"name": "Monthly & Weekly Plan"},
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.primary,
        centerTitle: true,
        elevation: 0.1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            "assets/img/black_white.png",
            width: 25,
            height: 25,
          ),
        ),
        title: Text(
          "Weekly Diet & Plan",
          style: TextStyle(
            color: TColor.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carousel for Exercises
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: SizedBox(
                width: media.width,
                height: media.width * 0.4,
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    autoPlay: false,
                    aspectRatio: 0.5,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    viewportFraction: 0.65,
                    enlargeFactor: 0.4,
                    enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  ),
                  itemCount: dataArr.length,
                  itemBuilder: (BuildContext context, int itemIndex, int index) {
                    var dObj = dataArr[index];
                    return buildExerciseContainer(dObj);
                  },
                ),
              ),
            ),

            // Carousel for Training Days
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                width: media.width,
                height: media.width * 1.1,
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    autoPlay: false,
                    aspectRatio: 0.6,
                    enlargeCenterPage: true,
                    viewportFraction: 0.85,
                    enableInfiniteScroll: false,
                    enlargeFactor: 0.4,
                    enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  ),
                  itemCount: trainingDayArr.length,
                  itemBuilder: (BuildContext context, int itemIndex, int index) {
                    var tObj = trainingDayArr[index];
                    return buildTrainingDayContainer(context, tObj, index);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildExerciseContainer(Map<String, dynamic> dObj) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: TColor.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              dObj["image"],
              width: double.maxFinite,
              height: double.maxFinite,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              dObj["name"],
              style: TextStyle(
                color: TColor.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTrainingDayContainer(
      BuildContext context, Map<String, dynamic> tObj, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: TColor.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            tObj["name"],
            style: TextStyle(
              color: TColor.secondaryText,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "week 1 to 4",
            style: TextStyle(
              color: TColor.secondaryText.withOpacity(0.8),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          ExercisesRow(
            number: "1",
            title: "Exercises 1 to 3",
            time: "7 Days",
            isActive: true,
            onPressed: () {},
          ),
          ExercisesRow(
            number: "2",
            title: "Exercises 2",
            time: "7 Days",
            onPressed: () {},
          ),
          const Spacer(),
          SizedBox(
            width: 150,
            height: 40,
            child: RoundButton(
              title: "Start",
              onPressed: () {
                // Navigate to SentimentAnalysisPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Weekly(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
