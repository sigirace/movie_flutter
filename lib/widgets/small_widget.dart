import 'package:final_project/models/movie_model.dart';
import 'package:final_project/screens/detail_screen.dart';
import 'package:flutter/material.dart';

class RunningWidget extends StatelessWidget {
  static const imageUrl = "https://image.tmdb.org/t/p/w500/";
  final MovieModel movieModel;
  const RunningWidget({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(movieModel: movieModel),
              ),
            );
          },
          child: Container(
            width: 200,
            height: 200,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  blurRadius: 7,
                  offset: const Offset(10, 10),
                  color: Colors.black.withOpacity(0.6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                "$imageUrl${movieModel.backdropPath}",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        SizedBox(
          width: 200,
          child: Center(
            child: Text(
              movieModel.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
