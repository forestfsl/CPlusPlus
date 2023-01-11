#include <iostream>

#include <string>
#include <algorithm>

using namespace std;

//C++
void testCopyCtor() {
    string s1 = "hello";
    string s2 = s1;
    /*
     s1的内容是:hello
     s2的内容是:hello
     &s1:    0x7ff7b4fdbbf8
     &s2:    0x7ff7b4fdbbe0
     */
    cout << "s1的内容是:" << s1 << endl;
    
    cout << "s2的内容是:" << s2 << endl;
    printf("&s1:     %p\n&s2:    %p  \n", &s1,&s2);
    printf("s1.c_str():%p\n",s1.c_str());
    printf("s2.c_str():%p\n",s2.c_str());
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

int main(int argc, char *argv[])
{
	std::cout << "Hello world!" << std::endl;
	// testCopyCtor();
}



