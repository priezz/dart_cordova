import 'package:rikulo_gap/device.dart';
import 'package:rikulo_gap/accelerometer.dart';
import 'dart:html'; // as js;
import 'dart:js'; // as js;

//At a regular interval, get the acceleration along the x, y, and z axis.
void accessAccelerometer() {
	accelerometer.watchAcceleration(
			(Acceleration acc) {
				writeToBody("t:${acc.timestamp}, x:${acc.x}, y:${acc.y}, z:${acc.z}");
			},
			() => writeToBody("Fail to get acceleration."),
			new AccelerometerOptions(frequency: 1000)
	                                );
}

void onDeviceReady(device) {
	accessAccelerometer();

	var persistent = context['PERSISTENT'];
	writeToBody( "Should be Constant PERSISTENT of LFS: " + persistent.toString() );
	context.callMethod( 'requestFileSystem', [persistent, 0, onInitFs, initFsErrorHandler] );
}

void onInitFs(JsObject fs) {
	writeToBody( "Success" );
	var fsroot = fs['root'];
	createFile(fsroot);
}

void initFsErrorHandler(e) {
	String msg;
	switch (e.code) {
		case FileError.QUOTA_EXCEEDED_ERR:
			msg = 'QUOTA_EXCEEDED_ERR'; break;
		case FileError.NOT_FOUND_ERR:
			msg = 'NOT_FOUND_ERR'; break;
		case FileError.SECURITY_ERR:
			msg = 'SECURITY_ERR'; break;
		case FileError.INVALID_MODIFICATION_ERR:
			msg = 'INVALID_MODIFICATION_ERR'; break;
		case FileError.INVALID_STATE_ERR:
			msg = 'INVALID_STATE_ERR'; break;
		default:
			msg = 'Unknown Error';
	};

	writeToBody('Error: ' + msg);
}

void createFile(JsObject fsroot) {
	var cNe = new JsObject.jsify( {'create': true, 'exclusive': false} );
	fsroot.callMethod( 'getFile', ["DartCreatedFile.txt", cNe, gotFileEntry, initFsErrorHandler] );
}

void gotFileEntry(JsObject fileEntry) {
	writeToBody( fileEntry['fullPath'] );
}

void writeToBody( String s ) {
	document.body.text += s;
}


void main() {
	writeToBody( "App launched" );
	Device.init()
		.then((Device device) => onDeviceReady(device))
		.catchError((ex, st) => writeToBody( "Failed: $ex, $st") );
}
