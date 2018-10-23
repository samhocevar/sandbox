

#include <vector>
#include <map>

#include <string>
#include <iostream>
#include <streambuf>
#include <cstdint>

//char const *chr = "\n 0123456789abcdefghijklmnopqrstuvwxyz!#%(){}[]<>+=/*:;.,~_";

std::vector<char> data;

int count() { return (int)data.size() * 2; }
uint8_t get(int pos) { return (pos & 1) ? (uint8_t)data[pos / 2] >> 4 : (uint8_t)data[pos / 2] & 0xf; }

int main()
{
    data = { std::istreambuf_iterator<char>(std::cin), std::istreambuf_iterator<char>() };

    // Analyze subsequences
    //for (int i = 0; 

    std::map<std::vector<uint8_t>, int> dict;
    for (uint8_t c = 0; c < 16; ++c)
        dict[{ c }] = c;

    int total = 0;
    int n = 16;
    std::vector<uint8_t> w;
    //printf("Output:");
    for (int i = 0; i < count(); ++i)
    {
        uint8_t ch = get(i);
        auto wc = w;
        wc.push_back(ch);
        if (dict.count(wc))
        {
            w = wc;
        }
        else
        {
            //printf(" %d", dict[w]);
            total += dict[w] < 32 ? 1 : dict[w] < 32 * 27 ? 2 : 3;
            dict[wc] = n++;
            w = { ch };
        }
    }
    if (!w.empty())
    {
        //printf(" %d", dict[w]);
        total += dict[w] < 32 ? 1 : dict[w] < 32 * 27 ? 2 : 3;
    }
    //printf("\n");
    printf("Total: %d tokens (%d bits) for %d bytes (%d bits)\n", total, int(total * 5.88264304936184125886), count() / 2, count() * 4);
}

