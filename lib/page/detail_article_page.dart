import 'package:epsi_shop/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailArticlePage extends StatelessWidget {
  const DetailArticlePage({super.key, required this.article});
  final article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Détail"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: (){},
            icon: Text(context.watch<Cart>().getAll().length.toString())
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: const Color(0xFFEBEBEB),
              child: Image.network(
                  article.image,
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      article.nom,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Text(
                    article.prixEuro(),
                    style: Theme.of(context).textTheme.bodyLarge
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 12.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Catégorie : ${article.categorie}",
                    ),
                  ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                article.description,
                textAlign: TextAlign.start,
              ),
            ),
            OutlinedButton(onPressed: (){
              context.read<Cart>().add(article);
            }, child: const Text("Ajouter au panier"))
          ],
        ),
      ),
    );
  }

  Future<bool> wait5Seconds() async {
    await Future.delayed(const Duration(seconds: 5));
    return true;
  }
}
