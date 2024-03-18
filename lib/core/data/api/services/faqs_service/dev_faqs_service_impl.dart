import 'package:injectable/injectable.dart';

import 'package:identidaddigital/core/data/api/services/faqs_service/faqs_service.dart';
import 'package:identidaddigital/core/data/models/faq_model.dart';
import 'package:identidaddigital/core/enums/flavor.dart';

@LazySingleton(as: FaqsService)
@Environment(Env.dev)
class DevFaqsServiceImpl implements FaqsService {
  @override
  Future<List<FaqModel>> requestFaqs() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    const faqs = <FaqModel>[
      FaqModel(
        title: '¿Cómo se llama la aplicación?',
        content: 'La aplicación se llama ID Uninorte',
      ),
      FaqModel(
        title: '¿Dónde puedo descargar la aplicación?',
        content:
            'En la tienda de aplicación de su dispositivo móvil ya sea Google Play o App Store',
      ),
      FaqModel(
        title: '¿Cuál es el usuario y la contraseña que debo ingresar?',
        content:
            'Son las mismas credenciales que se utiliza para ingresar al Portal',
      ),
      FaqModel(
        title: '¿Qué hago sino puedo ingresar con mis credenciales a la App?',
        content:
            'Debes comunicarte con CSU enviando un mensaje a foo@bar.com indicando: Nombre Completo, Código y Cedula',
      ),
      FaqModel(
        title: '¿Qué hago si olvide mi contraseña?',
        content:
            'Ingresa al sitio WEB y realiza el procedimiento para restablecer contraseña que se encuentra en la página de ingreso del portal.',
      ),
    ];
    return faqs;
  }

  @override
  Future<List<FaqModel>> requestExternalFaqs() => requestFaqs();
}
