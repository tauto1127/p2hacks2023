import 'dart:io';

import 'package:firebase_tutorial/model/prePost.dart';
import 'package:firebase_tutorial/state/add_post/add_post_state.dart';
import 'package:firebase_tutorial/view_model/multi/posts_repository.dart';
import 'package:firebase_tutorial/view_model/multi/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_post_viewmodel.g.dart';

@riverpod
class AddPostViewModel extends _$AddPostViewModel {
  @override
  AddPostState build(){
    return AddPostState();
  }
  
  void addFile(File file){
    state = state.copyWith(file: file);
  }

  Future<void> addPost(PrePost post, WidgetRef ref)async {
    PostsRepository postsRepository = PostsRepository();
    postsRepository.addPost(
      PrePost(
        poster: ref.watch(userViewModelProvider).email,
        description: post.description,
      ),
      ref.watch(addPostViewModelProvider).file!,
      ref.watch(userViewModelProvider).nickname,
      ref.watch(userViewModelProvider).iconUrl.toString(),
    );
  }
  
  void changeIsUploading(bool isUploading){
    state = state.copyWith(uploading: isUploading);
  }

  /*
  void addUser(String email, String url, String introduction, String name, String nickname){
    UsersRepository usersRepository = UsersRepository();
    usersRepository.register(email, url, introduction, nickname);
  }*/
  /*
  Future<void> changeIntroduction(String introduction){

  }*/
}