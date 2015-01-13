library log;

import 'package:logging/logging.dart';

Logger logger = new Logger('app');

void logInit() {
	Logger.root
		..level = Level.FINEST
		..onRecord.listen((LogRecord r) { print(r.message); });
}
