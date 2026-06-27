export 'quran_connection_unsupported.dart'
    if (dart.library.js_interop) 'quran_connection_web.dart'
    if (dart.library.ffi) 'quran_connection_native.dart';
