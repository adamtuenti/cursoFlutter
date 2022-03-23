
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hello_adam/src/models/movie_item.dart';
import 'package:flutter_hello_adam/src/recursos/movie_api_provider.dart';
import 'package:flutter_hello_adam/src/ui/movie_detail.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  late MovieApiProvider api;


  @override
  void initState(){
    super.initState();
    api = new MovieApiProvider();
  }


  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas populares')
      ),
      body: FutureBuilder<MovieItem>(
        future: api.getMovieList(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return buildMovieGrid(snapshot);
            //
          }else if(snapshot.hasError){
            print(snapshot.error);
            return Text(snapshot.error.toString());
          }

          return Center(
            child: CircularProgressIndicator()
          );
        }
      )
    );
  }

  Widget buildMovieGrid(AsyncSnapshot<MovieItem> snapshot) {
    return GridView.builder(
      itemCount: snapshot.data!.results?.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7
      ),
      itemBuilder: (BuildContext context, int index){
        return GridTile(
          child: InkResponse(
            enableFeedback: true,
            child: Image.network('https://image.tmdb.org/t/p/w185${snapshot.data!.results![index]?.posterPath}', fit: BoxFit.cover),
              onTap: () => openDetailPelicula(snapshot.data!, index)
          ),



          //child: Text('${snapshot.data!.results![index]?.title}')
        );
      }
    );
  }

  openDetailPelicula(MovieItem data, int index){
    Navigator.push(context,
    MaterialPageRoute(builder: (context) {
      return MovieDetail(title: data.results![index].title,
          posterUrl: data.results![index].posterPath,
          description: data.results![index].description,
          releaseDate: data.results![index].releaseDate,
          voteAverage: data.results![index].voteAverage.toString(),
          movieId:1
      );
    })
    );

  }
}
