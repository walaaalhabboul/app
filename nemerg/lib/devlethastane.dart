
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';



class Hak extends StatefulWidget {


  Hak({Key? key }) : super(key: key);

  @override
  State<Hak> createState() => _HakState();
}

class _HakState extends State<Hak> {
 String descText = "Türkiye'de çeşitli hastaneler var, bazı hastaneler belirli hizmetleri sağlarken bazıları sağlamaz \nAyrıca bu hastanelerin bazılarında özellikle acil durumlar için uzun bekleme süreleri vardır \nİnsanlar genellikle hangi hastanelerin ihtiyaç duydukları hizmetleri zamanında sağlayabileceğinden emin değildir\ninsanların acil durumlarda hangi hastaneye gidebileceklerini seçerken daha bilinçli kararlar almalarına yardımcı olur  " 

    
 
 
 
   
;
bool descTextShowFlag = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text("Hakkimizda"),
        backgroundColor: Colors.red,
        ),
      body: new Container(
        margin: EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
              Text(descText,
                maxLines: descTextShowFlag ? 13 : 2,textAlign: TextAlign.start),
              InkWell(
                onTap: (){ setState(() {
                descTextShowFlag = !descTextShowFlag; 
                }); },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text("         "),
                     Text("         "),
                      Text("         "),
                    descTextShowFlag ? Text("Show Less",
                    style: TextStyle(color: Colors.red),textAlign: TextAlign.right) : 
                     Text("Show More",style: TextStyle(color: Colors.red) ,textAlign: TextAlign.right ,),

Text('            '),
Text('            '),
Container(alignment: Alignment.center,
child: Image.asset('assets/images/v.png',height: 300,width: 400, ),

)
                 
                  ],
                
                ),
             
              ),
          ],
        ),
      ),
    );
  }
}
