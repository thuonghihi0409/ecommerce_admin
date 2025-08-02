import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/chat/presentation/bloc/profile_bloc/chat_bloc.dart';
import 'package:thuongmaidientu/features/chat/presentation/page/chat_detail_page.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/image_cache_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';
import 'package:thuongmaidientu/shared/widgets/overlay_custom.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({super.key});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  late ChatBloc _chatBloc;
  late String currentUserId;
  @override
  void initState() {
    super.initState();
    currentUserId = kIsWeb
        ? context.read<ProfileBloc>().state.store?.id ?? ""
        : (context.read<ProfileBloc>().state.profile?.id ?? "");
    _chatBloc = context.read<ChatBloc>();
    _getData();
  }

  _getData() async {
    _chatBloc.add(GetListConversation(userId: currentUserId));
  }

  @override
  Widget build(BuildContext context) {
    return OverlayLoadingCustom(
      loadingWidget:
          BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
        return CustomLoading(
          isLoading: state.isLoading,
          isOverlay: true,
        );
      }),
      child: BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
        return Scaffold(
            appBar: CustomAppBar(
              title: "key_conversation".tr(),
              isShowChatIcon: false,
            ),
            body: Builder(builder: (context) {
              if (state.listConversation?.results == null ||
                  state.listConversation!.results!.isEmpty) {
                return const Center(
                  child: Text('No conversation'),
                );
              }
              return ListView.builder(
                itemCount: (state.listConversation?.results ?? []).length,
                itemBuilder: (context, index) {
                  final conversation = state.listConversation?.results?[index];

                  return ListTile(
                    title: Text(conversation?.store?.name ?? ""),
                    //subtitle: Text('Thành viên: ${members.join(', ')}'),
                    onTap: () {
                      _chatBloc.add(
                          OpenConversation(conversationEntity: conversation));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ChatDetailPage(),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      child: CustomCacheImageNetwork(
                          imageUrl: conversation?.store?.logoUrl ?? ""),
                    ),

                    subtitle: Text(
                      Helper.convertLastMessage(conversation?.lastMessage),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (conversation?.lastMessage != null)
                          Text(
                              Helper.timeAgo(
                                  conversation?.lastMessage?.timesend ??
                                      DateTime.now()),
                              style: AppTextStyles.textSize12()),
                        if ((conversation?.unreadCount ?? 0) > 0)
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text("${conversation?.unreadCount}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 10)),
                          ),
                      ],
                    ),
                  );
                },
              );
            }));
      }),
    );
  }
}
