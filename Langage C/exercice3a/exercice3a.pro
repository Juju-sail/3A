TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

LIBS +=  -L$$PWD -lsudoku

SOURCES += \
        main.c \
        sudoku_functions.c

HEADERS += \
        sudoku_functions.h \
        sudoku_functions_correct.h
