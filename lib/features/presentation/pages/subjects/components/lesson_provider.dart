import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ixl/features/presentation/pages/subjects/models/lesson.dart';

class LessonProvider extends ChangeNotifier {
  List<Lesson> lessonTopics = [
    Lesson(
      title: 'Add and subtract whole numbers',
      isExpanded: false,
      category: 'math',
      items: [
        LessonItem(subtitle: 'Add and subtract whole numbers', score: 83),
        LessonItem(subtitle: 'Add and subtract whole numbers: word problems', score: 76),
      ],
    ),
    Lesson(
      title: 'Multiply whole numbers',
      isExpanded: false,
      category: 'Language',
      items: [
        LessonItem(subtitle: 'Multiply whole numbers', score: 0),
        LessonItem(subtitle: 'Multiply whole numbers: words problems', score: 0),
        LessonItem(subtitle: 'Multiply numbers ending in zeros', score: 0),
        LessonItem(subtitle: 'Multiply numbers ending in zeros: word problems', score: 0),
        LessonItem(subtitle: 'Estimate products', score: 0),
      ],
    ),
  ];

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  List<Lesson> foundLessons = [];

  void init() {
    foundLessons = lessonTopics;
    print('init');
  }

  List<Lesson> get lessons => foundLessons;
  String _searchString = "";

  void changeSearchAndFilterString2(String searchString) {
    _searchString = searchString;
    notifyListeners();
  }

  void runFilter(String category) {
    List<Lesson> results = [];
    if (category.isEmpty) {
      results = lessonTopics;
    } else {
      results = lessonTopics
          .where((lesson) =>
              lesson.category.toLowerCase().contains(category.toLowerCase()))
          .toList();
    }

    foundLessons = results;
    notifyListeners();
  }

  void runSearch(String enteredKeyword) {
    List<Lesson> results = [];
    if (enteredKeyword.isEmpty) {
      results = lessonTopics;
    } else {
      results = lessonTopics
          .where((lesson) =>
              lesson.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    foundLessons = results;
    notifyListeners();
  }
}

class LessonList extends StatelessWidget {
  final List<Lesson> lessonList;
  const LessonList({super.key, required this.lessonList});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: lessonList.map((lesson) {
        return LessonsWidget(
          lesson: lesson,
          onExpansionChanged: (bool expanded) {
              lesson.isExpanded = expanded;
          },
          titleColor: LessonProvider().getRandomColor(),
        );
      }).toList(),
    );
  }
}

class LessonsWidget extends StatelessWidget {
  final Lesson lesson;
  final ValueChanged<bool> onExpansionChanged;
  final Color titleColor; // New property for title color

  LessonsWidget({
    required this.lesson,
    required this.onExpansionChanged,
    required this.titleColor, // Initialize title color
  });

  @override
  Widget build(BuildContext context) {
    Color randomColor = LessonProvider().getRandomColor();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 187, 187, 187)), // Set border properties here
        borderRadius: BorderRadius.all(Radius.circular(8)), // Optional: Set border radius
      ),
      child: ExpansionTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: randomColor,
          child: Text(
            lesson.title![0].toUpperCase(),
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          lesson.title,
          style: TextStyle(
            color: randomColor,
            fontSize: 18,
            fontWeight: FontWeight.bold
            ),
        ),
        initiallyExpanded: lesson.isExpanded,
        onExpansionChanged: onExpansionChanged,
        children: [
          Divider( // Add Divider here
            color: Colors.grey,
            thickness: 1,
          ),
          ...lesson.items.map((item) => ScoreItemWidget(item: item)).toList(),
        ],
      ),
    );
  }
}

class ScoreItemWidget extends StatelessWidget {
  final LessonItem item;

  ScoreItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.subtitle),
      trailing: Text('${item.score}/100'),
    );
  }
}


    
























