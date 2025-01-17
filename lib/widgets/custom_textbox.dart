import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:smart_case/theme/color.dart';

class CustomTextBox extends StatelessWidget {
  const CustomTextBox({
    Key? key,
    this.hint = "",
    this.prefix,
    this.controller,
    this.readOnly = false,
    this.onChanged,
    this.onTap,
    this.autoFocus = false,
  }) : super(key: key);

  final String hint;
  final Widget? prefix;
  final bool readOnly;
  final bool autoFocus;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return (readOnly) ? _buildTextFieldButton() : _buildTextField();
  }

  _buildTextField() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 3),
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.appBgColor,
        border: Border.all(color: AppColors.textBoxColor),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withOpacity(.05),
            spreadRadius: .5,
            blurRadius: .5,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              readOnly: readOnly,
              controller: controller,
              onChanged: onChanged,
              autofocus: autoFocus,
              decoration: InputDecoration(
                prefixIcon: prefix,
                border: InputBorder.none,
                hintText: hint,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }

  _buildTextFieldButton() {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(bottom: 3),
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.appBgColor,
          border: Border.all(color: AppColors.textBoxColor),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor.withOpacity(.05),
              spreadRadius: .5,
              blurRadius: .5,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: TextField(
          readOnly: readOnly,
          controller: controller,
          onTap: onTap,
          decoration: InputDecoration(
            prefixIcon: prefix,
            border: InputBorder.none,
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
        ));
  }
}

class CustomTextArea extends StatelessWidget {
  const CustomTextArea(
      {super.key,
      this.hint = '',
      this.readOnly = false,
      this.autoFocus = false,
      this.controller,
      this.onChanged,
      this.minLines = 5,
      this.onTap});

  final String hint;
  final bool readOnly;
  final bool autoFocus;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function()? onTap;
  final int minLines;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  _buildBody() {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          autofocus: autoFocus,
          onChanged: onChanged,
          minLines: minLines,
          maxLines: 500,
          onTap: onTap,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.textBoxColor,
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.inActiveColor),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}

class SmartCaseTextField extends StatelessWidget {
  const SmartCaseTextField(
      {super.key, required this.hint, required this.controller});

  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  _buildBody() {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.textBoxColor,
              hintText: hint,
              hintStyle:
                  const TextStyle(color: AppColors.inActiveColor, fontSize: 15),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class SmartCaseNumberField extends StatelessWidget {
  const SmartCaseNumberField(
      {super.key, required this.hint, required this.controller});

  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  _buildBody() {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.textBoxColor,
              hintText: hint,
              hintStyle:
                  const TextStyle(color: AppColors.inActiveColor, fontSize: 15),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter()],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class SmartText extends StatelessWidget {
  const SmartText(
      {super.key,
      required this.value,
      required this.icon,
      required this.color});

  final IconData icon;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  _buildBody() {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.textBoxColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: TextStyle(color: color, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
