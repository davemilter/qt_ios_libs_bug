cmake_minimum_required(VERSION 3.5)

project(foo LANGUAGES CXX)

find_package(Qt5 COMPONENTS Core Quick REQUIRED)

set(CMAKE_AUTORCC ON)

set(addon_SRC)
IF(${CMAKE_SYSTEM_NAME} STREQUAL "iOS")
  set(addon_SRC
    ${CMAKE_CURRENT_BINARY_DIR}/foo_plugin_import.cpp
    ${CMAKE_CURRENT_BINARY_DIR}/foo_qml_plugin_import.cpp)
ENDIF()
add_executable(foo main.cpp ${addon_SRC} qml.qrc)


target_compile_definitions(foo
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)


IF(${CMAKE_SYSTEM_NAME} STREQUAL "iOS")
  set(QT_LIBRARIES Qt5::Core Qt5::Quick)  
  include(QtIosCMake/AddQtIosApp.cmake)
  include(QtStaticCMake/QtStaticCMake.cmake)
  add_qt_ios_app(foo)

    qt_generate_plugin_import(foo
    OUTPUT "foo_plugin_import.cpp"
    VERBOSE)
  
  qt_generate_qml_plugin_import(foo
    QML_SRC "main.qml"
    OUTPUT "foo_qml_plugin_import.cpp"
    VERBOSE)
ELSE()
  # conflict with AddQtIosApp.cmake
  target_link_libraries(foo PRIVATE Qt5::Core Qt5::Quick) 
ENDIF()
