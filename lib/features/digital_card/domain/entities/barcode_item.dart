abstract class BarcodeItem {
  String get label;

  bool get isQR => this is QRCodeItem;
}

class QRCodeItem extends BarcodeItem {
  @override
  String get label => 'linear_barcode';
}

class LinearBarcodeItem extends BarcodeItem {
  @override
  String get label => 'qr_code';
}
