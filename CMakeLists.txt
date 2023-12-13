# CMakeLists.txt

# Always set the cmake min version.
cmake_minimum_required(VERSION 3.23)

set (PROJECT_VERSION "1.0")

## 默认为Release
set(CMAKE_BUILD_TYPE "Release")

# Set the variable PROJ_NAME to whatever your library's name is, PROJECT_VERSION should be a version string like "0.1"
project(mylib VERSION ${PROJECT_VERSION})

message(STATUS "project_version = ${PROJECT_VERSION}")

## 设置visual studio 默认的启动项目为当前工程
set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${PROJECT_NAME})

# To build shared libraries in Windows, we set CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS to TRUE.
# See https://cmake.org/cmake/help/v3.4/variable/CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS.html
# See https://blog.kitware.com/create-dlls-on-windows-without-declspec-using-new-cmake-export-all-feature/
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

# ########-----------------------ADD Platform Define ---------------------#######
if (WIN32)
    message(STATUS "Compile ${PROJECT_NAME} on system: Windows")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D__WIN32__")
elseif (APPLE)
    message(STATUS "Compile ${PROJECT_NAME} on system: Apple")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D__APPLE__")
elseif (ANDROID)
    message(STATUS "Compile ${PROJECT_NAME} on system: Android")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D__ANDROID__")
elseif (UNIX)
    message(STATUS "Compile ${PROJECT_NAME} on system: Linux")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D__LINUX__")
endif ()

message(STATUS "CMAKE_ANDROID_ARCH_ABI ${CMAKE_ANDROID_ARCH_ABI}")

# Remove 'lib' prefix for shared libraries on Windows
if (WIN32)
  set(CMAKE_SHARED_LIBRARY_PREFIX "")
endif ()


include_directories(${CMAKE_CURRENT_SOURCE_DIR})

# We can now add their CMakeList as a child to ours.
add_subdirectory(./lib/libdependency/)


# Create our library target
add_library(mylib SHARED
 ${CMAKE_CURRENT_SOURCE_DIR}/interface.cpp)

 # And now, we tell CMake that libdependency should be linked to our library
target_link_libraries(mylib PRIVATE libdependency)
# You may want to add their include directories since your code might use their header files. If libdependency is exporting its symbols properly you shouldn't have to do this though.
target_include_directories(mylib PRIVATE ./lib/libdependency/include)

# This will name your output .so files "libsomething.1.0" which is pretty useful
set_target_properties(mylib
PROPERTIES
    VERSION ${PROJECT_VERSION}
    SOVERSION ${PROJECT_VERSION}
)


if(WIN32)
message(STATUS "target_compile_definitions on MSVC")
target_compile_options(mylib PRIVATE /EHsc /MTd /W2 /c)
# Set the DLLEXPORT variable to export symbols
target_compile_definitions(mylib PRIVATE WIN_EXPORT)
else()
 # G++
 target_compile_options(mylib PRIVATE -Wall -Wextra)
endif()
message(STATUS "CMAKE_CXX_COMPILER_ID: ${CMAKE_CXX_COMPILER_ID}")

 
# endif()