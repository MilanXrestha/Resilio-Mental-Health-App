import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'subscription_bloc.dart';
import 'subscription_state.dart';

@injectable
class PremiumCubit extends Cubit<bool> {
  final SubscriptionBloc _subscriptionBloc;
  late StreamSubscription _subscription;

  PremiumCubit(this._subscriptionBloc) : super(false) {
    // Initial check
    _checkPremiumStatus(_subscriptionBloc.state);

    // Listen to changes
    _subscription = _subscriptionBloc.stream.listen((state) {
      _checkPremiumStatus(state);
    });
  }

  void _checkPremiumStatus(SubscriptionState state) {
    if (state is SubscriptionLoaded) {
      final isActive = state.subscription.isActive;
      if (isActive != this.state) {
        emit(isActive);
      }
    } else if (state is SubscriptionError || state is SubscriptionInitial) {
       if (this.state != false) {
         emit(false);
       }
    }
  }

  // Force check (e.g. on login/logout)
  void recheck() {
    _checkPremiumStatus(_subscriptionBloc.state);
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
