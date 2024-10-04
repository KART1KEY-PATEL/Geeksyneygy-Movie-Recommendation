import 'package:flutter/material.dart';
import 'package:geeksynergymovie/utils/color.dart';
import 'package:geeksynergymovie/utils/text_util.dart';

class MovieCard extends StatelessWidget {
  final Map<String, dynamic> movie;

  MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    final sH = MediaQuery.of(context).size.height;
    final sW = MediaQuery.of(context).size.width;
    return Card(
      color: AppColors.accentPrimaryColor,
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.arrow_drop_up,
                      size: sH * 0.04,
                      color: AppColors.whiteSVGColor,
                    ),
                    txt(
                      '${movie['voting']}',
                      size: sH * 0.02,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: sH * 0.04,
                      color: AppColors.whiteSVGColor,
                    ),
                    txt(
                      "Votes",
                    ),
                  ],
                ),
                SizedBox(
                  width: sW * 0.02,
                ),
                Container(
                  height: sH * 0.14,
                  width: sW * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(movie['poster']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Poster Image

                SizedBox(width: 10),
                // Movie details column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      txt(
                        movie['title'],
                        size: sH * 0.024,
                        weight: FontWeight.bold,
                      ),
                      // Genre, Director, Stars
                      txt('Genre: ${movie['genre']}'),
                      txt('Director: ${movie['director'].join(", ")}'),
                      txt(
                        'Starring: ${movie['stars'].join(", ")}',
                        maxLine: 1,
                      ),
                      txt(
                        '${movie['language']}',
                        maxLine: 1,
                      ),
                      txt(
                        '${movie['pageViews']} views | Voted by ${movie['totalVoted']} People',
                        color: const Color.fromARGB(255, 123, 145, 253),
                      ),
                      SizedBox(height: 8),
                      // Watch Trailer Button
                    ],
                  ),
                ),

                // Voting Section
              ],
            ),
            Container(
              width: sW * 0.9,
              child: ElevatedButton(
                onPressed: () {},
                child: txt(
                  'Watch Trailer',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
