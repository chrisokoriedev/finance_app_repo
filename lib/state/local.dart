
import 'package:freezed_annotation/freezed_annotation.dart';

part 'local.freezed.dart';

@freezed
class AppStateManager with _$AppStateManager {
  const factory AppStateManager.initial() = _Initial;

  const factory AppStateManager.loading() = _Loading;
  const factory AppStateManager.success({String? success}) = _Success;

  const factory AppStateManager.failed({String? failed}) = _Failed;
}
