
#include "interface.h"

apiClass *ptr = nullptr;

extern "C"
{
  EXPORTED void initLib()
  {
    ptr = new apiClass();
  }

  EXPORTED void closeLib()
  {
    delete ptr;
  }

  EXPORTED int add(int a, int b)
  {
    return ptr->add(a, b);
  }
}