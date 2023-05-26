import 'package:http/http.dart' as http;

class DeleteUser {
  Future<void> deleteUser(String uid) async {
    try {
      final url =
          'https://identitytoolkit.googleapis.com/v1/accounts:delete?key=AIzaSyDngbcB_1mh2w7XnhBGqkj_ttjbaUrXf5c';
      final response = await http.post(
        Uri.parse(url),
        body: '{"localId": "$uid"}',
      );

      if (response.statusCode == 200) {
        print('Pengguna berhasil dihapus dari Firebase Auth.');
      } else {
        print('Gagal menghapus pengguna. Respon API: ${response.body}');
      }
    } catch (e) {
      print('Gagal menghapus pengguna: $e');
    }
  }
}
