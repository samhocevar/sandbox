//
//

#include <stdint.h>

struct int128_t
{
    uint64_t low;
    uint64_t high;

    int128_t() { }
    int128_t(uint64_t low, uint64_t high): low(low), high(high) { }
    int128_t(uint64_t low): low(low), high(0) { }
    int128_t(int64_t value): low(value), high((value >= 0) ? 0 : (uint64_t) -1LL) { }

    static int128_t mul(int64_t a, int64_t b);

    static int128_t mul(uint64_t a, uint64_t b);

    int128_t operator-() const
    {
        return int128_t((uint64_t) -(int64_t)low, ~high + (low == 0));
    }

    int128_t operator+(const int128_t& b) const
    {
        uint64_t lo = low + b.low;
        return int128_t(lo, high + b.high + (lo < low));
    }

    int128_t operator-(const int128_t& b) const
    {
        return *this + -b;
    }

    int128_t& operator+=(const int128_t& b)
    {
        uint64_t lo = low + b.low;
        if (lo < low)
        {
            ++high;
        }
        low = lo;
        high += b.high;
        return *this;
    }

    int128_t& operator++()
    {
        if (++low == 0)
        {
            ++high;
        }
        return *this;
    }

    int128_t operator*(int64_t b) const;

    int getSign() const
    {
        return ((int64_t) high < 0) ? -1 : (high || low) ? 1 : 0;
    }

    bool operator<(const int128_t& b) const
    {
        return (high < b.high) || ((high == b.high) && (low < b.low));
    }

    int ucmp(const int128_t&b) const
    {
        if (high < b.high)
        {
            return -1;
        }
        if (high > b.high)
        {
            return 1;
        }
        if (low < b.low)
        {
            return -1;
        }
        if (low > b.low)
        {
            return 1;
        }
        return 0;
    }
};

template<typename UWord, typename UHWord> class DMul
{
private:
    static uint32_t high(uint64_t value)
    {
        return (uint32_t) (value >> 32);
    }

    static uint32_t low(uint64_t value)
    {
        return (uint32_t) value;
    }

    static uint64_t mul(uint32_t a, uint32_t b)
    {
        return (uint64_t) a * (uint64_t) b;
    }

    static void shlHalf(uint64_t& value)
    {
        value <<= 32;
    }

    static uint64_t high(int128_t value)
    {
        return value.high;
    }

    static uint64_t low(int128_t value)
    {
        return value.low;
    }

    static int128_t mul(uint64_t a, uint64_t b)
    {
        return int128_t::mul(a, b);
    }

    static void shlHalf(int128_t& value)
    {
        value.high = value.low;
        value.low = 0;
    }

public:
    static void mul(UWord a, UWord b, UWord& resLow, UWord& resHigh)
    {
        UWord p00 = mul(low(a), low(b));
        UWord p01 = mul(low(a), high(b));
        UWord p10 = mul(high(a), low(b));
        UWord p11 = mul(high(a), high(b));
        UWord p0110 = UWord(low(p01)) + UWord(low(p10));
        p11 += high(p01);
        p11 += high(p10);
        p11 += high(p0110);
        shlHalf(p0110);
        p00 += p0110;
        if (p00 < p0110)
        {
            ++p11;
        }
        resLow = p00;
        resHigh = p11;
    }
};

int128_t int128_t::operator*(int64_t b) const
{
    bool negative = (int64_t) high < 0;
    int128_t a = negative ? -*this : *this;
    if (b < 0)
    {
        negative = !negative;
        b = -b;
    }
    int128_t result = mul(a.low, (uint64_t) b);
    result.high += a.high * (uint64_t) b;
    return negative ? -result : result;
}

int128_t int128_t::mul(int64_t a, int64_t b)
{
    int128_t result;

    bool negative = a < 0;
    if (negative)
    {
        a = -a;
    }
    if (b < 0)
    {
        negative = !negative;
        b = -b;
    }
    DMul<uint64_t, uint32_t>::mul((uint64_t) a, (uint64_t) b, result.low, result.high);
    return negative ? -result : result;
}

int128_t int128_t::mul(uint64_t a, uint64_t b)
{
    int128_t result;

    DMul<uint64_t, uint32_t>::mul(a, b, result.low, result.high);

    return result;
}

