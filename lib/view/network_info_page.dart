
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/common_widgets/loading_indicator.dart';
import 'package:movie/providers/network_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NetworkInfoPage extends ConsumerWidget {

  final int id;
  const NetworkInfoPage(this.id, {super.key});

  @override
  Widget build(BuildContext context, ref) {
    final networkData = ref.watch(networkProvider(id));
    return SafeArea(
      child: Scaffold(
          body: networkData.when(
              data: (data){
                final Uri url = Uri.parse(data.homepage);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: double.infinity,),
                    Container(
                      padding:  const EdgeInsets.symmetric(horizontal: 10),
                      height: 300,
                      color: Colors.grey,
                      child: CachedNetworkImage(
                        imageUrl: data.logo_path,
                        errorWidget: (c,t,r) => Image.asset('assets/images/image.png', fit: BoxFit.fitHeight,),
                        placeholder: (c, u) =>  Container(),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 20),
                      child: Column(
                        children: [
                          Row(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Name"),
                              Text(data.name, ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Country"),
                              Text(data.origin_country, ),
                            ],
                          ),

                        ],
                      ),
                    ),


                    const SizedBox(height: 20,),


                    OutlinedButton(
                        onPressed: () async {
                      await _launchURL(url);
                    }, child: const Text("Open page", style: TextStyle(color: Colors.red),))
                  ],
                );
              },
              error: (err, stack) => Center(child: Text(err.toString()),),
              loading: ()=>  const Center(child: LoadingIndicator(),)
          )
      ),
    );
  }

  Future<void> _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch $url";
    }
  }
}
