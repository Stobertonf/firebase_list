import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_list/models/text_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_list/shared/widgets/chat/chat_widget.dart';

class ChatPage extends StatefulWidget {
  final String nickName;
  const ChatPage({super.key, required this.nickName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final db = FirebaseFirestore.instance;
  final textoController = TextEditingController(text: '');
  String userId = "";

  @override
  void initState() {
    super.initState();
    carregarUsuario();
  }

  carregarUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('user_id')!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Chat"),
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: db.collection("chats").snapshots(),
                    builder: (context, snapshot) {
                      return !snapshot.hasData
                          ? const CircularProgressIndicator()
                          : ListView(
                              children: snapshot.data!.docs.map((e) {
                                var textModel = TextModel.fromJson(
                                  (e.data() as Map<String, dynamic>),
                                );
                                return ChatWidget(
                                  textModel: textModel,
                                  souEu: textModel.userId == userId,
                                );
                              }).toList(),
                            );
                    }),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 16,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      20,
                    ),
                  ),
                  border: Border.all(color: Colors.black),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: textoController,
                      decoration: const InputDecoration(
                        focusedBorder: InputBorder.none,
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    )),
                    IconButton(
                      onPressed: () async {
                        var textModel = TextModel(
                            nickname: widget.nickName,
                            text: textoController.text,
                            userId: userId);
                        await db.collection("chats").add(
                              textModel.toJson(),
                            );
                        textoController.text = '';
                      },
                      icon: const Icon(
                        Icons.send,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
