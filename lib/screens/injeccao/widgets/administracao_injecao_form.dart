import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:humab/constants.dart';
import 'package:humab/functions.dart';
import 'package:humab/helpers/screen_helper.dart';
import 'package:humab/models/injecao.dart';

class AdministracaoInjecaoForm extends StatelessWidget {
  const AdministracaoInjecaoForm({
    Key? key,
    required GlobalKey<FormState> formKey,
    this.press,
    required this.injecao,
    required this.saved,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final VoidCallback? press;
  final Injecao injecao;
  final Function(String?) saved;

  @override
  Widget build(BuildContext context) {
    final _diasAtraso = daysBetween(injecao.data, DateTime.now());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              formatData(injecao.data),
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (_diasAtraso > 0) SizedBox(width: 10.w),
            if (_diasAtraso > 0)
              Text(
                "($_diasAtraso dias atrasada)",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: kPrimaryColor,
                ),
              ),
          ],
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 45.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 230.w,
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    style: TextStyle(fontSize: 20.sp),
                    keyboardType: TextInputType.number,
                    textAlignVertical: TextAlignVertical.center,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                    onSaved: saved,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
                      labelText: "Nº Lote",
                      labelStyle: TextStyle(
                        fontSize: 16.sp,
                        color: kGreyColor,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: kLightGrey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: kLightGrey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      errorStyle: const TextStyle(height: 0),
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    )),
                onPressed: press,
                child: SvgPicture.asset('assets/icons/seringa.svg'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
