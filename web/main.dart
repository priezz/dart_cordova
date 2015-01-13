library app;

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';

import 'package:cordova_app/components/application.dart';
import 'package:cordova_app/log.dart';
// import 'package:cordova_app/router.dart';


class MyAppModule extends Module {
	MyAppModule() {
		bind(ApplicationComponent);
		// bind(RouteInitializerFn, toValue: routeInitializer);
		// bind(NgRoutingUsePushState, toValue: new NgRoutingUsePushState.value(false));
	}
}

void main() {
	logInit();

	applicationFactory()
		.addModule(new MyAppModule())
		.run();
}
