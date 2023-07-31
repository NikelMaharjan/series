



import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/models/series.dart';
import 'package:movie/providers/search_provider.dart';
import 'package:movie/view/widgets/tab_bar_widget.dart';

class SearchPage extends StatelessWidget {


  final searchController = TextEditingController();

  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Consumer(
            builder: (context, ref, child) {

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: true,
                      controller: searchController,
                      onFieldSubmitted: (val){
                        if(val.isEmpty){

                          showDialog(context: context, builder: (context) => AlertDialog(
                            content: const Text("Provide SearchText"),
                            actions: [

                              TextButton(onPressed: (){
                                Navigator.of(context).pop();
                               }, child: const Text("Close"))

                            ],

                          ));

                        }
                        else{
                          ref.read(searchProvider.notifier).getSeriesData(searchText: val);
                          searchController.clear();
                        }
                      },
                       decoration:  const InputDecoration(
                         focusedBorder: UnderlineInputBorder(
                           borderSide: BorderSide(color: Colors.red),
                         ),
                         prefixIconColor: Colors.red,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        hintText: 'Search Movie',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                    Expanded(child: TabBarWidget(true)),
                  ],
                ),
              );
            }
          )
      ),
    );
  }
}
