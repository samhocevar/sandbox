
#include "log.h"
#include "assert.h"
#include "array.h"
#include "unit.h"

namespace lol
{

LOLUNIT_FIXTURE(ArrayTest)
{
    LOLUNIT_TEST(ArrayPush)
    {
        Array<int> a;
        a.Push(0);
        a.Push(1);
        a.Push(2);
        a.Push(3);

        LOLUNIT_ASSERT_EQUAL(a[0], 0);
        LOLUNIT_ASSERT_EQUAL(a[1], 1);
        LOLUNIT_ASSERT_EQUAL(a[2], 2);
        LOLUNIT_ASSERT_EQUAL(a[3], 3);
    }
};

} /* namespace lol */

