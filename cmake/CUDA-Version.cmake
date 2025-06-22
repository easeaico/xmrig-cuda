set(DEVICE_COMPILER "nvcc")
set(CUDA_COMPILER "${DEVICE_COMPILER}" CACHE STRING "Select the device compiler")

if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    list(APPEND DEVICE_COMPILER "clang")
endif()

set_property(CACHE CUDA_COMPILER PROPERTY STRINGS "${DEVICE_COMPILER}")

list(APPEND CMAKE_PREFIX_PATH "$ENV{CUDA_ROOT}")
list(APPEND CMAKE_PREFIX_PATH "$ENV{CMAKE_PREFIX_PATH}")

# Enable CUDA language support
enable_language(CUDA)

# Get CUDA version from CMake's built-in CUDA support
if(CMAKE_CUDA_COMPILER_VERSION)
    set(CUDA_VERSION ${CMAKE_CUDA_COMPILER_VERSION})
    message(STATUS "CUDA ${CUDA_VERSION} detected")
    
    # Check for CUDA 12 compatibility
    if (CUDA_VERSION VERSION_GREATER_EQUAL 12.0)
        message(STATUS "CUDA ${CUDA_VERSION} detected - Full support enabled")
        add_definitions(-DCUDA_12_SUPPORT)
    endif()
else()
    message(FATAL_ERROR "CUDA compiler not found. Please install CUDA Toolkit.")
endif()

# Set CUDA toolkit root directory
if(CMAKE_CUDA_COMPILER)
    get_filename_component(CUDA_TOOLKIT_ROOT_DIR ${CMAKE_CUDA_COMPILER} DIRECTORY)
    get_filename_component(CUDA_TOOLKIT_ROOT_DIR ${CUDA_TOOLKIT_ROOT_DIR} DIRECTORY)
endif()
