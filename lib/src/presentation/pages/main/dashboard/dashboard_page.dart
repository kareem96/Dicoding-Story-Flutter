import 'package:dicoding_story_flutter/src/presentation/pages/main/cubit/cubit.dart';
import 'package:dicoding_story_flutter/src/presentation/presentations.dart';
import 'package:dicoding_story_flutter/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/domain.dart';
import 'cubit/cubit.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final ScrollController _scrollController = ScrollController();
  final List<Story> _story = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() async {});
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      /*child: Button(
        onPressed: (){
          try {
            var message =  sl<PrefManager>().token.toString() ;
            dismissAllToast(showAnim: true);
            showToastWidget(
               Toast(
                bgColor: Palette.green,
                icon: Icons.check_circle,
                message: message,
                textColor: Colors.white,
              ),
              dismissOtherToast: true,
              position: ToastPosition.top,
              duration: const Duration(seconds: 3),
            );
          } catch (e) {
            log.e("$e");
          }
        },
        title: 'Check token',
      ),*/
      child: RefreshIndicator(
        color: Theme.of(context).iconTheme.color,
        onRefresh: () {
          return context.read<StoriesCubit>().refreshStories(StoriesParams());
        },
        child: BlocBuilder<StoriesCubit, StoriesState>(
          builder: (_, state) {
            switch (state.status) {
              case StoriesStatus.loading:
                return const Center(
                  child: Loading(),
                );
              case StoriesStatus.success:
                final _data = state.stories!;
                _story.addAll(_data.story);
                return ListView.builder(
                    controller: _scrollController,
                    itemCount: _story.length,
                    padding: EdgeInsets.symmetric(vertical: Dimens.space16),
                    itemBuilder: (_, index) {
                      return index < _story.length
                          ? Container(
                              decoration: BoxDecorations.card.copyWith(
                                color: Theme.of(context).cardColor,
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: Dimens.space16,
                                horizontal: Dimens.space24,
                              ),
                              margin: EdgeInsets.symmetric(
                                vertical: Dimens.space8,
                                horizontal: Dimens.space16,
                              ),
                              child: Row(
                                children: [
                                  CircleImage(
                                    url: _story[index].photoUrl ?? "",
                                    size: Dimens.profilePicture,
                                  ),
                                  const SpacerHorizontal(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _story[index].name ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                                fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        _story[index].description ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .hintColor),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.all(Dimens.space16),
                              child: const Center(
                                child: CupertinoActivityIndicator(),
                              ),
                            );
                    });
              case StoriesStatus.failure:
                return Center(
                  child: Empty(
                    errorMessage: state.message ?? "",
                  ),
                );
              case StoriesStatus.empty:
                return const Center(
                  child: Empty(),
                );
            }
          },
        ),
      ),
      floatingButton: FloatingActionButton(
        onPressed: (){
          context.goTo(AppRoute.upload);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child:  Icon(Icons.add, color: Theme.of(context).primaryColorLight),
      ),
    );
  }
}
