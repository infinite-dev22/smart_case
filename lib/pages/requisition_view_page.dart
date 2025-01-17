import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:intl/intl.dart';
import 'package:smart_case/models/smart_requisition.dart';
import 'package:smart_case/services/apis/smartcase_api.dart';
import 'package:smart_case/widgets/custom_textbox.dart';
import 'package:smart_case/widgets/requisition/requisition_item.dart';
import 'package:toast/toast.dart';

import '../theme/color.dart';
import '../util/smart_case_init.dart';
import '../widgets/custom_appbar.dart';

class RequisitionViewPage extends StatefulWidget {
  const RequisitionViewPage({super.key});

  @override
  State<RequisitionViewPage> createState() => _RequisitionViewPageState();
}

class _RequisitionViewPageState extends State<RequisitionViewPage> {
  final ToastContext toast = ToastContext();

  late SmartRequisition requisition;

  TextEditingController commentController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  bool isHeadElevated = false;
  NumberFormat formatter =
      NumberFormat('###,###,###,###,###,###,###,###,###.##');

  @override
  Widget build(BuildContext context) {
    toast.init(context);
    requisition =
        ModalRoute.of(context)!.settings.arguments as SmartRequisition;
    amountController.text = formatter.format(double.parse(requisition.amount!));

    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.white,
        ),
        backgroundColor: AppColors.primary,
        title: AppBarContent(
          isNetwork: currentUser.avatar != null ? true : false,
          canNavigate: true,
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final ScrollController scrollController = ScrollController();
    return Column(
      children: [
        _buildHead('Process Requisition'),
        Expanded(
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              children: [
                RequisitionItem(
                  color: AppColors.white,
                  padding: 10,
                  requisition: requisition,
                ),
                _buildAmountHolder(),
                CustomTextArea(
                  hint: "Add comments",
                  controller: commentController,
                ),
                const SizedBox(height: 20),
                _buildButtons(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHead(String name) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.primary,
        border: Border.all(color: AppColors.primary),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withOpacity(.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0.0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: Text(
          name,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.white),
        ),
      ),
    );
  }

  Widget _buildAmountHolder() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.textBoxColor),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withOpacity(.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: SizedBox(
        height: 50,
        child: TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.textBoxColor,
            hintStyle:
                const TextStyle(color: AppColors.inActiveColor, fontSize: 15),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            CurrencyInputFormatter(),
          ],
          readOnly:
              (requisition.requisitionStatus!.code == "PRIMARY_APPROVED" &&
                      requisition.requisitionStatus!.code == "APPROVED")
                  ? true
                  : false,
          enabled: (requisition.requisitionStatus!.code == "PRIMARY_APPROVED" &&
                  requisition.requisitionStatus!.code == "APPROVED")
              ? false
              : true,
          controller: amountController,
          autofocus: false,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return (requisition.canPay == true)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: _payoutRequisition,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => AppColors.green),
                ),
                child: const Text(
                  'Pay out',
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: _approveRequisition,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => AppColors.green),
                ),
                child: const Text(
                  'Approve',
                ),
              ),
              FilledButton(
                onPressed: _returnRequisition,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => AppColors.orange),
                ),
                child: const Text(
                  'Return',
                ),
              ),
              FilledButton(
                onPressed: _rejectRequisition,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => AppColors.red),
                ),
                child: const Text(
                  'Reject',
                ),
              ),
            ],
          );
  }

  _payoutRequisition() {
    _submitData("PAY_OUT", 'Pay out successful');
  }

  _approveRequisition() {
    if (requisition.requisitionStatus!.code == 'EDITED' ||
        requisition.requisitionStatus!.code == "SUBMITTED") {
      if (requisition.canApprove == 'LV1') {
        _submitData("APPROVED", 'Requisition approved');
      } else if (requisition.canApprove == 'LV2') {
        _submitData("PRIMARY_APPROVED", 'Requisition primarily approved');
      }
    } else if (requisition.requisitionStatus!.code == "PRIMARY_APPROVED") {
      _submitData("SECONDARY_APPROVED", 'Requisition approved');
    }
  }

  _returnRequisition() {
    if (requisition.requisitionStatus!.code == 'EDITED' ||
        requisition.requisitionStatus!.code == "SUBMITTED") {
      if (requisition.canApprove == 'LVL1') {
        _submitData("RETURNED", 'Action successful');
      } else if (requisition.canApprove == 'LVL2') {
        _submitData("PRIMARY_RETURNED", 'Action successful');
      }
    } else if (requisition.requisitionStatus!.code == "PRIMARY_RETURNED") {
      _submitData("SECONDARY_RETURNED", 'Action successful');
    }
  }

  _rejectRequisition() {
    if (requisition.requisitionStatus!.code == 'EDITED' ||
        requisition.requisitionStatus!.code == "SUBMITTED") {
      if (requisition.canApprove == 'LVL1') {
        _submitData("REJECTED", 'Action successful');
      } else if (requisition.canApprove == 'LVL2') {
        _submitData("PRIMARY_REJECTED", 'Action successful');
      }
    } else if (requisition.requisitionStatus!.code == "PRIMARY_REJECTED") {
      _submitData("SECONDARY_REJECTED", 'Action successful');
    }
  }

  _onSuccess(String text) {
    Toast.show(text, duration: Toast.lengthLong, gravity: Toast.bottom);
    Navigator.pop(context);
  }

  _onError() {
    Toast.show("An error occurred",
        duration: Toast.lengthLong, gravity: Toast.bottom);
  }

  _submitData(String value, String toastText) {
    SmartCaseApi.smartPost(
      'api/accounts/requisitions/${requisition.id}/process',
      currentUser.token,
      {
        "forms": 1,
        "payout_amount": amountController.text.trim(),
        "action_comment": commentController.text.trim(),
        "submit": value,
      },
      onSuccess: () => _onSuccess(toastText),
      onError: _onError,
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
