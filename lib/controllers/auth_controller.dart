import 'dart:io';
import 'package:http/http.dart';
import 'package:path/path.dart' as p;
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:fotopal_beta/amplifyconfiguration.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:fotopal_beta/services/AuthService.dart';
import 'package:get/get.dart';

class AmplifyController extends GetxController {
  String userId;
  String estudioId;
  String rol;
  Amplify amplify = new Amplify();
  bool isAmplifyConfigured = false;
  bool isSignedIn = false;
  bool _isSignUpComplete = false;
  String _image_key = "";

  @override
  void onInit() {
    super.onInit();
    configureAmplify();
  }

  Future<String> getRole(String user) async {
    String r = await AuthService.fetchRoles(user);
    return r;
  }

  void configureAmplify() async {
    try {
      AmplifyAuthCognito pluginAuth = new AmplifyAuthCognito();
      AmplifyStorageS3 storage = AmplifyStorageS3();
      amplify.addPlugin(authPlugins: [pluginAuth], storagePlugins: [storage]);
      await amplify.configure(amplifyconfig);
      isAmplifyConfigured = true;
    } on AuthError catch (error) {
      isAmplifyConfigured = false;
      print(error);
    }
  }

  Future<bool> checkSession() async {
    try {
      CognitoAuthSession res = await Amplify.Auth.fetchAuthSession(
          options: CognitoSessionOptions(getAWSCredentials: true));

      print('CHECK SESION: ${res.identityId}');
      return true;
    } on AuthError catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login(String correo, String pass) async {
    try {
      SignInResult res = await Amplify.Auth.signIn(
        username: correo.trim(),
        password: pass.trim(),
      );

      userId = await AuthService.fetchID(correo);
      estudioId = await AuthService.fetchEstudio(correo);
      rol = await AuthService.fetchRoles(correo);

      // Esta logeado correctamente
      isSignedIn = res.isSignedIn;
      return res.isSignedIn;
    } on AuthError catch (error) {
      print(error);
      print("Register Error: " + error.toString());
      return false;
    }
    return false;
  }

  Future<bool> signOut() async {
    try {
      SignOutResult sor = await Amplify.Auth.signOut(
          options: CognitoSignOutOptions(globalSignOut: true));
      this.isSignedIn = false;
      return this.isSignedIn;
    } on AuthError catch (e) {
      print(e);
    } finally {
      return true;
    }
  }

  Future<bool> signUp(
      String nombre, String correo, String password, File image) async {
    try {
      String uploadFileString = await uploadFile(image);
      String getUrlString = await getUrl(uploadFileString);
      final String resultUrl =
          getUrlString.substring(0, getUrlString.indexOf('?'));
      print(resultUrl);

      Map<String, dynamic> userAttributes = {
        "name": nombre,
        "email": correo,
        "picture": resultUrl,
        "custom:rol": "regular",
        "custom:pickey": "public/" + this._image_key.toString()
      };

      if (resultUrl != null && resultUrl.isNotEmpty) {
        SignUpResult res = await Amplify.Auth.signUp(
            username: correo,
            password: password,
            options: CognitoSignUpOptions(userAttributes: userAttributes));
        _isSignUpComplete = res.isSignUpComplete;

        if (_isSignUpComplete) {
          return true;
        }
        return false;
      }
    } on AuthError catch (error) {
      print(error);
      print("Register Error: " + error.toString());
      return false;
    }
    return false;
  }

  Future<bool> checkSignUp(String correo, String codigo) async {
    if (_isSignUpComplete) {
      userId = await AuthService.fetchID(correo);
      estudioId = await AuthService.fetchEstudio(correo) ?? null;
      rol = await AuthService.fetchRoles(correo);
      print('USERID: ${userId} ESTUDIOID: ${estudioId} ROL: ${rol}');
      SignUpResult res = await Amplify.Auth.confirmSignUp(
          username: correo, confirmationCode: codigo);
      if (res.isSignUpComplete) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<String> uploadFile(File file) async {
    try {
      print('In upload');
      print(file.path);
      // Uploading the file with options
      final key = new DateTime.now().toString() + p.extension(file.path);

      Map<String, String> metadata = <String, String>{};
      metadata['name'] = 'perfilUsuario';
      metadata['desc'] = 'A test file';
      S3UploadFileOptions options = S3UploadFileOptions(
          accessLevel: StorageAccessLevel.guest, metadata: metadata);
      UploadFileResult result = await Amplify.Storage.uploadFile(
          key: key, local: file, options: options);

      _image_key = key;
      String _uploadFileResult = result.key;
      return _uploadFileResult;
    } catch (e) {
      print('UploadFile Err: ' + e.toString());
    }
    return "";
  }

  Future<String> getUrl(String uploadFileResult) async {
    try {
      print('In getUrl');
      String key = uploadFileResult;
      S3GetUrlOptions options = S3GetUrlOptions(
          accessLevel: StorageAccessLevel.guest, expires: 10000);
      GetUrlResult result =
          await Amplify.Storage.getUrl(key: key, options: options);
      return result.url;
    } catch (e) {
      print('GetUrl Err: ' + e.toString());
    }
  }
}
