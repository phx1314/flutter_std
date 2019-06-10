import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/model/ModelChat.dart';
import 'package:flutter_std/model/ModelUpload.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/TakePhoto.dart';

import '../Help.dart';
import 'ChatMessage.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen(
    this.mModelChats, {
    Key key,
    this.sheName,
    this.shePortrait,
    this.myPortrait,
  });

  final List mModelChats;
  final String sheName;
  final String shePortrait;
  final String myPortrait;

  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends BaseState<ChatScreen> {
  TextEditingController _textController = new TextEditingController();
  ScrollController _scrollController = new ScrollController();

  void _sendMessage({String text, String fileId, bool isMe}) {
    widget.mModelChats.add(ModelChat(
        isMe,
        fileId == null ? fileId : Help.URL_JAVA_FILE + fileId,
        isMe ? widget.myPortrait : widget.shePortrait,
        text));
    _scrollController.jumpTo((widget.mModelChats.length - 1) *
        ScreenUtil.getScaleW(context, 100).toDouble());
    loadUrl(
        Help.URL_JAVA + '/' + method_userchat_add,
        {
          "fileId": fileId ?? "",
          "message": text ?? "",
          "sendUserId": 'f8d4edd60f6863d86f840a999e9878ed',
          "recivedUserId": 'c759e39b35b42f8e1d8914d556c88551'
        },
        isShow: false);

    Help.closeKeyBord(context);
    setState(() {});
  }

  @override
  void onSuccess(String methodName, res) {
    if (methodName == Help.URL_JAVA + '/' + method_file_upload) {
      ModelUpload mModelUpload = ModelUpload.fromJson(res.data);
      _sendMessage(fileId: mModelUpload.data.fileId, isMe: true);
    } else if (methodName == Help.URL_JAVA + '/' + method_userchat_add) {
      Help.Toast(context, '添加成功');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(widget.sheName),
          centerTitle: true,
          elevation: 1.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Help.showAlertDialog(context, '确认删除', () {
                  setState(() {
                    widget.mModelChats.clear();
                  });
                });
              },
            )
          ]),
      body: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: new Column(
            children: <Widget>[
              Expanded(
                  child: ListView.builder(
                      itemExtent: ScreenUtil.getScaleW(context, 100),
                      controller: _scrollController,
                      padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 8)),
                      itemCount: widget.mModelChats.length,
//                    reverse: true,
                      itemBuilder: (context, index) {
                        return ChatMessage(
                          mModelChat: widget.mModelChats[index],
                        );
                      })),
              Divider(height: 1.0),
              Container(
                decoration: new BoxDecoration(
                  color: Theme.of(context).cardColor,
                ),
                child: IconTheme(
                    data:
                        new IconThemeData(color: Theme.of(context).accentColor),
                    child: new Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: ScreenUtil.getScaleW(context, 8)),
                        child: new Row(children: <Widget>[
                          new Container(
                            child: new IconButton(
                                icon: new Icon(Icons.photo_camera),
                                onPressed: () async {
                                  Help.showMyDialog(context, TakePhoto((file) {
                                    if (file != null) {
                                      loadUrl(
                                          Help.URL_JAVA +
                                              '/' +
                                              method_file_upload,
                                          {
                                            "file": UploadFileInfo(file, 'img'),
                                          },isFormData: true);
                                    }
                                  }));
                                }),
                          ),
                          Expanded(
                              child: new TextField(
                            controller: _textController,
                            onChanged: (s) {
                              setState(() {});
                            },
                            decoration:
                                new InputDecoration.collapsed(hintText: '发送消息'),
                          )),
                          new Container(
                            child: new IconButton(
                                icon: new Icon(
                                  Icons.send,
                                  color: _textController.text.isEmpty
                                      ? Colors.grey
                                      : Theme.of(context).accentColor,
                                ),
                                onPressed: () {
                                  if (_textController.text.isNotEmpty) {
                                    _sendMessage(
                                        text: _textController.text, isMe: true);
//                                    _sendMessage(
//                                        text: _textController.text, imageUrl:'http://pic9.nipic.com/20100827/5252423_161258496483_2.jpg', isMe: true);
                                    _textController.clear();
                                  }
                                }),
                          )
                        ]))),
              )
            ],
          )),
    );
  }
}
