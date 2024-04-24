import 'package:final_project/models/movie_detail_model.dart';
import 'package:final_project/models/movie_model.dart';
import 'package:final_project/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailScreen extends StatefulWidget {
  final MovieModel movieModel;
  const DetailScreen({super.key, required this.movieModel});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MovieDetailModel> movieInfo;

  String calRuntime(String runtime) {
    int time = int.parse(runtime);
    int hours = time ~/ 60;
    int minutes = time % 60;
    return "$hours h $minutes min";
  }

  @override
  void initState() {
    super.initState();
    movieInfo = ApiService.getMovieById((widget.movieModel.id).toString());
  }

  @override
  Widget build(BuildContext context) {
    print(movieInfo);
    return FutureBuilder<MovieDetailModel>(
      future: movieInfo,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GestureDetector(
            onHorizontalDragEnd: (DragEndDetails details) {
              if (details.primaryVelocity!.isNegative) {
                // 사용자가 오른쪽에서 왼쪽으로 스와이프했을 때
                Navigator.pop(context);
              }
            },
            child: Scaffold(
              body: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  var posterPath =
                      "https://image.tmdb.org/t/p/w500${snapshot.data!.posterPath}";
                  double voteAverage =
                      (snapshot.data!.voteAverage / 2).toDouble();

                  return Container(
                    width: constraints.maxWidth, // LayoutBuilder의 전체 너비를 차지
                    height: constraints.maxHeight,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          posterPath,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: constraints.maxHeight * 0.1,
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                size: 22,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            const Text(
                              "Back to list",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.25,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 300,
                              child: Text(
                                snapshot.data!.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 34,
                                  fontWeight: FontWeight.w800,
                                ),
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            RatingBar.builder(
                              initialRating: voteAverage,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemSize: 32,
                              onRatingUpdate: (rating) {},
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          children: [
                            Text(
                              "${calRuntime(snapshot.data!.runtime)} | ${snapshot.data!.genres}",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 210, 206, 206),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Row(
                          children: [
                            Text(
                              "Storyline",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: constraints.maxWidth,
                          child: Center(
                            child: Text(
                              snapshot.data!.overview,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              softWrap: true,
                              maxLines: 8,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 52,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Really?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 100,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "Buy ticket",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
