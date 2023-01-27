import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:micartelera/models/models.dart';
class MovieSlider extends StatefulWidget {
  // const MovieSlider({Key? key}) : super(key: key);
  final List<Movie> movies;
  final String? title;
  final Function onNextPage;
  const MovieSlider({
    Key? key, 
    required this.movies, 
    required this.onNextPage,
    this.title
  }) : super (key: key)  ;
  @override
  State<MovieSlider> createState() => _MovieSliderState();
}
class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = new ScrollController();
  @override
  void initState() {
    scrollController.addListener(() {
      if ( scrollController.position.pixels >= scrollController.position.maxScrollExtent - 400 ) {
        widget.onNextPage();
      }
      // print( scrollController.position.pixels );
    });
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    getError(this.widget.movies.length);
    return Container(
      width: double.infinity,
      height: 260,
      color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          if ( this.widget.title != null )          
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text( this.widget.title!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
            ),
         
          Expanded(            
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (_, int index) { 

                 return _MoviesPoster(widget.movies[index], '${widget.title}-${index}-${widget.movies[index].id}');
              }   
            )
          )
        ],
      ),
    );
  }
}
class _MoviesPoster extends StatelessWidget {

  final Movie movie;
  final String heroId;
  const _MoviesPoster(this.movie, this.heroId);

  @override
  Widget build(BuildContext context) {
    movie.heroId = heroId;
    return Container(
      width: 130,
      height: 160,
      color: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [

          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  // image: NetworkImage('https://avatar.amuniversal.com/user_avatars/avatars_gocomicsver3/1241000/1241766/spongebob-300x400.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
                  width: 130,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
           SizedBox( height: 5, ),
           Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      )
    );
  }
}
getError(int valor) {
  print('este es el numero:  $valor');
}