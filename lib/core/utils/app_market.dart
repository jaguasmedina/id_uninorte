import 'package:meta/meta.dart';
import 'package:store_redirect/store_redirect.dart';

void openAppMarketFor({
  @required String androidId,
  @required String iOSId,
}) {
  StoreRedirect.redirect(
    androidAppId: androidId,
    iOSAppId: iOSId,
  );
}
