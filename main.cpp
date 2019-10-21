#include <iostream>
#include <cstring>
using namespace std;
#include <cstdlib> /* system() */
int main(int argc, char *argv[])
{
 switch(*argv[1])
 {
    case '1':
    {
        system ("flex lexer.l");
        break;
    }
    case '2':
    {
        /*system ("bison -o y.y");*/
		cout<<"bison file does not exist yet";
        break;
    }
    default:
    {
        /*system ("flex lexer.l");
        system ("bison -o y.y");*/
		cout<<"bison file does not exist yet";
        break;
    }
 }
 return 0;
}
