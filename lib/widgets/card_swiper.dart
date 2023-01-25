import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

import '../models/models.dart';


class CardSwiper extends StatelessWidget {  

  final List<Movie> movies;

  const CardSwiper({super.key, required this.movies});

  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    if( this.movies.length == 0 ) {
      return Container(
        width: double.infinity,
        height: size.height,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }


    return Container(
      width: double.infinity,
      height: 500,
      color: Colors.green,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: ( _ , int index ) {

          final  movie = movies[index];
          // elvis();
          // print(movie.fullPosterImg);
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                // image: NetworkImage('https://via.placeholder.com/300x400'),
                image: NetworkImage( movie.fullPosterImg ),
                fit: BoxFit.cover
              ),
            ),
          );
        }
      )
    );
  }
}

elvis() {
  print('peru campeon');
}