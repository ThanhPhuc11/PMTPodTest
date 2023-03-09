//
//  E2EEInfo.m
//  TCiPhone_CIMB
//
//  Created by Don Lee on 1/11/13.
//
//

#import "E2EEInfo.h"

@implementation E2EEInfo
@synthesize pubKey, sessionID, randomKey, modulus, exponent, e2ee_EncryptedPassword;

- (id) init {
    self = [super init];
    if (self) {
    }
    return self;
}



@end
