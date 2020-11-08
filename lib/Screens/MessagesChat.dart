import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petscompanytest/Models/message_model.dart';
import 'package:petscompanytest/Models/user_model.dart';

class MessagesChat extends StatefulWidget {
  User currentUser;

  final Message message;

  MessagesChat({this.message});

  @override
  _MessagesChatState createState() => _MessagesChatState();
}

class _MessagesChatState extends State<MessagesChat> {
  User currentUser = User(id: 0, name: 'Hamza');
  final myController = TextEditingController();
  File imageFile;

  var screenWidth, screenHeight;

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      imageFile = image;
      chats.add(new Message(
        sender: 'Hamza',
        date: '',
        text: myController.text,
        readen: false,
        msgType: 1,
      ));
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      imageFile = image;
      chats.add(new Message(
        sender: 'Hamza',
        date: '',
        text: myController.text,
        readen: false,
        msgType: 1,
      ));
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  getMessageContainer(Message message, bool isMe) {
    if (message.msgType == 0) {
      return Container(
        decoration: isMe
            ? BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                  bottomLeft: Radius.circular(12.0),
                ),
                gradient: LinearGradient(
                  begin: Alignment(-0.19, -0.27),
                  end: Alignment(1.66, 2.66),
                  colors: [HexColor("#689fee"), HexColor("#c737c2")],
                  stops: [0.0, 1.0],
                ),
              )
            : BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.0),
                  topRight: Radius.circular(14.0),
                  bottomRight: Radius.circular(14.0),
                ),
                //white please
                color: const Color(0xffebebeb),
              ),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.text,
              style: TextStyle(
                fontFamily: 'SF Pro Text',
                fontSize: 14,
                color: isMe ? const Color(0xffffffff) : const Color(0xff231f20),
                letterSpacing: 0.14,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      );
    } else if (message.msgType == 1) {
      //image
      return Container(
        width: 230.0 * screenWidth,
        height: 210.0 * screenHeight,
        decoration: isMe
            ? BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                  bottomLeft: Radius.circular(12.0),
                ),
                color: const Color(0xffec1c40),
              )
            : BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.0),
                  topRight: Radius.circular(14.0),
                  bottomRight: Radius.circular(14.0),
                ),
                color: const Color(0xffebebeb),
              ),
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Stack(
            children: [
              Container(
                width: 224.0 * screenWidth,
                height: 204.0 * screenHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: new FileImage(imageFile),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              isMe
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.done_all,
                              color: Colors.white,
                              size: 17,
                            ),
                          )))
                  : Text('')
            ],
          ),
        ),
      );
    }
  }

  _buildMessage(Message message, bool isMe) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Align(
          alignment: isMe ? Alignment.topRight : Alignment.topLeft,
          child: getMessageContainer(message, isMe)),
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: 70.0 * screenHeight,
      color: HexColor("#200517"),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_camera),
            iconSize: 30,
            color: HexColor("#dc21b8"),
            onPressed: () {
              _showPicker(context);
            },
          ),
          Expanded(
            child: TextField(
              controller: myController,
              decoration: InputDecoration(
                hintText: 'écrire un message ...',
                filled: true,
                fillColor: const Color(0xffebedf0),
                contentPadding: EdgeInsets.fromLTRB(16.0, 8, 8, 8),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.grey[100],
                    )),
                hintStyle: TextStyle(
                  fontFamily: 'SF Pro Text',
                  fontSize: 14,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5 * screenWidth,
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: HexColor("#dc21b8"),
              size: 30 * screenWidth,
            ),
            onPressed: () => setState(() => chats.add(new Message(
                  sender: 'Hamza',
                  date: '',
                  text: myController.text,
                  readen: false,
                  msgType: 0,
                ))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width * 0.04 / 14.5;
    screenHeight = MediaQuery.of(context).size.height * 0.02 / 14;

    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        body: Container(
          color: HexColor("#200517"),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                  Widget>[
            Stack(children: <Widget>[
              // Adobe XD layer: 'Banner Top' (shape)
              //appBar("Messages"),
              Container(
                width: 375.0 * screenWidth,
                height: 100.0 * screenHeight,
                color: HexColor("#1f1f21"),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(0, 20 * screenHeight, 0, 0),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  title: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Hatie Hampton",
                      style: TextStyle(
                        fontFamily: 'SF Pro Text',
                        fontSize: 18,
                        color: const Color(0xffffffff),
                        letterSpacing: 0.18,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.phone,
                          size: 30 * screenHeight, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.videocam,
                          size: 30 * screenHeight, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ]),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 5, 8, 2),
                child: Text(
                  "Today at 5:03 PM",
                  style: TextStyle(
                    fontFamily: 'SF Pro Text',
                    fontSize: 12,
                    color: const Color(0xff999999),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: HexColor("#200517"),
                child: ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (BuildContext context, int index) {
                      final bool isMe = chats[index].sender == currentUser.name;
                      return Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          _buildMessage(chats[index], isMe),
                          if (index != 0 &&
                              chats[index].sender != chats[index - 1].sender)
                            Center(
                              child: Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8.0, 5, 8, 5),
                                  child: Text(
                                    chats[index].date,
                                    style: TextStyle(
                                      fontFamily: 'SF Pro Text',
                                      fontSize: 12,
                                      color: const Color(0xff999999),
                                      letterSpacing: 0.12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    }),
              ),
            ),
            Container(
                width: 375.0 * screenWidth,
                height: 1,
                color: HexColor("#262628")),
            _buildMessageComposer(),
          ]),
        ));
  }
}
