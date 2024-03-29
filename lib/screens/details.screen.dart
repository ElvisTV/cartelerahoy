import  'package:flutter/material.dart';
import 'package:micartelera/widgets/widgets.dart';

import '../models/models.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  
  @override
  Widget build(BuildContext context) {

    // Por Hacer: Cambiar luego por una instancia de movie

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    print('elvis '+movie.title);

   return   Scaffold(
      body: CustomScrollView  (
        slivers: [
          _CustomAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(movie),
              _Overview(movie),
              _Overview(movie),
              _Overview(movie),              
              CastingCards(movie.id),
            ]
               
            )
          )
        ],    
      )
    );        
  }
}

class _CustomAppBar extends StatelessWidget {
  
  final Movie movie;

  const _CustomAppBar( this.movie );

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          // color: const Color.fromARGB(246, 183, 9, 84),
          padding: EdgeInsets.only( bottom: 10, left: 10, right: 10 ),
          child:  Text(
            movie.title,
            style: TextStyle( fontSize: 16 ),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullBackdropPath),
          // image: NetworkImage('assets/loading.gif'),
          fit: BoxFit.cover,
        ),

      ),
    );
  }
}
  

class _PosterAndTitle extends StatelessWidget {
  // const _PosterAndTitle({Key? key}) : super(key: key);

  final Movie movie;

  const _PosterAndTitle(this.movie);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return  Container(
      margin: const EdgeInsets.only(top:20),
      padding: const EdgeInsets.symmetric( horizontal: 20 ) ,
      child: Row(
        children: [
          Hero(
            tag: movie.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child:  FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                height: 150,
                width: 110,
              ),
            ),
          ),
          SizedBox( width: 20, ),

          ConstrainedBox(
            constraints: BoxConstraints( maxWidth: size.width - 190 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title, 
                  style: textTheme.headline5, 
                  overflow: TextOverflow.ellipsis, 
                  maxLines: 2, 
                ),
                
                Text(
                  movie.originalTitle, 
                  style: textTheme.subtitle1, 
                  overflow: TextOverflow.ellipsis, 
                  maxLines: 2, 
                ),
          
                Row(
                  children: [
                    Icon( Icons.star_outline, size: 15, color: Colors.grey ),
                    SizedBox(width: 5,),
                    Text('${movie.voteAverage}', style:  Theme.of(context).textTheme.caption )
          
                  ],
                )
          
              ],
            ),
          )
        ],
      )
    );
  }
}


class _Overview  extends StatelessWidget {
  // const _Overview ({Key? key}) : super(key: key);

  final Movie movie;
  const _Overview(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1

      ),
    );
  }
}











