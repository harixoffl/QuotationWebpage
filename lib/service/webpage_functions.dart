import 'dart:convert';

import 'package:approve_reject_quotation/api_url.dart';
import 'package:approve_reject_quotation/models/entities/Response_entities.dart';
import 'package:approve_reject_quotation/models/entities/quotationPdf_entities.dart';
import 'package:approve_reject_quotation/service/API_services/invoker.dart';
import 'package:approve_reject_quotation/styles.dart';
import 'package:approve_reject_quotation/controllers/webpage_controller.dart';
import 'package:approve_reject_quotation/views/components/basicDialog.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

mixin WebpageServices {
  final QuotationController quotationController = Get.find<QuotationController>();
  // final quotationController.quotationModel quotationController.quotationModel = Get.find<quotationController.quotationModel>();
  final Invoker apiController = Get.find<Invoker>();
  final String email = 'support@sporadasecure.com';
  final String imageUrl = 'https://sporadasecure.com/';
  final String websiteUrl = 'https://sporadasecure.com/';
  bool _isDialogShowing = false;

  Future<void> downloadPdf() async {
    const url = 'assets/pdf/anamalai.pdf'; // Path to your PDF file
    final fileName = 'analmalai${DateTime.now().millisecondsSinceEpoch}.pdf';

    try {
      // Load the PDF file as bytes
      final ByteData data = await rootBundle.load(url);
      final Uint8List bytes = data.buffer.asUint8List();

      // Save the file using FileSaver
      await FileSaver.instance.saveFile(name: fileName, bytes: bytes, ext: 'pdf');
    } catch (e) {
      print('Error downloading PDF: $e');
    }
  }

  void showReadablePdf(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            insetPadding: const EdgeInsets.all(20),
            child: SizedBox(
              width: 800,
              height: 1500,
              child: MouseRegion(
                cursor: SystemMouseCursors.basic,
                child: Builder(
                  builder: (context) {
                    if (quotationController.quotationModel.quotationPdf.value != null) {
                      return SfPdfViewer.memory(quotationController.quotationModel.quotationPdf.value!);
                    } else {
                      return const Center(child: Text('Fetching PDF', style: TextStyle(color: Colors.red, fontSize: 16)));
                    }
                  },
                ),
              ),
            ),
          ),
    );
  }

  void launchemail() async {
    final Uri gmailUri = Uri.parse('https://mail.google.com/mail/?view=cm&fs=1&to=$email&su=Support%20Request&body=Hello,');

    if (await canLaunchUrl(gmailUri)) {
      await launchUrl(gmailUri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $gmailUri');
    }
  }

  void openUrl(String url, {required LaunchMode mode}) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  void printPdfWeb(String pdfUrl) {
    final window = web.window;
    window.open(pdfUrl, "_blank");
    // window.print();
  }

  Future<bool> showQuotationDialog(BuildContext context, bool isAccepted) async {
    if (_isDialogShowing) return true; // Prevent multiple dialogs
    _isDialogShowing = true;

    // Show the dialog
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: 450,
          height: 250,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Primary_Colors.Light),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(isAccepted ? Icons.check_circle : Icons.check_circle, color: isAccepted ? Colors.green : Colors.red, size: 60),
              const SizedBox(height: 20),
              const Text('Thank You', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Primary_Colors.heading_color)),
              const SizedBox(height: 20),
              Text(
                isAccepted ? 'Quotation Accepted Successfully!' : 'Your Quotation Rejection Request has been sent.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isAccepted ? Colors.green : Colors.red),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );

    // Auto-close after delay
    await Future.delayed(const Duration(milliseconds: 1000));
    if (Get.isDialogOpen!) {
      Get.back(); // Ensure dialog is closed properly
    }

    _isDialogShowing = false;
    return true;
  }

  void showRejectionDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          color: Primary_Colors.Light,
          width: 600,
          height: 300, // Adjust width
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Reject Quotation', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Primary_Colors.heading_color)),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () async {
                        bool? confirmClose = await _showCloseConfirmationDialog(context);
                        if (confirmClose == true) {
                          quotationController.clearSelectedReason();
                          Get.back();
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Dropdown Menu Instead of DropdownButtonFormField
                Align(
                  alignment: Alignment.center,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Obx(() {
                        return DropdownMenu<String>(
                          width: constraints.maxWidth * 0.9,
                          initialSelection: quotationController.quotationModel.selectedReason.value.isEmpty ? null : quotationController.quotationModel.selectedReason.value,
                          label: const Text('Select Reason', style: TextStyle(color: Colors.grey, fontSize: 13)),
                          inputDecorationTheme: const InputDecorationTheme(
                            contentPadding: EdgeInsets.all(10),
                            filled: true,
                            fillColor: Primary_Colors.boxBackground,
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5), bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                          textStyle: const TextStyle(color: Colors.white),
                          onSelected: (value) {
                            quotationController.quotationModel.selectedReason.value = value!;
                            quotationController.quotationModel.customReasonController.value.clear();
                          },
                          controller: quotationController.quotationModel.customReasonController.value,

                          dropdownMenuEntries:
                              quotationController.quotationModel.suggestions
                                  .map<DropdownMenuEntry<String>>((Suggestion reason) => DropdownMenuEntry<String>(value: reason.suggestion, label: reason.suggestion))
                                  .toList(),
                        );
                      });
                    },
                  ),
                ),

                const SizedBox(height: 50),
                Center(
                  child: Column(
                    children: [
                      Obx(
                        () =>
                            quotationController.quotationModel.errorMessage.value.isNotEmpty
                                ? Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(quotationController.quotationModel.errorMessage.value, style: const TextStyle(color: Colors.red, fontSize: 14)),
                                )
                                : const SizedBox(),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    width: 150,
                    padding: const EdgeInsets.all(8), // Padding around the button
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.green, Colors.lightGreen], // Define gradient colors
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (quotationController.quotationModel.selectedReason.value.isNotEmpty || quotationController.quotationModel.customReasonController.value.text.isNotEmpty) {
                          quotationController.clearSelectedReason();
                          showQuotationDialog(context, false);
                          await Future.delayed(Duration(milliseconds: 1000));
                          quotationController.clearError();

                          //   Get.back();
                          //   Navigator.pop(context);
                          // } else {
                          //   quotationController.quotationModel.errorMessage.value='Please fill all fields';

                          // }
                          if (Get.isDialogOpen!) {
                            Get.back(); // Close rejection dialog only if still open
                          }
                        } else {
                          quotationController.quotationModel.errorMessage.value = 'Please select or enter a reason';
                        }
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, // Transparent to let gradient show
                        shadowColor: Colors.transparent, // Remove shadow
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white, // Ensure text is visible on the gradient
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future<bool?> _showCloseConfirmationDialog(BuildContext context) {
    return Get.dialog<bool>(
      AlertDialog(
        title: const Text('Confirm Close'),
        content: const Text('Are you sure you want to close the rejection dialog?'),
        actions: [
          TextButton(onPressed: () => Get.back(result: false), child: const Text('Cancel', style: TextStyle(color: Colors.blue))),
          TextButton(onPressed: () => Get.back(result: true), child: const Text('OK', style: TextStyle(color: Colors.blue))),
        ],
      ),
    );
  }

  void GetQuoteDetails(BuildContext context) async {
    try {
      var requestBody = {"eventid": 1};
      String encodedData = json.encode(requestBody);
      Map<String, dynamic>? response = await apiController.SendByQuerystring(encodedData, API.GetAlldetails_API, quotationController.quotationModel.secret);
      if (response['statusCode'] == 200) {
        CMDmResponse value = CMDmResponse.fromJson(response);
        if (value.code) {
          print(value.data);
          await Basic_dialog(context: context, title: "LOGO", content: value.message!, onOk: () {});
        } else {
          await Basic_dialog(context: context, title: 'Uploading Logo', content: value.message ?? "", onOk: () {});
        }
      } else {
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Basic_dialog(context: context, title: "ERROR", content: "$e");
    }
  }
}
