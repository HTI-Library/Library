import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/models/messageModel.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/loading.dart';

class ChattingPage extends StatefulWidget {
  const ChattingPage({Key? key}) : super(key: key);

  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  late MainCubit cubit;
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cubit = context.read<MainCubit>();
    cubit.getMessages('admin');
    cubit.listenToMessages('admin');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return BackScaffold(
            typing: true,
            scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: 'Admin',
            body: Column(

              children: [
                BuildCondition(
                  condition: cubit.messages.isNotEmpty,
                  builder: (_) => cubit.isLoad && cubit.profileModel != null ? buildChattingListView() : const Center(child: LoadingWidget()),
                  fallback: (_) => buildNotMessages(),
                ),
                if (cubit.messages.isEmpty || cubit.isLoad == false) const Spacer(),
                buildTextChat(),
              ],
            ),
          );
        },
    );
  }

  Widget buildChattingListView() {
    return Expanded(
      child: BlocBuilder<MainCubit, MainState>(
        buildWhen: (previous, current) => current is GetMessagesSuccessState,
        builder: (context, state) {
          return ListView.builder(
            itemCount: cubit.messages.length,
            itemBuilder: (context, index) {
              MessageModel message = cubit.messages[index];
              if (message.senderId == cubit.profileModel!.email)
              {
                return buildSenderMessage(message.message!);
              } else
              {
                return buildReceiverMessage(message.message!);
              }
            },
          );
        },
      ),
    );
  }

  Widget buildSenderMessage(String message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.only(
                top: 5,
                bottom: 5,
                right: 15,
                left: 25,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.blue[500],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsetsDirectional.only(end: 8),
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Icon(
              Icons.done,
              size: 10,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildReceiverMessage(String message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsetsDirectional.only(start: 10),
          child: CircleAvatar(
            radius: 15,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/images/hti123.png'),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                right: 25,
                left: 15,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildNotMessages() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Center(
        child: Column(
          children: [
            Image.asset("assets/images/message.png",height: 300,width: 300,),
            space20Vertical,
            Text(
              appTranslation(context).myMessageNo,
              style: Theme.of(context).textTheme.headline6!,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextChat() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15 / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: HexColor(mainColor).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15 * 0.75,
                ),
                decoration: BoxDecoration(
                  color: HexColor(mainColor).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: const InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
              ),
            ),
            IconButton(
                onPressed: () => sendMessage(),
                icon: Icon(Icons.send_rounded, color: HexColor(mainColor))),
          ],
        ),
      ),
    );
  }

  void sendMessage() {
    String messageContent = messageController.text;
    String userId = cubit.profileModel!.email;
    String time = DateTime.now().toString();

    if (cubit.messages.isEmpty) {
      cubit.uploadData();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget));
    }

    if (messageController.text.isNotEmpty) {
      MessageModel message = MessageModel(
        messageId: time + userId,
        senderId: userId,
        reciverId: 'admin',
        message: messageContent,
        time: time,
      );
      cubit.sendMessage(message);
      cubit.getMessages('admin');
      messageController.clear();
    }
  }
}
