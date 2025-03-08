import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../generated/locale_keys.g.dart';
import '../../service/show_message.dart';


part 'sensitive_connectivity_event.dart';
part 'sensitive_connectivity_state.dart';

class SensitiveConnectivityBloc extends Bloc<SensitiveConnectivityEvent, SensitiveConnectivityState> {
  SensitiveConnectivityBloc() : super(ConnectivityOfflineState()) {
    on<ChangeConnectivityEvent>(_onCheckConnectivity);
  }

  void _onCheckConnectivity(
    ChangeConnectivityEvent event,
    Emitter<SensitiveConnectivityState> emit,
  ) async {


    if (event.connectivityResult == ConnectivityResult.mobile) {
      showMessage(LocaleKeys.lbl_has_internet.tr(),timeShowing: Toast.LENGTH_SHORT);
      emit(ConnectivityCellularState());
    } else if (event.connectivityResult == ConnectivityResult.wifi) {
      showMessage(LocaleKeys.lbl_has_internet.tr(),timeShowing: Toast.LENGTH_SHORT);
      emit(ConnectivityWifiState());
    } else if(event.connectivityResult == ConnectivityResult.none){
      showMessage(LocaleKeys.lbl_lost_internet.tr(),timeShowing: Toast.LENGTH_LONG);
      emit(ConnectivityOfflineState());
    }
  }
}
