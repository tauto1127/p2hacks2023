import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_tutorial/state/hiru_state.dart';
import 'package:firebase_tutorial/view_model/single/hiru_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Hiru extends ConsumerWidget {
  const Hiru({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("昼ビルド: ${ref.read(hiruViewModelProvider)}");
    return Scaffold(
      // appBar: AppBar(title: TextButton(child: Text("更新"),onPressed: () async => ref.read(hiruViewModelProvider.notifier).initializePosts(),)),
      appBar: AppBar(title: TextButton(child: Text("更新"),onPressed: () async => ref.refresh(hiruViewModelProvider),)),
      body: ref.watch(hiruViewModelProvider).when(
        data: (HiruState data) {
          return ListView.builder(
            cacheExtent: 200,
            itemCount: data.postsOnlyMe.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Text(data.postsOnlyMe[index].nickname),
                  CachedNetworkImage(
                    placeholder: (context, url) => Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width * 4/3,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    imageUrl: data.postsOnlyMe[index].imageUrl.toString(),
                  ),
                  Text(data.postsOnlyMe[index].description),
                ],
              );
            },
          );
        },
        error: (_,__) => Text("errorが発生"), 
        loading: () => const Text("loading"),
      )
    );
  }
}