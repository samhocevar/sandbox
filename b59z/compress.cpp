

#include <vector>
#include <map>

#include <string>
#include <iostream>
#include <streambuf>
#include <cstdint>
#include <cmath>

// Number of tokens in our alphabet
#define TOKEN_COUNT 59
// Number of tokens that encode higher order bytes
#define HIGH_TOKENS 27
#define LOW_TOKENS (TOKEN_COUNT - HIGH_TOKENS)

//char const *chr = "\n 0123456789abcdefghijklmnopqrstuvwxyz!#%(){}[]<>+=/*:;.,~_";

struct data_stream : std::vector<uint8_t>
{
    inline int size() { return std::vector<uint8_t>::size(); }

    inline void push_back2(uint8_t a, uint8_t b)
    {
        push_back(a);
        push_back(b);
    }

    inline uint64_t get(int pos, int count) const
    {
        uint64_t z = 0;
        for (int i = 0; i < count; ++i)
            z |= (uint64_t)(*this)[pos + i] << (4 * i);
        return z;
    }
};

std::map<std::vector<uint8_t>, int> make_dict()
{
    std::map<std::vector<uint8_t>, int> ret;
    for (uint8_t c = 0; c < 16; ++c)
        ret[{ c }] = c;
    return ret;
}

int main()
{
    // Read stdin into a vector of nybbles
    data_stream data;
    for (uint8_t ch : std::vector<char>{ std::istreambuf_iterator<char>(std::cin),
                                         std::istreambuf_iterator<char>() } )
        data.push_back2(ch & 0xf, ch >> 4);

    printf("Read %d bytes (%d nybbles, %d bits)\n",
           data.size() / 2, data.size(), 4 * data.size());
    printf("Would be encoded as %d tokens in optimal case, %d with custom base59\n",
           (int)std::ceil(4 * data.size() / std::log2(TOKEN_COUNT)), (4 * data.size() * 8 + 46) / 47);

#if 0
    // Analyze subsequences
    for (int size = 2; size <= 8; size++)
    //for (int size = 16; size > 0; size--)
    {
        printf("Counting sequences of size %d\n", size);
        std::map<uint64_t, int> hist;
        for (int i = 0; i < data.size() - size; ++i)
        {
            uint64_t z = data.get(i, size);
            if (hist.count(z))
                continue;
            for (int j = i; j < data.size() - size; ++j)
            {
                bool ok = true;
                for (int n = 0; ok && n < size; ++n)
                    if (data[j + n] != data[i + n])
                        ok = false;
                if (ok)
                {
                    ++hist[z];
                    j += size - 1;
                }
            }
        }
        for (auto const &kv : hist)
            if (kv.second > 1)
                printf("%d [size: %d count: %d] %08lx\n", kv.second * (size - 1), size, kv.second, kv.first);
    }
#endif

    auto dict = make_dict();

    int total = 0;
    int n = 16;
    std::vector<uint8_t> w;
    //printf("Output:");
    for (int i = 0; i < data.size(); ++i)
    {
        uint8_t ch = data[i];
        auto wc = w;
        wc.push_back(ch);
        if (dict.count(wc))
        {
            w = wc;
        }
        else
        {
            //printf(" %d", dict[w]);
            total += dict[w] < LOW_TOKENS ? 1 : dict[w] < LOW_TOKENS * HIGH_TOKENS ? 2 : 3;
//            total += dict[w] < LOW_TOKENS ? 1 : 2;
            // Move emitted item to most recently used, i.e. position 16
            int index = dict[w];
            int new_index = (index - 16) / 2 + 16;
            for (auto &kv : dict)
                if (kv.second >= new_index && kv.second < index)
                    ++kv.second;
            dict[w] = new_index;
            // Insert new entry in our dictionary, at position 24
            for (auto &kv : dict)
                if (kv.second >= 17)
                    ++kv.second;
            dict[wc] = 17;
            ++n;
            w = { ch };
        }
    }
    if (!w.empty())
    {
        //printf(" %d", dict[w]);
        total += dict[w] < LOW_TOKENS ? 1 : dict[w] < LOW_TOKENS * HIGH_TOKENS ? 2 : 3;
//        total += dict[w] < LOW_TOKENS ? 1 : 2;
    }
    //printf("\n");
    printf("Total: %d tokens (%d bits) for %d bytes (%d bits)\n", total, int(total * 5.88264304936184125886), data.size() / 2, data.size() * 4);
}

