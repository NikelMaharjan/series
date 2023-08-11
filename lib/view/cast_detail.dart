

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/common_widgets/loading_indicator.dart';
import 'package:movie/models/cast_detail.dart';
import 'package:movie/providers/cast_detail_provider.dart';
import 'package:movie/providers/cast_image_provider.dart';

class CastDetailPage extends ConsumerWidget {

  int id;

  CastDetailPage({required this.id});



  @override
  Widget build(BuildContext context, ref) {
    print(id);
    final castData = ref.watch(castDetailProvider(id));
    final castImages = ref.watch(castImageProvider(id));
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                castImages.when(
                    data: (data){
                      return SizedBox(
                        height: 300.h,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: data.length,
                            itemBuilder: (context, index){

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CachedNetworkImage(
                                imageUrl: data[index].file_path,
                                errorWidget: (c,t,r) => Image.asset('assets/images/image.png', fit: BoxFit.fitHeight,),
                                placeholder: (c, u) =>  Container(),
                              ),
                            );

                            }
                        ),
                      );
                    },
                    error: (e,s) => SizedBox(
                        height: 300.h,
                        child: Center(child: Text(e.toString()))),
                    loading: () =>  SizedBox(
                      height: 300.h,
                        child: LoadingIndicator())
                ),
                _buildCastDetails(castData),

              ],
            ),
          )

        ),

    );
  }

  Widget _buildCastDetails(AsyncValue<CastDetail> castData) {
    return castData.when(
                data: (data){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(data.name, style: const TextStyle(color: Colors.red),),
                        ),
                        Text(data.birthday, style: const TextStyle(color: Colors.red),),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(data.place_of_birth, style: const TextStyle(color: Colors.red),),
                        ),
                        Text(data.biography, style: const TextStyle(color: Colors.red),)
                      ],
                    ),
                  );
                },
                error: (e, s) => Center(child: Text(e.toString()),),
                loading: () => const Center(child: LoadingIndicator(),)
            );
  }
}
