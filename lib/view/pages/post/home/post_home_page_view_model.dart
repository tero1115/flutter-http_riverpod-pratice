import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_riverpod_app/model/post/post.dart';

// 창고 관리자 (Provider)
final postHomePageProvider = StateNotifierProvider<PostHomePageViewModel, PostHomePageModel?>((ref) {
  return PostHomePageViewModel(null);
});

// 창고 (Store)
class PostHomePageViewModel extends StateNotifier<PostHomePageModel?>{
  PostHomePageViewModel(super.state);

  void init(List<Post> postDtoList){
    state = PostHomePageModel(posts: postDtoList);
  }

  void add(Post post) {
    List<Post> posts = state!.posts;
    // posts.add(post);
    List<Post> newPosts = [...posts, post];  // 추가, 삭제, 수정
    state = PostHomePageModel(posts: newPosts); // 레퍼런스가 달라지면 된다 (값이 동일해도 다시 그린다)
  }

  void remove(int id) {
    List<Post> posts = state!.posts;
    // 검색과 삭제
    List<Post> newPosts = posts.where((e) => e.id != id).toList();
    state = PostHomePageModel(posts: newPosts);
  }

  void update(Post post){
    List<Post> posts = state!.posts;
    List<Post> newPosts = posts.map((e)=> e.id == post.id ? post : e).toList();
    state = PostHomePageModel(posts: newPosts);
  }
}

// 창고 데이터
class PostHomePageModel {
  List<Post> posts;
  PostHomePageModel({required this.posts});
}