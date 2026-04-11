import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/subscription_entity.dart';
import '../../domain/repositories/subscription_repository.dart';
import 'subscription_event.dart';
import 'subscription_state.dart';

@injectable
class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionRepository _subscriptionRepository;

  SubscriptionBloc(this._subscriptionRepository) : super(SubscriptionInitial()) {
    on<LoadSubscription>(_onLoadSubscription);
    on<PurchaseSubscription>(_onPurchaseSubscription);
    on<LoadTransactions>(_onLoadTransactions);
  }

  Future<void> _onLoadSubscription(
    LoadSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoading());

    final failureOrSubscription = await _subscriptionRepository.getSubscription();

    failureOrSubscription.fold(
      (failure) => emit(SubscriptionError(message: failure.message)),
      (subscription) => emit(SubscriptionLoaded(subscription: subscription)),
    );
  }

  Future<void> _onPurchaseSubscription(
    PurchaseSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionPurchaseLoading());

    final failureOrSubscription = await _subscriptionRepository.updateSubscription(
      planId: event.planId,
      status: event.status,
      paymentProvider: event.paymentProvider,
      paymentProviderTransactionId: event.paymentProviderTransactionId,
      amount: event.amount,
      currency: event.currency,
    );

    failureOrSubscription.fold(
      (failure) => emit(SubscriptionPurchaseFailure(message: failure.message)),
      (subscription) {
        emit(SubscriptionPurchaseSuccess(subscription: subscription));
        // After success, reload the subscription state
        add(LoadSubscription());
      },
    );
  }

  Future<void> _onLoadTransactions(
    LoadTransactions event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoading());

    // Try to get subscription data; if none exists (e.g. free user), use a
    // placeholder so we can still display the (empty) transaction list.
    SubscriptionEntity subscription;
    if (state is SubscriptionLoaded) {
      subscription = (state as SubscriptionLoaded).subscription;
    } else {
      final failureOrSub = await _subscriptionRepository.getSubscription();
      subscription = failureOrSub.fold(
        (_) => _noSubscription,
        (sub) => sub,
      );
    }

    final failureOrTx = await _subscriptionRepository.getTransactions();

    failureOrTx.fold(
      (failure) => emit(SubscriptionError(message: failure.message)),
      (transactions) => emit(SubscriptionLoaded(
        subscription: subscription,
        transactions: transactions,
      )),
    );
  }

  static final SubscriptionEntity _noSubscription = SubscriptionEntity(
    id: '',
    userId: '',
    planId: 'none',
    status: 'none',
    startDate: DateTime(2000),
    paymentMethod: '',
    lastTransactionId: '',
    isAutoRenew: false,
    createdAt: DateTime(2000),
    updatedAt: DateTime(2000),
  );
}
