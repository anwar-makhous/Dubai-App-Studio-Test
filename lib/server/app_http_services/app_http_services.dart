import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:dubai_app_studio/core/constants/app_constants.dart';
import 'package:dubai_app_studio/server/app_http_failure.dart';
import 'package:dubai_app_studio/core/services/app_storage.dart';
import 'package:dubai_app_studio/features/account/data/models/account_model.dart';
import 'package:dubai_app_studio/features/beneficiary/data/models/beneficiary_model.dart';
import 'package:dubai_app_studio/features/recharge/data/models/history_item_model.dart';

part 'app_account_info_http_service.dart';
part 'app_beneficiary_http_service.dart';
part 'app_history_http_service.dart';
part 'app_otp_http_service.dart';
part 'app_recharge_http_service.dart';
