#include <stdint.h>
#include <cstdarg>

namespace lol
{

class Log
{
public:
#ifdef __GNUC__
#   define LOL_FMT_ATTR(n, p) __attribute__((format(printf, n, p)))
#else
#   define LOL_FMT_ATTR(n, p)
#endif
    static void Debug(char const *format, ...) LOL_FMT_ATTR(1, 2);
    static void Info(char const *format, ...) LOL_FMT_ATTR(1, 2);
    static void Warn(char const *format, ...) LOL_FMT_ATTR(1, 2);
    static void Error(char const *format, ...) LOL_FMT_ATTR(1, 2);
#undef LOL_FMT_ATTR

private:
    enum MessageType
    {
        DebugMessage,
        InfoMessage,
        WarnMessage,
        ErrorMessage
    };

    static void Helper(MessageType type, char const *fmt, va_list ap);
};

} /* namespace lol */

