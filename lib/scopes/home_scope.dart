import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

import '../model/post_model.dart';
import '../pages/create_or_update_post.dart';
import '../services/http_service.dart';

class HomeScope extends Model {
  bool isLoading = false;
  List<Post> items = [];

  Future<bool> apiPostList() async {
    isLoading = true;
    notifyListeners();
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null) {
      items = Network.parsePostList(response);
    } else {
      items = [];
    }
    isLoading = false;
    notifyListeners();
    return response != null;
  }

  Future<bool> apiPostDelete(Post post) async {
    isLoading = true;
    notifyListeners();
    var response = await Network.DEL(Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
    if (response != null) {
      apiPostList();
    }
    isLoading = false;
    notifyListeners();
    return response != null;
  }

  Future<bool> apiPostCreate(Post post) async {
    isLoading = true;
    notifyListeners();
    var response = await Network.POST(Network.API_CREATE, Network.paramsCreate(post));
    if (response != null) {
      apiPostList();
    }
    isLoading = false;
    notifyListeners();
    return response != null;
  }

  Future<bool> apiPostUpdate(Post post) async {
    isLoading = true;
    notifyListeners();
    var response = await Network.PUT(Network.API_UPDATE + post.id.toString(), Network.paramsUpdate(post));
    if (response != null) {
      apiPostList();
    }
    isLoading = false;
    notifyListeners();
    return response != null;
  }

  onCreatePost(BuildContext context) async {
    await openDialog(context, type: DialogType.create).then((post) {
      if (post != null) apiPostCreate(post);
    });
  }

  onUpdatePost(BuildContext context, Post post) async {
    await openDialog(context, type: DialogType.update, post: post).then((post) {
      if (post != null) apiPostUpdate(post);
    });
  }
}
