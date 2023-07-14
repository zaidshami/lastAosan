import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../utill/custom_themes.dart';
import '../../../localization/language_constrants.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final int maxLine;
  final FocusNode focusNode;
  final FocusNode nextNode;
  final TextInputAction textInputAction;
  final bool isPhoneNumber;
  final bool isValidator;
  final String validatorMessage;
  final Color fillColor;
  final TextCapitalization capitalization;
  final bool isBorder;
  final String labelText;
  final bool readonly ;
  final Function onTap;
   GlobalKey key ;
   final isAdressScreen ;
  final bool isCheckOut ;
  final Widget prefixIcon ;



  CustomTextField(


      {
        this.isCheckOut = false,
        this.prefixIcon ,
        this.onTap,
        this.readonly= false ,
        this.controller,
      this.hintText,
      this.textInputType,
      this.maxLine,
      this.focusNode,
      this.nextNode,
      this.textInputAction,
      this.isPhoneNumber = false,
      this.isValidator=false,
      this.validatorMessage,
      this.capitalization = TextCapitalization.none,
      this.fillColor,
      this.isBorder = false,
        this.labelText,
        this.key = null,
        this.isAdressScreen =false

      });

  @override
  Widget build(context) {
    final _errorNotifier = ValueNotifier<bool>(false);
    return TextFormField(

      // validator: (value) {
      //   if (value != null && value.trim().length < 3) {
      //     return 'This field requires a minimum of 3 characters';
      //   }
      //
      //   return null;
      // },
      key: key,
      onTap: onTap,
      readOnly: readonly,
      style: robotoBold,
      textAlign: isBorder? TextAlign.center:TextAlign.start,
      controller: controller,
      maxLines: maxLine ?? 1,
      textCapitalization: capitalization,
      maxLength: isPhoneNumber ? 15 : null,
      focusNode: focusNode,
      keyboardType: textInputType ?? TextInputType.text,
      //keyboardType: TextInputType.number,
      initialValue: null,
      textInputAction: textInputAction ?? TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(context).requestFocus(nextNode);
      },
      //autovalidate: true,
      inputFormatters: [isPhoneNumber ? FilteringTextInputFormatter.digitsOnly : FilteringTextInputFormatter.singleLineFormatter],
      validator: (input){
        if(input.isEmpty){
          _errorNotifier.value = true;
          if(isValidator){
            return validatorMessage??"";
          }
          else {_errorNotifier.value = false;}
        }
        return null;
        },
      // decoration: InputDecoration(
      //   hintText: hintText ?? '',
      //   filled: fillColor != null,
      //   fillColor: fillColor,
      //   contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
      //   isDense: true,
      //   counterText: '',
      //   focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      //   hintStyle: titilliumRegular.copyWith(color: Theme.of(context).hintColor),
      //   errorStyle: TextStyle(height: 1.5),
      //   border: InputBorder.none,
      // ),
      decoration:  InputDecoration(
        suffixIcon: prefixIcon,

          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10), // Adjust the vertical padding here


        focusedBorder:OutlineInputBorder(

            borderSide: BorderSide(color: Colors.black,width: 2)
        ) ,
        hintStyle: robotoBold.copyWith(color: Colors.grey),
          errorStyle: robotoBold.copyWith(fontSize: 12),
          labelStyle: robotoRegular1,
          hintText: hintText,
          labelText:labelText,

          // This is the normal border
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black,width: 1)
          ),

          // This is the error border
          errorBorder: OutlineInputBorder(

              borderSide: BorderSide(color: Colors.red, width: 1))),
    );
  }
}
