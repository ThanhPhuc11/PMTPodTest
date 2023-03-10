//
//  E2EEInfo.h
//  TCiPhone_CIMB
//
//  Created by Don Lee on 1/11/13.
//
//

#import <Foundation/Foundation.h>

@interface E2EEInfo : NSObject {
    NSString *pubKey;
    NSString *sessionID;
    NSString *randomKey;
    NSString *modulus;
    NSString *exponent;
    NSString *e2ee_EncryptedPassword;
}
@property (nonatomic, strong) NSString *pubKey;
@property (nonatomic, strong) NSString *sessionID;
@property (nonatomic, strong) NSString *randomKey;
@property (nonatomic, strong) NSString *modulus;
@property (nonatomic, strong) NSString *exponent;
@property (nonatomic, strong) NSString *e2ee_EncryptedPassword;

@end
