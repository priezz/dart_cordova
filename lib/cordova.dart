library cordova;

import 'dart:js' as js;

import 'package:logging/logging.dart';
import 'package:rikulo_gap/device.dart';
import 'package:rikulo_gap/accelerometer.dart';

Logger _log = new Logger('cordova');


// class DeviceInfo {
// 	bool available = false;
// 	String model = '';
// 	String platform = '';
// 	String uuid = '';
// 	String version = '';
// }


void notification( String message, var callback, String title, String buttonName ) {

	js.context['navigator']['notification'].callMethod( 'alert', [ message, callback, title, buttonName ]);
}

void errorHandler(e) {
	String msg = e is String ? e : 'Unknown Error';
	_log.warning('Error: ' + msg);
}

void getAvailableNetworks(handler) {
	js.context['navigator']['wifi'].callMethod( 'getAccessPoints', [ handler, errorHandler ]);
}

void getConfiguredNetworks(handler) {
	js.context['WifiWizard'].callMethod( 'listNetworks', [ handler, errorHandler ]);
}

// void initDevice(handler) {
// 	Device.init()
// 		.then((device) => handler(device))
// 		.catchError((ex) {});
// }

// DeviceInfo getDeviceInfo() {
// 	DeviceInfo info = new DeviceInfo();
// 	info.available = js.context['device']['available'];
// 	info.model = js.context['device']['model'];
// 	info.uuid = js.context['device']['uuid'];
// 	info.platform = js.context['device']['platform'];
// 	info.version = js.context['device']['version'];
// 	return info;
// }
