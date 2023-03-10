//
//  RSAClass.m
//  PMTPodTest
//
//  Created by PhucMT on 09/03/2023.
//

#import "RSAClass.h"
//#import "Crypt/RSACrypt.h"
#import "RSACrypt.h"
#import "E2EECrypt.h"

@implementation RSAClass

//RSA Encryption
//Special for E2EE Implementation (CIMB SG) in which the second password field is encrypted by RSA 1024. The public key is generated by modulus and exponent and the output result is in Hexadecimal string
- (NSString *)rsaEncryptData:(NSString *)plainText withModulus:(NSString *)modulus andExponent:(NSString *)exponent andTag:(NSString *)tag {
    NSData *rsaEncryptedStr = [RSACrypt encryptToData:plainText withPublicKeyBits:[RSACrypt generatePublicKeyBits:NO withCertContent:nil orWithModulus:modulus andExponent:exponent] andTag:tag];
    return [self hexStringFromBytes:rsaEncryptedStr forURL:NO];
}
//Special for AES Implementation (CIMB KL) in which the AES Key is encrypted by RSA 512. The public key is generated by certificate content (in X509 format) and the output result is in Base64 encoded string
//Special for AES Implementation (CIMB KL) in which the AES Key is encrypted by RSA 512. The public key is generated by certificate content (in X509 format) and the output result is in Base64 encoded string
- (NSString *)rsaEncryptData:(NSString *)plainText withCertContent:(NSString *)certContent andTag:(NSString *)tag andExponent:(NSString *)exponent{
    NSString *rsaEncryptedStr = [RSACrypt encryptAndB64EncodeToStr:plainText withPublicKeyBits:[RSACrypt generatePublicKeyBits:YES withCertContent:certContent orWithModulus:certContent andExponent:exponent] andTag:tag];
    return rsaEncryptedStr;
}

- (NSString *)hexStringFromBytes:(NSData *)data forURL:(BOOL)appendPerc
{
    NSString *sbResult = @"";
    int i;
    int idata;
    Byte *byteData = (Byte*)malloc([data length]);
    memcpy(byteData, [data bytes], [data length]);
    for (i=0; i<[data length]; i++) {
        if (appendPerc) {
            sbResult = [NSString stringWithFormat:@"%@%@", sbResult, @"%"];
        }
        idata = (int) byteData[i];
        if ((idata & 0xff) < 0x10) {
            sbResult = [NSString stringWithFormat:@"%@%i", sbResult, 0];
        }
        idata = idata & 0xff;
        sbResult = [NSString stringWithFormat:@"%@%x", sbResult, idata];
    }
    free(byteData);
    
    return sbResult;
}

+ (nullable NSString *)encryptedPassword:(NSString *)password publicKey:(NSString *)publicKey randomNum:(NSString *)randomNum sessionID:(NSString *)sessionID {
    return [E2EECrypt e2eePassword:publicKey randomKey:randomNum session:sessionID password:password];
}

@end
