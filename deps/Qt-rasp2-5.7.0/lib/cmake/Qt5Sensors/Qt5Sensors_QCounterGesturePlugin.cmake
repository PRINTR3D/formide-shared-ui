
add_library(Qt5::QCounterGesturePlugin MODULE IMPORTED)

_populate_Sensors_plugin_properties(QCounterGesturePlugin RELEASE "sensorgestures/libqtsensorgestures_counterplugin.so")

list(APPEND Qt5Sensors_PLUGINS Qt5::QCounterGesturePlugin)
