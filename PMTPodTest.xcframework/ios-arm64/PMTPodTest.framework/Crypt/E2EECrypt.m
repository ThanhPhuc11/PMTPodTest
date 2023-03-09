//
//  E2EECrypt.m
//  TCiPhone_CIMB
//
//  Created by Don Lee on 1/11/13.
//
//

#import "E2EECrypt.h"

@implementation E2EECrypt

+ (NSString*)e2eePassword:(NSString*)pubKey randomKey:(NSString*)randomKey session:(NSString*)session password:(NSString*)password
{
//    init([pubKey UTF8String], [randomKey UTF8String], [session UTF8String]);
	
//    [pubKey UTF8String];
//    [randomKey UTF8String];
//    [session UTF8String];
//    [password UTF8String];

////	char* input = (char*)encryptPIN1([password UTF8String]);
////	
////	NSString *output = [NSString stringWithFormat:@"%s", input];
////	

////	return output;
//    
//    return nil;
    
    
    init([pubKey UTF8String], [randomKey UTF8String], [session UTF8String]);
    
    
    char* input = (char*)encryptPIN1((char*)[password UTF8String]);
    
    NSString *output = [NSString stringWithFormat:@"%s", input];
    
    
    
    return output;
}

-(id) init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
