cmake_minimum_required(VERSION 3.5)

project(foo LANGUAGES CXX)

find_package(Qt5 COMPONENTS Core Quick REQUIRED)

set(CMAKE_AUTORCC ON)

add_executable(foo main.cpp qml.qrc)


target_compile_definitions(foo
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)

# conflict with AddQtIosApp.cmake
target_link_libraries(foo PRIVATE Qt5::Core Qt5::Quick)

IF(${CMAKE_SYSTEM_NAME} STREQUAL "iOS")
#  set(QT_LIBRARIES Qt5::Core Qt5::Quick)  
  include(QtIosCMake/AddQtIosApp.cmake)
  
  add_qt_ios_app(foo)
ENDIF()
