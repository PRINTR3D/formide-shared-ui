
add_library(Qt5::OpenMAXILPlayerServicePlugin MODULE IMPORTED)

_populate_Multimedia_plugin_properties(OpenMAXILPlayerServicePlugin RELEASE "mediaservice/libopenmaxilmediaplayer.so")

list(APPEND Qt5Multimedia_PLUGINS Qt5::OpenMAXILPlayerServicePlugin)
