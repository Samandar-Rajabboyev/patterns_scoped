// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:patterns_scoped/scopes/home_scope.dart';
import 'package:scoped_model/scoped_model.dart';

import '../views/item_of_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeScope viewModel = HomeScope();

  @override
  void initState() {
    super.initState();
    viewModel.apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("setState"),
        ),
        body: ScopedModel<HomeScope>(
          model: viewModel,
          child: ScopedModelDescendant<HomeScope>(
            builder: (context, child, model) {
              return Stack(
                children: [
                  ListView.builder(
                    itemCount: model.items.length,
                    itemBuilder: (ctx, index) {
                      return itemOfPost(viewModel, model.items[index]);
                    },
                  ),
                  model.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const SizedBox.shrink(),
                ],
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          onPressed: () => viewModel.onCreatePost(context),
          child: const Icon(Icons.add),
        ));
  }
}
