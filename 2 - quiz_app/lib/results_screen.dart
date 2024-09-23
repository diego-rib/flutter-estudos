import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(
      {super.key, required this.chosenAnswers, required this.resetGame});

  final List<String> chosenAnswers;
  final void Function() resetGame;

  List<Map<String, Object>> getSummaryData() {
    List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'questionIndex': i + 1,
        'question': questions[i].text,
        'correctAnswer': questions[i].answers[0],
        'selectedAnswer': chosenAnswers[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final totalQuestions = questions.length;
    final correctAnsweredQuestions = getSummaryData().where((data) {
      return data['correctAnswer'] == data['selectedAnswer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You answered $correctAnsweredQuestions out of $totalQuestions questions correctly!",
              style: GoogleFonts.dmSans(color: Colors.white, fontSize: 22),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            const Divider(
              color: Colors.white,
              thickness: 1,
            ),
            const SizedBox(height: 25),
            QuestionsSummary(getSummaryData()),
            const SizedBox(height: 30),
            TextButton(
              onPressed: resetGame,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.rotate_right),
                  Text('Restart Quiz'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
