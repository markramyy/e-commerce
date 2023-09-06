
import 'package:dio/dio.dart';

class DioHelper {
  final Dio dio = Dio();
  Future<List> getProduct({required String path})async{
    Response response = await dio.get(path);
    return response.data["products"];
  }
}

/*لما الهوووم تخلص*/
/*
Widget build(BuildContext context) {
  return Scaffold(


      body: products.length == 0
          ? const Center(
        child: CircularProgressIndicator(
          color: Colors.orange,
        ),
      )
          :
  );
}*/
