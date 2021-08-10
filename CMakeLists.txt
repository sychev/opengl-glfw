cmake_minimum_required(VERSION 2.8.12)
set (CMAKE_CXX_STANDARD 11)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/steamworkssdk/cmake")

project(main)

# GLFW
set(GLFW_BUILD_DOCS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
add_subdirectory(glfw)
include_directories(glfw/include)
include_directories(glfw/deps)
include_directories(glad/include)

# add_subdirectory(imgui)
include_directories(imgui)
include_directories(imgui/backends)

# Physics libr
add_subdirectory(reactphysics3d)
include_directories(reactphysics3d/include)

set(IMGUISOURCES
    imgui/imstb_truetype.h
    imgui/imstb_textedit.h
    imgui/imstb_rectpack.h
    imgui/imgui_widgets.cpp
    imgui/imgui_tables.cpp
    imgui/imgui_internal.h
    imgui/imgui_draw.cpp
    imgui/imgui_demo.cpp
    imgui/imgui.cpp
    imgui/imgui.h
    imgui/imconfig.h
    imgui/backends/imgui_impl_glfw.h
    imgui/backends/imgui_impl_glfw.cpp
    imgui/backends/imgui_impl_opengl3.h
    imgui/backends/imgui_impl_opengl3.cpp
)

set(SOURCES
    glad/src/glad.c
    src/main.cpp
)

# Steamworks SDK
add_subdirectory(steamworkssdk/cmake)
include_directories(steamworkssdk/steamworks_sdk/public/steam)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/steamworkssdk/steamworks_sdk/redistributable_bin/win64)
link_directories(${CMAKE_CURRENT_SOURCE_DIR}/steamworkssdk/steamworks_sdk/redistributable_bin/win64)
find_package(STEAMWORKSSDK REQUIRED)

add_executable(main ${SOURCES} ${IMGUISOURCES})

target_link_libraries(main glfw ${GLFW_LIBRARIES})
target_link_libraries(main reactphysics3d)
target_link_libraries(main STEAMWORKSSDK::STEAMWORKSSDK)
