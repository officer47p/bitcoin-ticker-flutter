import 'package:flutter/material.dart';
import './coin_data.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'price_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList[0];
  Map priceData = {};
  CoinData coinData = CoinData();
  @override
  void initState() {
    super.initState();
    for (String coin in cryptoList) {
      priceData[coin] = "?";
    }
    getCoinsData(selectedCurrency);
  }

  void getCoinsData(currency) async {
    for (String coin in cryptoList) {
      dynamic coinPrice = await coinData.getCoinData(coin, currency);
      priceData[coin] = coinPrice;
    }
    setState(() {});
  }

  List<Widget> getPriceWidgets() {
    List<Widget> priceWidgets = [];
    for (String coin in cryptoList) {
      priceWidgets.add(PriceCard(
          coin: coin,
          price: priceData[coin],
          selectedCurrency: selectedCurrency));
    }
    return priceWidgets;
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> items = [];
    for (String currency in currenciesList) {
      items.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: items,
      onChanged: (value) {
        selectedCurrency = value;
        setState(() {
          for (String coin in cryptoList) {
            priceData[coin] = "?";
          }
          getCoinsData(selectedCurrency);
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Widget> items = [];
    for (String currency in currenciesList) {
      items.add(Text(currency));
    }
    return CupertinoPicker(
      scrollController: FixedExtentScrollController(initialItem: 0),
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (index) {
        setState(() {
          selectedCurrency = currenciesList[index];
          for (String coin in cryptoList) {
            priceData[coin] = "?";
          }
          getCoinsData(selectedCurrency);
        });
      },
      children: items,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: getPriceWidgets(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ? androidDropdown() : iOSPicker(),
          ),
        ],
      ),
    );
  }
}
