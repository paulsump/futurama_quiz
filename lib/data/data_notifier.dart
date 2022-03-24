import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

DataNotifier getDataNotifier(BuildContext context, {required bool listen}) =>
    Provider.of<DataNotifier>(context, listen: listen);

class DataNotifier extends ChangeNotifier {}
