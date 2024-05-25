
import '../Class/status_request.dart';

handlingData(response){
  if(response is StatusRequest){
    return response;//because response have all status in ""crud"" file.
  }
  else{
    return StatusRequest.success;
  }
}