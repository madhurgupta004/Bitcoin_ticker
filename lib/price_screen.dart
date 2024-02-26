// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'fetching_data.dart';
import 'coin_widget.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String amountBTC = '';
  String amountETH = '';
  String amountLTC = '';

  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      dropDownItems.add(newItem);
    }
    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropDownItems,
        onChanged: (value) async {
          if (value != null) {
            final dynamic coinDataBTC =
                await FetchData().getCoinData(value, 'BTC');
            final dynamic coinDataETH =
                await FetchData().getCoinData(value, 'ETH');
            final dynamic coinDataLTC =
                await FetchData().getCoinData(value, 'LTC');
            setState(() {
              selectedCurrency = value;
              amountBTC = coinDataBTC['rate'].toStringAsFixed(2);
              amountETH = coinDataETH['rate'].toStringAsFixed(2);
              amountLTC = coinDataLTC['rate'].toStringAsFixed(2);
            });
          }
        });
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (value) async {
        final dynamic coinDataBTC =
            await FetchData().getCoinData(currenciesList[value], 'BTC');
        final dynamic coinDataETH =
            await FetchData().getCoinData(currenciesList[value], 'ETH');
        final dynamic coinDataLTC =
            await FetchData().getCoinData(currenciesList[value], 'LTC');
        setState(() {
          selectedCurrency = currenciesList[value];
          amountBTC = coinDataBTC['rate'].toStringAsFixed(2);
          amountETH = coinDataETH['rate'].toStringAsFixed(2);
          amountLTC = coinDataLTC['rate'].toStringAsFixed(2);
        });
      },
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Center(
          // child: Text('🤑 Coin Ticker'),
          child: Text('Coin Ticker'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CoinWidget(
              selectedCurrency: selectedCurrency,
              coinName: 'BTC',
              amount: amountBTC),
          CoinWidget(
            selectedCurrency: selectedCurrency,
            coinName: 'ETH',
            amount: amountETH,
          ),
          CoinWidget(
            selectedCurrency: selectedCurrency,
            coinName: 'LTC',
            amount: amountLTC,
          ),
          SizedBox(
            height: 300.0,
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ? iOSPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }
}
