import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trim_app/bloc/model/message_model.dart';
import 'package:trim_app/bloc/provider/repository/message_repository.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({
    super.key,
    required this.salonId,
    required this.salonTitle,
  });

  final String salonId;
  final String salonTitle;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final MessageRepository _repository = MessageRepository();
  final TextEditingController _controller = TextEditingController();
  String? conversationId;

  @override
  void initState() {
    super.initState();
    _initConversation();
  }

  Future<void> _initConversation() async {
    print('Conversation yaratish boshlandi, salonId: ${widget.salonId}');
    try {
      final id = await _repository.createConversation(widget.salonId);
      print('Conversation yaratildi: $id');
      if (mounted) setState(() => conversationId = id);
    } catch (e) {
      print('XATOLIK: $e');
    }
  }

  void _sendMessage() {
    print('conversationId: $conversationId');
    print('text: ${_controller.text}');
    if (_controller.text.trim().isEmpty || conversationId == null) return;

    _repository.sendMessage(
      conversationId: conversationId!,
      message: _controller.text.trim(),
    );
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserid = FirebaseAuth.instance.currentUser?.uid;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 65.h),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 24.w),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/images/img_5.png',
                    width: 28.w,
                    height: 28.h,
                  ),
                ),
                SizedBox(width: 16.w),
                Text(
                  widget.salonTitle,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 130),
                Image.asset(
                  'assets/images/img_30.png',
                  width: 28.w,
                  height: 28.h,
                ),
              ],
            ),
            SizedBox(height: 50),
            conversationId == null
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                      child: StreamBuilder<List<Message>>(
                        stream: _repository.watchMessages(conversationId!),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          final messages = snapshot.data!;

                          if (messages.isEmpty) {
                            return Center(
                              child: Text(
                                'Xabarlar yo\'q. Birinchi bo\'lib yozing!',
                              ),
                            );
                          }
                          return ListView.builder(
                            padding: EdgeInsets.all(16),
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final msg = messages[index];
                              final isMe = msg.senderId == currentUserid;

                              return Align(
                                alignment: isMe
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                        0.7,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isMe
                                        ? Color(0xffFD9301)
                                        : Color(0xffF5F5F5),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        msg.message,
                                        style: TextStyle(
                                          color: isMe
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '${msg.createdAt.hour.toString().padLeft(2, '0')}:${msg.createdAt.minute.toString().padLeft(2, '0')}',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: isMe
                                              ? Colors.white70
                                              : Colors.black45,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Row(
                children: [
                  Container(
                    width: 300,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xffF5F5F5),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Сообщение',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: const BoxDecoration(
                        color: Color(0xffFD9301),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
