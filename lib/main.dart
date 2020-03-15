import 'dart:collection';
import 'dart:convert';

import 'package:corona_virus/icons/custom_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import '../icons/custom_icons.dart';

//var mock_data ='{"objectIdFieldName":"OBJECTID","uniqueIdField":{"name":"OBJECTID","isSystemMaintained":true},"globalIdFieldName":"","geometryType":"esriGeometryPoint","spatialReference":{"wkid":4326,"latestWkid":4326},"fields":[{"name":"OBJECTID","type":"esriFieldTypeOID","alias":"OBJECTID","sqlType":"sqlTypeOther","domain":null,"defaultValue":null},{"name":"Country_Region","type":"esriFieldTypeString","alias":"Country_Region","sqlType":"sqlTypeOther","length":8000,"domain":null,"defaultValue":null},{"name":"Last_Update","type":"esriFieldTypeDate","alias":"Last_Update","sqlType":"sqlTypeOther","length":8,"domain":null,"defaultValue":null},{"name":"Lat","type":"esriFieldTypeDouble","alias":"Lat","sqlType":"sqlTypeOther","domain":null,"defaultValue":null},{"name":"Long_","type":"esriFieldTypeDouble","alias":"Long","sqlType":"sqlTypeOther","domain":null,"defaultValue":null},{"name":"Confirmed","type":"esriFieldTypeInteger","alias":"Confirmed","sqlType":"sqlTypeOther","domain":null,"defaultValue":null},{"name":"Deaths","type":"esriFieldTypeInteger","alias":"Deaths","sqlType":"sqlTypeOther","domain":null,"defaultValue":null},{"name":"Recovered","type":"esriFieldTypeInteger","alias":"Recovered","sqlType":"sqlTypeOther","domain":null,"defaultValue":null}],"features":[{"attributes":{"OBJECTID":40,"Country_Region":"China","Last_Update":1583952723000,"Lat":22.166667,"Long_":113.55,"Confirmed":80932,"Deaths":3172,"Recovered":62892}},{"attributes":{"OBJECTID":93,"Country_Region":"Italy","Last_Update":1583962382000,"Lat":43,"Long_":12,"Confirmed":12462,"Deaths":827,"Recovered":1045}},{"attributes":{"OBJECTID":69,"Country_Region":"Iran","Last_Update":1584011607000,"Lat":32,"Long_":53,"Confirmed":10075,"Deaths":429,"Recovered":2959}},{"attributes":{"OBJECTID":87,"Country_Region":"Korea, South","Last_Update":1583989982000,"Lat":36,"Long_":128,"Confirmed":7869,"Deaths":66,"Recovered":333}},{"attributes":{"OBJECTID":33,"Country_Region":"France","Last_Update":1583969583000,"Lat":47,"Long_":2,"Confirmed":2284,"Deaths":48,"Recovered":12}},{"attributes":{"OBJECTID":14,"Country_Region":"Spain","Last_Update":1583975878000,"Lat":40,"Long_":-4,"Confirmed":2277,"Deaths":55,"Recovered":183}},{"attributes":{"OBJECTID":13,"Country_Region":"Germany","Last_Update":1584006786000,"Lat":51,"Long_":9,"Confirmed":2078,"Deaths":3,"Recovered":25}},{"attributes":{"OBJECTID":54,"Country_Region":"US","Last_Update":1583898783000,"Lat":40,"Long_":-100,"Confirmed":1323,"Deaths":38,"Recovered":8}},{"attributes":{"OBJECTID":36,"Country_Region":"Norway","Last_Update":1584018811000,"Lat":60.472,"Long_":8.4689,"Confirmed":702,"Deaths":0,"Recovered":1}},{"attributes":{"OBJECTID":37,"Country_Region":"Cruise Ship","Last_Update":1583964792000,"Lat":35.4437,"Long_":139.638,"Confirmed":696,"Deaths":7,"Recovered":325}},{"attributes":{"OBJECTID":82,"Country_Region":"Switzerland","Last_Update":1583959982000,"Lat":46.8182,"Long_":8.2275,"Confirmed":652,"Deaths":4,"Recovered":4}},{"attributes":{"OBJECTID":57,"Country_Region":"Japan","Last_Update":1583989982000,"Lat":36,"Long_":138,"Confirmed":639,"Deaths":16,"Recovered":118}},{"attributes":{"OBJECTID":77,"Country_Region":"Denmark","Last_Update":1583967183000,"Lat":56,"Long_":10,"Confirmed":617,"Deaths":0,"Recovered":2}},{"attributes":{"OBJECTID":15,"Country_Region":"Netherlands","Last_Update":1583935991000,"Lat":52.1326,"Long_":5.2913,"Confirmed":503,"Deaths":5,"Recovered":0}},{"attributes":{"OBJECTID":53,"Country_Region":"Sweden","Last_Update":1583955182000,"Lat":63,"Long_":16,"Confirmed":500,"Deaths":1,"Recovered":1}},{"attributes":{"OBJECTID":116,"Country_Region":"United Kingdom","Last_Update":1583971992000,"Lat":55,"Long_":-3,"Confirmed":459,"Deaths":8,"Recovered":19}},{"attributes":{"OBJECTID":73,"Country_Region":"Belgium","Last_Update":1583952723000,"Lat":50.8333,"Long_":4,"Confirmed":314,"Deaths":3,"Recovered":1}},{"attributes":{"OBJECTID":56,"Country_Region":"Austria","Last_Update":1584011609000,"Lat":47.5162,"Long_":14.5501,"Confirmed":302,"Deaths":1,"Recovered":4}},{"attributes":{"OBJECTID":92,"Country_Region":"Qatar","Last_Update":1583952723000,"Lat":25.3548,"Long_":51.1839,"Confirmed":262,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":9,"Country_Region":"Bahrain","Last_Update":1583965983000,"Lat":26.0275,"Long_":50.55,"Confirmed":195,"Deaths":0,"Recovered":35}},{"attributes":{"OBJECTID":114,"Country_Region":"Singapore","Last_Update":1583934804000,"Lat":1.283333,"Long_":103.833333,"Confirmed":178,"Deaths":0,"Recovered":96}},{"attributes":{"OBJECTID":55,"Country_Region":"Malaysia","Last_Update":1583926388000,"Lat":2.5,"Long_":112.5,"Confirmed":149,"Deaths":0,"Recovered":26}},{"attributes":{"OBJECTID":100,"Country_Region":"Israel","Last_Update":1584019982000,"Lat":31,"Long_":35,"Confirmed":130,"Deaths":0,"Recovered":4}},{"attributes":{"OBJECTID":68,"Country_Region":"Australia","Last_Update":1584001993000,"Lat":-25,"Long_":133,"Confirmed":128,"Deaths":3,"Recovered":21}},{"attributes":{"OBJECTID":1,"Country_Region":"Canada","Last_Update":1583799198000,"Lat":60,"Long_":-95,"Confirmed":117,"Deaths":2,"Recovered":12}},{"attributes":{"OBJECTID":117,"Country_Region":"Greece","Last_Update":1583970782000,"Lat":39.0742,"Long_":21.8243,"Confirmed":99,"Deaths":1,"Recovered":0}},{"attributes":{"OBJECTID":71,"Country_Region":"Czechia","Last_Update":1583976783000,"Lat":49.8175,"Long_":15.473,"Confirmed":94,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":11,"Country_Region":"Slovenia","Last_Update":1584019982000,"Lat":46.1512,"Long_":14.9955,"Confirmed":89,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":101,"Country_Region":"Iceland","Last_Update":1583934804000,"Lat":64.9631,"Long_":-19.0208,"Confirmed":85,"Deaths":0,"Recovered":1}},{"attributes":{"OBJECTID":59,"Country_Region":"Kuwait","Last_Update":1584004404000,"Lat":29.5,"Long_":47.75,"Confirmed":80,"Deaths":0,"Recovered":5}},{"attributes":{"OBJECTID":24,"Country_Region":"United Arab Emirates","Last_Update":1583959982000,"Lat":23.4241,"Long_":53.8478,"Confirmed":74,"Deaths":0,"Recovered":17}},{"attributes":{"OBJECTID":25,"Country_Region":"India","Last_Update":1584001993000,"Lat":21,"Long_":78,"Confirmed":73,"Deaths":1,"Recovered":4}},{"attributes":{"OBJECTID":84,"Country_Region":"Iraq","Last_Update":1584001993000,"Lat":33,"Long_":44,"Confirmed":71,"Deaths":8,"Recovered":15}},{"attributes":{"OBJECTID":74,"Country_Region":"Thailand","Last_Update":1584003182000,"Lat":15.87,"Long_":100.9925,"Confirmed":70,"Deaths":1,"Recovered":34}},{"attributes":{"OBJECTID":31,"Country_Region":"San Marino","Last_Update":1584003182000,"Lat":43.9424,"Long_":12.4578,"Confirmed":69,"Deaths":3,"Recovered":0}},{"attributes":{"OBJECTID":88,"Country_Region":"Egypt","Last_Update":1584003182000,"Lat":26,"Long_":30,"Confirmed":67,"Deaths":1,"Recovered":27}},{"attributes":{"OBJECTID":86,"Country_Region":"Lebanon","Last_Update":1584004404000,"Lat":33.8547,"Long_":35.8623,"Confirmed":61,"Deaths":3,"Recovered":1}},{"attributes":{"OBJECTID":45,"Country_Region":"Finland","Last_Update":1583933590000,"Lat":64,"Long_":26,"Confirmed":59,"Deaths":0,"Recovered":1}},{"attributes":{"OBJECTID":51,"Country_Region":"Portugal","Last_Update":1583933591000,"Lat":39.3999,"Long_":-8.2245,"Confirmed":59,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":58,"Country_Region":"Brazil","Last_Update":1583976783000,"Lat":-14.235,"Long_":-51.9253,"Confirmed":52,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":78,"Country_Region":"Philippines","Last_Update":1584006786000,"Lat":12.8797,"Long_":121.774,"Confirmed":52,"Deaths":2,"Recovered":2}},{"attributes":{"OBJECTID":50,"Country_Region":"Romania","Last_Update":1584004404000,"Lat":46,"Long_":25,"Confirmed":49,"Deaths":0,"Recovered":6}},{"attributes":{"OBJECTID":83,"Country_Region":"Taiwan*","Last_Update":1584000789000,"Lat":23.7,"Long_":121,"Confirmed":49,"Deaths":1,"Recovered":20}},{"attributes":{"OBJECTID":106,"Country_Region":"Poland","Last_Update":1584019982000,"Lat":51.9194,"Long_":19.1451,"Confirmed":49,"Deaths":1,"Recovered":0}},{"attributes":{"OBJECTID":10,"Country_Region":"Saudi Arabia","Last_Update":1583975878000,"Lat":24,"Long_":45,"Confirmed":45,"Deaths":0,"Recovered":1}},{"attributes":{"OBJECTID":64,"Country_Region":"Ireland","Last_Update":1583962383000,"Lat":53.1424,"Long_":-7.6921,"Confirmed":43,"Deaths":1,"Recovered":0}},{"attributes":{"OBJECTID":47,"Country_Region":"Vietnam","Last_Update":1584005583000,"Lat":16,"Long_":108,"Confirmed":39,"Deaths":0,"Recovered":16}},{"attributes":{"OBJECTID":44,"Country_Region":"Indonesia","Last_Update":1583925266000,"Lat":-0.7893,"Long_":113.9213,"Confirmed":34,"Deaths":1,"Recovered":2}},{"attributes":{"OBJECTID":48,"Country_Region":"Russia","Last_Update":1584003182000,"Lat":60,"Long_":90,"Confirmed":28,"Deaths":0,"Recovered":3}},{"attributes":{"OBJECTID":70,"Country_Region":"Algeria","Last_Update":1584004404000,"Lat":28.0339,"Long_":1.6596,"Confirmed":24,"Deaths":1,"Recovered":8}},{"attributes":{"OBJECTID":76,"Country_Region":"Georgia","Last_Update":1583964792000,"Lat":42.3154,"Long_":43.3569,"Confirmed":24,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":72,"Country_Region":"Chile","Last_Update":1583964792000,"Lat":-35.6751,"Long_":-71.543,"Confirmed":23,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":61,"Country_Region":"Costa Rica","Last_Update":1583976783000,"Lat":9.7489,"Long_":-83.7534,"Confirmed":22,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":22,"Country_Region":"Pakistan","Last_Update":1584003182000,"Lat":30.3753,"Long_":69.3451,"Confirmed":20,"Deaths":0,"Recovered":2}},{"attributes":{"OBJECTID":5,"Country_Region":"Argentina","Last_Update":1583893096000,"Lat":-38.4161,"Long_":-63.6167,"Confirmed":19,"Deaths":1,"Recovered":0}},{"attributes":{"OBJECTID":62,"Country_Region":"Luxembourg","Last_Update":1584010383000,"Lat":49.8144,"Long_":6.1317,"Confirmed":19,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":81,"Country_Region":"Croatia","Last_Update":1583964792000,"Lat":45.1667,"Long_":15.5,"Confirmed":19,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":115,"Country_Region":"Serbia","Last_Update":1584004404000,"Lat":44.0165,"Long_":21.0059,"Confirmed":19,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":17,"Country_Region":"Oman","Last_Update":1583829182000,"Lat":21,"Long_":57,"Confirmed":18,"Deaths":0,"Recovered":9}},{"attributes":{"OBJECTID":52,"Country_Region":"South Africa","Last_Update":1584004404000,"Lat":-30.5595,"Long_":22.9375,"Confirmed":17,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":66,"Country_Region":"Ecuador","Last_Update":1583919192000,"Lat":-1.8312,"Long_":-78.1834,"Confirmed":17,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":34,"Country_Region":"Slovakia","Last_Update":1584019982000,"Lat":48.669,"Long_":19.699,"Confirmed":16,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":85,"Country_Region":"Estonia","Last_Update":1583964792000,"Lat":58.5953,"Long_":25.0136,"Confirmed":16,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":23,"Country_Region":"Albania","Last_Update":1583976783000,"Lat":41.1533,"Long_":20.1683,"Confirmed":15,"Deaths":1,"Recovered":0}},{"attributes":{"OBJECTID":35,"Country_Region":"Peru","Last_Update":1584003182000,"Lat":-9.19,"Long_":-75.0152,"Confirmed":15,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":30,"Country_Region":"Hungary","Last_Update":1583964792000,"Lat":47.1625,"Long_":19.5033,"Confirmed":13,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":110,"Country_Region":"Belarus","Last_Update":1584003182000,"Lat":53.7098,"Long_":27.9534,"Confirmed":12,"Deaths":0,"Recovered":3}},{"attributes":{"OBJECTID":112,"Country_Region":"Mexico","Last_Update":1583989983000,"Lat":23,"Long_":-102,"Confirmed":12,"Deaths":0,"Recovered":4}},{"attributes":{"OBJECTID":12,"Country_Region":"Bosnia and Herzegovina","Last_Update":1584004406000,"Lat":43.9159,"Long_":17.6791,"Confirmed":11,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":26,"Country_Region":"Azerbaijan","Last_Update":1583914389000,"Lat":40.1431,"Long_":47.5769,"Confirmed":11,"Deaths":0,"Recovered":3}},{"attributes":{"OBJECTID":60,"Country_Region":"Panama","Last_Update":1584003182000,"Lat":8.538,"Long_":-80.7821,"Confirmed":11,"Deaths":1,"Recovered":0}},{"attributes":{"OBJECTID":67,"Country_Region":"Brunei","Last_Update":1583964792000,"Lat":4.5353,"Long_":114.7277,"Confirmed":11,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":108,"Country_Region":"Latvia","Last_Update":1583934804000,"Lat":56.8796,"Long_":24.6032,"Confirmed":10,"Deaths":0,"Recovered":1}},{"attributes":{"OBJECTID":89,"Country_Region":"Colombia","Last_Update":1583937184000,"Lat":4.5709,"Long_":-74.2973,"Confirmed":9,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":2,"Country_Region":"Maldives","Last_Update":1583919192000,"Lat":3.2028,"Long_":73.2207,"Confirmed":8,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":18,"Country_Region":"North Macedonia","Last_Update":1583837583000,"Lat":41.6086,"Long_":21.7453,"Confirmed":7,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":28,"Country_Region":"Afghanistan","Last_Update":1583921592000,"Lat":33,"Long_":65,"Confirmed":7,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":49,"Country_Region":"Bulgaria","Last_Update":1583964792000,"Lat":42.7339,"Long_":25.4858,"Confirmed":7,"Deaths":1,"Recovered":0}},{"attributes":{"OBJECTID":113,"Country_Region":"Tunisia","Last_Update":1583952723000,"Lat":33.8869,"Long_":9.5375,"Confirmed":7,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":80,"Country_Region":"Morocco","Last_Update":1583976783000,"Lat":31.7917,"Long_":-7.0926,"Confirmed":6,"Deaths":1,"Recovered":0}},{"attributes":{"OBJECTID":91,"Country_Region":"Cyprus","Last_Update":1583952723000,"Lat":35.1264,"Long_":33.4299,"Confirmed":6,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":96,"Country_Region":"Malta","Last_Update":1583926388000,"Lat":35.9375,"Long_":14.3754,"Confirmed":6,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":19,"Country_Region":"French Guiana","Last_Update":1583551385000,"Lat":3.9339,"Long_":-53.1258,"Confirmed":5,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":21,"Country_Region":"New Zealand","Last_Update":1583546609000,"Lat":-40.9006,"Long_":174.886,"Confirmed":5,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":42,"Country_Region":"Dominican Republic","Last_Update":1583688188000,"Lat":18.7357,"Long_":-70.1627,"Confirmed":5,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":107,"Country_Region":"Paraguay","Last_Update":1583901183000,"Lat":-23.4425,"Long_":-58.4438,"Confirmed":5,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":102,"Country_Region":"Senegal","Last_Update":1583698988000,"Lat":14.4974,"Long_":-14.4524,"Confirmed":4,"Deaths":0,"Recovered":1}},{"attributes":{"OBJECTID":3,"Country_Region":"Lithuania","Last_Update":1583893106000,"Lat":55.1694,"Long_":23.8813,"Confirmed":3,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":4,"Country_Region":"Cambodia","Last_Update":1583919192000,"Lat":12.5657,"Long_":104.991,"Confirmed":3,"Deaths":0,"Recovered":1}},{"attributes":{"OBJECTID":29,"Country_Region":"Bangladesh","Last_Update":1583821172000,"Lat":23.685,"Long_":90.3563,"Confirmed":3,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":38,"Country_Region":"Cuba","Last_Update":1583992383000,"Lat":22,"Long_":-80,"Confirmed":3,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":79,"Country_Region":"Moldova","Last_Update":1583952723000,"Lat":47.4116,"Long_":28.3699,"Confirmed":3,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":105,"Country_Region":"Martinique","Last_Update":1583893109000,"Lat":14.6415,"Long_":-61.0242,"Confirmed":3,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":6,"Country_Region":"Bolivia","Last_Update":1583952723000,"Lat":-16.2902,"Long_":-63.5887,"Confirmed":2,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":7,"Country_Region":"Cameroon","Last_Update":1583644983000,"Lat":3.848,"Long_":11.5021,"Confirmed":2,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":8,"Country_Region":"Burkina Faso","Last_Update":1583919192000,"Lat":12.2383,"Long_":-1.5616,"Confirmed":2,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":16,"Country_Region":"Jamaica","Last_Update":1583976783000,"Lat":18.1096,"Long_":-77.2975,"Confirmed":2,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":20,"Country_Region":"Monaco","Last_Update":1584017583000,"Lat":43.7333,"Long_":7.4167,"Confirmed":2,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":65,"Country_Region":"Nigeria","Last_Update":1583746983000,"Lat":9.082,"Long_":8.6753,"Confirmed":2,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":111,"Country_Region":"Honduras","Last_Update":1583952723000,"Lat":15.2,"Long_":-86.2419,"Confirmed":2,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":118,"Country_Region":"Sri Lanka","Last_Update":1583919192000,"Lat":7.8731,"Long_":80.7718,"Confirmed":2,"Deaths":0,"Recovered":1}},{"attributes":{"OBJECTID":27,"Country_Region":"Turkey","Last_Update":1583897585000,"Lat":38.9637,"Long_":35.2433,"Confirmed":1,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":32,"Country_Region":"Mongolia","Last_Update":1583820823000,"Lat":46.8625,"Long_":103.8467,"Confirmed":1,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":39,"Country_Region":"Togo","Last_Update":1583547189000,"Lat":8.6195,"Long_":0.8248,"Confirmed":1,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":41,"Country_Region":"Armenia","Last_Update":1583092382000,"Lat":40.0691,"Long_":45.0382,"Confirmed":1,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":43,"Country_Region":"Ukraine","Last_Update":1583249582000,"Lat":48.3794,"Long_":31.1656,"Confirmed":1,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":46,"Country_Region":"Liechtenstein","Last_Update":1583285587000,"Lat":47.14,"Long_":9.55,"Confirmed":1,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":63,"Country_Region":"Andorra","Last_Update":1583180596000,"Lat":42.5063,"Long_":1.5218,"Confirmed":1,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":90,"Country_Region":"Reunion","Last_Update":1583968387000,"Lat":-21.1151,"Long_":55.5364,"Confirmed":1,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":94,"Country_Region":"Bhutan","Last_Update":1583509382000,"Lat":27.5142,"Long_":90.4336,"Confirmed":1,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":95,"Country_Region":"Nepal","Last_Update":1583829183000,"Lat":28.3949,"Long_":84.124,"Confirmed":1,"Deaths":0,"Recovered":1}},{"attributes":{"OBJECTID":97,"Country_Region":"Congo (Kinshasa)","Last_Update":1583961204000,"Lat":-4.0383,"Long_":21.7587,"Confirmed":1,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":99,"Country_Region":"Holy See","Last_Update":1583867601000,"Lat":41.9029,"Long_":12.4534,"Confirmed":1,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":103,"Country_Region":"Cote d\'Ivoire","Last_Update":1583975881000,"Lat":7.54,"Long_":-5.5471,"Confirmed":1,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":104,"Country_Region":"Jordan","Last_Update":1583249582000,"Lat":31.24,"Long_":36.51,"Confirmed":1,"Deaths":0,"Recovered":0}},{"attributes":{"OBJECTID":109,"Country_Region":"Guyana","Last_Update":1583992383000,"Lat":5,"Long_":-58.75,"Confirmed":1,"Deaths":1,"Recovered":0}}]}';
//var mock_data =
//    '{"countries":[{"_id":"5e6b5af9eba9073343c02c4a","name":"Afghanistan","latitude":33,"longitude":65,"confirmed":7,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.923Z"},{"_id":"5e6b5af9eba907d82fc02c45","name":"Albania","latitude":41.1533,"longitude":20.1683,"confirmed":23,"recovered":1,"deaths":0,"updatedAt":"2020-03-13T10:05:45.910Z"},{"_id":"5e6b5af9eba9074594c02c05","name":"Algeria","latitude":28.0339,"longitude":1.6596,"confirmed":24,"recovered":1,"deaths":8,"updatedAt":"2020-03-13T10:05:45.773Z"},{"_id":"5e6b5af9eba9079c73c02c26","name":"Andorra","latitude":42.5063,"longitude":1.5218,"confirmed":1,"recovered":0,"deaths":1,"updatedAt":"2020-03-13T10:05:45.832Z"},{"_id":"5e6b5af9eba9073104c02bf1","name":"Argentina","latitude":-38.4161,"longitude":-63.6167,"confirmed":19,"recovered":1,"deaths":0,"updatedAt":"2020-03-13T10:05:45.745Z"},{"_id":"5e6b5af9eba907b581c02c4c","name":"Armenia","latitude":40.0691,"longitude":45.0382,"confirmed":4,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.925Z"},{"_id":"5e6b5af9eba9078ba2c02c2a","name":"Australia","latitude":-25,"longitude":133,"confirmed":128,"recovered":3,"deaths":21,"updatedAt":"2020-03-13T10:05:45.840Z"},{"_id":"5e6b5af9eba9070a81c02c14","name":"Austria","latitude":47.5162,"longitude":14.5501,"confirmed":302,"recovered":1,"deaths":4,"updatedAt":"2020-03-13T10:05:45.794Z"},{"_id":"5e6b5af9eba907af20c02c09","name":"Azerbaijan","latitude":40.1431,"longitude":47.5769,"confirmed":11,"recovered":0,"deaths":3,"updatedAt":"2020-03-13T10:05:45.778Z"},{"_id":"5e6b5af9eba90719d8c02bff","name":"Bahrain","latitude":26.0275,"longitude":50.55,"confirmed":195,"recovered":0,"deaths":35,"updatedAt":"2020-03-13T10:05:45.765Z"},{"_id":"5e6b5af9eba907975fc02bf8","name":"Bangladesh","latitude":23.685,"longitude":90.3563,"confirmed":3,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.753Z"},{"_id":"5e6b5af9eba907e002c02c48","name":"Belarus","latitude":53.7098,"longitude":27.9534,"confirmed":12,"recovered":0,"deaths":3,"updatedAt":"2020-03-13T10:05:45.913Z"},{"_id":"5e6b5af9eba907b43ac02c3e","name":"Belgium","latitude":50.8333,"longitude":4,"confirmed":314,"recovered":3,"deaths":1,"updatedAt":"2020-03-13T10:05:45.888Z"},{"_id":"5e6b7011eba907281dc02c54","name":"Belgium","latitude":50.8333,"longitude":4,"confirmed":399,"recovered":3,"deaths":1,"updatedAt":"2020-03-13T11:35:45.919Z"},{"_id":"5e6b5af9eba9070badc02c11","name":"Bhutan","latitude":27.5142,"longitude":90.4336,"confirmed":1,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.790Z"},{"_id":"5e6b5af9eba9072efcc02c0e","name":"Bolivia","latitude":-16.2902,"longitude":-63.5887,"confirmed":2,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.784Z"},{"_id":"5e6b5af9eba90742f8c02c33","name":"Bosnia and Herzegovina","latitude":43.9159,"longitude":17.6791,"confirmed":11,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.854Z"},{"_id":"5e6b5af9eba9075192c02c03","name":"Brazil","latitude":-14.235,"longitude":-51.9253,"confirmed":52,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.770Z"},{"_id":"5e6b5af9eba90773d9c02c49","name":"Brunei","latitude":4.5353,"longitude":114.7277,"confirmed":11,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.922Z"},{"_id":"5e6b7269eba90760c4c02c56","name":"Brunei","latitude":4.5353,"longitude":114.7277,"confirmed":11,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T11:45:45.742Z"},{"_id":"5e6b5af9eba9072efcc02c20","name":"Bulgaria","latitude":42.7339,"longitude":25.4858,"confirmed":7,"recovered":1,"deaths":0,"updatedAt":"2020-03-13T10:05:45.824Z"},{"_id":"5e6b5af9eba907f06ec02c4e","name":"Burkina Faso","latitude":12.2383,"longitude":-1.5616,"confirmed":2,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.929Z"},{"_id":"5e6b5af9eba90702d5c02c0d","name":"Cambodia","latitude":12.5657,"longitude":104.991,"confirmed":3,"recovered":0,"deaths":1,"updatedAt":"2020-03-13T10:05:45.783Z"},{"_id":"5e6b5af9eba907de85c02bf9","name":"Cameroon","latitude":3.848,"longitude":11.5021,"confirmed":2,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.755Z"},{"_id":"5e6b5af9eba907467fc02c00","name":"Canada","latitude":60,"longitude":-95,"confirmed":117,"recovered":2,"deaths":12,"updatedAt":"2020-03-13T10:05:45.766Z"},{"_id":"5e6b5af9eba9070c97c02c1b","name":"Chile","latitude":-35.6751,"longitude":-71.543,"confirmed":23,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.807Z"},{"_id":"5e6b5af9eba907468bc02bde","name":"China","latitude":22.166667,"longitude":113.55,"confirmed":80932,"recovered":3172,"deaths":62901,"updatedAt":"2020-03-13T10:05:45.668Z"},{"_id":"5e6b5af9eba907a230c02c34","name":"Colombia","latitude":4.5709,"longitude":-74.2973,"confirmed":9,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.862Z"},{"_id":"5e6b5af9eba907da13c02c51","name":"Congo (Kinshasa)","latitude":-4.0383,"longitude":21.7587,"confirmed":1,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.934Z"},{"_id":"5e6b7011eba90770c3c02c55","name":"Congo (Kinshasa)","latitude":-4.0383,"longitude":21.7587,"confirmed":1,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T11:35:45.986Z"},{"_id":"5e6b5af9eba9076f38c02c30","name":"Costa Rica","latitude":9.7489,"longitude":-83.7534,"confirmed":22,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.851Z"},{"_id":"5e6b5af9eba9079dcec02c3c","name":"Cote dIvoire","latitude":7.54,"longitude":-5.5471,"confirmed":1,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.879Z"},{"_id":"5e6b5af9eba9078e04c02c1c","name":"Croatia","latitude":45.1667,"longitude":15.5,"confirmed":19,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.808Z"},{"_id":"5e6b5af9eba9078d1ec02be7","name":"Cruise Ship","latitude":35.4437,"longitude":139.638,"confirmed":696,"recovered":7,"deaths":325,"updatedAt":"2020-03-13T10:05:45.691Z"},{"_id":"5e6b5af9eba9070510c02c4d","name":"Cuba","latitude":22,"longitude":-80,"confirmed":3,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.927Z"},{"_id":"5e6b5af9eba9072747c02bf6","name":"Cyprus","latitude":35.1264,"longitude":33.4299,"confirmed":6,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.751Z"},{"_id":"5e6b5af9eba9074148c02c16","name":"Czechia","latitude":49.8175,"longitude":15.473,"confirmed":94,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.800Z"},{"_id":"5e6b5af9eba907f304c02c13","name":"Denmark","latitude":56,"longitude":10,"confirmed":617,"recovered":0,"deaths":2,"updatedAt":"2020-03-13T10:05:45.793Z"},{"_id":"5e6b5af9eba9072167c02c0c","name":"Dominican Republic","latitude":18.7357,"longitude":-70.1627,"confirmed":5,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.782Z"},{"_id":"5e6b5af9eba907c32fc02c47","name":"Ecuador","latitude":-1.8312,"longitude":-78.1834,"confirmed":17,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.912Z"},{"_id":"5e6b5af9eba90791b5c02bed","name":"Egypt","latitude":26,"longitude":30,"confirmed":67,"recovered":1,"deaths":27,"updatedAt":"2020-03-13T10:05:45.740Z"},{"_id":"5e6b7e21eba90779dbc02c5a","name":"Egypt","latitude":26,"longitude":30,"confirmed":80,"recovered":2,"deaths":27,"updatedAt":"2020-03-13T12:35:45.768Z"},{"_id":"5e6b5af9eba9077096c02c32","name":"Estonia","latitude":58.5953,"longitude":25.0136,"confirmed":16,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.853Z"},{"_id":"5e6b7e21eba9074e10c02c5b","name":"Fench Guiana","latitude":4,"longitude":-53,"confirmed":5,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T12:35:45.863Z"},{"_id":"5e6c0854946cd03dc6041497","name":"Fench Guiana","latitude":4,"longitude":-53,"confirmed":5,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T22:25:24.873Z"},{"_id":"5e6c1d6c946cd03d36041498","name":"Fench Guiana","latitude":4,"longitude":-53,"confirmed":5,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T23:55:24.774Z"},{"_id":"5e6c221c946cd033f4041499","name":"Fench Guiana","latitude":4,"longitude":-53,"confirmed":5,"recovered":0,"deaths":0,"updatedAt":"2020-03-14T00:15:24.760Z"},{"_id":"5e6c3284946cd0f22b04149a","name":"Fench Guiana","latitude":4,"longitude":-53,"confirmed":5,"recovered":0,"deaths":0,"updatedAt":"2020-03-14T01:25:24.777Z"},{"_id":"5e6c34dc946cd0f04004149b","name":"Fench Guiana","latitude":4,"longitude":-53,"confirmed":5,"recovered":0,"deaths":0,"updatedAt":"2020-03-14T01:35:24.776Z"},{"_id":"5e6b5af9eba9076fbac02c18","name":"Finland","latitude":64,"longitude":26,"confirmed":59,"recovered":0,"deaths":1,"updatedAt":"2020-03-13T10:05:45.802Z"},{"_id":"5e6b5af9eba90763a0c02be2","name":"France","latitude":47,"longitude":2,"confirmed":2284,"recovered":48,"deaths":12,"updatedAt":"2020-03-13T10:05:45.683Z"},{"_id":"5e6b5af9eba90780c3c02c21","name":"French Guiana","latitude":3.9339,"longitude":-53.1258,"confirmed":5,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.825Z"},{"_id":"5e6b7011eba907af41c02c52","name":"French Guiana","latitude":3.9339,"longitude":-53.1258,"confirmed":5,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T11:35:45.826Z"},{"_id":"5e6b7e21eba9070fc5c02c5e","name":"French Guiana","latitude":3.9339,"longitude":-53.1258,"confirmed":5,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T12:35:45.897Z"},{"_id":"5e6c0854946cd02c62041496","name":"French Guiana","latitude":3.9339,"longitude":-53.1258,"confirmed":5,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T22:25:24.868Z"},{"_id":"5e6c34dc946cd04db204149c","name":"French Guiana","latitude":3.9339,"longitude":-53.1258,"confirmed":5,"recovered":0,"deaths":0,"updatedAt":"2020-03-14T01:35:24.823Z"},{"_id":"5e6b5af9eba907bfe4c02bf0","name":"Georgia","latitude":42.3154,"longitude":43.3569,"confirmed":24,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.744Z"},{"_id":"5e6b5af9eba9071735c02be5","name":"Germany","latitude":51,"longitude":9,"confirmed":2078,"recovered":3,"deaths":25,"updatedAt":"2020-03-13T10:05:45.690Z"},{"_id":"5e6b5af9eba9077201c02c40","name":"Greece","latitude":39.0742,"longitude":21.8243,"confirmed":99,"recovered":1,"deaths":0,"updatedAt":"2020-03-13T10:05:45.892Z"},{"_id":"5e6b7e21eba9077732c02c59","name":"Greece","latitude":39.0742,"longitude":21.8243,"confirmed":133,"recovered":1,"deaths":0,"updatedAt":"2020-03-13T12:35:45.754Z"},{"_id":"5e6c0854946cd0608a041494","name":"Greece","latitude":39.0742,"longitude":21.8243,"confirmed":190,"recovered":1,"deaths":0,"updatedAt":"2020-03-13T22:25:24.664Z"},{"_id":"5e6b5af9eba9078344c02bfd","name":"Guyana","latitude":5,"longitude":-58.75,"confirmed":1,"recovered":1,"deaths":0,"updatedAt":"2020-03-13T10:05:45.761Z"},{"_id":"5e6b5af9eba9072c29c02c27","name":"Holy See","latitude":41.9029,"longitude":12.4534,"confirmed":1,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.833Z"},{"_id":"5e6b5af9eba9075fa7c02bfa","name":"Honduras","latitude":15.2,"longitude":-86.2419,"confirmed":2,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.756Z"},{"_id":"5e6b7e21eba907ab1dc02c5f","name":"Honduras","latitude":15.2,"longitude":-86.2419,"confirmed":2,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T12:35:45.900Z"},{"_id":"5e6b5af9eba9070c1cc02bf3","name":"Hungary","latitude":47.1625,"longitude":19.5033,"confirmed":13,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.747Z"},{"_id":"5e6b5af9eba907f6aac02beb","name":"Iceland","latitude":64.9631,"longitude":-19.0208,"confirmed":103,"recovered":0,"deaths":1,"updatedAt":"2020-03-13T10:05:45.738Z"},{"_id":"5e6b5af9eba9074c81c02c41","name":"India","latitude":21,"longitude":78,"confirmed":73,"recovered":1,"deaths":4,"updatedAt":"2020-03-13T10:05:45.897Z"},{"_id":"5e6b5af9eba9071c97c02c1a","name":"Indonesia","latitude":-0.7893,"longitude":113.9213,"confirmed":34,"recovered":1,"deaths":2,"updatedAt":"2020-03-13T10:05:45.806Z"},{"_id":"5e6b5af9eba907aba7c02c17","name":"Iraq","latitude":33,"longitude":44,"confirmed":71,"recovered":8,"deaths":15,"updatedAt":"2020-03-13T10:05:45.801Z"},{"_id":"5e6b5af9eba9077a61c02bef","name":"Ireland","latitude":53.1424,"longitude":-7.6921,"confirmed":43,"recovered":1,"deaths":0,"updatedAt":"2020-03-13T10:05:45.743Z"},{"_id":"5e6b5af9eba90762fec02c15","name":"Israel","latitude":31,"longitude":35,"confirmed":131,"recovered":0,"deaths":4,"updatedAt":"2020-03-13T10:05:45.799Z"},{"_id":"5e6b5af9eba907e859c02be0","name":"Italy","latitude":43,"longitude":12,"confirmed":12462,"recovered":827,"deaths":1045,"updatedAt":"2020-03-13T10:05:45.678Z"},{"_id":"5e6b5af9eba90742fdc02c24","name":"Jamaica","latitude":18.1096,"longitude":-77.2975,"confirmed":2,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.830Z"},{"_id":"5e6b5af9eba907ce95c02bfe","name":"Japan","latitude":36,"longitude":138,"confirmed":639,"recovered":16,"deaths":118,"updatedAt":"2020-03-13T10:05:45.764Z"},{"_id":"5e6b5af9eba907429bc02bdf","name":"Jordan","latitude":31.24,"longitude":36.51,"confirmed":1,"recovered":0,"deaths":1,"updatedAt":"2020-03-14T10:35:24.906Z"},{"_id":"5e6b5af9eba907f496c02c12","name":"Jordan","latitude":31.24,"longitude":36.51,"confirmed":1,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.792Z"},{"_id":"5e6b5af9eba907c710c02be1","name":"Korea, South","latitude":36,"longitude":128,"confirmed":7869,"recovered":66,"deaths":333,"updatedAt":"2020-03-13T10:05:45.682Z"},{"_id":"5e6b5af9eba9077912c02bec","name":"Kuwait","latitude":29.5,"longitude":47.75,"confirmed":80,"recovered":0,"deaths":5,"updatedAt":"2020-03-13T10:05:45.739Z"},{"_id":"5e6b5af9eba907835cc02c1f","name":"Latvia","latitude":56.8796,"longitude":24.6032,"confirmed":10,"recovered":0,"deaths":1,"updatedAt":"2020-03-13T10:05:45.822Z"},{"_id":"5e6b5af9eba90784fac02c42","name":"Lebanon","latitude":33.8547,"longitude":35.8623,"confirmed":61,"recovered":3,"deaths":1,"updatedAt":"2020-03-13T10:05:45.902Z"},{"_id":"5e6b5af9eba907624cc02c50","name":"Liechtenstein","latitude":47.14,"longitude":9.55,"confirmed":1,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.933Z"},{"_id":"5e6b5af9eba9075e0ec02c37","name":"Lithuania","latitude":55.1694,"longitude":23.8813,"confirmed":3,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.869Z"},{"_id":"5e6b5af9eba907668ac02c46","name":"Luxembourg","latitude":49.8144,"longitude":6.1317,"confirmed":19,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.911Z"},{"_id":"5e6b5af9eba9074350c02c3f","name":"Malaysia","latitude":2.5,"longitude":112.5,"confirmed":149,"recovered":0,"deaths":26,"updatedAt":"2020-03-13T10:05:45.891Z"},{"_id":"5e6b5af9eba907523ec02c0a","name":"Maldives","latitude":3.2028,"longitude":73.2207,"confirmed":8,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.779Z"},{"_id":"5e6b5af9eba907dcaec02c4b","name":"Malta","latitude":35.9375,"longitude":14.3754,"confirmed":6,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.924Z"},{"_id":"5e6b5af9eba907b5acc02c38","name":"Martinique","latitude":14.6415,"longitude":-61.0242,"confirmed":3,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.871Z"},{"_id":"5e6b5af9eba9077913c02c1e","name":"Mexico","latitude":23,"longitude":-102,"confirmed":12,"recovered":0,"deaths":4,"updatedAt":"2020-03-13T10:05:45.811Z"},{"_id":"5e6b7e21eba9071764c02c5d","name":"Mexico","latitude":23,"longitude":-102,"confirmed":12,"recovered":0,"deaths":4,"updatedAt":"2020-03-13T12:35:45.882Z"},{"_id":"5e6b5af9eba90727a5c02c23","name":"Moldova","latitude":47.4116,"longitude":28.3699,"confirmed":3,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.828Z"},{"_id":"5e6b5af9eba907ca84c02c39","name":"Monaco","latitude":43.7333,"longitude":7.4167,"confirmed":2,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.876Z"},{"_id":"5e6b5af9eba907a15bc02c3a","name":"Mongolia","latitude":46.8625,"longitude":103.8467,"confirmed":1,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.877Z"},{"_id":"5e6b5af9eba9076735c02c0b","name":"Morocco","latitude":31.7917,"longitude":-7.0926,"confirmed":6,"recovered":1,"deaths":0,"updatedAt":"2020-03-13T10:05:45.780Z"},{"_id":"5e6b5af9eba907510dc02bfc","name":"Nepal","latitude":28.3949,"longitude":84.124,"confirmed":1,"recovered":0,"deaths":1,"updatedAt":"2020-03-13T10:05:45.760Z"},{"_id":"5e6b5af9eba9078df2c02c3d","name":"Netherlands","latitude":52.1326,"longitude":5.2913,"confirmed":503,"recovered":5,"deaths":0,"updatedAt":"2020-03-13T10:05:45.887Z"},{"_id":"5e6b5af9eba907b073c02c36","name":"New Zealand","latitude":-40.9006,"longitude":174.886,"confirmed":5,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.868Z"},{"_id":"5e6b5af9eba90723acc02c0f","name":"Nigeria","latitude":9.082,"longitude":8.6753,"confirmed":2,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.788Z"},{"_id":"5e6b5af9eba9073c35c02bf5","name":"North Macedonia","latitude":41.6086,"longitude":21.7453,"confirmed":7,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.750Z"},{"_id":"5e6b5af9eba9072d30c02be4","name":"Norway","latitude":60.472,"longitude":8.4689,"confirmed":702,"recovered":0,"deaths":1,"updatedAt":"2020-03-13T10:05:45.689Z"},{"_id":"5e6b5af9eba907db6ac02c07","name":"Oman","latitude":21,"longitude":57,"confirmed":18,"recovered":0,"deaths":9,"updatedAt":"2020-03-13T10:05:45.775Z"},{"_id":"5e6b5af9eba9070b08c02c06","name":"Pakistan","latitude":30.3753,"longitude":69.3451,"confirmed":20,"recovered":0,"deaths":2,"updatedAt":"2020-03-13T10:05:45.774Z"},{"_id":"5e6b5af9eba9076d87c02bf4","name":"Panama","latitude":8.538,"longitude":-80.7821,"confirmed":11,"recovered":1,"deaths":0,"updatedAt":"2020-03-13T10:05:45.748Z"},{"_id":"5e6b5af9eba9076444c02bf7","name":"Paraguay","latitude":-23.4425,"longitude":-58.4438,"confirmed":5,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.752Z"},{"_id":"5e6b5af9eba907d8cec02c08","name":"Peru","latitude":-9.19,"longitude":-75.0152,"confirmed":15,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.777Z"},{"_id":"5e6b5af9eba907f632c02bee","name":"Philippines","latitude":12.8797,"longitude":121.774,"confirmed":52,"recovered":2,"deaths":2,"updatedAt":"2020-03-13T10:05:45.742Z"},{"_id":"5e6b5af9eba907b859c02c2e","name":"Poland","latitude":51.9194,"longitude":19.1451,"confirmed":49,"recovered":1,"deaths":0,"updatedAt":"2020-03-13T10:05:45.845Z"},{"_id":"5e6b5af9eba9077a62c02c2d","name":"Portugal","latitude":39.3999,"longitude":-8.2245,"confirmed":59,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.844Z"},{"_id":"5e6b5af9eba9071cdcc02c29","name":"Qatar","latitude":25.3548,"longitude":51.1839,"confirmed":262,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.839Z"},{"_id":"5e6b5af9eba9072313c02c3b","name":"Reunion","latitude":-21.1151,"longitude":55.5364,"confirmed":1,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.878Z"},{"_id":"5e6b5af9eba9074f9cc02c43","name":"Romania","latitude":46,"longitude":25,"confirmed":49,"recovered":0,"deaths":6,"updatedAt":"2020-03-13T10:05:45.903Z"},{"_id":"5e6b5af9eba9075437c02c2f","name":"Russia","latitude":60,"longitude":90,"confirmed":28,"recovered":0,"deaths":3,"updatedAt":"2020-03-13T10:05:45.850Z"},{"_id":"5e6b5af9eba90707edc02c02","name":"San Marino","latitude":43.9424,"longitude":12.4578,"confirmed":69,"recovered":3,"deaths":0,"updatedAt":"2020-03-13T10:05:45.769Z"},{"_id":"5e6b5af9eba9076b3dc02c04","name":"Saudi Arabia","latitude":24,"longitude":45,"confirmed":45,"recovered":0,"deaths":1,"updatedAt":"2020-03-13T10:05:45.772Z"},{"_id":"5e6b5af9eba907a8c3c02c22","name":"Senegal","latitude":14.4974,"longitude":-14.4524,"confirmed":4,"recovered":0,"deaths":1,"updatedAt":"2020-03-13T10:05:45.827Z"},{"_id":"5e6b5af9eba9075ad8c02c31","name":"Serbia","latitude":44.0165,"longitude":21.0059,"confirmed":19,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.852Z"},{"_id":"5e6b7e21eba907fdc1c02c5c","name":"Serbia","latitude":44.0165,"longitude":21.0059,"confirmed":31,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T12:35:45.880Z"},{"_id":"5e6b5af9eba90706dbc02bea","name":"Singapore","latitude":1.283333,"longitude":103.833333,"confirmed":178,"recovered":0,"deaths":96,"updatedAt":"2020-03-13T10:05:45.736Z"},{"_id":"5e6b7e21eba907edb3c02c58","name":"Singapore","latitude":1.283333,"longitude":103.833333,"confirmed":187,"recovered":0,"deaths":96,"updatedAt":"2020-03-13T12:35:45.744Z"},{"_id":"5e6b5af9eba90792d8c02c1d","name":"Slovakia","latitude":48.669,"longitude":19.699,"confirmed":16,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.810Z"},{"_id":"5e6b5af9eba90772b4c02c2b","name":"Slovenia","latitude":46.1512,"longitude":14.9955,"confirmed":89,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.841Z"},{"_id":"5e6b5af9eba90770b7c02bf2","name":"South Africa","latitude":-30.5595,"longitude":22.9375,"confirmed":17,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.746Z"},{"_id":"5e6b5af9eba9077b57c02be3","name":"Spain","latitude":40,"longitude":-4,"confirmed":2277,"recovered":55,"deaths":183,"updatedAt":"2020-03-13T10:05:45.684Z"},{"_id":"5e6b5af9eba9077f50c02c4f","name":"Sri Lanka","latitude":7.8731,"longitude":80.7718,"confirmed":2,"recovered":0,"deaths":1,"updatedAt":"2020-03-13T10:05:45.932Z"},{"_id":"5e6b7011eba9073466c02c53","name":"Sri Lanka","latitude":7.8731,"longitude":80.7718,"confirmed":2,"recovered":0,"deaths":1,"updatedAt":"2020-03-13T11:35:45.914Z"},{"_id":"5e6b7e21eba9076b03c02c60","name":"Sri Lanka","latitude":7.8731,"longitude":80.7718,"confirmed":3,"recovered":0,"deaths":1,"updatedAt":"2020-03-13T12:35:45.903Z"},{"_id":"5e6c0854946cd0369a041495","name":"Sri Lanka","latitude":7.8731,"longitude":80.7718,"confirmed":5,"recovered":0,"deaths":1,"updatedAt":"2020-03-13T22:25:24.738Z"},{"_id":"5e6b5af9eba907c0a5c02c28","name":"Sweden","latitude":63,"longitude":16,"confirmed":599,"recovered":1,"deaths":1,"updatedAt":"2020-03-13T10:05:45.838Z"},{"_id":"5e6b5af9eba907dd1cc02be8","name":"Switzerland","latitude":46.8182,"longitude":8.2275,"confirmed":652,"recovered":4,"deaths":4,"updatedAt":"2020-03-13T10:05:45.734Z"},{"_id":"5e6b5af9eba9075450c02c19","name":"Taiwan*","latitude":23.7,"longitude":121,"confirmed":49,"recovered":1,"deaths":20,"updatedAt":"2020-03-13T10:05:45.804Z"},{"_id":"5e6b5af9eba907811fc02c2c","name":"Thailand","latitude":15.87,"longitude":100.9925,"confirmed":70,"recovered":1,"deaths":34,"updatedAt":"2020-03-13T10:05:45.842Z"},{"_id":"5e6b5af9eba9077748c02c10","name":"Togo","latitude":8.6195,"longitude":0.8248,"confirmed":1,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.789Z"},{"_id":"5e6b5af9eba9071fc2c02c35","name":"Tunisia","latitude":33.8869,"longitude":9.5375,"confirmed":7,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.863Z"},{"_id":"5e6b5af9eba907efbdc02c25","name":"Turkey","latitude":38.9637,"longitude":35.2433,"confirmed":1,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.831Z"},{"_id":"5e6b5af9eba907be34c02be6","name":"US","latitude":40,"longitude":-100,"confirmed":1663,"recovered":40,"deaths":12,"updatedAt":"2020-03-13T10:05:45.691Z"},{"_id":"5e6b5af9eba9072638c02bfb","name":"Ukraine","latitude":48.3794,"longitude":31.1656,"confirmed":1,"recovered":0,"deaths":0,"updatedAt":"2020-03-13T10:05:45.757Z"},{"_id":"5e6b5af9eba907526fc02c01","name":"United Arab Emirates","latitude":23.4241,"longitude":53.8478,"confirmed":85,"recovered":0,"deaths":17,"updatedAt":"2020-03-13T10:05:45.768Z"},{"_id":"5e6b5af9eba9072ab0c02be9","name":"United Kingdom","latitude":55,"longitude":-3,"confirmed":459,"recovered":8,"deaths":19,"updatedAt":"2020-03-13T10:05:45.735Z"},{"_id":"5e6b7e21eba907f687c02c57","name":"United Kingdom","latitude":55,"longitude":-3,"confirmed":593,"recovered":8,"deaths":19,"updatedAt":"2020-03-13T12:35:45.742Z"},{"_id":"5e6b5af9eba9077363c02c44","name":"Vietnam","latitude":16,"longitude":108,"confirmed":39,"recovered":0,"deaths":16,"updatedAt":"2020-03-13T10:05:45.907Z"}],"paginator":{"page":0,"per_page":200,"total_elements":140}}';

//fetchCoronaData_old() async {
////    final response = await http.get('http://34.247.255.80/api/v1/country');
////
////    if (response.statusCode == 200) {
////      // If the server did return a 200 OK response,
////      // then parse the JSON.
////      var body = json.decode(response.body);
////      var countries = body['countries'];
////} else {
////throw Exception('Failed to load album');
////}
//  var countries = json.decode(mock_data)['countries'];
//
//  List<CoronaData> corona_data_list = [];
////    if (countries == null ) {
//////      return corona_data_list;
////        body = json.decode(mock_data);
////        countries = body['features'];
////    }
//
//  for (var i = 0; i < countries.length; i++) {
//    corona_data_list.add(CoronaData.fromJson(countries[i]));
//  }
//
//  return corona_data_list;
//}

class CoronaData {
  final String name;
  final int last_update;
//  final Double lat;
//  final Double lng;
  final int confirmed;
  final int deaths;
  final int recovered;

  CoronaData(
      {this.name,
      this.last_update,
//    this.lat, this.lng,
      this.confirmed,
      this.deaths,
      this.recovered});

  factory CoronaData.fromJson(Map<String, dynamic> json) {
    return CoronaData(
        name: json['name'],
        last_update: json['updatedAt'],
//      lat: json['features'][0]['attributes']['Lat'],
//      lng: json['features'][0]['attributes']['Long_'],
        confirmed: json['confirmed'],
        deaths: json['deaths'],
        recovered: json['recovered']);
  }
}

var DEATHS_COLOR = Color(0xfff40f4c);
var RECOVERED_COLOR = Color(0xff55aa50);
var CASES_COLOR = Color(0xffefae1d);
const int _purplePrimaryValue = 0xff2a1c66;
const BACKGROUND_COLOR = Color(_purplePrimaryValue);

const MaterialColor primaryPurple = MaterialColor(
  _purplePrimaryValue,
  <int, Color>{
    50: BACKGROUND_COLOR,
    100: BACKGROUND_COLOR,
    200: BACKGROUND_COLOR,
    300: BACKGROUND_COLOR,
    400: BACKGROUND_COLOR,
    500: BACKGROUND_COLOR,
    600: BACKGROUND_COLOR,
    700: BACKGROUND_COLOR,
    800: BACKGROUND_COLOR,
    900: BACKGROUND_COLOR,
  },
);

enum FILTERS {
  CASES,
  RECOVERED,
  DEATHS,
}

Map<FILTERS, String> filter2name = {
  FILTERS.CASES: 'CASES',
  FILTERS.DEATHS: 'DEATHS',
  FILTERS.RECOVERED: 'RECOVERED',
};

Map<FILTERS, Color> filter2color = {
  FILTERS.CASES: CASES_COLOR,
  FILTERS.DEATHS: DEATHS_COLOR,
  FILTERS.RECOVERED: RECOVERED_COLOR,
};

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: primaryPurple,
        backgroundColor: primaryPurple,
        primaryColor: primaryPurple,
        accentColor: Colors.grey,
        fontFamily: "Century Gothic",
        iconTheme: IconThemeData(
          color: Colors.grey,
          size: 28.0,
        ),
        textTheme: TextTheme(
          headline5: TextStyle(
              fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white),
          headline6: TextStyle(fontSize: 13.0, color: Colors.grey),
          headline4: TextStyle(fontSize: 17.0, color: Colors.grey),
          bodyText2: TextStyle(fontSize: 36.0, color: Colors.grey),
        ),
      ),
      home: MyHomePage(title: 'Corona Virus Numbers'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<CoronaData>> futureCoronaData;
  Position _currentPosition;
  List<CoronaData> _filtered_corona_data;
  bool is_fetching;
  FILTERS _filter = FILTERS.CASES;
  String _selected_country = null;
  Set<String> _favorite_countries = {};
//  SharedPreferences _shared_preferences;

  fetchCoronaData() async {
    setState(() {
      is_fetching = true;
    });
    final response = await http.get('http://34.247.255.80/api/v1/country');
    var countries;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var body = json.decode(response.body);
      countries = body['countries'];
    } else {
      throw Exception('Failed to load album');
    }

//    var countries = json.decode(mock_data)['countries'];

    List<CoronaData> corona_data_list = [];
//    if (countries == null ) {
////      return corona_data_list;
//        body = json.decode(mock_data);
//        countries = body['features'];
//    }

    for (var i = 0; i < countries.length; i++) {
      corona_data_list.add(CoronaData.fromJson(countries[i]));
    }

    setState(() {
      is_fetching = false;
      _filtered_corona_data = corona_data_list;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCoronaData();
    get_favorite_countries_from_shared_preferences();
//    get_shared_preferences();
//    print(_shared_preferences.getKeys());
  }

  Widget _corona_body() {
    if (is_fetching) {
      return Center(child: CircularProgressIndicator());
    }
    print(_filtered_corona_data);
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        children: <Widget>[
          _build_top_icons_row(context),
          _build_top_name_row(context),
          _build_top_numbers_row(_filtered_corona_data),
          _build_filter_icons_row(context),
          _build_bottom_list(context, _filtered_corona_data),
          _build_last_update_row(_filtered_corona_data),
        ],
      ),
    );
  }

  Padding _build_last_update_row(List<CoronaData> data) {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0, 10.0, 0, 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Text(
              "Last update: 10 March 2020 12:23PM",
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.grey,
              ),
            ),
          ],
        ));
  }

  _get_visible_number(CoronaData data) {
    if (_filter == FILTERS.RECOVERED) {
      return data.recovered.toString();
    } else if (_filter == FILTERS.DEATHS) {
      return data.deaths.toString();
    }
    return data.confirmed.toString();
  }

  Expanded _build_bottom_list(
      BuildContext context, List<CoronaData> corona_data) {
    return new Expanded(
        child: new ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(16.0),
      itemCount: corona_data.length,
      itemBuilder: (context, i) {
        return ListTile(
          onTap: () => setState(() {
            _selected_country = corona_data[i].name;
          }),
          leading: IconButton(
            icon: Icon(
              _favorite_countries.contains(corona_data[i].name)
                  ? Icons.star
                  : Icons.star_border,
              color: Theme.of(context).iconTheme.color,
              size: Theme.of(context).iconTheme.size,
            ),
            tooltip: 'Add to favorite',
            onPressed: () {
              if (_favorite_countries.contains(corona_data[i].name)) {
                _favorite_countries.remove(corona_data[i].name);
              } else {
                _favorite_countries.add(corona_data[i].name);
              }
              save_favorite_countries(_favorite_countries);
              setState(() {});
            },
          ),
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  corona_data[i].name.toUpperCase().substring(
                      0,
                      corona_data[i].name.length > 18
                          ? 18
                          : corona_data[i].name.length),
                  style: Theme.of(context).textTheme.headline4,
                ),
                new Text(
                  _get_visible_number(corona_data[i]),
                  style: Theme.of(context).textTheme.headline4,
                )
              ]),
          trailing: _build_themed_icon(Icons.notifications),
        );
      },
    ));
  }

  Row _build_filter_icons_row(BuildContext context) {
    Column _build_filter_icon(
        BuildContext context, IconData icon, FILTERS filter_type) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(
              icon,
              color: (_filter == filter_type)
                  ? filter2color[filter_type]
                  : Theme.of(context).iconTheme.color,
              size: Theme.of(context).iconTheme.size,
            ),
            tooltip: 'Filter by ',
            onPressed: () {
              setState(() {
                _filter = filter_type;
              });
            },
          ),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                filter2name[filter_type],
                style: Theme.of(context).textTheme.headline6,
              )),
        ],
      );
    }

    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _build_filter_icon(context, MyCustomIcons.cases, FILTERS.CASES),
        _build_filter_icon(context, MyCustomIcons.deaths, FILTERS.DEATHS),
        _build_filter_icon(context, MyCustomIcons.recovered, FILTERS.RECOVERED),
      ],
    );
  }

  Icon _build_themed_icon(IconData icon) {
    return Icon(
      icon,
      color: Theme.of(context).iconTheme.color,
      size: Theme.of(context).iconTheme.size,
    );
  }

  Row _build_top_icons_row(BuildContext context) {
    Expanded _build_top_icons(BuildContext context) {
      return new Expanded(
          child: new ListTile(
        leading: _build_themed_icon(Icons.menu),
        trailing: _build_themed_icon(Icons.share),
      ));
    }

    return new Row(
      children: <Widget>[
        _build_top_icons(context),
      ],
    );
  }

  Row _build_top_name_row(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
            child: new Container(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: new Text(
                  _selected_country == null
                      ? "WORLDWIDE"
                      : _selected_country.toUpperCase(),
                  style: Theme.of(context).textTheme.headline5,
                )))
      ],
    );
  }

  Row _build_top_numbers_row(List<CoronaData> snapshot) {
    Column _build_top_number(Color text_color, int number) {
      return new Column(
        children: <Widget>[
          new Text(
            number.toString(),
            style: TextStyle(
                fontSize: 36.0, fontWeight: FontWeight.bold, color: text_color),
          )
        ],
      );
    }

    var totalConfirmed = snapshot
        .where((element) =>
            _selected_country == null || element.name == _selected_country)
        .map((e) => e.confirmed)
        .reduce((value, element) => value + element);

    var totalDeaths = snapshot
        .where((element) =>
            _selected_country == null || element.name == _selected_country)
        .map((e) => e.deaths)
        .reduce((value, element) => value + element);

    var totalRecovered = snapshot
        .where((element) =>
            _selected_country == null || element.name == _selected_country)
        .map((e) => e.recovered)
        .reduce((value, element) => value + element);

    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _build_top_number(CASES_COLOR, totalConfirmed),
        _build_top_number(DEATHS_COLOR, totalDeaths),
        _build_top_number(RECOVERED_COLOR, totalRecovered),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    apply_filter();

    return Scaffold(
      body: _corona_body(),
    );
  }

  get_favorite_countries_from_shared_preferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _favorite_countries = prefs.getStringList('favorite_countries').toSet();
  }

  save_favorite_countries(Set<String> favorite_countries) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'favorite_countries', favorite_countries.toList());
  }

  void apply_filter() {
    if (_filter != null && _filtered_corona_data != null) {
      if (_filter == FILTERS.CASES) {
        _filtered_corona_data.sort((a, b) => compare(a, b, (e)=>e.confirmed));
      } else if (_filter == FILTERS.DEATHS) {
        _filtered_corona_data.sort((a, b) => compare(a, b, (e)=>e.deaths));
      } else {
        _filtered_corona_data.sort((a, b) => compare(a, b, (e)=>e.recovered));
      }
    }
  }

  int compare(CoronaData a, CoronaData b, Function accessor) {
    if (is_country_pair_comparable(a, b)) {
      return accessor(a) >accessor(b) ? -1 : 1;
    }
    if (_favorite_countries.contains(a.name)) {
      return -1;
    }
    return 1;
  }

  bool is_country_pair_comparable(CoronaData a, CoronaData b) {
    return _favorite_countries.contains(a.name) &&
                _favorite_countries.contains(b.name) ||
            !_favorite_countries.contains(a.name) &&
                !_favorite_countries.contains(b.name);
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        print(_currentPosition);
      });
    }).catchError((e) {
      print(e);
    });
  }
}
