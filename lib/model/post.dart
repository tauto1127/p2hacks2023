import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';

@freezed
class Post with _$Post {

  factory Post({
    required String poster,
    required String description,
    required Uri imageUrl,
    List? favoriteArray,
    DateTime? postDatetime,
    String? id,
  }) = _Post;
  
  factory Post.fromFirestore(
    DocumentSnapshot<Object?> snapshot,
  ) {
    final data = snapshot.data() as Map<String, dynamic>;
    String poster = data['poster'];
    if(poster == '') throw Exception("invalid poster");
    String description = data['description'];
    Uri url = Uri.parse(data['image_url']);
    
    //TODO favoriteの実装
    List favorites = data['favorite_array'] as List;

    Timestamp postTimestamp = data['post_datetime'];
    DateTime postDatetime = postTimestamp.toDate();

    //_post_datetime = data?['post_datetime'].toDate();
    postDatetime = DateTime.now();
    debugPrint("fromfirestore");

    return Post(
      poster: poster,
      description: description,
      imageUrl: url,
      favoriteArray: favorites,
      postDatetime: postDatetime,
      id: snapshot.id,
    );
  }
  
  /*
  Map<String, dynamic> toFirestore() {
    return {
      if (poster != null) "poster": poster,
      if (description != null) "description": description,
      if (favorite_array != null) "favorite_array": favorite_array,
      if (image_url != null) "capital": image_url,
      if (post_datetime != null) "population": post_datetime,
    };
  }*/
}