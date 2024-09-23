import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatelessWidget {
  const Homepage(this.startQuiz, {super.key});

  final void Function() startQuiz;
  static double gapSize = 20;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/quiz-logo.png',
            width: 300,
            color: const Color.fromRGBO(255, 255, 255, 0.667),
          ),
          SizedBox(height: gapSize * 2),
          Text(
            'Learn Flutter the fun way!',
            style: GoogleFonts.lato(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          SizedBox(height: gapSize),
          ElevatedButton.icon(
            onPressed: startQuiz,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 68, 9, 141),
            ),
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Start Quiz'),
          )
        ],
      ),
    );
  }
}
