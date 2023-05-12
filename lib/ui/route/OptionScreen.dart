import 'package:alto_minho_mobilidade/utils/constants.dart';
import 'package:alto_minho_mobilidade/utils/size_config.dart';
import 'package:flutter/material.dart';

class OptionScreen extends StatefulWidget {
  @override
  _OptionScreenState createState() => _OptionScreenState();
  final String searchMode;
  final ValueChanged<String> onChanged;
  String optionModel;

  OptionScreen({this.searchMode, this.onChanged, this.optionModel});
}

class _OptionScreenState extends State<OptionScreen> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Opções"),
      ),
      body: WillPopScope(
        onWillPop: () async {
          widget.onChanged(widget.optionModel);
          Navigator.pop(context);
          return false;
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: widget.searchMode == "Students"
                          ? _studentsList()
                          : _publicList(),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _studentsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          title: Text(TranslationConstant.TRANSIT_WALK),
          leading: Radio(
            value: TranslationConstant.TRANSIT_WALK,
            groupValue: widget.optionModel,
            onChanged: (newValue) {
              setState(() {
                widget.optionModel = newValue;
              });
            },
          ),
        ),
        ListTile(
          title: Text(TranslationConstant.WALK),
          leading: Radio(
            value: TranslationConstant.WALK,
            groupValue: widget.optionModel,
            onChanged: (newValue) {
              setState(() {
                widget.optionModel = newValue;
              });
            },
          ),
        ),
        ListTile(
          title: Text(TranslationConstant.CAR),
          leading: Radio(
            value: TranslationConstant.CAR,
            groupValue: widget.optionModel,
            onChanged: (newValue) {
              setState(() {
                widget.optionModel = newValue;
              });
            },
          ),
        ),
        ListTile(
          title: Text(TranslationConstant.BICYCLE),
          leading: Radio(
            value: TranslationConstant.BICYCLE,
            groupValue: widget.optionModel,
            onChanged: (newValue) {
              setState(() {
                widget.optionModel = newValue;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _publicList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          title: Text(TranslationConstant.WALK),
          leading: Radio(
            value: TranslationConstant.WALK,
            groupValue: widget.optionModel,
            onChanged: (newValue) {
              setState(() {
                widget.optionModel = newValue;
              });
            },
          ),
        ),
        ListTile(
          title: Text(TranslationConstant.CAR),
          leading: Radio(
            value: TranslationConstant.CAR,
            groupValue: widget.optionModel,
            onChanged: (newValue) {
              setState(() {
                widget.optionModel = newValue;
              });
            },
          ),
        ),
        ListTile(
          title: Text(TranslationConstant.BICYCLE),
          leading: Radio(
            value: TranslationConstant.BICYCLE,
            groupValue: widget.optionModel,
            onChanged: (newValue) {
              setState(() {
                widget.optionModel = newValue;
              });
            },
          ),
        ),
      ],
    );
  }
}