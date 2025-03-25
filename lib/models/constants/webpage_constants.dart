import 'dart:typed_data';

import 'package:approve_reject_quotation/models/entities/webpage_entities.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class QuotationModel {
  final isApproved = false.obs;
  var clientName = "Hello PATTUKOTTAI MTEENZ T5,";
  var content_1 = "We hope you're doing well. Please find your Quotation from Sporada Secure.";
  var sub_content = "If you would like to proceed with the Quotation, please confirm by clicking the button below";
  final confirmationValue = ''.obs;
  final isDownloading = false.obs;
  final phoneNumber = '739975001';
  final message = 'Hello';
  final selectedReason = ''.obs;
  final errorMessage = ''.obs;
  final customReasonController = TextEditingController().obs;
  final suggestions = <Suggestion>[].obs;
  final isLoading = false.obs;
  final secret = '15b97956-b296-11';
  var quotationPdf = Rx<Uint8List?>(null);
  final imageUrl = 'https://sporadasecure.com/';
  final websiteUrl = 'https://sporadasecure.com/';
  final localEmail = 'support@sporadasecure.com';
}
