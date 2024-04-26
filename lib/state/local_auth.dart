import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_auth.freezed.dart';

@freezed
class LocalAuthState with _$LocalAuthState {
  const factory LocalAuthState.initial() = _Initial;

  const factory LocalAuthState.loading() = _Loading;

  const factory LocalAuthState.success({bool? success}) = _Success;

  const factory LocalAuthState.failed({bool? failed}) = _Failed;
}
