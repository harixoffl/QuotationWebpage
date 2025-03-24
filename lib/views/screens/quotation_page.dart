import 'package:approve_reject_quotation/styles.dart';
import 'package:approve_reject_quotation/controllers/webpage_controller.dart';
import 'package:approve_reject_quotation/service/webpage_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class QuotationPage extends StatefulWidget with WebpageServices {
  QuotationPage({super.key, required this.event_id, required this.secret});

  final String event_id;
  final String secret;

  @override
  State<QuotationPage> createState() => _QuotationPageState();
}

class _QuotationPageState extends State<QuotationPage> with SingleTickerProviderStateMixin {
  final QuotationController quotationController = Get.find<QuotationController>();

  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  final String imageUrl = 'https://sporadasecure.com/';
  final String websiteUrl = 'https://sporadasecure.com/';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 4), vsync: this);

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Start the animation when the page opens and keep it looping
    _controller.repeat(reverse: true);
    widget.GetQuoteDetails(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // print(screenWidth);
    // print(screenHeight);

    // double referenceWidth=1920;
    // double referenceHeight=945;
    // double widthFactor=screenWidth /referenceWidth;
    // double heightFactor=screenHeight/referenceHeight;

    return Scaffold(
      backgroundColor: Primary_Colors.Dark,
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                Container(
                  width: screenWidth > 1130 ? screenWidth - 610 : screenWidth,
                  color: Primary_Colors.Light,
                  // Vertical scrolling
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo and title row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Logo on the top left
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Event Details"),
                                    content: Column(mainAxisSize: MainAxisSize.min, children: [Text("Event ID: ${widget.event_id}"), Text("Secret: ${widget.secret}")]),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Close"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text("Show Event Details"),
                          ),
                          const SizedBox(width: 280), // Space between logo and text
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(top: 35, bottom: 10),
                              alignment: Alignment.topCenter,
                              child: Animate(
                                effects: [FadeEffect(duration: 500.ms), SlideEffect(begin: Offset(0, -1), end: Offset(0, 0), duration: 800.ms)],
                                child: Text('YOUR QUOTATION FROM SPORADA SECURE', style: TextStyle(color: Colors.white, fontSize: screenWidth > 1330 ? 22 : 16, fontWeight: FontWeight.w900)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Divider(
                        color: Colors.white, // Match your theme
                        thickness: 0.2, // Line thickness
                        indent: 20, // Optional: space from the left
                        endIndent: 20, // Optional: space from the right
                      ),

                      const SizedBox(height: 5),

                      // Greeting message
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text('Hello PATTUKOTTAI MTEENZ T5,', style: TextStyle(fontSize: screenWidth > 1330 ? 18 : 14, color: Colors.white, fontWeight: FontWeight.w800)),
                      ),
                      const SizedBox(height: 5),

                      // Additional message
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          "We hope you're doing well. Please find your Quotation from Sporada Secure Private Limited below.",
                          style: TextStyle(
                            fontSize: screenWidth > 1330 ? 18 : 14,
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Container(
                          height: 735,
                          width: 525,
                          // padding: EdgeInsets.only(),
                          color: Primary_Colors.Dark,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('Double Tap on PDF to View', style: TextStyle(fontSize: 9, color: Primary_Colors.heading_color)),
                              Expanded(
                                child: GestureDetector(
                                  child: Stack(
                                    children: [
                                      Obx(() {
                                        if (quotationController.quotationModel.quotationPdf.value != null) {
                                          return SfPdfViewer.memory(
                                            quotationController.quotationModel.quotationPdf.value!,
                                            canShowScrollHead: false,
                                            canShowScrollStatus: false,
                                            enableTextSelection: false,
                                            onTextSelectionChanged: (details) {},
                                            onDocumentLoaded: (details) {
                                              print('Pdf loaded Successfully');
                                            },
                                            onDocumentLoadFailed: (details) {
                                              print('Error: ${details.description}');
                                            },
                                            canShowPageLoadingIndicator: false,
                                          );
                                        } else {
                                          return const Center(child: Text('Fetching PDF'));
                                        }
                                      }),
                                      Align(
                                        alignment: AlignmentDirectional.bottomEnd,
                                        child: Padding(padding: const EdgeInsets.all(5), child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)))),
                                      ),
                                    ],
                                  ),
                                  onDoubleTap: () {
                                    widget.GetQuoteDetails(context);
                                    widget.showReadablePdf(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Space at the bottom
                    ],
                  ),
                ),

                // Right side static container
                Container(
                  width: screenWidth > 1130 ? 600 : screenWidth,
                  // height: double.infinity,
                  color: Primary_Colors.Dark,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RotationTransition(turns: _rotationAnimation, child: Icon(Icons.article, color: Primary_Colors.boxBackground, size: 50)),

                              SizedBox(height: 10),
                              Text('QUOTATION RESPONSE', style: TextStyle(fontSize: 18, color: Primary_Colors.heading_color, fontWeight: FontWeight.w900)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      SizedBox(
                        width: 600,
                        child: Center(
                          // margin: EdgeInsets.only(left: 40),
                          // padding: const EdgeInsets.only(left: 80, bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('File Name', style: TextStyle(color: Colors.grey, fontSize: 10)),
                                  SizedBox(height: 4),
                                  Text('Installation Invoice.pdf', style: TextStyle(color: Primary_Colors.Color_1, fontSize: 17)),
                                  SizedBox(height: 25),
                                  Text('Mailed By', style: TextStyle(color: Colors.grey, fontSize: 10)),
                                  SizedBox(height: 4),
                                  Text('sporadasecure.com', style: TextStyle(color: Primary_Colors.Color_1, fontSize: 17)),
                                ],
                              ),
                              // SizedBox(width: 65),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Dated On', style: TextStyle(color: Colors.grey, fontSize: 10)),
                                  SizedBox(height: 4),
                                  Text('March 14, 2025', style: TextStyle(color: Primary_Colors.Color_1, fontSize: 17)),
                                  SizedBox(height: 25),
                                  Text('From', style: TextStyle(color: Colors.grey, fontSize: 10)),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.description, color: Color.fromARGB(255, 213, 212, 212), size: 12),
                                      SizedBox(width: 4),
                                      Text('Sporada Alerts', style: TextStyle(color: Primary_Colors.Color_1, fontSize: 17)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 30),
                      Container(
                        margin: const EdgeInsets.only(left: 25, right: 10),
                        width: double.infinity,
                        child: Center(
                          child: const Text(
                            'If you would like to proceed with the Quotation, please confirm by clicking the button below:',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              // fontWeight: FontWeight.w400,
                              // fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), padding: const EdgeInsets.all(20)),
                            onPressed: () async {
                              bool isClosed = await widget.showQuotationDialog(context, true);

                              if (!isClosed) {
                                await Future.delayed(const Duration(milliseconds: 1000));
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context); // Ensure it does not pop again if already dismissed
                                }
                              }
                            },
                            child: const Text('Confirm Approval', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                          SizedBox(width: 30),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), padding: const EdgeInsets.all(20)),
                            onPressed: () async {
                              widget.showRejectionDialog(context);
                            },
                            child: const Text('Reject Quotation', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ],
                      ),

                      SizedBox(height: 25),
                      Container(
                        margin: const EdgeInsets.only(left: 25, right: 10),
                        width: double.infinity,
                        child: Center(
                          child: const Text(
                            'If you have any questions regarding your quotation or need further assistance, please feel free to contact us.',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              // fontWeight: FontWeight.w400,
                              // fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        width: 500,
                        margin: EdgeInsets.only(),
                        padding: const EdgeInsets.only(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Regards,', style: TextStyle(color: Colors.white, fontSize: 18)),
                            SizedBox(height: 5),
                            Text('Sporada Secure India Private India', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(height: 5),
                            Text('Contact : + 91 73997 50001', style: TextStyle(color: Colors.white, fontSize: 18)),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Email :', style: TextStyle(color: Colors.white, fontSize: 18)),
                                SizedBox(width: 4),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: widget.launchemail,
                                    child: const Text(
                                      'support@sporadasecure.com',
                                      style: TextStyle(color: Colors.blue, fontSize: 18, decoration: TextDecoration.underline, decorationColor: Colors.blue),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.only(left: 15, top: 5),
                        margin: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Sporada Secure Support Team', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey, fontSize: 12)),
                            const SizedBox(height: 8),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () => widget.openUrl(imageUrl, mode: LaunchMode.externalApplication),
                                child: Image.asset(
                                  'assets/images/leaf.png',
                                  height: 70,
                                  width: 100,
                                  // color: Colors.white,r
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text('Sporada Secure India Private Limited', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 14)),
                            const SizedBox(height: 2),
                            const Text('687/7, Trichy Road, Ramanathapuram,\nCoimbatore - 641045, Tamilnadu, India.', style: TextStyle(color: Colors.grey, fontSize: 14)),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Visit our Website: ', style: TextStyle(fontSize: 14, color: Colors.grey)),
                                SizedBox(width: 4),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () => widget.openUrl(websiteUrl, mode: LaunchMode.externalApplication),
                                    child: const Text('www.sporadasecure.com', style: TextStyle(color: Colors.lightGreen, fontSize: 14)),
                                  ),
                                ),
                              ],
                            ),
                            // //  const SizedBox(height: 2),
                            // const Divider(
                            //   color: Colors.white, // Match your theme
                            //   thickness: 0.1,        // Line thickness
                            //   indent: 20,          // Optional: space from the left
                            //   endIndent: 20,       // Optional: space from the right
                            // ),
                            SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () async {
                                      await widget.downloadPdf();
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(top: 4),
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), shape: BoxShape.circle),
                                          child: Icon(Icons.download, color: Colors.blue, size: 24),
                                        ),
                                        SizedBox(height: 4),
                                        Text("Download", style: TextStyle(fontSize: 12, color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                ),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () async {
                                      widget.printPdfWeb('assets/pdf/installation_invoice.pdf');
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), shape: BoxShape.circle),
                                          child: Icon(Icons.print, color: Colors.green, size: 24),
                                        ),
                                        SizedBox(height: 4),
                                        Text("Print", style: TextStyle(fontSize: 12, color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                ),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () async {
                                      final encodedMessage = Uri.encodeComponent(quotationController.quotationModel.message);
                                      final phNo = quotationController.quotationModel.phoneNumber;
                                      final whatsappUrl = Uri.parse('https://wa.me/$phNo?text=$encodedMessage');

                                      if (await canLaunchUrl(whatsappUrl)) {
                                        await launchUrl(whatsappUrl, mode: LaunchMode.inAppBrowserView);
                                      } else {
                                        print('Could not launch $whatsappUrl');
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(color: Colors.teal.withOpacity(0.1), shape: BoxShape.circle),
                                          child: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.teal, size: 24),
                                        ),
                                        SizedBox(height: 4),
                                        Text("WhatsApp", style: TextStyle(fontSize: 12, color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                ),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () async {
                                      widget.launchemail();
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), shape: BoxShape.circle),
                                          child: Icon(Icons.mail, color: Colors.red, size: 24),
                                        ),
                                        SizedBox(height: 4),
                                        Text("Mail", style: TextStyle(fontSize: 12, color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
        ),
      ),
    );
  }
}
