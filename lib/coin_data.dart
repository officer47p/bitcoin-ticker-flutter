import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const String apiUrl = "https://apiv2.bitcoinaverage.com/indices/global/ticker/";

class CoinData {
  dynamic getCoinData(coin, currency) async {
    try {
      http.Response response = await http
          .get("${apiUrl}${coin}${currency}")
          .timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        return data["last"];
      }
      throw "";
    } catch (err) {
      return Error();
    }
  }
}
