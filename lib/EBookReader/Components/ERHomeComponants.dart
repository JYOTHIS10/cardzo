import 'dart:ffi';
import 'dart:convert';
import 'package:Cardzo/EBookReader/BlocManagement/ERBloc.dart';
import 'package:Cardzo/EBookReader/DataManagement/ERData.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as ImageProcess;


final dbHelper = ERDBHelper.instance;

// Appbar
Widget eRHAppBar(Bloc bloc, List<EBookDetails> ebooks) => new AppBar(
      elevation: 1,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {},
      ),
      title: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Text(
            'EBook Reader',
            textAlign: TextAlign.center,
          )
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            bloc.importBook('assets/one.epub');
            bloc.importBook('assets/halo.epub');
            bloc.importBook('assets/And Then.epub');
          },
        ),
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            bloc.eBookDeleteAll().add(ebooks);
          },
        ),
      ],
    );

// Creating A Single Book Tile
Widget createBookTile(Bloc bloc, EBookDetails book) {
  return new Hero(
    tag: book.id,
    child: new Material(
      elevation: 15,
      shadowColor: Colors.blueGrey.shade900,
      child: new InkWell(
        onTap: () {
          bloc.openBook(book);
        },
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            book.imagePath == 'null'
                ? new Image.network(
                    'https://www.paygees.com/assets/default_book_cover-646413bf89a285d3c21caf3f2b27abbf22055916cd783fed7e40c8a35aee98b7.png',
                    fit: BoxFit.cover,
                    height: 120,
                  )
                : new Image.network(
                    'https://www.paygees.com/assets/default_book_cover-646413bf89a285d3c21caf3f2b27abbf22055916cd783fed7e40c8a35aee98b7.png',
                    fit: BoxFit.contain,
                    height: 120,
                  ),
            Text(
              book.title,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}

// Creating the GridView of Books
Widget createBooksGrid(Bloc bloc, List<EBookDetails> ebookslist) {
  return new CustomScrollView(
    primary: false,
    slivers: [
      new SliverPadding(
        padding: EdgeInsets.all(16),
        sliver: SliverGrid.count(
          crossAxisCount: 3,
          childAspectRatio: 2 / 3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: ebookslist
              .map<Widget>((book) => createBookTile(bloc, book))
              .toList(),
        ),
      )
    ],
  );
}
