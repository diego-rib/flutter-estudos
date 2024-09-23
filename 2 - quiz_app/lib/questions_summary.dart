import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((data) {
            var questionIndex = data['questionIndex'];
            var questionText = data['question'];
            var userAnswer = data['selectedAnswer'];
            var correctAnswer = data['correctAnswer'];

            Color circleColor = correctAnswer == userAnswer
                ? const Color.fromARGB(255, 0, 255, 34)
                : const Color.fromARGB(255, 202, 124, 247);

            return (Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: circleColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Center(
                    child: Text(
                      "$questionIndex",
                      style: const TextStyle(
                        color: Color.fromRGBO(48, 6, 99, 1),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$questionText",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "$userAnswer",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 202, 124, 247),
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "$correctAnswer",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 0, 255, 34),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ));
          }).toList(),
        ),
      ),
    );
  }
}
