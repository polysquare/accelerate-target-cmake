# /test/UseFilesInBuildDirectoryInPCHFile.cmake
#
# Places some headers in the source / build directories.
#
# See LICENCE.md for Copyright information.

include (AccelerateTarget)
include (CMakeUnit)
include (ExportCfgIntDirHelper)

set (COTIRE_MINIMUM_NUMBER_OF_TARGET_SOURCES 1 CACHE BOOL "" FORCE)

set (SOURCE_FILE ${CMAKE_CURRENT_SOURCE_DIR}/Source.cpp)
set (SOURCE_FILE_CONTENTS
     "#include \"Header.h\"\n"
     "int main ()\n"
     "{\n"
     "    return 0\;\n"
     "}\n")
file (WRITE ${SOURCE_FILE} ${SOURCE_FILE_CONTENTS})

set (HEADER_FILE ${CMAKE_CURRENT_BINARY_DIR}/Header.h)
set (HEADER_FILE_CONTENTS
    "#ifndef _HEADER_H\n"
    "#define _HEADER_H\n"
    "#endif\n")
file (WRITE ${HEADER_FILE} ${HEADER_FILE_CONTENTS})

set (EXECUTABLE executable)

include_directories (${CMAKE_CURRENT_BINARY_DIR})
add_executable (${EXECUTABLE} ${SOURCE_FILE} ${HEADER_FILE})
psq_accelerate_target (${EXECUTABLE})
