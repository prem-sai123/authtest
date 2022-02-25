import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
part 'signincubit_state.dart';

class SignincubitCubit extends Cubit<SignInCubitState> {
  bool userexists = false;
  Future<bool> fetchUserList(String uname, String pwd) async {
    try {
      final baseUrl =
          'http://testt2t.easycloud.in/openbravo/org.openbravo.service.json.jsonrest/ADUser?l=$uname&p=$pwd';
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        print("SUCCESS");
        userexists = true;
      } else {
        print("FAIL");
        userexists = false;
      }
    } catch (err, stack) {
      print('$err  \n,$stack');
    }
    return userexists;
  }

  SignincubitCubit() : super(SignInCubitState(loginSuccess: false,isLoading: false));
  givenDetais(String uname, String pwd) async {
    emit(SignInCubitState(isLoading: true));
    bool result = await fetchUserList(uname, pwd);
    emit(SignInCubitState(loginSuccess: result,isLoading: false));
  }
}
