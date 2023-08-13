

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/common_widgets/loading_indicator.dart';
import 'package:movie/providers/season_details_provider.dart';

class SeasonDetails extends ConsumerWidget {

  final int seriesID, seasonNumber;

  SeasonDetails({super.key, required this.seriesID, required this.seasonNumber});




  @override
  Widget build(BuildContext context, ref) {

    final data = ref.watch(seasonDetailProvider(Test(seriesId: seriesID, seasonNumber: seasonNumber)));
    return SafeArea(
      child: Scaffold(

        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: data.when(
                  data: (data){
                    return data.isEmpty ? const Center(child: Text("Not avaiable"),) : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                        itemBuilder: (context, index){

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data[index].name, style: const TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(data[index].air_date),
                                    Text("${data[index].runtime.toString()} min"),
                                  ],
                                ),
                              ),
                              Text(data[index].overview),
                            ],

                          ),
                        );

                        }
                    );
                  },
                  error: (e, s) => Center(child: Text(e.toString()),),
                  loading: () => const Center(child: LoadingIndicator(),)
              ),
            ),
          ),


        ),

      ),
    );
  }
}
