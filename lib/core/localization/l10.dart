import '../../l10n/app_localizations.dart';
import '../di/injection.dart';
import '../routing/navigation_service.dart';

AppLocalizations get l10 =>
    AppLocalizations.of(getIt<NavigationService>().getContext())!;
