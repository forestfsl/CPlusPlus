//
//  ViewController.m
//  C++Study
//
//  Created by songlin on 2022/12/9.
//

#import "ViewController.h"
//C++
#include <iostream>
//C
#include "stdio.h"

#include "Foo.hpp"

using namespace std;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testCPlusPlusDemo1];
//    [self testArrayPrint];
    [self testNewAndDelete];
}



- (void)testNewAndDelete
{
    cout << "sizeof(Foo)=" << sizeof(Foo) << endl;;
    Foo *p = new Foo(7);
    delete p;
    
    Foo* pArray = new Foo[5];
    delete [] pArray;
}




/**
 a:     0x30850cba0
 &a:    0x30850cba0
 &a[0]: 0x30850cba0
 &a[1]: 0x30850cba4
 &a[2]: 0x30850cba8
 &a[3]: 0x30850cbac
 &a[4]: 0x30850cbb0


 ptr:0x30850cbb4---(ptr-1):0x30850cbb0==========
 *(a+1):2,(ptr - 1):5==========
 ptr1:0x30850cba4---(ptr1-1):0x30850cba0==========
 *(a+1):2,(ptr1 - 1):1==========
 */

//测试&a 和 a demo 案例
- (void)testArrayPrint {
    int a[5] = {1,2,3,4,5};
    
    int *ptr = (int *)(&a + 1);
    
    printf("a:     %p\n", a);    //数组首元素地址
    printf("&a:    %p\n\n", &a);    //整个数组地址位置
    printf("&a[0]: %p\n", &a[0]);    //数组第一个元素的地址
    printf("&a[1]: %p\n", &a[1]);    //数组第二个元素的地址
    printf("&a[2]: %p\n", &a[2]);    //数组第三个元素的地址
    printf("&a[3]: %p\n", &a[3]);    //数组第四个元素的地址
    printf("&a[4]: %p\n", &a[4]);    //数组第五个元素的地址
    
    printf("ptr:%p---(ptr-1):%p",ptr,(ptr - 1));
    
    printf("==========\n");
    printf("*(a+1):%d,(ptr - 1):%d",*(a+1),*(ptr - 1));
    
    printf("==========\n");
    int *ptr1=(int *)(a+1);
    printf("ptr1:%p---(ptr1-1):%p",ptr1,(ptr1 - 1));
    printf("==========\n");
    printf("*(a+1):%d,(ptr1 - 1):%d",*(a+1),*(ptr1 - 1));
    printf("==========\n");
}

- (void)testCPlusPlusDemo1
{
    int i = 7;
    cout << "i=" << i << endl;
    
}

- (void)testCDemo1
{
    int i = 7;
    printf("i=%d \n",i);
}



@end
