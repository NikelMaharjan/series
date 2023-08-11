

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie/common_widgets/loading_indicator.dart';
import 'package:movie/providers/genre_provider.dart';

import 'detail_page.dart';

class GenrePage extends ConsumerWidget {


  int id;
  GenrePage(this.id);


  @override
  Widget build(BuildContext context, ref) {
    print("id is $id");
    final data = ref.watch(genreProvider(id));
    return SafeArea(
      child: Scaffold(
        body: data.when(
            data: (data){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: data.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 10,
                        childAspectRatio: 3 / 5.5
                    ),
                    itemBuilder: (context, index) {
                      final series = data[index];
                      return InkWell(
                        onTap: () {
                          print(series.id);
                          Get.to(DetailPage(series),
                              transition: Transition.leftToRight);
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CachedNetworkImage(
                                  errorWidget: (context, url, child) =>
                                      Image.asset('assets/images/image.png', fit: BoxFit.fitHeight,),
                                  imageUrl: series.poster_path,
                                  fit: BoxFit.fitWidth,
                                  height: 260.h,
                                  width: 180.w,
                                  placeholder: (context, url) => const Center(child: LoadingIndicator()),

                                ),


                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8),
                                  child: Text(series.name,
                                    overflow: TextOverflow.ellipsis,),
                                ),

                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star, color: Colors.red,),
                                    const SizedBox(width: 6,),
                                    Text(series.vote_average),
                                  ],
                                ),


                              ],
                            )),
                      );
                    }
                ),
              );
            },
            error: (e, s) => Center(child: Text(e.toString()),),
            loading: () => const LoadingIndicator()
        )

      ),
    );
  }
}
