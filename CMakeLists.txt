cmake_minimum_required(VERSION 3.5)

project(foo LANGUAGES CXX)

find_package(Qt5 COMPONENTS Core Quick REQUIRED)

set(CMAKE_AUTORCC ON)

add_executable(foo main.cpp qml.qrc)

target_compile_definitions(foo
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(foo PRIVATE Qt5::Core Qt5::Quick)

IF(${CMAKE_SYSTEM_NAME} STREQUAL "iOS")
  include(QtIosCMake/AddQtIosApp.cmake)
  include(QtStaticCMake/QtStaticCMake.cmake)

  qt_generate_plugin_import(foo VERBOSE)
  qt_generate_qml_plugin_import(foo
    QML_SRC ${CMAKE_CURRENT_SOURCE_DIR}
    EXTRA_PLUGIN
      QQuickLayoutsPlugin
    VERBOSE
    )

  if(TARGET Qt5::QmlWorkerScript)
    target_link_libraries(foo PRIVATE Qt5::QmlWorkerScript)
  endif()

  add_qt_ios_app(foo)
ENDIF()
