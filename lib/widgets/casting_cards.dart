import 'package:flutter/material.dart';

class CastingCards extends StatelessWidget {
  // const CastingCards({Key? key}) : super(key: key);

  final int movieId;

  const CastingCards(
    this.movieId
    );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      width: double.infinity,
      height: 200,
      color: Colors.red,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: ( _ , int index) => _CastCard()

      ),
    );
  }
}

class _CastCard extends StatelessWidget {
  const _CastCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 150,
      color: Colors.green,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/150x4300'),
              height: 140,
              width: 100,
              fit: BoxFit.cover
            ),
          ),
          const SizedBox( height: 5, ),
          const Text(
            'actor.name este es el primer contenido',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      )

    );
  }
}

