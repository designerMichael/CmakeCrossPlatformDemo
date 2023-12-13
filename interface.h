
#include "libs_export.h"
#include "apiClass.hh"
extern "C"
{
    EXPORTED void initLib();

    EXPORTED void closeLib();
    
    EXPORTED int add(int a, int b);
}