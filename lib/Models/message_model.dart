import 'package:flutter/cupertino.dart';
import 'package:petscompanytest/Models/user_model.dart';

class Message {
  final String sender;
  final String time;
  final String
      date; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String objet;
  final String type;
  final String text;
  final bool readen;
  final int msgType;
  Color colorContainer;
  Message({
    this.sender,
    this.time,
    this.date,
    this.objet,
    this.type,
    this.text,
    this.readen,
    this.msgType,
  });
}

//Current User
final User currentUser = User(id: 0, name: 'Hamza', isFounder: false);




List<Message> chats = [
      Message(
    sender: 'John',
    date: '',
    text: "Hey comment tu vas ?",
    readen: false,
    msgType: 0,
  ),
    Message(
    sender: 'Hamza',
    date: '',
    text: "très bien juste je m'ennui  et toi?",
    readen: false,
    msgType: 0,
  ),


  Message(
    sender: 'John',
    date: '5:33 PM',
    text: "ca te dis d'aller boire un verre ce soir",
    readen: false,
    msgType: 0,
  ),
   Message(
    sender: 'Hamza',
    date: '',
    text: "oui jaimerais bien t'accompagner",
    readen: false,
    msgType: 0,
  ),

];



