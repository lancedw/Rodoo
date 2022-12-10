import 'package:flutter/material.dart';
import 'package:rodoo/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:rodoo/utils/theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateSheet extends StatefulWidget {
  final List<DateTime> dates;

  const DateSheet({required this.dates, Key? key}) : super(key: key);

  @override
  State<DateSheet> createState() => _DateSheetState();
}

class _DateSheetState extends State<DateSheet> {
  DateRangePickerYearCellStyle customYearCellStyle =
      DateRangePickerYearCellStyle(
    textStyle: const TextStyle(
      fontSize: 15,
      color: Colors.black,
    ),
    todayTextStyle: generalBoldTextStyle.copyWith(
      color: kPrimaryColor,
      fontSize: 15,
    ),
  );

  DateRangePickerMonthCellStyle customMonthCellStyle =
      DateRangePickerMonthCellStyle(
    textStyle: const TextStyle(
      fontSize: 15,
      color: Colors.black,
    ),
    todayTextStyle: generalBoldTextStyle.copyWith(
      color: kPrimaryColor,
      fontSize: 15,
    ),
    weekendTextStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  );

  late List<DateTime> selectedDates;

  @override
  void initState() {
    selectedDates = widget.dates;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.70,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "When",
                  style: restoNameTextStyle,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 28,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 400,
              child: SfDateRangePicker(
                initialSelectedDates: selectedDates,
                view: DateRangePickerView.month,
                monthViewSettings: const DateRangePickerMonthViewSettings(
                  weekendDays: <int>[6, 7],
                  firstDayOfWeek: 1,
                ),
                selectionMode: DateRangePickerSelectionMode.multiple,
                yearCellStyle: customYearCellStyle,
                monthCellStyle: customMonthCellStyle,
                selectionColor: kPrimaryColor,
                selectionTextStyle: generalBoldTextStyle.copyWith(
                  fontSize: 15,
                  color: Colors.white,
                ),
                todayHighlightColor: kPrimaryColor,
                showNavigationArrow: true,
                enablePastDates: false,
                headerHeight: 80,
                headerStyle: DateRangePickerHeaderStyle(
                  textAlign: TextAlign.center,
                  textStyle: generalBoldTextStyle.copyWith(
                    fontSize: 18,
                  ),
                ),
                onSelectionChanged: (selection) {
                  selectedDates = selection.value;
                },
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 44,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                ),
                onPressed: () {
                  Navigator.pop(context, selectedDates);
                },
                child: Text(
                  "Apply filters",
                  style: generalTextStyle.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
