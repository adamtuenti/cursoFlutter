import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hello_adam/src/models/trailer_item.dart';
import 'package:flutter_hello_adam/src/recursos/movie_api_provider.dart';

class MovieDetail extends StatefulWidget {
  const MovieDetail({Key? key, this.posterUrl, this.description, this.releaseDate, required this.title, required this.voteAverage, required this.movieId}) : super(key: key);

  final posterUrl;
  final description;
  final releaseDate;
  final String title;
  final String voteAverage;
  final int movieId;

  @override
  _MovieDetailState createState() => _MovieDetailState(
    title: title,
    posterUrl: posterUrl,
    description: description,
    releaseDate: releaseDate,
    voteAverage: voteAverage,
    movieId: movieId
  );
}

class _MovieDetailState extends State<MovieDetail> {
  final posterUrl;
  final description;
  final  releaseDate;
  final String title;
  final String voteAverage;
  final int movieId;

  // ignore: unused_element
  _MovieDetailState({Key? key, this.posterUrl, this.description, this.releaseDate, required this.title, required this.voteAverage, required this.movieId});


  // ignore: prefer_typing_uninitialized_variables


  @override
  _MovieDetailState createState() => _MovieDetailState(
      title: title,
      posterUrl: posterUrl,
      description: description,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      movieId: movieId
  );
  @override
  Widget build(BuildContext context) {
    MovieApiProvider api = new MovieApiProvider();
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
            return <Widget>[
              SliverAppBar(
                expandedHeight: 250.0,
                elevation: 0.5,
                floating: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network('https://image.tmdb.org/t/p/w500${posterUrl}',
                  fit: BoxFit.cover),
                ),
              )
            ];
          },
          body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                )),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: Colors.yellow
                    ),
                    Text(
                      voteAverage,
                      style: TextStyle(
                        fontSize: 15
                      )
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 7.5)
                    ),
                    Text(
                      releaseDate,
                      style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic
                      )
                    )
                  ]
                ),
                Container(
                  margin: EdgeInsets.only(top: 7.5)
                ),
                Text(title),
                Container(
                  margin: EdgeInsets.only(top: 7.5)
                ),
                Text(
                  "Trailer",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold

                  ),
                ),
                FutureBuilder<TrailerItem>(
                  future: api.getVideos(movieId),
                  builder: (context, trailerSnapshot) {
                    if(trailerSnapshot.hasData){

                      return trailerLayout(trailerSnapshot.data);

                    }else{
                      return Center(child:
                      CircularProgressIndicator()
                      );
                    }

                  }
                )

              ],
              ),
          ),
      )
    )
    );
  }

  Widget trailerLayout(TrailerItem? data){

          if(data?.results!.length == 1){
            return Row(
                children: <Widget>[
                  trailerItemLayout(data, 0),
                  trailerItemLayout(data, 1)
                ]
            );

          }else{
            return Row(
                children: <Widget>[
                  trailerItemLayout(data, 0),
                ]
            );
          }




  }

  trailerItemLayout(TrailerItem? data, int i) {

    Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5.0),
          height: 115,
          color: Colors.grey,
          child: Center(
            child:
              IconButton(
                icon: Icon(Icons.play_circle_filled),
                onPressed: (){
                  _verVideo(data!.results![i].key, data!.results![i].site);
                }
              ),
          ),
        ),
        Text(
          data?.results![i].name,
          maxLines: 1,
          overflow: TextOverflow.fade,
        )
      ]
    )

  }

  void _verVideo(String key, String site){}


}
