import 'package:firebase_tutorial/model/user.dart';
import 'package:firebase_tutorial/view_model/multi/users_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_view_model.g.dart';

@Riverpod(keepAlive: true)
class UserViewModel extends _$UserViewModel {
  @override
  User build(){
    return User(
      email: "",
      nickname: "",
      iconUrl: Uri.parse(""),
      introduction: "",
    );
  }

  Future<void> registerUser(String email, String url, String introduction, String nickname)async{
    
    UsersRepository usersRepository = UsersRepository();
    await usersRepository.register(email, url, introduction, nickname);
    debugPrint("---------- logined ---------");
    debugPrint("email: $email, icon_url: $url, introduction: $introduction, nickname: $nickname");
    state = User(
      email: email,
      iconUrl: Uri.parse(url),
      introduction: introduction,
      nickname: nickname,
    );
  }

  void setUser(User user){
    debugPrint("---------- logined ---------");
    debugPrint("email: ${user.email}, icon_url: ${user.iconUrl}, introduction: ${user.introduction}, nickname: ${user.nickname}");
    state = user;
  }
  
  Future<void> changeIntroduction(WidgetRef ref, String introduction) async{
    UsersRepository usersRepository = UsersRepository();
    await usersRepository.changeIntroduction(ref, introduction);
    state = state.copyWith(
      introduction: introduction,
    );
  }
  
  Future<void> changeNickname(WidgetRef ref, String nickname) async {
    state = state.copyWith(
      nickname: nickname,
    );
  }
  /*
  Future<void> changeIntroduction(String introduction){

  }*/
}
