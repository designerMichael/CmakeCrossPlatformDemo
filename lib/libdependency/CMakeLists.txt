# Always set the cmake min version.
cmake_minimum_required(VERSION 3.23)


project(libdependency C CXX)


# file(GLOB CPP_FILES *.cpp)

 
# NOTE: Boost's includes are transitively added through B_INCLUDE_DIRS.
include_directories( 
                 ${CMAKE_CURRENT_SOURCE_DIR}/include )

add_library(${PROJECT_NAME} SHARED
apiClass.cpp
     )

 

# Expose C's definitions (in this case only the ones of XXX transitively)
# to other subprojects through cache variable.
# set(${PROJECT_NAME}_DEFINITIONS ${XXX_DEFINITIONS}
#     CACHE INTERNAL "${PROJECT_NAME}: Definitions" FORCE)

# Expose C's public includes (including the ones of C's dependencies transitively)
# to other subprojects through cache variable.
set(${PROJECT_NAME}_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/include
                                 
    CACHE INTERNAL "${PROJECT_NAME}: Include Directories" FORCE)


    
if(WIN32)
message(STATUS "target_compile_definitions on MSVC")
target_compile_options(${PROJECT_NAME} PRIVATE /EHsc /MTd /W2 /c)
# Set the DLLEXPORT variable to export symbols
target_compile_definitions(${PROJECT_NAME} PRIVATE WIN_EXPORT)
else()
 # G++
 target_compile_options(${PROJECT_NAME} PRIVATE -Wall -Wextra)
endif()
message(STATUS "CMAKE_CXX_COMPILER_ID: ${CMAKE_CXX_COMPILER_ID}")