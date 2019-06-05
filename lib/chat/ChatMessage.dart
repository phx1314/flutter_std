import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/model/ModelChat.dart';

import '../Help.dart';
import 'ImageZoomable.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage({this.mModelChat});

  final ModelChat mModelChat;

  @override
  Widget build(BuildContext context) {
    Widget _sheSessionStyle() {
      return new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
              margin:   EdgeInsets.only(right: ScreenUtil.getScaleW(context, 15)),
              child: new CircleAvatar(
                  radius: ScreenUtil.getScaleW(context, 27),
                  backgroundImage: CachedNetworkImageProvider(
                      mModelChat.headImg,
                      cacheManager: Help.mImageCacheManager)),
            ),
            new Expanded(
                child: new Container(
                  child: mModelChat.imageUrl != null
                      ? new GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute<Null>(
                          builder: (BuildContext context) {
                            return new ImageZoomable(
                              new NetworkImage(mModelChat.imageUrl),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            );
                          }));
                    },
                    child: CachedNetworkImage(
                        imageUrl: mModelChat.imageUrl,
                        cacheManager: Help.mImageCacheManager),
                  )
                      : new Text(mModelChat.text),
                )),
          ]);
    }

    Widget _mySessionStyle() {
      return new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(child: Container()),
            new Container(
              child: mModelChat.imageUrl != null
                  ? new GestureDetector(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute<Null>(
                      builder: (BuildContext context) {
                        return new ImageZoomable(
                          NetworkImage(mModelChat.imageUrl),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        );
                      }));
                },
                child: CachedNetworkImage(
                    imageUrl: mModelChat.imageUrl,
                    cacheManager: Help.mImageCacheManager),
              )
                  : new Text(mModelChat.text),
            ),
            new Container(
              margin: EdgeInsets.only(left: ScreenUtil.getScaleW(context, 15)),
              child: new CircleAvatar(
                  radius: ScreenUtil.getScaleW(context, 27),
                  backgroundImage: CachedNetworkImageProvider(
                      mModelChat.headImg,
                      cacheManager: Help.mImageCacheManager)),
            ),
          ]);
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: ScreenUtil.getScaleW(context, 10)),
      child: mModelChat.isMe ? _mySessionStyle() : _sheSessionStyle(),
    );
  }
}