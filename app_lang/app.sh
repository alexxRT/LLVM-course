set -x

bison -d app.y || exit 1
lex app.lex || exit 1

clang++ -std=c++20 lex.yy.c app.tab.c  $(llvm-config --cflags --ldflags --libs) ./app/sim.cpp $($SDL --cflags --libs) || exit 1
rm app.tab.c app.tab.h lex.yy.c
cat app.txt
cat app.txt | ./a.out
