import 'package:approve_reject_quotation/models/constants/webpage_constants.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class QuotationController extends GetxController {
  var quotationModel = QuotationModel();

  void updateIsApproved(bool value) {
    quotationModel.isApproved.value = value;
  }

  void updateConfirmation(String value) {
    quotationModel.confirmationValue.value = value;
  }

  void clearSelectedReason() {
    quotationModel.selectedReason.value = '';
    quotationModel.customReasonController.value.clear();
  }

  void clearError() {
    quotationModel.errorMessage.value = '';
  }

  // void setRejectionReasons(List<Suggestion> reasons) {
  //   quotationModel.suggestions.value = reasons;
  // }

  String getFinalReason() {
    String customInput = quotationModel.customReasonController.value.text;
    return customInput.isNotEmpty ? customInput : quotationModel.selectedReason.value;
  }
}
