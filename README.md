* **Curso de edx:** https://www.edx.org/es/course/becoming-a-hyperledger-aries-developer
* **Sdk flutter:** https://github.com/ayanworks/ARNIMA-flutter-sdk
* **Blockchain utilizada:**
  *  https://github.com/cloudcompass/ToIPLabs/blob/master/docs/LFS173x/vonNetwork.md
  *  https://github.com/bcgov/von-network/blob/master/docs/UsingVONNetwork.md
* **Laboratorio para configurar el agente de python:** https://github.com/cloudcompass/ToIPLabs/blob/master/docs/LFS173x/AliceGetsCredential.md

# identidad_digital

Para realizar el experimento del agente movil para identidad digital se escogio el SDK de flutter de ARNIMA https://github.com/ayanworks/ARNIMA-flutter-sdk

Este SDK tiene dispobile:
  - Emision de protocolos de credenciales
  - Protocolos de prueba actual
  - Protocolo de conexion
  - Protoco de ping de confianza

Con los anteriores es posibles realizar la creación de un wallet para el almacenamiento de las credenciales de un usuario.

Se puede realizar la conexión con un mediador, en este caso puede ser la conexión con el medidador de GO para hacer la comunicación a traves de didexchange.

De este mismo modo debería ser posible realizar la conexion con el agente empesarial hecho en python.

Para realizar pruebas locales se puede levantar el gente python como mediador para realizar conexiones de prueba, esto se puede realizar desde una consolada de `play with docker` en el navegador o desde el local montando la imagen en un docker local. (este es el link del laboratorio donde muestran como se puede levantar https://github.com/cloudcompass/ToIPLabs/blob/master/docs/LFS173x/AliceGetsCredential.md).


- Se realiza la actualización de a la ultima version de flutter 2.5
    -   https://stackoverflow.com/questions/64797607/how-do-i-upgrade-an-existing-flutter-app
    -   se realiza las correcciones del codigo para poder adaptarlas a nullsafe
    -   con la actualización de flutter tambien se actualizan las librerias que utuliza la libreria 
        de aries:
        -   http
        -   hive
        -   hive_flutter
        -   path_provider
        -   uuid
        -   socket_io_client
        -   eventify
    -   se realiza la actualiza la version de minimo sdk perminitido en el archivo de build.gradle al tag 18
        -   https://stackoverflow.com/questions/52060516/how-to-change-android-minsdkversion-in-flutter-project
    - escaneo con camara https://pub.dev/packages/qr_mobile_vision/example

En la actualización se realiazo el cambio de dos librerias, la primera es la que libreria que realiza el preloader, ya que esta deprecado, para esto se crea un witget con la misma funcionalidad, esta en la carpet utils/dialog. Y la segunda es la actualización de la libreria que realiza los scaneos de los codigos QR que estaba tambien deprecada, el ejemplo de como funciona la nueva libreria esta en el archivo connection_screen.dart, se realiza con la librereria qr_mobile_vision.

Para la actualización se presentaron algunos errores, estos errores fueron corregidos, pero en ios queda pendiente corregir un error, que es 'no such module indy' (Los errores anteriores quedaron documentados en la sección 'Errores compilacion ios'). Para android quedaron corregidos, y se levanta el ambiente ccon normalidad. 

El proyecto tiene un archivo example.dart, en este esta como se puede obtener la información del dispositivo, esto con el fin de ser implementado cuando el dispositivo se inicie se puedan optener el device del dispositivo y con el crear la wallet una vez se inicie la aplicación.

La wallet que se crea en este momento tiene estos parametros quedamados, que pendiente por hacer la implementación de este y probarlo.


## iOS
-   Utilizamos el comando `pod install --repo-update` para actualizar las dependecias que se instalan con pod en el el archivo podfile
-   se realiza el cambio de la instalacion de las dependencias `libindy` y `libindy-objc` que estaban en el archivo `/ios/.symlinks/plugins/AriesFlutterMobileAgent/ios/AriesFlutterMobileAgent.podspec` se comentan y se agregan en el archivo `Podfile`
- se encuentra la solución del error de instalacion de la libreria `libindy-objc` en este link `https://stackoverflow.com/questions/58310423/the-podfile-for-hyperledger-indy-seems-to-be-linking-to-the-wrong-repository`
- Blob para intalacion de pods indy https://github.com/hyperledger/indy-sdk/blob/master/wrappers/ios/README.md

### erorres compilacion ios 
- generacion de pods para ios https://stackoverflow.com/questions/50671286/flutter-h-not-found-error/60847368
  - En el link se puede encontrar en el comentario `For Anyone that comes here is 2021` como se pueden realizar las configuraciones de pods
    - En la carpeta ios existe un archivo llamado Podfile, en este archivo se encuentra toda la configuracion de los pods
      - (
        ¿Que son los pods?
          los pods son simplemente una referencia a una libreria externa que quereamos añadir a nuestro proyecto, por poder administrar
          estos pods necesitamos un administrador de dependencias, para es necesario cocoapods, quien es el encargado de hacer esta tarea.
          Aqui un breve guia de como configurar y como funciona 
          https://medium.com/kaosdev/cocoapods-una-herramienta-vital-para-desarrollar-en-xcode-f0aa1695bbd2
        )
    - Para instalar las dependencias del proyecto solo de necesario ejecurtar los siguientes comandos
    ```
      flutter pub get
      cd ios
      pod install
    ```
    - Para actualizar las dependecias ejecutamos
    ```
      pod update
      flutter clean
      flutter run
    ```
- instalacion de indy ios utlizancion cocoapods para obtener las dependencias de indy y que ios las pueda utlizar
  https://stackoverflow.com/questions/58310423/the-podfile-for-hyperledger-indy-seems-to-be-linking-to-the-wrong-repository
  ***NOTA*** Para que el proyecto de ios se pueda levantar es necesario que todas las dependencias de ios este corriendo
- En este link se explica que puede utlizar despues de que barcode fue deprecated 
  https://stackoverflow.com/questions/49521283/is-there-a-way-to-scan-barcodes-in-flutter
  La alternativa es qr_mobile_vision y tambien explican como es su implementacion, anteriormente ya tambien se menciona 
  como se puede utilizar, este es el link donde esta el ejemplo 
  https://pub.dev/packages/qr_mobile_vision/example
- Librerias deprecadas, para esto se tuvo que consultar cuales eran las formas en las que cambio y actalizar manualmente
  los archivos en los que se estaban presentando los errores para que puediera funcionar, en los siguientes links 
  me apoye para hacer la solucion de los errores que estaba presentando
    - https://stackoverflow.com/questions/61669237/subscribercellularprovider-was-deprecated-in-ios-12-0
    - https://issueexplorer.com/issue/Baseflow/flutter-permission-handler/607
    - https://stackoverflow.com/questions/52846542/why-do-servicesubscribercellularproviders-return-nil-in-ios-12
    - https://github.com/googleads/googleads-consent-sdk-ios/issues/21
  - Status barorientation 
    - https://www.titanwolf.org/Network/q/fbb477ac-8812-4d8c-8ab0-94bf89bc31b2/y
    - https://stackoverflow.com/questions/57965701/statusbarorientation-was-deprecated-in-ios-13-0-when-attempting-to-get-app-ori
  - Configuración de path's https://stackoverflow.com/questions/29500227/getting-error-no-such-module-using-xcode-but-the-framework-is-there
- En el momento de configurar nuevas librerias manualmente en el podfile que se encuentra en la carpeta de ios, tener en cuenta que cuando se ejecute el pod install y sale algun error es porque se ha configurado mal la libreria o esta no pudo ser encontrada o algo por el estilo. (para tener en cuenta solo al momento de instalaciones manuales)
- Error: no such module indy (aun no esta solucionado pero estos son los links que he encontrado con algo de informacion util)
  - https://stackoverflow.com/questions/26445784/target-overrides-the-framework-search-paths-build-settings

## agente js

- https://github.com/hyperledger/aries-framework-javascript/blob/main/docs/getting-started/2-connections.md
- https://github.com/hyperledger/aries-framework-javascript
- https://github.com/hyperledger/aries-framework-javascript/blob/main/docs/getting-started/0-agent.md
- https://github.com/hyperledger/aries-framework-javascript/blob/main/docs/getting-started/1-transports.md
- https://github.com/hyperledger/aries-framework-javascript/blob/main/docs/getting-started/2-connections.md
- http://dev.greenlight.bcovrin.vonx.io/genesis
- https://github.com/hyperledger/aries-framework-javascript/blob/main/docs/getting-started/0-agent.md
- solucionar problemas de instalacion de indy https://github.com/hyperledger/aries-framework-javascript/blob/main/TROUBLESHOOTING.md
  - https://stackoverflow.com/questions/19776571/error-dlopen-library-not-loaded-reason-image-not-found

- compilaciones con nodejs y ts https://khalilstemmler.com/blogs/typescript/node-starter-project/
- webview para implementar flutter con js
  - https://pub.dev/packages/flutter_webview_plugin/example
  - https://pub.dev/packages/webview_flutter/example
  - https://pub.dev/packages/flutter_js
  - como implementarlo
    - https://maheshikapiumi.medium.com/flutter-web-calling-custom-java-script-functions-in-dart-vice-versa-b03a8c29d34f



## dudas

-   Validar si la billetera solo se va a utiliza de manera local una unica vez y guarda su almacenamiento de ese momento, o debería de almacenar la información y en una futura conexión obtener toda la información que ha generado


## examples 
- https://protocoderspoint.com/how-to-get-flutter-device-info-with-example/





