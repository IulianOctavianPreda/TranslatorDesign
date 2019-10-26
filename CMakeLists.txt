set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wno-deprecated-register")

project(C--)

cmake_minimum_required(VERSION 3.1)

find_package(BISON REQUIRED)
find_package(FLEX REQUIRED)

BISON_TARGET(${CMAKE_CURRENT_BINARY_DIR}/src/parser/cmm_parser
             ${CMAKE_CURRENT_BINARY_DIR}/src/parser/cmm_parser.yy
             ${CMAKE_CURRENT_BINARY_DIR}/src/parser/cmm_parser.tab.cc)

FLEX_TARGET(${CMAKE_CURRENT_BINARY_DIR}/src/scanner/cmm_lexer
            ${CMAKE_CURRENT_BINARY_DIR}/src/scanner/cmm_lexer.l
            ${CMAKE_CURRENT_BINARY_DIR}/src/scanner/cmm_lexer.yy.cc)

ADD_FLEX_BISON_DEPENDENCY(${CMAKE_CURRENT_BINARY_DIR}/src/scanner/cmm_lexer ${CMAKE_CURRENT_BINARY_DIR}/src/parser/cmm_parser)

add_executable(cmm WIN32
    ${CMAKE_CURRENT_SOURCE_DIR}/src/main.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/driver/cmm_driver.cpp

    ${FLEX_cmm_lexer_OUTPUTS}
    ${BISON_cmm_parser_OUTPUTS}
)
target_include_directories(cmm
    PRIVATE
        .
        ${CMAKE_CURRENT_BINARY_DIR})
set_property(TARGET cmm
             PROPERTY CXX_STANDARD 14)