import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String google_api_key = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? 'default_key';