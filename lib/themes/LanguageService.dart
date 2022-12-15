// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// class LanguageService{
//   final _box = GetStorage();
//   final _key='lang';
//   _saveLangToBox(String lang)=>_box.write(_key, lang);
//   Locale _loadLanguageForBox() => _box.read(_key)!=null?Locale("vi","VN"):Locale("vi","VN");
//   Locale get locale=> _loadLanguageForBox()=="vi-VN"?Locale("vi","VN"):Locale("vi","VN");
//   void switchLang(){
//     Get.updateLocale(Locale("vi","VN"));
//     _saveLangToBox(_loadLanguageForBox()==Locale("vi","VN")?"en-US":"vi-VN");
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalizationService extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    "en_US":{
      "hello":"hello"
    },
    "vi_VN":{
      "hello":"xin chào"
    }
  };
  final _box = GetStorage();
  final _key='lang';
  _saveLangToBox(String lang)=>_box.write(_key, lang);
  Locale _loadLanguageForBox() {
    if(_box.read(_key)==null){
      return Locale("en","US");
    }
    else{
      if(_box.read(_key)=="vi-VN"){
        return Locale("vi","VN");
      }
      else{
        return Locale("en","US");
      }
    }
  }
  Locale get locale=> _loadLanguageForBox();
  void switchLang(){
    Get.updateLocale(_loadLanguageForBox()==Locale("vi","VN")?Locale("en","US"):Locale("vi","VN"));
    _saveLangToBox(_loadLanguageForBox()==Locale("vi","VN")?"en-US":"vi-VN");
  }
}