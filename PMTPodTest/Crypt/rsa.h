/*
	this header is not required for the dll
	to compile, but is need to any applications
	or dlls that want to link with this dll
*/

#ifndef SncE2EEDLL_H
#define SncE2EEDLL_H

/* for rsa.c */
static    char* pin = 0;
static    char* oldPin = 0;
static    char* randomNumber = 0;
static    char* publicKeyValue = 0;
static    char* sID = 0;
static    char* invalidPwdErrorMsg = 0;
static    char* newkeyCopy =0;
    
void setPassword(const char* newPin);
char * getPassword();
void setOldPassword(const char * OldPin);
char* getOldPassword();
void setRandomNumber(const char* newRandomNumber);
char* getRandomNumber();
void cleanVar();
void setPubKeyValue(const char* newPublicKeyValue);
char* getPubKeyValue();
void setSessionID(const char* newsID);
char* getSessionID();
void setErrorMsg(const char* newInvalidPwdErrorMsg);
char* getInvalidPwdErrorMsg();
void init(const char* publicKeyString, const char* RandomNumber, const char* SID); 
char * encryptPIN1(char* pin);
char* encryptPIN2(char * oldPin, char * pin);
int validatePin(const char* pin);
int validatePin2(const char* oldPin, const char* pin);
void destroy();



#endif 

