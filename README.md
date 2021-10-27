* **Curso de edx:** https://www.edx.org/es/course/becoming-a-hyperledger-aries-developer
* **Sdk flutter:** https://github.com/ayanworks/ARNIMA-flutter-sdk
* **Blockchain utilizada:**
  *  https://github.com/cloudcompass/ToIPLabs/blob/master/docs/LFS173x/vonNetwork.md
  *  https://github.com/bcgov/von-network/blob/master/docs/UsingVONNetwork.md
* **Laboratorio para configurar el agente de python:** https://github.com/cloudcompass/ToIPLabs/blob/master/docs/LFS173x/AliceGetsCredential.md

# identidad_digital

- Se realiza la actualización de a la ultima version de flutter
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

## iOS
-   Utilizamos el comando `pod install --repo-update` para actualizar las dependecias que se instalan con pod en el el archivo podfile
-   se realiza el cambio de la instalacion de las dependencias `libindy` y `libindy-objc` que estaban en el archivo `/ios/.symlinks/plugins/AriesFlutterMobileAgent/ios/AriesFlutterMobileAgent.podspec` se comentan y se agregan en el archivo `Podfile`
- se encuentra la solución del error de instalacion de la libreria `libindy-objc` en este link `https://stackoverflow.com/questions/58310423/the-podfile-for-hyperledger-indy-seems-to-be-linking-to-the-wrong-repository`



# dudas

-   Validar si la billetera solo se va a utiliza de manera local una unica vez y guarda su almacenamiento de ese momento, o debería de almacenar la información y en una futura conexión obtener toda la información que ha generado

