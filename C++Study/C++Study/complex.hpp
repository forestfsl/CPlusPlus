//
//  complex.hpp
//  C++Study
//
//  Created by songlin on 2022/12/12.
//

#ifndef complex_hpp
#define complex_hpp

#include <stdio.h>


class complex
{
public:
    complex (double r = 0, double i = 0) : re(r),im(i) {}
    complex& operator += (const complex&);
    int func (const complex& param)
    {
        return param.re + param.im;
    }
private:
    double re,im;
    friend complex& __doapl (complex *, const complex&);
    friend complex& __doapl (complex &, const complex&);
};

inline complex&
__doapl (complex* ths, const complex& r)
{
  double f = ths->re * r.re - ths->im * r.im;
  ths->im = ths->re * r.im + ths->im * r.re;
  ths->re = f;
  return *ths;
}

inline complex&
complex::operator += (const complex& r)
{
    return __doapl (this, r);
}

//inline complex&
//__doapl (complex& ths, const complex& r)
//{
//  double f = ths.re * r.re - ths.im * r.im;
//  ths.im = ths.re * r.im + ths.im * r.re;
//  ths.re = f;
//  return ths;
//}
//
//inline complex&
//complex::operator += (const complex& r)
//{
//    return __doapl (*this, r);
//}



#endif /* complex_hpp */
