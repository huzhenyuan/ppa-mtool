cmake_minimum_required (VERSION 2.8)
project (mtool)

install(DIRECTORY ${CMAKE_SOURCE_DIR}/bin/ DESTINATION DESTINATION bin/mtool)
install(DIRECTORY ${CMAKE_SOURCE_DIR}/lib/ DESTINATION DESTINATION lib/mtool)
