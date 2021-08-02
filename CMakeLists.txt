cmake_minimum_required(VERSION 3.15)
project(PDNet2_0)

set(CMAKE_CXX_STANDARD 14)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread -O0")

add_executable(PDNet2_0 main.cpp   v_table.cpp v_table.h y.tab.cpp y.tab.h lex.y.cpp
         expression_tree.cpp expression_tree.h AST.cpp AST.h pre_process.cpp cpn.h cpn.cpp base.cpp base.h MultiSet.h MultiSet.cpp Sort.h cpn_rg.h cpn_rg.cpp slice.cpp
        criteria.cpp
        product.cpp
        product.h
        BA/buchi.cpp
        BA/buchi.h
        BA/set.h
        BA/Syntax_Tree.cpp
        BA/Syntax_Tree.h
        BA/tinystr.cpp
        BA/tinystr.h
        BA/tinyxml.cpp
        BA/tinyxml.h
        BA/tinyxmlerror.cpp
        BA/tinyxmlparser.cpp
        BA/VWAA.cpp
        BA/VWAA.h
        unfold.cpp unfold.h)

target_link_libraries(PDNet2_0 tcmalloc)