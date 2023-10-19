import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/color.dart';

class DateTimeAccordion extends StatefulWidget {
  const DateTimeAccordion({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  State<DateTimeAccordion> createState() => _DateTimeAccordionState();
}

class _DateTimeAccordionState extends State<DateTimeAccordion> {
  bool isDate = true;
  bool isTime = true;

  late bool _showContent;

  late double _height = 200;

  DateTime now = DateTime.now();

  String selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String selectedTime = DateFormat('h:mm a').format(DateTime.now());
  String selectedTime2 =
      DateFormat('h:mm a').format(DateTime.now().add(const Duration(hours: 1)));

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(children: [
        _buildTimeField(selectedDate, selectedTime),
        // Show or hide the content based on the state
        _showContent
            ? Container(
                height: _height,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: (isDate)
                    ? CalendarDatePicker(
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year),
                        lastDate: DateTime(DateTime.now().year + 99),
                        onDateChanged: (DateTime newDate) {
                          setState(() {
                            selectedDate =
                                DateFormat('dd/MM/yyyy').format(newDate);
                          });
                        },
                      )
                    : (isTime)
                        ? CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            initialDateTime: DateTime.now(),
                            onDateTimeChanged: (DateTime newTime) {
                              setState(() {
                                selectedTime =
                                    DateFormat('h:mm a').format(newTime);
                              });
                            },
                          )
                        : CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            initialDateTime:
                                DateTime.now().add(const Duration(hours: 1)),
                            onDateTimeChanged: (DateTime newTime) {
                              setState(() {
                                selectedTime2 =
                                    DateFormat('h:mm a').format(newTime);
                              });
                            },
                          ),
              )
            : Container()
      ]),
    );
  }

  _buildTimeField(String date, String time) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.name),
              Row(
                children: [
                  SizedBox(
                    height: 40,
                    child: FilledButton(
                      onPressed: () {
                        setState(() {
                          isDate = true;
                          // if (_showContent) {
                          //   _showContent = !_showContent;
                          //   _showContent = true;
                          //   return;
                          // }
                          _height = 280;
                          _showContent = !_showContent;
                        });
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => AppColors.appBgColor)),
                      child: Text(
                        date,
                        style: const TextStyle(color: AppColors.darker),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 40,
                    child: FilledButton(
                      onPressed: () {
                        setState(() {
                          isTime = false;
                          isDate = false;
                          if (_showContent && isTime == false) {
                            _showContent = !_showContent;
                            _showContent = true;
                            return;
                          }
                          _height = 200;
                          _showContent = !_showContent;
                        });
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => AppColors.appBgColor)),
                      child: Text(
                        time,
                        style: const TextStyle(color: AppColors.darker),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _showContent = false;
  }
}

class DateTimeAccordion2 extends StatefulWidget {
  const DateTimeAccordion2({Key? key, required this.date, required this.startTime, required this.endTime}) : super(key: key);

  final TextEditingController date;
  final TextEditingController startTime;
  final TextEditingController endTime;

  @override
  State<DateTimeAccordion2> createState() => _DateTimeAccordion2State();
}

class _DateTimeAccordion2State extends State<DateTimeAccordion2> {
  bool isDate = true;
  bool isStartTime = true;
  bool isEndTime = true;

  late bool _showContent;

  late double _height = 200;

  DateTime now = DateTime.now();

  String selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String selectedTime = DateFormat('h:mm a').format(DateTime.now());
  String selectedTime2 =
      DateFormat('h:mm a').format(DateTime.now().add(const Duration(hours: 1)));

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(children: [
        _buildTimeField(selectedDate, selectedTime, selectedTime2),
        // Show or hide the content based on the state
        _showContent
            ? Container(
                height: _height,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: (isDate)
                    ? CalendarDatePicker(
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year),
                        lastDate: DateTime(DateTime.now().year + 99),
                        onDateChanged: (DateTime newDate) {
                          setState(() {
                            selectedDate =
                                DateFormat('dd/MM/yyyy').format(newDate);
                            widget.date.text = selectedDate;
                          });
                        },
                      )
                    : (isStartTime)
                        ? CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            initialDateTime: DateTime.now(),
                            onDateTimeChanged: (DateTime newTime) {
                              setState(() {
                                selectedTime =
                                    DateFormat('h:mm a').format(newTime);
                                widget.startTime.text = selectedTime;

                              });
                            },
                          )
                        : CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            initialDateTime:
                                DateTime.now().add(const Duration(hours: 1)),
                            onDateTimeChanged: (DateTime newTime) {
                              setState(() {
                                selectedTime2 =
                                    DateFormat('h:mm a').format(newTime);
                                widget.endTime.text = selectedTime2;
                              });
                            },
                          ),
              )
            : Container()
      ]),
    );
  }

  _buildTimeField(String date, String timeStart, String timeEnd) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 40,
                child: FilledButton(
                  onPressed: () {
                    setState(() {
                      isDate = true;

                      if (_showContent && isStartTime || isEndTime) {
                        isEndTime = false;
                        isStartTime = false;
                        _height = 280;
                        _showContent = true;
                        return;
                      }

                      isEndTime = false;
                      isStartTime = false;
                      _height = 280;
                      _showContent = !_showContent;
                    });
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => AppColors.appBgColor)),
                  child: Text(
                    date,
                    style: const TextStyle(color: AppColors.darker),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                child: FilledButton(
                  onPressed: () {
                    setState(() {
                      isStartTime = true;

                      if (_showContent && isDate || isEndTime) {
                        isDate = false;
                        isEndTime = false;
                        _showContent = true;
                        _height = 200;
                        return;
                      }

                      isDate = false;
                      isEndTime = false;
                      _height = 200;
                      _showContent = !_showContent;
                    });
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => AppColors.appBgColor)),
                  child: Text(
                    timeStart,
                    style: const TextStyle(color: AppColors.darker),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                child: FilledButton(
                  onPressed: () {
                    setState(() {
                      isEndTime = true;

                      if (_showContent && isStartTime || isDate) {
                        isDate = false;
                        isStartTime = false;
                        _showContent = true;
                        _height = 200;
                        return;
                      }

                      isDate = false;
                      isStartTime = false;
                      _height = 200;
                      _showContent = !_showContent;
                    });
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => AppColors.appBgColor)),
                  child: Text(
                    timeEnd,
                    style: const TextStyle(color: AppColors.darker),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _showContent = false;
  }
}

class DateAccordion extends StatefulWidget {
  const DateAccordion({Key? key, required this.onDateChanged})
      : super(key: key);

  /// Called when the user selects a date in the picker.
  final ValueChanged<DateTime> onDateChanged;

  @override
  State<DateAccordion> createState() => _DateAccordionState();
}

class _DateAccordionState extends State<DateAccordion> {
  late bool _showContent;

  late final double _height = 280;

  DateTime now = DateTime.now();

  String selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String selectedTime = DateFormat('h:mm a').format(DateTime.now());
  String selectedTime2 =
      DateFormat('h:mm a').format(DateTime.now().add(const Duration(hours: 1)));

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(children: [
        _buildTimeField(selectedDate),
        _showContent
            ? Container(
                height: _height,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: CalendarDatePicker(
                  initialDate: DateTime.now(),
                  firstDate: DateTime(DateTime.now().year),
                  lastDate: DateTime(DateTime.now().year + 99),
                  onDateChanged: (DateTime newDate) {
                    setState(() {
                      selectedDate = DateFormat('dd/MM/yyyy').format(newDate);

                      widget.onDateChanged(newDate);
                    });
                  },
                ),
              )
            : Container()
      ]),
    );
  }

  _buildTimeField(String date) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showContent = !_showContent;
        });
      },
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(date),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                    _showContent
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 18),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _showContent = false;
  }
}