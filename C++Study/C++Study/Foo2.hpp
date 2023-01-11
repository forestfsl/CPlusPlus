//
//  Foo2.hpp
//  C++Study
//
//  Created by songlin on 2023/1/10.
//

#ifndef Foo2_hpp
#define Foo2_hpp

#include <stdio.h>
#include <iostream>

using namespace std;

class Bad{};

class Foo2 {
public:
    Foo2() {
        cout << "Foo:Foo()" << endl;
    }
    Foo2(int) {
        cout << "Foo:Foo(int)" << endl;
        throw Bad();
    }
    
    //这个就是一般的operator new()的重载
    void* operator new(size_t size) {
        return malloc(size);
    }
    
    //这个就是标准库已提供的placement new()的重载(的形式)
    void* operator new(size_t size,void* start) {
        return start;
    }
    
    //这个才是崭新的placement new
    void* operator new(size_t size,long extra) {
        return malloc(size+extra);
    }
    
    //这个又是一个placement new
    void* operator new(size_t size,long extra,char init) {
        return malloc(size+extra);
    }
    
    //这个又是另外一个placement new，但是故意写错第一参数的type(那必须是size_t 以符合正常的operator new),直接编译期就报错了
//    void* operator new(long extra,char init) {
//        return malloc(extra);
//    }
    
    //以下就是搭配上述placement new的各个所谓placement delete,当ctor发出异常，这儿对应的operator(placement)delete就会被调用
//    其用途是释放对应之placement new分配所得的memory
    void operator delete(void*,size_t)
    {
        cout << "operator delete(void*,size_t)" << endl;
    }
    
    void operator delete(void*,void *)
    {
        cout << "operator delete(void*,void*)" << endl;
    }
    
    void operator delete(void*,long) {
        cout << "operator delete(void*,long)" << endl;
    }
    
    void operator delete(void*,long,char) {
        cout << "operator delete(void*,long ,char)" << endl;
    }
};

#endif /* Foo2_hpp */
