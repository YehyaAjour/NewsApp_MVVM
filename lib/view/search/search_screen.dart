import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/view/CustomWidget/custom_text.dart';
import 'package:newsapp/view_model/AppCubit/app_cubit.dart';
import 'package:newsapp/view_model/AppStates/app_states.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class SearchScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 25,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: cubit.searchList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    height: 100,
                    width: 100,
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: ConditionalBuilder(
                      condition: cubit.searchList[index]['urlToImage'] != null,
                      builder: (context) {
                        return Image(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                                '${cubit.searchList[index]['urlToImage']}'));
                      },
                      fallback: (context) {
                        return Shimmer(
                          child: Container(
                            color: Colors.grey[500],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          '${cubit.searchList[index]['title']}',
                          color: Colors.black,
                          fontFamily: 'din',
                          fontSize: 15,
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            CustomText(
                              '${cubit.searchList[index]['publishedAt']}',
                              color: Colors.black,
                              fontFamily: 'din',
                              fontSize: 13,
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.bookmark_border,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}
