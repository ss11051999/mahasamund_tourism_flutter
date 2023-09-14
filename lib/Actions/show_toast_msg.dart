import 'package:fluttertoast/fluttertoast.dart';
import 'package:mahasamund_tourism/Theme/app_colors.dart';

showToastMsg({required String msg}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.primary,
      textColor: AppColors.white,
      fontSize: 16.0);
}
