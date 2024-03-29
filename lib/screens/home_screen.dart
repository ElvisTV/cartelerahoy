import 'package:flutter/material.dart';
import 'package:micartelera/providers/movies_provider.dart';
import '../search/search_delegate.dart';
import 'package:micartelera/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'package:admob_flutter/admob_flutter.dart';
import 'dart:io';
import '../share_preferences/preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  AdmobBannerSize? bannerSize;
  late AdmobInterstitial interstitialAd;
  late AdmobReward rewardAd;

    @override
  void initState() {
    super.initState();
    rewardAd = AdmobReward(
      adUnitId: getRewardBasedVideoAdUnitId()!,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) rewardAd.load();
        handleEvent(event, args, 'Reward');
      },
    );
    rewardAd.load();
  }

  
  void handleEvent(
    AdmobAdEvent event, Map<String, dynamic>? args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        // showSnackBar('New Admob $adType Ad loaded!');
        showSnackBar('Bienvenido a PelisHoy');
        break;
      case AdmobAdEvent.opened:
        // showSnackBar('Admob $adType Ad opened!');
        showSnackBar('Gracias por ganar estrellas');
        break;
      case AdmobAdEvent.closed:
        showSnackBar('Sigue ganando estrellas');
        break;
      case AdmobAdEvent.failedToLoad:
        // showSnackBar('Admob $adType failed to load. :(');
        showSnackBar('PelisHoy se actualizará');

        break;
      case AdmobAdEvent.rewarded:
        showDialog(
          context: scaffoldState.currentContext!,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () async {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                return true;
              },
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Reward callback fired. Thanks Andrew!'),
                    Text('Type: ${args!['type']}'),
                    Text('Amount: ${args['amount']}'),
                  ],
                ),
              ),
            );
          },
        );
        break;
      default:
    }
  }

  void showSnackBar(String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        duration: Duration(milliseconds: 1500),
      ),
    );
  }

  int _counter = 0;
  int _almancenado = Preferences.estrellasGanadas;  

  void _incrementCounter() {
    setState(() {
      // _counter++;
      // Preferences.estrellasGanadas = Preferences.estrellasGanadas + _counter;
      Preferences.estrellasGanadas ++;
      _almancenado = Preferences.estrellasGanadas;
    });
  }

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    getmuestra(moviesProvider.popularMovies.length.toInt());

    return Scaffold(
        appBar: AppBar(
          title: const Text('Catalogo de Películas'),
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.search_outlined),
              onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate())
            )
          ]
        ),
        body: SingleChildScrollView(
            child: Column(
              children: [               
                //Tarjetas principales
                CardSwiper(movies: moviesProvider.OnDisplayMovies),
                  Text(
                  'Estrellas Ganadas',
                  style: TextStyle(
                    fontSize: 20, 
                    fontStyle: FontStyle.normal,
                    color: Color.fromARGB(255, 255, 0, 0)
                  )
                ),
                Text(
                  // '$_counter',
                  '$_almancenado',
                  style: TextStyle(
                    fontSize: 20, 
                    fontStyle: FontStyle.normal,
                    color: Color.fromARGB(255, 140, 0, 255)
                  )
                ),
                Row(         
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,         
                  children: <Widget>[    
                    Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 255, 183, 0),
                      size: 30,          
                    ),    
                    Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 255, 183, 0),
                      size: 50,  
                                      
                    ),
                    Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 255, 183, 0),
                      size: 30,                  
                    ),
                  ],
                  
                ),
                
                //Slider de Peliculas
                MovieSlider(
                  movies: moviesProvider.popularMovies,
                  title: 'Populares',
                  onNextPage: () => moviesProvider.getPopularMovies()
                ),

              ],
        )
      ),
       bottomNavigationBar: Builder(
            builder: (BuildContext context) {
              return Container(
                color: Color.fromARGB(255, 228, 13, 13),
                child: SafeArea(
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[                        
                        Expanded(
                          child: TextButton(
                           onPressed: () async {
                              if (await rewardAd.isLoaded) {
                                rewardAd.show();
                                _incrementCounter();
                              } else {
                                showSnackBar('Reward ad is still loading...');
                              }
                            },
                            child: Text(
                              'Ver Anuncios',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ),
              );
            },
          )
    );
  }
}

String? getRewardBasedVideoAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544/1712485313';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-9639991028205856/4389361059';
  }
  return null;
}

getmuestra(int valor) {
  print('aquí es del home: $valor');
}