import 'package:flutter/material.dart';
import 'package:shoppingapp/databasefolder/firestoredatabase.dart';

import 'model/product_model.dart';

class Search extends SearchDelegate<void> {
  Widget buildfeaturedrow(image , name , price){
    return Container(
      width: 100,
      height: 400,
      color: Colors.green,
      child: Column(
        children: [
          Container(
            height: 100,
            width: 400,
            child: Image.network(image),
          ),
          Text(name),
          Text(price)
        ],
      ),
    );
  }
  @override
  List<Widget>? buildActions(BuildContext context) {
  return [
    IconButton(onPressed: () {
      query = "";
    },
        icon: Icon(Icons.close))
  ];
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () {
      close(context, null);
    },
        icon: Icon(Icons.arrow_back)
    );
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Product> searchdatas = Databaseservices().searching(query);
    return GridView.count(
      childAspectRatio: 0.87,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: searchdatas.map((e) => buildfeaturedrow(e.image,
            e.name,
            e.price)
        ).toList(),
    );
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> searchdatas = Databaseservices().searching(query);
    return GridView.count(
      childAspectRatio: 0.87,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: searchdatas.map((e) => buildfeaturedrow(
          e.image,
          e.name,
          e.price)
      ).toList(),
    );
    throw UnimplementedError();
  }

}