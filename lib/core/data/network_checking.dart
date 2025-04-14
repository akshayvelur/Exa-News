  
  import 'dart:async';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

newWorkChecking(){
    bool isConnectedInternet=false;
 StreamSubscription? _internetConnectionStreamSubscription;
   _internetConnectionStreamSubscription= InternetConnection().onStatusChange.listen((event) {
     print(event);
     switch(event){
        case InternetStatus.connected:
         
          isConnectedInternet=true;
        
        break;
        case InternetStatus.disconnected:
         
          isConnectedInternet=false;
            
        break;
      default:
      
         isConnectedInternet=false;
      
    
      }
    });
  }