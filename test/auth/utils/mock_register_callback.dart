import 'package:gymnastic_center/common/results.dart';

final mockRegisterCallBack = ({required String email, required String password, required String name, required String phone}) async => Future.value(Result.success(true));
final mockRegisterCallBackShouldFail = ({required String email, required String password, required String name, required String phone}) async => Future.value(Result<bool>.fail(Exception()));