//
//  Foo.cpp
//  C++Study
//
//  Created by songlin on 2023/1/10.
//

#include "Foo.hpp"

//
//static void* operator new(size_t size);
//static void operator delete(void* pdead,size_t size);
//static void* operator new[](size_t size);
//static void operator delete[](void* pdead, size_t size);

void* Foo::operator new(size_t size) {
    Foo* p = (Foo *)malloc(size);
    cout << "operator new" << endl;
    return p;
}

void Foo::operator delete(void* pdead,size_t size) {
    cout << "operator delete" << endl;
    free(pdead);
}


void* Foo::operator new[](size_t size) {
    Foo* p = (Foo *)malloc(size);
    cout << "operator new[]" << endl;
    return p;
}

void Foo::operator delete[](void* pdead,size_t size) {
    cout << "operator delete[]" << endl;
    free(pdead);
}
