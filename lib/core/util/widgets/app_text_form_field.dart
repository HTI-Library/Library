import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';

import '../constants.dart';

class AppTextFormField extends StatefulWidget {
  final String label;
  final Widget? icon;
  final String hint;
  final bool isPassword;
  final Function callbackHandle;
  final ValueChanged<String>? onChanged;
  final TextInputType type;

  const AppTextFormField({
    Key? key,
    this.label = '',
    this.icon,
    required this.hint,
    this.type = TextInputType.text,
    this.isPassword = false,
    this.onChanged,
    required this.callbackHandle,
  }) : super(key: key);

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  final TextEditingController textEditingController = TextEditingController();
  bool isShown = true;

  @override
  Widget build(BuildContext context) {
    widget.callbackHandle(textEditingController);

    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return Container(
          height: 55.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: HexColor(greyWhite),
          ),
          child: TextFormField(
            style: Theme.of(context).textTheme.subtitle2,
            keyboardType: widget.type,
            controller: textEditingController,
            obscureText: widget.isPassword ? isShown : false,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: MainCubit.get(context).isDark
                      ? HexColor(grey)
                      : secondaryVariant,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              hintStyle: Theme.of(context).textTheme.bodyText1,
              hintText: widget.hint,
              contentPadding: const EdgeInsetsDirectional.only(
                start: 15.0,
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                padding: const EdgeInsets.all(15.0),
                onPressed: () {
                  setState(() {
                    isShown = !isShown;
                  });
                },
                icon: Image(
                  image: isShown
                      ? const AssetImage('assets/images/eye_slash.png')
                      : const AssetImage('assets/images/eye.png'),
                ),
              )
                  : Padding(
                padding: const EdgeInsetsDirectional.all(15.0),
                child: widget.icon,
              ),
            ),
          ),
        );
      },
    );
  }
}