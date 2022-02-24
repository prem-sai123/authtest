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
        return userexists = true;
      } else {
        print("FAIL");
        return userexists = false;
      }
    } catch (err, stack) {
      print('$err  \n,$stack');
    } finally {
      return userexists;
    }
  }

  SignincubitCubit() : super(SignInCubitState(username: '', passWd: ''));
  givenDetais(String uname, String pwd) {
    return fetchUserList(uname, pwd);
  }
}
