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


#include <string>
#include <algorithm>

using namespace std;

@interface ViewController ()

@property (nonatomic, copy) NSMutableArray *mArray;
@property (nonatomic, strong) NSMutableArray *mArray2;
@property (nonatomic, strong) NSMutableArray *mArray3;
@property (nonatomic, strong) NSArray *array3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testCPlusPlusDemo1];
//    [self testArrayPrint];
   // [self testNewAndDelete];
//    [self umutableToCopy];
//    [self testCopyCtor];
//    [self umutableToMutableCopy];
    
//    [self copyArray];
    
//    [self testMutableArrayCopy];
    [self testCopyPropertyForArray];
}

//研究下C++的copy 和 OC的copy是否一样
//参考链接 iOS - 如何深拷贝Array内元素、自定义对象、及自定义对象的属性 https://juejin.cn/post/6960138151138590734

/**
 copy 和mutalbelCopy 概念
 */
//OC
/**
 NSString 不可变 copy 是指针拷贝
 因为str2 = str1的时候，两个字符串都是不可变的，指向的同一块内存空间中的 @"str1",是不可能变成@"abcd"的。所以这个时候，为了优化性能，系统没必要另外提供内存，只生成另外一个指针，指向同一块内存空间就行。
 但是当你从新给 str1 或者str2赋值的时候，因为之前的内容不可变，还有互不影响的原则下，这个时候，系统会从新开辟一块内存空间
 */
- (void)umutableToCopy {
    NSString *str1 = @"st1";
    NSString *str2 = str1;
    NSString *str3 = [str1 copy];
    /*
    str1 = st1 str1P = 0x10e92a1b0,
    str2 = st1,str2P = 0x10e92a1b0
   ,str3 = st1,str3 = 0x10e92a1b0
     */
    NSLog(@"\n str1 = %@  str1P = %p \n, str2 = %@, str2P = %p \n,str3 = %@, str3 = %p", str1, str1, str2, str2, str3,str3);
    
    /*
     str1 = abcdefg  str1P = 0x10e92a1f0
    , str2 = st1, str2P = 0x10e92a1b0
    ,str3 = st1, str3 = 0x10e92a1b0

     */
    str1 = @"abcdefg";
    NSLog(@"\n str1 = %@  str1P = %p \n, str2 = %@, str2P = %p \n,str3 = %@, str3 = %p", str1, str1, str2, str2, str3,str3);
    
}


- (void)testCopyPropertyForArray {
    /**
     arrP = 0x1092975a8
     self.mArrayP = 0x600001286520, self.mArray class = __NSArrayI
     self.mArray2P = 0x600001286af0, self.mArray2 class = __NSArrayM
     self.array3 = 0x1092975a8, self.array3 class = NSConstantArray
     self.mArray3 = 0x1092975a8, self.mArray3 class = NSConstantArray
     */
    NSArray *array = @[@"123",@"456",@"add"];
    self.mArray = [array mutableCopy];
    self.mArray2 = [array mutableCopy];
    self.mArray3 = [array copy];
    self.array3 = [array copy];
    NSLog(@"\n arrP = %p \n self.mArrayP = %p, self.mArray class = %@ \n self.mArray2P = %p, self.mArray2 class = %@ \n self.array3 = %p, self.array3 class = %@ \n self.mArray3 = %p, self.mArray3 class = %@", array, self.mArray, [self.mArray class],self.mArray2,[self.mArray2 class],self.mArray3,[self.mArray3 class],self.array3,[self.array3 class]);
    
//    -[__NSArrayI addObject:]: unrecognized selector sent to instance 0x600001b2c870
//    [self.mArray addObject:@"crash"];
    
}


- (void)umutableToMutableCopy {
    NSString *umStr1 = @"123";
    NSString *umStr2 = [umStr1 mutableCopy];
    
    NSMutableString *mStr1 = [@"123" mutableCopy];
    NSMutableString *mStr2 = [mStr1 mutableCopy];
    /**
     umStr1 = 123 umStr1 = 0x106306210
     umStr2 = 123 umStr2 = 0x6000023ed680
     mStr1 = 123 mStr1P = 0x6000023ed500
     mStr2 = 123 mStr2P = 0x6000023ed560
     */
    NSLog(@"\n umStr1 = %@ umStr1 = %p \n umStr2 = %@ umStr2 = %p \n mStr1 = %@ mStr1P = %p \n mStr2 = %@ mStr2P = %p",umStr1,umStr1,umStr2,umStr2, mStr1, mStr1, mStr2, mStr2);
    
    /**
     umStr1 = 456 umStr1 = 0x106306250
     umStr2 = 123 umStr2 = 0x6000023ed680
     mStr1 = 123 mStr1P = 0x6000023ed500
     mStr2 = 123 mStr2P = 0x6000023ed560
     */
    umStr1 = @"456";
    NSLog(@"\n umStr1 = %@ umStr1 = %p \n umStr2 = %@ umStr2 = %p \n mStr1 = %@ mStr1P = %p \n mStr2 = %@ mStr2P = %p",umStr1,umStr1,umStr2,umStr2, mStr1, mStr1, mStr2, mStr2);
    
    /**
     umStr1 = 456 umStr1 = 0x106306250
     umStr2 = 123 umStr2 = 0x6000023ed680
     mStr1 = 123456789 mStr1P = 0x6000023ed500
     mStr2 = 123 mStr2P = 0x6000023ed560
     */
    [mStr1 appendString:@"456789"];
    NSLog(@"\n umStr1 = %@ umStr1 = %p \n umStr2 = %@ umStr2 = %p \n mStr1 = %@ mStr1P = %p \n mStr2 = %@ mStr2P = %p",umStr1,umStr1,umStr2,umStr2, mStr1, mStr1, mStr2, mStr2);
    
    /**
     umStr1 = 456 umStr1 = 0x106306250
     umStr2 = 123 umStr2 = 0x6000023ed680
     mStr1 = 123456789 mStr1P = 0x6000023ed500
     mStr2 = 123aaaa mStr2P = 0x6000023ed560
     */
    [mStr2 appendString:@"aaaa"];
    NSLog(@"\n umStr1 = %@ umStr1 = %p \n umStr2 = %@ umStr2 = %p \n mStr1 = %@ mStr1P = %p \n mStr2 = %@ mStr2P = %p",umStr1,umStr1,umStr2,umStr2, mStr1, mStr1, mStr2, mStr2);
    
}

- (void)copyArray {
    NSArray *array1 = @[@"123",@"456"];
    NSArray *array2 = [array1 copy];
    NSMutableArray *array3 = [array1 mutableCopy];
    
    /*
     array1 = (
        123,
        456
    ) array1P = 0x10c5883e8 array1 class = NSConstantArray

     array2 = (
        123,
        456
    ) array2P = 0x10c5883e8 array2 class = NSConstantArray
     array3 = (
        123,
        456
    ) array3P = 0x6000028111a0 array3 class = __NSArrayM
     */
    NSLog(@"\n array1 = %@ array1P = %p array1 class = %@ \n\n array2 = %@ array2P = %p array2 class = %@ \n array3 = %@ array3P = %p array3 class = %@ \n", array1, array1, [array1 class], array2, array2, [array2 class],array3, array3, [array3 class]);
    
    
    /**
     array1 = (
        789,
        000
    ) array1P = 0x10c588400 array1 class = NSConstantArray

     array2 = (
        123,
        456
    ) array2P = 0x10c5883e8 array2 class = NSConstantArray
     array3 = (
        123,
        456
    ) array3P = 0x6000028111a0 array3 class = __NSArrayM
     */
    array1 = @[@"789",@"000"];
    NSLog(@"\n array1 = %@ array1P = %p array1 class = %@ \n\n array2 = %@ array2P = %p array2 class = %@ \n array3 = %@ array3P = %p array3 class = %@ \n", array1, array1, [array1 class], array2, array2, [array2 class],array3, array3, [array3 class]);
    
    
    NSMutableArray *mArr1 = [@[@"123", @"456", @"asd"] mutableCopy];
    NSMutableArray *mArr2 = [mArr1 copy];
    /**
     mArr1 = (
        123,
        456,
        asd
    ) mArr1P = 0x60000287dd10 mArr1 class = __NSArrayM

     mArr2 = (
        123,
        456,
        asd
    ) mArr2P = 0x60000287e010 mArr2 class = __NSArrayI
     */
    NSLog(@"\n mArr1 = %@ mArr1P = %p mArr1 class = %@ \n\n mArr2 = %@ mArr2P = %p mArr2 class = %@", mArr1, mArr1, [mArr1 class], mArr2, mArr2, [mArr2 class]);
    
}

- (void)testMutableArrayCopy {
    NSMutableArray *mArr1 = [@[@"123", @"456", @"asd"] mutableCopy];
    NSMutableArray *mArr2 = [mArr1 copy];
    NSMutableArray *mArr3 = [mArr1 mutableCopy];
    /**
     mArr1 = (
        123,
        456,
        asd
    ) mArr1P = 0x600001ff49f0 mArr1 class = __NSArrayM

     mArr2 = (
        123,
        456,
        asd
    ) mArr2P = 0x600001ff4c00 mArr2 class = __NSArrayI
     mArr3 = (
        123,
        456,
        asd
    ) mArr1P = 0x600001ff55c0 mArr3 class = __NSArrayM
     */
    NSLog(@"\n mArr1 = %@ mArr1P = %p mArr1 class = %@ \n\n mArr2 = %@ mArr2P = %p mArr2 class = %@ \n mArr3 = %@ mArr1P = %p mArr3 class = %@ \n", mArr1, mArr1, [mArr1 class], mArr2, mArr2, [mArr2 class],mArr3, mArr3, [mArr3 class]);
    /**
     2023-01-11 16:02:21.768839+0800 C++Study[65783:939536] temp=123,temp=0x10a173218
     2023-01-11 16:02:21.768935+0800 C++Study[65783:939536] temp=456,temp=0x10a173258
     2023-01-11 16:02:21.769026+0800 C++Study[65783:939536] temp=asd,temp=0x10a173318
     */
    for (NSString *temp in mArr1) {
        NSLog(@"temp=%@,temp=%p",temp,temp);
    }
    
    /**
     2023-01-11 16:02:21.769106+0800 C++Study[65783:939536] temp2=123,temp2=0x10a173218
     2023-01-11 16:02:21.769193+0800 C++Study[65783:939536] temp2=456,temp2=0x10a173258
     2023-01-11 16:02:21.769281+0800 C++Study[65783:939536] temp2=asd,temp2=0x10a173318
     */
    for (NSString *temp2 in mArr2) {
        NSLog(@"temp2=%@,temp2=%p",temp2,temp2);
    }
    
    /**
     2023-01-11 16:02:21.769362+0800 C++Study[65783:939536] temp3=123,temp2=0x10a173218
     2023-01-11 16:02:21.769473+0800 C++Study[65783:939536] temp3=456,temp2=0x10a173258
     2023-01-11 16:02:21.769563+0800 C++Study[65783:939536] temp3=asd,temp2=0x10a173318
     */
    for (NSString *temp3 in mArr3) {
        NSLog(@"temp3=%@,temp3=%p",temp3,temp3);
    }
    
    /**
     mArr1 = (
        ffff,
        456,
        asd
    ) mArr1P = 0x600001ff49f0 mArr1 class = __NSArrayM

     mArr2 = (
        123,
        456,
        asd
    ) mArr2P = 0x600001ff4c00 mArr2 class = __NSArrayI
     mArr3 = (
        123,
        456,
        asd
    ) mArr1P = 0x600001ff55c0 mArr3 class = __NSArrayM
     */
    mArr1[0] = @"ffff";
    /**
     2023-01-11 16:02:21.769362+0800 C++Study[65783:939536] temp4=123,temp2=0x108ad13d8
     2023-01-11 16:02:21.769473+0800 C++Study[65783:939536] temp4=456,temp2=0x10a173258
     2023-01-11 16:02:21.769563+0800 C++Study[65783:939536] temp4=asd,temp2=0x10a173318
     */
    NSLog(@"\n mArr1 = %@ mArr1P = %p mArr1 class = %@ \n\n mArr2 = %@ mArr2P = %p mArr2 class = %@ \n mArr3 = %@ mArr1P = %p mArr3 class = %@ \n", mArr1, mArr1, [mArr1 class], mArr2, mArr2, [mArr2 class],mArr3, mArr3, [mArr3 class]);
    for (NSString *temp in mArr1) {
        NSLog(@"temp4=%@,temp4=%p",temp,temp);
    }
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mArr1];
    NSMutableArray *dataArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    mArr1[0] = @"eeeee";
    /*
     mArr1 = (
        eeeee,
        456,
        asd
    ) mArr1P = 0x60000097c840 mArr1 class = __NSArrayM

     mArr2 = (
        123,
        456,
        asd
    ) mArr2P = 0x60000097cb70 mArr2 class = __NSArrayI
     mArr3 = (
        123,
        456,
        asd
    ) mArr1P = 0x60000097c9c0 mArr3 class = __NSArrayM
     
     dataArray = (
        ffff,
        456,
        asd
    ) dataArrayP = 0x6000009214a0 dataArray class = __NSArrayM
     */
    NSLog(@"\n mArr1 = %@ mArr1P = %p mArr1 class = %@ \n\n mArr2 = %@ mArr2P = %p mArr2 class = %@ \n mArr3 = %@ mArr1P = %p mArr3 class = %@ \n \n dataArray = %@ dataArrayP = %p dataArray class = %@ \n", mArr1, mArr1, [mArr1 class], mArr2, mArr2, [mArr2 class],mArr3, mArr3, [mArr3 class],dataArray, dataArray, [dataArray class]);
    /**
     2023-01-11 16:22:00.750035+0800 C++Study[66107:958768] temp5=ffff,temp5=0xfed3942ce907b3a1
     2023-01-11 16:22:00.750170+0800 C++Study[66107:958768] temp5=456,temp5=0xfed3942a8c028686
     2023-01-11 16:22:00.750295+0800 C++Study[66107:958768] temp5=asd,temp5=0xfed3942a8926e3d6
     */
    for (NSString *temp in dataArray) {
        NSLog(@"temp5=%@,temp5=%p",temp,temp);
    }
    
    /**
     2023-01-11 16:22:00.750392+0800 C++Study[66107:958768] temp6=eeeee,temp6=0x1049f6418
     2023-01-11 16:22:00.750496+0800 C++Study[66107:958768] temp6=456,temp6=0x1049f6258
     2023-01-11 16:22:00.750596+0800 C++Study[66107:958768] temp6=asd,temp6=0x1049f6318
     */
    for (NSString *temp in mArr1) {
        NSLog(@"temp6=%@,temp6=%p",temp,temp);
    }
}


class String
{
        friend bool operator == (const String &,const String &);
        friend bool operator != (const String &,const String &);
        friend bool operator <  (const String &,const String &);
        friend bool operator >  (const String &,const String &);
        friend bool operator <= (const String &,const String &);
        friend bool operator >= (const String &,const String &);
  
        friend ostream &operator <<(ostream &os,const String &s);
        friend istream &operator >>(istream &os,String &s);
  
  
public:
        //无参构造函数
        String()
        {
            cout << "调用默认构造函数" << endl;
            pstr_=new char[1];
        }
  
        //有参构造函数
        String (const char *s)
        {
            cout << "调用有参构造函数" << endl;
            pstr_=new char[strlen(s)+1];
            strcpy(pstr_,s);
        }
  
  
        //复制构造函数
        String (const String &rhs)
        {
            cout << "调用拷贝构造函数" << endl;
            pstr_=new char[strlen(rhs.pstr_)+1];
            strcpy(pstr_,rhs.pstr_);
        }
  
  
        //赋值对象重载函数
        String &operator = (const String &rhs)
        {
         if(this!=&rhs)//如果不是自复制
         {
          delete []pstr_;//先删除掉原有的内容
          pstr_=new char[strlen(rhs.pstr_)+1];
          strcpy(pstr_,rhs.pstr_);
         }
         return *this;
        }
  
  
        //赋值字符串重载函数
        String &operator = (const char *s)
        {
         pstr_=new char[strlen(s)+1];
         strcpy(pstr_,s);
         return *this;
        }
  
  
        //重载+=运算符  左边对象本身发生了改变
        String & operator +=(const String & rhs)
        {
         //用临时的字符串指针存放
         char *tmp;
         tmp=new char[strlen(pstr_)+strlen(rhs.pstr_)+1];
         strcpy(tmp,pstr_);
         strcat(tmp,rhs.pstr_);
         delete []pstr_;
         pstr_=tmp;
         return *this;
  
        }
        String &operator += (const char *pstr)
        {
         char *tmp;
         tmp = new char[strlen(pstr_)+strlen(pstr)+1];//先开空间
         strcpy(tmp,pstr_);
         strcat(tmp,pstr);
         delete []pstr_;
         pstr_=tmp;
         return *this;
        }
  
  
        //重载[]下标运算符
        char &operator[](size_t index)
        {
         static char sNULL='\0';
         //要判断给出的下标越界的情况
         if(index<strlen(pstr_) && index>0)
         {
          return pstr_[index];
         }
         else
         {
          cout<<"下标越界"<<endl;
          return sNULL;
         }
        }
        //重载const对象的运算符
        const char &operator[](size_t index) const
        {
          static char sNULL='\0';
         //要判断给出的下标越界的情况
         if(index<strlen(pstr_) && index>0)
         {
          return pstr_[index];
         }
         else
         {
          cout<<"下标越界"<<endl;
          return sNULL;
         }
        }
  
  
  
  
        //返回字符串长度函数  函数后面加const代表这里面的所有变量只能读不能改
        size_t size() const
        {
          return strlen(pstr_);
        }
  
        //重载c_str函数  返回的是当前字符串的首字符地址
        const char* c_str()const
        {
         return pstr_;
        }
  
  
  
  
        //析构函数
        ~String()
        {
            cout << "调用析构函数" << endl;
         delete []pstr_;
        }
  
        //打印函数
        void print()
        {
         if(pstr_==NULL)
         {
         cout<<""<<endl;
         }
        else
        {
         cout<<"string :"<<pstr_<<endl;
        }
        }
  
private:
        char *pstr_;
  
};
//重载== 函数
bool operator == (const String &lhs,const String &rhs)
{
        if(strcmp(lhs.pstr_,rhs.pstr_)==0)
        {
         return 1;
        }
        else
         {
         return 0;
         }
}
//重载!=函数
bool operator != (const String &lhs,const String &rhs)
{
        if(strcmp(lhs.pstr_,rhs.pstr_)==0)
        {
         return 0;
        }
        else
         {
         return 1;
         }
}
//重载< 函数
bool operator <(const String &lhs,const String &rhs)
{
        if(strcmp(lhs.pstr_,rhs.pstr_)<0)
        {
         return 1;
        }
        else
        {
         return 0;
        }
}
//重载>函数
bool operator >(const String &lhs,const String &rhs)
{
        if(strcmp(lhs.pstr_,rhs.pstr_)>0)
        {
         return 1;
        }
        else
        {
         return 0;
        }
}
//重载<=函数
bool operator <=(const String &lhs,const String &rhs)
{
        if(strcmp(lhs.pstr_,rhs.pstr_)<=0)
        {
         return 1;
        }
        else
        {
         return 0;
        }
}
  
//重载>=函数
bool operator >=(const String &lhs,const String &rhs)
{
   if(strcmp(lhs.pstr_,rhs.pstr_)>=0)
        {
         return 1;
        }
        else
        {
         return 0;
        }
}
  
//重载<<流
ostream &operator <<(ostream &ofs,const String &rhs)
{
        ofs<<rhs.pstr_<<endl;
        return ofs;
}
//重载>>流
istream &operator >>(istream &ifs, String &rhs)
{
  
        char tmp[1024];//先开空间
        ifs>>tmp;
        rhs.pstr_=tmp;//输入的字符 放到rhs中
        return ifs;
  
}
//重载+(两个对象之间)
String operator +(const String &lhs,const String & rhs)
{
        String str(lhs);
        str+=rhs;
        return str;
}
String operator +(const String &lhs,const char *s)
{
        String str(lhs);
        str+=s;
        return str;
}
String operator +(const char *s,const String &rhs)
{
        String str(rhs);
        str+=s;
        return s;
  
}

//C++
- (void)testCopyCtor {
    string s1 = "hello";
    string s2 = s1;
    /*
     s1的内容是:hello
     s2的内容是:hello
     &s1:    0x7ff7b4fdbbf8
     &s2:    0x7ff7b4fdbbe0
     
     本来想证明是指向同一个区域的，但是打印出来的指针却是两个值不一样(刚开始以为是编译器的问题，最后发现使用vscode编译也还是一样https://www.cnblogs.com/sjie/p/15671843.html)
     https://stackoverflow.com/questions/12199710/legality-of-cow-stdstring-implementation-in-c11
     s1.c_str():0x7ff7b1deabf9
     s2.c_str():0x7ff7b1deabe1
     */
    cout << "s1的内容是:" << s1 << endl;
    cout << "s2的内容是:" << s2 << endl;
    printf("&s1:     %p\n&s2:    %p  \n", &s1,&s2);
    printf("s1.c_str():%p\n",s1.c_str());
    printf("s2.c_str():%p",s2.c_str());
    cout << "-----------------------"  << endl;
   
    /*
     转换s1的内容是:hello
     转换s2的内容是:HELLO
     &s1:     0x7ff7b4fdbbf8
     &s2:    0x7ff7b4fdbbe0
     */
    s1 = "hello2";
    cout << "转换s1的内容是:" << s1 << endl;
    cout << "转换s2的内容是:" << s2 << endl;
    printf("&s1:     %p\n&s2:    %p\n", &s1,&s2);
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
