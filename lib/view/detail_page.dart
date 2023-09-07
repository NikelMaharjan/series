




import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie/common_widgets/loading_indicator.dart';
import 'package:movie/models/seasons.dart';
import 'package:movie/models/series.dart';
import 'package:movie/providers/cast_provider.dart';
import 'package:movie/providers/recommendation_provider.dart';
import 'package:movie/providers/season_provider.dart';
import 'package:movie/providers/video_provider.dart';
import 'package:movie/view/cast_detail.dart';
import 'package:movie/view/genre_detail.dart';
import 'package:movie/view/season_details.dart';
import 'package:movie/view/widgets/video_widget.dart';

import 'network_info_page.dart';

class DetailPage extends StatelessWidget {

  final scrollController = ScrollController();

  final Series series;


  DetailPage(this.series, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
             _buildSliverAppBar()
            ];
          },
          body: _buildSeriesDetails(),

        ),
      ),
    );

  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: true,
      pinned: true,
      expandedHeight: 380.h,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(topRight: Radius.circular(6)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(series.name,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ),
        background: Container(
          margin: const EdgeInsets.only(top: 6),
          child: CachedNetworkImage(
            errorWidget: (c,t,r) => Image.asset('assets/images/image.png', fit: BoxFit.fitHeight,),
            imageUrl: series.backdrop_path, fit: BoxFit.cover,
            placeholder: (context, url) =>  const Center(child: LoadingIndicator()),
          ),
        ),
      ),
    );
  }

  Widget _buildSeriesDetails() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
         children: [
           _buildDateAndVotes(),

           _buildGenres(),


           _buildText(text: 'OVERVIEW', padding: 0),

           _buildText(text: series.overview.isEmpty ? "No Description" : series.overview, color: Colors.white, fontWeight: FontWeight.normal, letterSpacing: 1, padding: 20),

           _buildText(text: "CAST", padding: 10),

           _buildCastData(),


           _buildText(text: 'NETWORKS', padding: 20),

           _buildSeasonData(),


           _buildText(text: 'VIDEOS', padding: 20),

           _buildVideosData(),

           _buildText(text: 'SIMILAR SHOWS', padding: 20),

           _buildRecommendationData()

         ],
          ),
    );





  }

  Widget _buildDateAndVotes() {
    return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTimeAndVotes(icon: Icons.date_range, text: series.first_air_date),
                  _buildTimeAndVotes(icon: Icons.trending_up_rounded, text: series.popularity),
                  _buildTimeAndVotes(icon: Icons.people, text: series.vote_count.toString()),
                ],
              ),
            );
  }

  Widget _buildText({required String text, required double padding, Color? color, FontWeight? fontWeight, double? letterSpacing, double? fontSize}) {
    return Container(
      padding:   EdgeInsets.all(padding),
      child: Text(text, style:  TextStyle(color: color ?? Colors.red, fontSize: fontSize ?? 20, fontWeight: fontWeight ?? FontWeight.bold, letterSpacing: letterSpacing ?? 3,) ,),
    );
  }

  Widget _buildRecommendationData() {
    return Consumer(
             builder: (context, ref, child){
               final recommendationData = ref.watch(recommendationProvider(series.id));
               return recommendationData.when(
                   data: (data){
                     return SizedBox(
                       height: 260.h,
                       child: ListView.builder(
                         physics: const BouncingScrollPhysics(),
                         scrollDirection: Axis.horizontal,
                           itemCount: data.length,
                           itemBuilder: (context, index){
                           return InkWell(
                             onTap: (){
                               Get.to(() => DetailPage(data[index]), transition: Transition.leftToRight, preventDuplicates: false);
                             },
                             child: Container(
                               margin: EdgeInsets.only(right: 10, left: index == 0 ? 10 : 0),

                               width: 140.w,
                               child: Column(
                                 children: [
                                   SizedBox(
                                     height: 200.h,
                                     child: Stack(
                                       children: [
                                         CachedNetworkImage(
                                           imageUrl: data[index].poster_path, fit: BoxFit.fitHeight,
                                           errorWidget: (c,t,r) => Image.asset('assets/images/image.png', height: 240.h, fit: BoxFit.fitHeight,),
                                           placeholder: (c, u) =>   const Center(child: LoadingIndicator(),),
                                         ),
                                         Positioned(
                                           left: 4,
                                           child: Container(
                                             color: Colors.black,
                                             child: Column(
                                               children: [
                                                 const Icon(Icons.star, color: Colors.red,),
                                                 Text(data[index].vote_average.substring(0,3),style: const TextStyle(color: Colors.red),)
                                               ],
                                             ),
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),

                                   Padding(
                                     padding: const EdgeInsets.symmetric(vertical: 8.0),
                                     child: Text(data[index].name, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.red),),
                                   ),
                                 ],
                               ),
                             ),
                           );


                           }
                       ),
                     );
                   },
                   error: (err, stack) => Padding(
                     padding: const EdgeInsets.only(bottom: 30.0),
                     child: Center(child: Text(err.toString()),),
                   ),
                   loading: ()=>  const Center(child: LoadingIndicator(size: 20,))
               );
         });
  }

  Widget _buildVideosData() {
    return Consumer(
             builder: (context, ref, child){
               final videoData = ref.watch(videoProvider(series.id));
               return videoData.when(
                   data: (data){
                     return SizedBox(
                       height: 230.h,
                       child: ListView.separated(
                         separatorBuilder: (BuildContext context, int index) {
                           return const VerticalDivider(
                             color: Colors.red,
                             indent: 60,
                             endIndent: 60,
                           );
                         },

                         physics: const BouncingScrollPhysics(),
                         scrollDirection: Axis.horizontal,
                         itemCount: data.length,
                         itemBuilder: (context, index){

                           return Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: SizedBox(
                               width: 320.w,
                               child: Column(
                                 children: [
                                   Container(margin: const EdgeInsets.only(left: 10),child: Text(data[index].name, overflow: TextOverflow.ellipsis,)),
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: VideoWidget(data[index].key),
                                     ),
                                   ),

                                 ],
                               ),
                             ),
                           );
                         },

                          ),
                     );
                   },
                   error: (err, stack) => Center(child: Text(err.toString()),),
                   loading: () =>  const Center(child: LoadingIndicator(size: 20,),)
               );
             }
         );
  }

  Widget _buildEpisodeInfo({required String date, required int index, required String text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text),
        Text(date),
      ],
    );
  }

  Widget _buildTimeAndVotes({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, color: Colors.red,),
        const SizedBox(width: 8,),
        Text(text),
      ],
    );
  }

  Widget _buildSeasonData() {


    return Consumer(
        builder: (context, ref, child){
          final seasonData = ref.watch(seasonProvider(series.id));
          return seasonData.when(
              data: (data){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildNetworkData(data),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildText(text: 'SEASONS', padding: 20),
                        _buildText(text: data.status, fontWeight: FontWeight.normal, letterSpacing: 1, color: Colors.white, fontSize: 16, padding: 20),
                      ],
                    ),

                    _buildEpisodeData(data),
                  ],
                );
              },
              error: (err, stack) => Center(child: Text(err as String),),
              loading: ()=>  const Center(child: LoadingIndicator(size: 20,),)
          );
        }
    );
  }

  Widget _buildEpisodeData(Season data) {
    return ListView.builder(
                    shrinkWrap: true,
                      controller: scrollController,
                      scrollDirection: Axis.vertical,
                      itemCount: data.seasons.length,
                      itemBuilder: (context, index){
                        return ListTileTheme(
                          dense: true,
                          child: InkWell(
                            onTap: (){
                              Get.to(SeasonDetails(seriesID: series.id, seasonNumber: data.seasons[index].season_number,));
                            },
                            child: ExpansionTile(
                              iconColor: Colors.red,
                              textColor: Colors.red,
                              childrenPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                              title: Text(data.seasons[index].name),
                              children: [
                                _buildEpisodeInfo(date: data.seasons[index].air_date, index: index, text: "Air Data"),
                                _buildEpisodeInfo(date: data.seasons[index].episode_count.toString(), index: index, text: "Episodes"),

                              ],
                            ),
                          ),
                        );
                      }
                  );
  }

  Widget _buildNetworkData(Season data) {
    return SizedBox(
                    height: 66.h,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: data.networks.length,
                        itemBuilder: (context, index){
                        return     Container(
                          margin: EdgeInsets.only(right: 20, left: index == 0 ? 20 : 10),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: (){
                                   Get.to(NetworkInfoPage(data.networks[index].id));
                                },
                                child: SizedBox(
                                  height: 30.h,
                                  child: CachedNetworkImage(
                                    imageUrl: data.networks[index].logo_path, color: Colors.red,
                                    errorWidget: (c,t,r) => Image.asset('assets/images/image.png', fit: BoxFit.fitHeight,),
                                    placeholder: (c, u) =>  Container(),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(data.networks[index].name.isEmpty ? "not available" : data.networks[index].name, style: const TextStyle(fontSize: 10)),
                              ),
                            ],
                          ),
                        );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const VerticalDivider(
                            thickness: 1,
                            color: Colors.red,
                            indent: 10,
                            endIndent: 18,
                          );
                        },
                        ),
                  );
  }

 Widget _buildGenres() {
    
    return Consumer(
        builder: (c, ref, child){
          final seasonData = ref.watch(seasonProvider(series.id));
          return seasonData.when(
              data: (data){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    direction: Axis.horizontal,
                    children: data.genres.map((i) => InkWell(
                       onTap: (){
                         Get.to(() => GenrePage(i.id));
                       },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(i.name, style: const TextStyle(fontSize: 18),),
                        ))).toList(),
                  ),
                );
              },
              error: (e,s) => Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(e.toString()),
              ),
              loading: () => const Padding(
                padding: EdgeInsets.all(8.0),
                child: LoadingIndicator(size: 20,),
              )
          );
        }
    );
    
 }

  Widget _buildCastData() {
    return Consumer(
        builder: (c, ref, child){
          final seasonData = ref.watch(castProvider(series.id));
          return seasonData.when(
              data: (data){
                return SizedBox(
                  height: 180.h,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: data.length,
                      itemBuilder: (c, index){
                      return InkWell(
                        onTap: (){
                          Get.to(() => CastDetailPage(id: data[index].id), transition: Transition.leftToRight);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          width: 100.w,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                child: CachedNetworkImage(
                                  imageUrl: data[index].profile_path, height: 140.h,
                                  errorWidget: (c,t,r) => Image.asset('assets/images/image.png', fit: BoxFit.fitHeight,),
                                  placeholder: (c, u) =>  const LoadingIndicator(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[index].name, style: const TextStyle(color: Colors.red), overflow: TextOverflow.ellipsis,),
                              ),
                            ],
                          ),
                        ),
                      );
                      }
                  ),
                );
              },
              error: (e,s) => Text(e.toString()),
              loading: () => const Padding(
                padding: EdgeInsets.all(8.0),
                child: LoadingIndicator(size: 20,),
              )
          );
        }
    );
  }







}



