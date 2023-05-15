import 'package:cached_network_image/cached_network_image.dart';
import 'package:explore_flutter/model/movie.dart';
import 'package:explore_flutter/model/movies_list.dart';
import 'package:flutter/material.dart';
import 'package:explore_flutter/network/movies_service.dart';

class Movies extends StatefulWidget {
  const Movies({super.key});

  @override
  State<StatefulWidget> createState() => MoviesState();
}

class MoviesState extends State<Movies> {
  late Future<MoviesList> futureMovies;

  @override
  void initState() {
    super.initState();
    MoviesService api = MoviesService();
    futureMovies = api.fetchPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: const Color(0XFFD3D3D3),
        appBar: AppBar(
          backgroundColor: const Color(0XFF595A5C),
          title: const Text('Fetch Movies'),
        ),
        body: Center(
          child: FutureBuilder<MoviesList>(
            future: futureMovies,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.data != null &&
                  snapshot.data?.results != null) {
                return movieList(snapshot.data?.results);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Widget movieList(List<Movie>? results) {
    if (results != null && results.isNotEmpty) {
      return ListView.separated(
        padding: const EdgeInsets.all(8),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: results.length,
        itemBuilder: (c, index) {
          return listItem(results[index]);
        },
      );
    } else {
      return const Text('No Data!! Try again Later');
    }
  }

  Widget backCard(Movie movie) {
    return Center(
      child: Card(
          color: const Color(0XFFE8E8E8),
          elevation: 4,
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(140, 20, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  movie.title!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${movie.voteAverage}/10',
                  style: const TextStyle(
                    color: Color(0xFFffbc03),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(movie.overview!,
                    maxLines: 3,
                    style: const TextStyle(
                        fontSize: 14, fontStyle: FontStyle.italic),
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          )),
    );
  }

  Widget frontCard(Movie movie) {
    return Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 8,
        margin: const EdgeInsets.all(10),
        child: SizedBox(
          width: 120,
          height: 180,
          child: CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/original${movie.posterPath!}',
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ));
  }

  Widget listItem(Movie movie) => Stack(
        children: <Widget>[
          backCard(movie),
          frontCard(movie),
        ],
      );
}
