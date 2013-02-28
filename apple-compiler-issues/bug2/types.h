
namespace lol
{

/* There are many reasons for wanting single-word type names, the most
 * important one being compilation speedups in our vector.h: we can hide
 * some global methods in namespaces that contain the name of the type,
 * but namespaces cannot have spaces in their names. */
typedef long double ldouble;

/* The “real” type used for real numbers. It’s a specialisation of the
 * “Real” template class. */
template<int N> class Real;
typedef Real<16> real;

/* The “half” type used for 16-bit floating point numbers. */
class half;

} /* namespace lol */

