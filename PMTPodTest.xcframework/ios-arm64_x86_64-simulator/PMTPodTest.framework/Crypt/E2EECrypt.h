//
//  E2EECrypt.h
//  TCiPhone_CIMB
//
//  Created by Don Lee on 1/11/13.
//
//

#import <Foundation/Foundation.h>
#import "rsa.h"

@interface E2EECrypt : NSObject

+ (NSString*)e2eePassword:(NSString*)pubKey randomKey:(NSString*)randomKey session:(NSString*)session password:(NSString*)password;

@end
