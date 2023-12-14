import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:metronome_app/models/user.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

@freezed
class Settings with _$Settings {
  @JsonSerializable(includeIfNull: false)
  factory Settings({
    required int? id,
    required bool hapticFeedback,
    required User user,
  }) = _Settings;

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);
}
