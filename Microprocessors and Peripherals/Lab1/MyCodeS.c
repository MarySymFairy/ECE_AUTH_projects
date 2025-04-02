#include <stdio.h>

int calculate_hash(char *str);

int main() {
    char str[] = "123AaB"; //gives 48

    int hash = calculate_hash(str); //call the function which return the number=hash

    printf("hash=%d\n", hash);

    return 0;
}

int calculate_hash(char *str){
    int hash=0;
    int values[26] = {10, 42, 12, 21, 7, 5, 67, 48, 69, 2, 36, 3, 19, 1, 14, 51, 71, 8, 26, 54, 75, 15, 6, 59, 13, 25};
    
    for (int i = 0; str[i] != '\0'; i++) {
            
     if(str[i] >= 'A' && str[i] <= 'Z'){ 
            hash += values[str[i] - 'A']; 
	    //if i=2 then hash[str[2]-'A']=hash['D'-'A']=hash[3].
     }

     if(str[i] >= 'a' && str[i] <= 'z') {
            hash -= values[str[i] - 'a'];
     }
     
     else if (str[i] >= '1' && str[i] <= '9') { 
            hash += (str[i] - '0'); // '0' --> so as to convert it to integer
     }
    }

return hash;

}