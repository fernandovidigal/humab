import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:humab/components/list_item_bg.dart';
import 'package:humab/constants.dart';
import 'package:humab/models/contactos.dart';
import 'package:humab/helpers/screen_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactosItem extends StatelessWidget {
  const ContactosItem({
    Key? key,
    required this.contacto,
  }) : super(key: key);

  final Contactos contacto;

  @override
  Widget build(BuildContext context) {
    return ListItemBackground(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            padding: EdgeInsets.all(9.w),
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(opcoesContactos[contacto.tipo]['svgIcon']!),
          ),
          SizedBox(width: 24.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  opcoesContactos[contacto.tipo]['nome']!,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  contacto.nome,
                  style: TextStyle(
                    fontSize: 22.sp,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  contacto.local,
                  style: TextStyle(
                    color: const Color(0xFFA5A5A5),
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                if (contacto.contacto != null)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Contacto Telefónico",
                          style: TextStyle(fontSize: 12.sp, color: kGreyColor),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          contacto.contacto.toString(),
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 2.h),
                if (contacto.email != null)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: TextStyle(fontSize: 12.sp, color: kGreyColor),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          contacto.email!,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 10.h),
                if (contacto.contacto != null || contacto.email != null)
                  Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Row(
                      children: [
                        if (contacto.contacto != null)
                          Padding(
                            padding: EdgeInsets.only(right: 30.w),
                            child: GestureDetector(
                              onTap: () => launch("tel:${contacto.contacto}"),
                              child: Column(
                                children: [
                                  Container(
                                    width: 46.w,
                                    height: 46.w,
                                    padding: EdgeInsets.all(12.w),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kLightBlue,
                                    ),
                                    child: SvgPicture.asset("assets/icons/chamada.svg"),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    "Telefonar",
                                    style: TextStyle(color: kGreyColor, fontSize: 13.sp, letterSpacing: .4),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (contacto.contacto != null)
                          Padding(
                            padding: EdgeInsets.only(right: 30.w),
                            child: GestureDetector(
                              onTap: () => launch("sms:${contacto.contacto}"),
                              child: Column(
                                children: [
                                  Container(
                                    width: 46.w,
                                    height: 46.w,
                                    padding: EdgeInsets.all(12.w),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kLightBlue,
                                    ),
                                    child: SvgPicture.asset("assets/icons/sms.svg"),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    "Mensagem",
                                    style: TextStyle(color: kGreyColor, fontSize: 13.sp, letterSpacing: .4),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (contacto.email != null)
                          GestureDetector(
                            onTap: () => launch("mailto:${contacto.email}"),
                            child: Column(
                              children: [
                                Container(
                                  width: 46.w,
                                  height: 46.w,
                                  padding: EdgeInsets.all(12.w),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kLightBlue,
                                  ),
                                  child: SvgPicture.asset("assets/icons/email.svg"),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "Email",
                                  style: TextStyle(color: kGreyColor, fontSize: 13.sp, letterSpacing: .4),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
