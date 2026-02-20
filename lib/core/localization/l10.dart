import 'package:resilio/core/di/injection.dart';
import 'package:resilio/core/routing/navigation_service.dart';

import '../../l10n/app_localizations.dart';

AppLocalizations get l10 =>
    AppLocalizations.of(getIt<NavigationService>().getContext())!;
