import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie/api.dart';
import 'package:movie/models/series.dart';
import 'package:movie/providers/series_provider.dart';
import 'package:movie/view/search_page.dart';
import 'package:movie/view/widgets/tab_bar_widget.dart';



class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 80.h,
              flexibleSpace: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('BROWSE', style: TextStyle( fontSize: 30, fontWeight: FontWeight.w500,)),
                    IconButton(onPressed: (){
                      Get.to(SearchPage(), transition: Transition.leftToRight);
                     }, icon: const Icon(Icons.search, size: 30,))
                  ],
                ),
              ),
              bottom: PreferredSize(      //we use PreferredSize here just to able to wrap tabbar with consumer
                preferredSize: Size(double.infinity, 40.h),
                child: Consumer(
                  builder: (context, ref, child) {
                    return TabBar(
                      onTap: (index){
                        switch(index){
                          case 0:
                            ref.read(seriesProvider.notifier).changeCategory(apiPath: Api.getPopularSeries);
                            break;

                          case 1:
                            ref.read(seriesProvider.notifier).changeCategory(apiPath: Api.getTopRatedSeries);
                            break;

                          default:
                            ref.read(seriesProvider.notifier).changeCategory(apiPath: Api.getAiringSeries);

                        }
                      },
                        indicator: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        tabs: const [
                          Tab(
                            text: 'Trending',
                          ),
                          Tab(
                            text: 'Top Rated',
                          ),
                          Tab(
                            text: 'Airing',
                          ),
                        ]
                    );
                  }
                ),
              ),
            ),
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
                children: [
                  TabBarWidget(false),
                  TabBarWidget(false),
                  TabBarWidget(false)

                ])
        ),
      ),
    );
  }
}