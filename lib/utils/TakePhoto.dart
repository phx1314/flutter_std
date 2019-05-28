import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:image_picker/image_picker.dart';

class TakePhoto extends StatefulWidget {
  MethodCallBack mMethodCallBack;

  TakePhoto(this.mMethodCallBack);

  @override
  TakePhotoState createState() => new TakePhotoState();
}

typedef MethodCallBack = void Function(File file);

class TakePhotoState extends BaseState<TakePhoto> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency, //透明类型
      child: Container(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                  child: InkWell(
                onTap: () => finish(),
              )),
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: _takePhoto,
                          child: Container(
                            padding: EdgeInsets.all(ScreenUtil.getScaleW(context,15)),
                            width: double.infinity,
                            child: Text(
                              '拍照',
                              style: Style.text_style_16_black,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                    Divider(
                      height: 1,
                    ),
                    Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: _openGallery,
                          child: Container(
                            padding: EdgeInsets.all(ScreenUtil.getScaleW(context,15)),
                            width: double.infinity,
                            child: Text(
                              '从手机相册选择',
                              style: Style.text_style_16_black,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                    Container(
                      color: Color(0x66000000),
                      height: ScreenUtil.getScaleW(context,15),
                    ),
                    Material(
                      color: Colors.white,
                      child: InkWell(
                        onTap: () => finish(),
                        child: Container(
                          padding: EdgeInsets.all(ScreenUtil.getScaleW(context,15)),
                          width: double.infinity,
                          child: Text(
                            '取消',
                            textAlign: TextAlign.center,
                            style: Style.text_style_16_black,
                          ),
                        ),
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

  @override
  void initState() {
    super.initState();
  }

/*拍照*/
  _takePhoto() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera,maxWidth:400,maxHeight:400);
    widget.mMethodCallBack(image);
    finish();
  }

  /*相册*/
  _openGallery() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery,maxWidth:400,maxHeight:400);
    widget.mMethodCallBack(image);
    finish();
  }
}
