import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:imdb/blocs/movies_bloc.dart';
import 'package:imdb/global/colors.dart';
import 'package:imdb/view/tiles/movie_list_tile.dart';
import 'package:imdb/view/widgets/header.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MoviesBloc>(context);
    bloc.inSearch.add("");

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: MainAppBar(),
      ),
      backgroundColor: colorGrayscale10,
      body: StreamBuilder(
          stream: bloc.outMovies,
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return ListView.builder(
                physics: ScrollPhysics(),
                padding: const EdgeInsets.all(2.0),               
                itemBuilder: (context, index) {
                  if (index < snapshot.data.length) {
                    return MovieListViewTile(snapshot.data[index]);
                  } else if (index > 1) {
                    bloc.inSearch.add(null);
                    return Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.yellow),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
                itemCount: snapshot.data.length + 1,
              );
            else
              return Container();
          }),
    );
  }
}
