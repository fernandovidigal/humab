import 'package:flutter/material.dart';
import 'package:humab/components/calendario.dart';
import 'package:humab/components/primary_button.dart';
import 'package:humab/functions.dart';

import 'package:humab/helpers/screen_helper.dart';
import 'package:humab/screens/welcome/widgets/date_input_field.dart';
import 'package:humab/screens/welcome/widgets/page_header.dart';

class ProximaDataPage extends StatefulWidget {
  const ProximaDataPage({Key? key, this.dataChangesCallback, this.currentData}) : super(key: key);

  final ValueChanged<DateTime>? dataChangesCallback;
  final DateTime? currentData;

  @override
  _ProximaDataPageState createState() => _ProximaDataPageState();
}

class _ProximaDataPageState extends State<ProximaDataPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _inputController = TextEditingController();
  late DateTime _selectedData;

  @override
  void initState() {
    super.initState();
    _selectedData = widget.currentData ?? DateTime.now();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _updateSelectedData(DateTime selectedDay) {
    _selectedData = selectedDay;
    if (widget.dataChangesCallback != null) {
      widget.dataChangesCallback!(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(title: "Data", subtitle: "da próxima injecção"),
          SizedBox(height: 48.h),
          Form(
            key: _formKey,
            child: DateInputField(
              controller: _inputController,
              tap: () => _showBottomSheetCalendar(context),
            ),
          ),
        ],
      ),
    );
  }

  _showBottomSheetCalendar(context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      isScrollControlled: true,
      builder: (BuildContext ctx) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.h),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    "Selecione uma data",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.h),
              Calendario(
                valueChange: _updateSelectedData,
                initialDate: _selectedData,
              ),
              SizedBox(height: 30.h),
              PrimaryButton(
                  text: "Selecionar",
                  press: () {
                    _inputController.text = formatData(_selectedData);
                    Navigator.pop(context);
                  }),
              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }
}
