import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:swapreads/features/exchange_requests/domain/entity/exchange_request_entity.dart';

Future<List<ExchangeRequestEntity>> getExchangeRequestsList() async {
  final response =
      await rootBundle.loadString('test_data/exchange_entity_test.json');
  final jsonList = await json.decode(response);

  final List<ExchangeRequestEntity> exchangeList = jsonList
      .map<ExchangeRequestEntity>(
        (json) => ExchangeRequestEntity.fromJson(json),
      )
      .toList();

  return Future.value(exchangeList);
}