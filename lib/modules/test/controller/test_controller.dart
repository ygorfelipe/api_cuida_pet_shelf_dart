//! nesse caso, nós não iremos utilizar o shelf controller e nem na logica do cuidapet
//! iremos tentar realizar as rotas com base no artigo do Brasizza

import 'dart:convert';

import 'package:shelf/shelf.dart';

class TestController {
  Future<Response> getAll(Request request) async {
    return Response.ok(
      jsonEncode({'message': 'Teste first page'}),
    );
  }

  Future<Response> getSecondPage(Request request) async {
    return Response.ok(
      jsonEncode({'message': 'Teste Second page'}),
    );
  }
}
