library application;

import 'dart:async';

import 'package:rikulo_gap/device.dart';
import 'package:rikulo_gap/accelerometer.dart';
import 'package:angular/angular.dart';

import 'package:cordova_app/log.dart';
import 'package:cordova_app/cordova.dart';


@Component(
		selector: 'application',
		templateUrl: 'application.html',
		useShadowDom: false )

class ApplicationComponent {

	bool deviceInitialized = false;

	Device _deviceInfo;
	Device get deviceInfo => _deviceInfo;

	Acceleration _accel;
	Acceleration get accel => _accel;

	void _onDeviceReady() {
		_deviceInfo = device;
		deviceInitialized = true;
		_watchAcceleration();
	}

	// At a regular interval, get the acceleration along the x, y, and z axis.
	void _watchAcceleration() {
		accelerometer.watchAcceleration(
				(Acceleration accel) => _accel = accel,
				// (Acceleration accel) => Timer.run(() => _accel = accel),
				() => logger.warning("Fail to get acceleration."),
				new AccelerometerOptions(frequency: 200)
		                                );
	}

	String getAccelCoord(String coord) {
		if (_accel == null) return "";
		if (coord == 'x') return _accel.x.toString();
		if (coord == 'y') return _accel.y.toString();
		if (coord == 'z') return _accel.z.toString();
	}

	String getStr(num v) => v.toString();

	void _update(Timer timer) {
		var tmp = _accel;
		// _accel = null;
		Timer.run(() => _accel = tmp);
	}

	ApplicationComponent() {
		// enable the device
		Device.init()
			.then((_) => _onDeviceReady())
			.catchError((ex) {});

		new Timer.periodic(new Duration(milliseconds: 100), _update);
		notification( 'App launched', () {}, '', 'Done' );
	}

}
