import 'dart:convert';
import 'dart:typed_data';

class QuotationDetails {
  final Uint8List pdfBytes;

  QuotationDetails({required this.pdfBytes});

  factory QuotationDetails.fromJson(Map<String, dynamic> json) {
    return QuotationDetails(pdfBytes: base64Decode(json['pdfData']));
  }
}

class Suggestion {
  final int suggestId;
  final String suggestion;
  final DateTime rowUpdatedDate;
  final int status;
  final int deletedFlag;

  Suggestion({required this.suggestId, required this.suggestion, required this.rowUpdatedDate, required this.status, required this.deletedFlag});

  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
      suggestId: json['suggest_id'],
      suggestion: json['Suggestions'],
      rowUpdatedDate: DateTime.parse(json['Row_updated_date']),
      status: json['status'],
      deletedFlag: json['Deleted_flag'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'suggest_id': suggestId, 'Suggestions': suggestion, 'Row_updated_date': rowUpdatedDate.toIso8601String(), 'status': status, 'Deleted_flag': deletedFlag};
  }
}
