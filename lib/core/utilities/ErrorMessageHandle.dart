class ErrorMessageHandle {
  String getiste(String data){
    
    var datas = data.split(":");
    print(datas.length);
    if(datas.length != 2){
      return data;
    }
    return datas[1];
  }
}