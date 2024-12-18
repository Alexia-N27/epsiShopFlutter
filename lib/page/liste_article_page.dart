import 'package:epsi_shop/cart.dart';
import 'package:flutter/material.dart';
import 'package:epsi_shop/article.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:provider/provider.dart';




class ListeArticlePage extends StatelessWidget {
  final List<Article> listArticle;
  const ListeArticlePage({super.key, required this.listArticle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('EPSI_shop'),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Text(context.watch<Cart>().getAll().length.toString())
          )
        ],
      ),
      body: FutureBuilder<List<Article>>(
        future: fetchListArticle(),
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data != null) {
            return ListArticles(listArticle: snapshot.data!);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const CircularProgressIndicator();
          }
        }
      )
    );
  }

  Future<List<Article>> fetchListArticle() async {
    // Récupérer kes données depuis fakestore api
    final res = await get(Uri.parse("https://fakestoreapi.com/products"));
    if (res.statusCode == 200) {
      // Les transformer en Listes d'articles
      final listMapArticles = jsonDecode(res.body) as List<dynamic>;
      return listMapArticles.map((map) =>
        Article(
          map["title"],
          map["description"],
          map["price"],
          map["image"],
          map["category"],
        )
      ).toList();
    }
    // Les renvoyer
    return Future.error("Connexion impossible");
  }
}

class ListArticles extends StatelessWidget {
  final List<Article> listArticle;
  const ListArticles({
    super.key,
    required this.listArticle
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listArticle.length,
      itemBuilder: (ctx, index)=> ListTile(
        onTap: () => ctx.go("/detail", extra: listArticle[index]),
        leading: Image.network(
          listArticle[index].image,
          height: 80,
          width: 80,
        ),
        title: Text(listArticle[index].nom),
      )
    );
  }
}
