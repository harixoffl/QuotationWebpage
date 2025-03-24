import 'package:flutter/material.dart';

class Primary_Colors {
  static const Color Light = Color.fromARGB(255, 11, 15, 26);
  static const Color Dark = Color.fromARGB(255, 18, 22, 33);
  static const Color boxBackground=const Color.fromARGB(255, 33, 37, 41);
  static const Color Color_1 = Color.fromARGB(255, 213, 212, 212);
  static const Color heading_color=const Color.fromARGB(255, 236, 215, 197);
  static const Color clientName_color=Color.fromARGB(255, 225, 174, 240);
  static const Color Color_2 = Color.fromARGB(255, 133, 131, 131);

}




          // // Main content using Expanded to take the remaining height
          // Expanded(
          //   // flex: 7,
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       // Left section - Quotation details
          //       Container(
          //           height: 850,
          //         margin: EdgeInsets.only(left:120, top: 5),
          //         width:700, // Fixed width so it doesn’t stretch too much
          //         padding: EdgeInsets.all(5.0),
          //          color: Colors.grey,
          //         child: GestureDetector(
          //           child: Stack(
          //             children: [
          //                 SfPdfViewer.asset('assets/pdf/installation_invoice.pdf', initialZoomLevel:1,
          //                 onDocumentLoaded: (details) {
          //                  print('Pdf loaded successfully');
          //                 },
          //                 onDocumentLoadFailed: (details) {
          //                   print('Error: ${details.description}');
          //                 },
          //                 canShowPageLoadingIndicator: false,
          //                  ),
          //                   Align(
          //                   alignment: AlignmentDirectional.bottomEnd,
          //                   child: Padding(
          //                     padding: const EdgeInsets.all(5),
          //                     child: Container(
          //                       decoration: BoxDecoration(
          //                         borderRadius: BorderRadius.circular(50),
          //                       ),
          //                     ),
          //                   ),
          //                 ),       
          //             ],
                        
          //           ),
          //           onDoubleTap: () {
          //             widget.showReadablePdf(context);
          //           },
          //         ),
                    
                  
          //       ),

          //       // Right section - Approval status
          //       Expanded(
          //       // flex: 3,
          //       child: Column(
          //         children: [
          //           Container(
          //              padding: const EdgeInsets.only(top: 25),
          //             height: 150,
          //             width: 850,
                     
          //             child: Text(
          //               quotationController.quotationModel.message,
          //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          //             ),
          //           ),
          //       const SizedBox(height: 10),
          //       Container(
          //         padding: const EdgeInsets.only(top: 40, right: 60,left: 40),
          //         child: Center( // Centering the inner container
          //           child: Container(
          //             width: 600, // Adjust the width as needed
          //             height: 650, // Vertically long container
          //             padding: const EdgeInsets.all(20),
          //             decoration: BoxDecoration(
          //               color: Primary_Colors.boxBackground, // Dark background for contrast
          //               borderRadius: BorderRadius.circular(15), // Rounded edges
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.black.withOpacity(0.3),
          //                   blurRadius: 10,
          //                   spreadRadius: 2,
          //                   offset: const Offset(0, 5),
          //                 ),
          //               ],
          //             ),
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
                        

          //                 const SizedBox(height: 30),
          //                 ElevatedButton(
          //                   onPressed: () async {
          //                     await widget.downloadPdf();
          //                   },
          //                   style: ElevatedButton.styleFrom(
          //                     backgroundColor: Colors.blue,
          //                     foregroundColor: Colors.white,
          //                     padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          //                   ),
          //                   child: const Text('Download PDF'),
          //                 ),
          //                 const SizedBox(height: 30,),
          //                 ElevatedButton(
          //                   onPressed: () async {
          //                     widget.showQuotationDialog(context, true);
          //                   },
          //                   style: ElevatedButton.styleFrom(
          //                     backgroundColor: Colors.green,
          //                     foregroundColor: Colors.white,  
          //                     padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          //                   ),
          //                   child: Text('Accept Quotation'),
          //                 ),
          //                 const SizedBox(height: 30),
          //                 ElevatedButton(
          //                   onPressed: () async {
          //                     widget.showQuotationDialog(context, false);
          //                   },
          //                   style: ElevatedButton.styleFrom(
          //                     backgroundColor: Colors.red,
          //                     foregroundColor: Colors.white,  
          //                     padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          //                   ),
          //                   child: Text('Reject Quotation'),
          //                 ),
                          
                          
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //         ],
          //     ),
          //       ),

          //     ],
          //   ),
          // ),
