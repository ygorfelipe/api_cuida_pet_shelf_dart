enum HeadersEnum {
  get(label: 'GET'),
  post(label: 'POST'),
  patch(label: 'PATCH'),
  put(label: 'PUT'),
  delete(label: 'DELETE'),
  options(label: 'OPTIONS');

  final String label;
  const HeadersEnum({required this.label});
}
