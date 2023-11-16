import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sellersapp/const/const.dart';
import 'package:sellersapp/views/widgets/text_style.dart';

Widget customTextField({label,hint,controller, isDesc = false}) {
  return TextFormField(
    style: const TextStyle(color: Colors.white),
    controller: controller,
    maxLines: isDesc ? 4 : 1,
    decoration: InputDecoration(
      isDense: true,
      label: normalText(text: label),
      enabledBorder: OutlineInputBorder(
        borderRadius:  BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: white,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius:  BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: white,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius:  BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: white,
        ),
      ),
      hintText: hint,
      hintStyle: const TextStyle(color: lightGrey),
    ),
  );
}