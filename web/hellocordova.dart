import 'package:rikulo_gap/device.dart';
import 'package:rikulo_gap/accelerometer.dart';
import 'dart:html'; // as js;
import 'dart:js'; // as js;

//At a regular interval, get the acceleration along the x, y, and z axis.
void accessAccelerometer() {
	accelerometer.watchAcceleration(
			(Acceleration acc) {
				context['document'].write("t:${acc.timestamp}, x:${acc.x}, y:${acc.y}, z:${acc.z}");
			},
			() => context['document'].write("Fail to get acceleration."),
			new AccelerometerOptions(frequency: 1000)
	                                );
}

void onDeviceReady(device) {
	accessAccelerometer();

	var persistent = context['PERSISTENT'];
	context['document'].write( "Should be Constant PERSISTENT of LFS: " + persistent.toString() );
	context.callMethod( 'requestFileSystem', [persistent, 0, onInitFs, initFsErrorHandler] );
}

void onInitFs(JsObject fs) {
	context['document'].write( "Success" );
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

	context['document'].write('Error: ' + msg);
}

void createFile(JsObject fsroot) {
	var cNe = new JsObject.jsify( {'create': true, 'exclusive': false} );
	fsroot.callMethod( 'getFile', ["DartCreatedFile.txt", cNe, gotFileEntry, initFsErrorHandler] );
}

void gotFileEntry(JsObject fileEntry) {
	context['document'].write( fileEntry['fullPath'] );
}


void main() {
	Device.init()
		.then((Device device) => onDeviceReady(device))
		.catchError((ex, st) => context['document'].write( "Failed: $ex, $st") );
}
