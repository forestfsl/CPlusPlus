//
//  Foo.hpp
//  C++Study
//
//  Created by songlin on 2023/1/10.
//

#ifndef Foo_hpp
#define Foo_hpp

#include <stdio.h>
//C++
#include <iostream>


using namespace std;

/*
 重载::operator new, ::operator delete
 ::operator new[],::operator delete[]
 */

//void *myAlloc(size_t size)
//{
//    return malloc(size);
//}
//
//void myFree(void *ptr)
//{
//    return free(ptr);
//}

class Foo
{
public:
    int _id;
    long _data;
    string _str;

public:
    Foo():_id(0) {
        cout << "default ctor.this=" << this << "id=" << _id << endl;
    }
    
    Foo(int i):_id(i) {
        cout << "ctor.this=" << this << "id=" << _id << endl;
    }
    
    ~Foo() {
        cout << "dtor.this = " << this << "id=" << _id << endl;
    }
    static void* operator new(size_t size);
    static void operator delete(void* pdead,size_t size);
    static void* operator new[](size_t size);
    static void operator delete[](void* pdead, size_t size);
    
};

#endif /* Foo_hpp */
