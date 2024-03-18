import 'package:flutter/painting.dart';
import 'package:identidaddigital/features/digital_card/domain/entities/profile.dart';

@Deprecated('Hardcoded user profile definitions. Unused')
const Map<String, Profile> _profileDefinitions = {
  'FD': Profile('Colaborador administrativo', Color(0xFFC41615)), // C41615
  'DO': Profile('Docente', Color(0xFFC41615)), // C41615
  'CD': Profile('Consejo Directivo', Color(0xFF00015C)), // 00015C
  'ES': Profile('Estudiante', Color(0xFF650E81)), // 650E81
  'EG': Profile('Egresado', Color(0xFFE0AF28)), // E0AF28
  'VT': Profile('Visitante', Color(0xFF5DAF5E)), // 5DAF5E
  'CO': Profile('Contratista', Color(0xFFE60485)), // E60485
  'FH': Profile('Colaborador HUN', Color(0xFF00C2E7)), // 00C2E7
  'PE': Profile('Pensionado', Color(0xFFE96000)), // E96000
};

@Deprecated('Unused function')
Profile findProfile(String value) {
  Profile profile = _profileDefinitions[value];
  return profile ??= _profileDefinitions['ES'];
}
