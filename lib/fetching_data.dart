import 'networking.dart';

const apiKey = '039C94D6-06B9-408B-A243-D549E8FBED68';
const coinApiURL = 'https://rest.coinapi.io/v1/exchangerate';

class FetchData {
  Future<dynamic> getCoinData(String selectedCurrency, String coinName) async {
    var url =
        '$coinApiURL/$coinName/$selectedCurrency?apikey=$apiKey&invert=true';
    NetworkHelper networkHelper = NetworkHelper(url);
    var coinData = await networkHelper.getData();
    return coinData;
  }
}
