import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fleshchat/app/Pages/modul/ChatModel.dart';
import 'package:fleshchat/app/Pages/modul/usersModuls/userModuls.dart';
import 'package:fleshchat/app/Pages/widgets/contener_login.dart';
import 'package:flutter/material.dart';

class chatPage extends StatefulWidget {
  const chatPage({super.key, this.urModels});
  final UrModels? urModels;
  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  final _formfield = GlobalKey<FormState>();
  final smsMesseges = TextEditingController();
  final Sms = FirebaseFirestore.instance.collection('Sms');
  Future<void> addSms(String sms) {
    final urModels = UrModels();
    final chatModel = ChatModels(
        userName: urModels.name,
        creattedTime: Timestamp.now(),
        sms: sms,
        senderId: urModels.id,
        sender: urModels.email);
    return Sms.add(chatModel.toJson())
        .then((value) => print("User Sms Added"))
        .catchError((error) => print("Failed to add user sms: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formfield,
          child: Column(
            children: [
              WidgetContener(
                text: 'Flash Chat⚡',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: SizedBox(
                  height: 70,
                ),
              ),
              Center(
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  cursorColor: Colors.black,
                  cursorWidth: 2,
                  maxLines: null,
                  style: TextStyle(fontSize: 20),
                  strutStyle: StrutStyle(fontSize: 20),
                  controller: smsMesseges,
                  cursorHeight: 45,
                  decoration: InputDecoration(
                      hintText: 'enter your masseges',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.blue, width: 4)),
                      labelStyle: TextStyle(
                        color: Colors.blue,
                      ),
                      focusColor: Colors.black,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          addSms(smsMesseges.text);
                        },
                        icon: Icon(EvaIcons.paperPlaneOutline),
                        color: Colors.blue,
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter your masseges";
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
