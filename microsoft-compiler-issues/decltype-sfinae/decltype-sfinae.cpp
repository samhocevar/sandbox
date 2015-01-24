#include <cstdio>
#include <typeinfo>

template<typename...T> struct dummy {};

struct my_struct_1
{
    template<typename I, typename...S>
    static bool foo(I&, S&&...)
    {
        printf("my_struct_1::foo(I,S...)\n");
        return true;
    }

    static bool foo(char&)
    {
        printf("my_struct_1::foo(char)\n");
        return true;
    }
};

struct my_struct_2
{
    template<typename T = int>
    static bool foo(T&)
    {
        printf("my_struct_2::foo(%s)\n", typeid(T).name());
        return true;
    }
};

template<typename R, template<typename...> class A,
                     template<typename...> class C>
struct foo_caller
{
    template<typename I, typename...S>
    static auto foo(I& i, S &&...s)
        -> decltype(R::template foo<A, C>(i, s...), bool())
    {
        return R::template foo<A, C>(i, s...);
    }

    template<typename I, typename...S>
    static auto foo(I& i, S &&...)
        -> decltype(R::template foo(i), bool())
    {
        return R::foo(i);
    }
};

int main()
{
    int x32;
    char x8;

    foo_caller<my_struct_1, dummy, dummy>::foo(x32);
    foo_caller<my_struct_1, dummy, dummy>::foo(x32, x32);
    foo_caller<my_struct_1, dummy, dummy>::foo(x8);
    foo_caller<my_struct_1, dummy, dummy>::foo(x8, x32);

    foo_caller<my_struct_2, dummy, dummy>::foo(x32);
    foo_caller<my_struct_2, dummy, dummy>::foo(x8);
}
