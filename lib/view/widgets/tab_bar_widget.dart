import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/instance_manager.dart';
import 'package:movie/common_widgets/loading_indicator.dart';
import 'package:movie/models/series.dart';
import 'package:movie/providers/search_provider.dart';
import 'package:movie/providers/series_provider.dart';
import 'package:get/get.dart';
import 'package:movie/view/detail_page.dart';






class TabBarWidget extends StatelessWidget {





  final bool isSearchPage;

  TabBarWidget(this.isSearchPage);

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
        child: Container(),
        connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
        ) {

          final bool connected = connectivity != ConnectivityResult.none;
          return Consumer(
              builder: (context, ref, child) {


                final seriesData = isSearchPage ? ref.watch(searchProvider) : ref.watch(seriesProvider);

                if (seriesData.isLoad) {
                  return  const Center(child: LoadingIndicator(),);
                }

                else if (seriesData.errText.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NotificationListener(
                      onNotification: (ScrollNotification notification){
                        final before = notification.metrics.extentBefore;
                        final max = notification.metrics.maxScrollExtent;
                        if (before == max) {
                          if(connected && !isSearchPage) ref.read(seriesProvider.notifier).loadMore();
                        }
                        return true;

                      },
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: seriesData.series.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 10,
                              childAspectRatio: 3 / 5.5
                          ),
                          itemBuilder: (context, index) {
                            final series = seriesData.series[index];
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
                                         Text(series.vote_average.substring(0,1)),
                                        ],
                                      ),


                                    ],
                                  )),
                            );
                          }
                      ),
                    ),
                  );
                }

                else {
                  if(seriesData.errText == 'No Internet.' && !isSearchPage){

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(connected ? 'connection on' : 'no connection', style: TextStyle(
                          fontSize: 20, color: connected ? Colors.green : Colors.red
                        ),),

                        OutlinedButton(onPressed: (){
                          ref.read(seriesProvider.notifier).refresh();

                         }, child: const Text("Reload", style: TextStyle(color: Colors.red),))

                    ],
                    );

                  }
                  else
                    {
                      return Center(child: Text(seriesData.errText),);
                    }
                }
              }
          );
        }
    );
  }
}