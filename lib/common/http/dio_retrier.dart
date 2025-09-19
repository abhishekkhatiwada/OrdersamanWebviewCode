import 'package:dio/dio.dart';

Future<Response> requestRetrier({
  required String baseUrl,
  required Response response,
}) async {
  return response;
  // final refreshToken = await GetPrefs.refreshToken();

  // if (refreshToken != null) {
  //   try {
  //     final requestHeader = await GetPrefs.tenantId();
  //     final dio = Dio();
  //     final tokenResponse = await dio.post(
  //       options: Options(headers: {'x-tenant-id': requestHeader}),
  //       '$baseUrl/auth/refresh-token',
  //       data: {'refreshToken': refreshToken},
  //     );

  //     final newAccessToken = tokenResponse.data['data']['accessToken'];
  //     await SetPrefs.setToken(token: newAccessToken);

  //     final retryOptions = Options(
  //       method: response.requestOptions.method,
  //       headers: {'Authorization': 'Bearer $newAccessToken'},
  //     );

  //     final retryResponse = await dio.request(
  //       response.requestOptions.path,
  //       options: retryOptions,
  //       data: response.requestOptions.data,
  //       queryParameters: response.requestOptions.queryParameters,
  //     );

  //     return retryResponse;
  //   } catch (e) {
  //     CustomToast.error(message: 'Session expired. Please log in again.');
  //     await SharedPref.remove(PrefsConst.carrierId);
  //     await SharedPref.remove(PrefsConst.isLogin);
  //     await SharedPref.remove(PrefsConst.tenantId);
  //     await SharedPref.remove(PrefsConst.refreshToken);
  //     await SharedPref.remove(PrefsConst.token);
  //     NavigationService.pushNamedAndRemoveUntil(
  //       routeName: Routes.userTypeSectionScreen,
  //     );
  //     return Future.value(
  //       Response(
  //         requestOptions: response.requestOptions,
  //         statusCode: 401,
  //         statusMessage: "Unauthorized",
  //       ),
  //     );
  //   }
  // } else {
  //   return response;
  // }
}
