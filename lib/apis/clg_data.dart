import 'package:coca_cola/constant/api.dart';
import 'package:http/http.dart' as http;
import '../model/clg_data_model.dart';

class ClgData {
  static Future<ClgDataModel?> getData() async {
    try {
      final url = Uri.parse(apiPath + "search-college?input=");
      var response = await http.get(url);
      print("status code----" + response.statusCode.toString());
      // return response.body;
      if (response.statusCode == 200) {
        ClgDataModel getdata = clgDataModelFromJson(response.body);
        return getdata;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
