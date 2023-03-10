//
//  RSACrypt.m
//  TCiPhone_CIMB
//
//  Created by Don Lee on 1/15/13.
//
//

#import "RSACrypt.h"
@implementation RSACrypt

+ (NSData *)generatePublicKeyBits:(BOOL)isCert withCertContent:(NSString *)certContent orWithModulus:(NSString *)modulus andExponent:(NSString *)exponent {
    if (isCert) {
        [Base64 initialize];
        NSData *modulusData = [Base64 decode:modulus];
        NSData *exponentData = [Base64 decode:exponent];
        
        NSMutableArray *testArray = [[NSMutableArray alloc] init];
        if (modulusData) {
            [testArray addObject:modulusData];
        }
        
        if (exponentData) {
             [testArray addObject:exponentData];
        }
       
        NSData *publicKeyBits = [testArray berData];
        return publicKeyBits;
    }
    else {
        [Base64 initialize];
        NSData *modulusData = [Base64 decode:modulus];
        NSData *exponentData = [Base64 decode:exponent];
        
        NSMutableArray *testArray = [[NSMutableArray alloc] init];
        if (modulusData) {
            [testArray addObject:modulusData];
        }
        
        if (exponentData) {
            [testArray addObject:exponentData];
        }
        NSData *publicKeyBits = [testArray berData];

        return publicKeyBits;
    }
    
    return nil;
}

+ (NSData *)encryptToData:(NSString *)plainText withPublicKeyBits:(NSData *)publicKeyBits andTag:(NSString *)tag {
    
    SecKeyRef publicKey = [self addPublicKeyRef:publicKeyBits withTag:tag];
    
    if (!publicKey)
    {
        return nil;
    }
    
    size_t cipherBufferSize = SecKeyGetBlockSize(publicKey);
    uint8_t *cipherBuffer = malloc(cipherBufferSize);
    
    //Method 1
    /*
     uint8_t *nonce = (uint8_t *)[plainText UTF8String];
     SecKeyEncrypt(publicKey, kSecPaddingPKCS1, nonce, strlen((char*)nonce) + 1, &cipherBuffer[0], &cipherBufferSize);
     */
    
    //Method 2
    NSData *inputData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    int length = (int)[inputData length];
    uint8_t *nonce = malloc(length);
    const void *bytes = [inputData bytes];
    memcpy(nonce, bytes, length);
    
    // Ordinarily, you would split the data up into blocks
    // equal to cipherBufferSize, with the last block being
    // shorter. For simplicity, this example assumes that
    // the data is short enough to fit.
    if (cipherBufferSize < sizeof(nonce))
    {
        if(publicKey) {
            CFRelease(publicKey);
        }
        free(cipherBuffer);
        free(nonce);
        return nil;
    }
    
    SecKeyEncrypt(publicKey, kSecPaddingPKCS1, nonce, length, cipherBuffer, &cipherBufferSize);
    
    NSData *encryptedData = [NSData dataWithBytes:cipherBuffer length:cipherBufferSize];
    //NSLog(@"RSA EncryptedData :%@", encryptedData);
    
    if(publicKey) {
        CFRelease(publicKey);
    }
    free(cipherBuffer);
    free(nonce);
    
    return encryptedData;
}

+ (NSString *)encryptAndB64EncodeToStr:(NSString *)plainText withPublicKeyBits:(NSData *)publicKeyBits andTag:(NSString *)tag {
    
    
    
    SecKeyRef publicKey = [self addPublicKeyRef:publicKeyBits withTag:tag];
    
    if (!publicKey)
    {
        NSLog(@"Failed to add public key.");
    }
    
    size_t cipherBufferSize = SecKeyGetBlockSize(publicKey);
    uint8_t *cipherBuffer = malloc(cipherBufferSize);
    
    //Method 1
    /*
     uint8_t *nonce = (uint8_t *)[plainText UTF8String];
     SecKeyEncrypt(publicKey, kSecPaddingPKCS1, nonce, strlen((char*)nonce) + 1, &cipherBuffer[0], &cipherBufferSize);
     */
    
    //Method 2
    NSData *inputData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    int length = (int)[inputData length];
    uint8_t *nonce = malloc(length);
    const void *bytes = [inputData bytes];
    memcpy(nonce, bytes, length);
    
    // Ordinarily, you would split the data up into blocks
    // equal to cipherBufferSize, with the last block being
    // shorter. For simplicity, this example assumes that
    // the data is short enough to fit.
    if (cipherBufferSize < sizeof(nonce))
    {
        if(publicKey) {
            CFRelease(publicKey);
        }
        free(cipherBuffer);
        free(nonce);
        NSLog(@"Could not encrypt.  Packet too large.");
        return nil;
    }
    
    SecKeyEncrypt(publicKey, kSecPaddingPKCS1, nonce, length, cipherBuffer, &cipherBufferSize);
    
    NSData *encryptedData = [NSData dataWithBytes:cipherBuffer length:cipherBufferSize];
    NSString *b64EncryptedData = [Base64 encode:encryptedData];
    //NSLog(@"RSA EncryptedData :%@", encryptedData);
    //NSLog(@"Base64Encoded RSA EncryptedData:%@", b64EncryptedData);
    
    if(publicKey) {
        CFRelease(publicKey);
    }
    free(cipherBuffer);
    free(nonce);
    
    return b64EncryptedData;
}

+ (NSData *)getX509PublicKeyBits:(NSString *)certContent {
    
    //Base64 decoding
    NSData *publicKeyBits = [Base64 decode:certContent];
    
    unsigned char * bytes = (unsigned char *)[publicKeyBits bytes];
    size_t bytesLen = [publicKeyBits length];
    
    size_t i = 0;
    if (bytes[i++] != 0x30)
        NSLog(@"Could not set public key.");
    
    //Skip size bytes
    if (bytes[i] > 0x80)
        i += bytes[i] - 0x80 + 1;
    else
        i++;
    
    if (i >= bytesLen)
        NSLog(@"Could not set public key.");
    
    if (bytes[i] != 0x30)
        NSLog(@"Could not set public key.");
    
    //Skip OID
    i += 15;
    
    if (i >= bytesLen - 2)
        NSLog(@"Could not set public key.");
    
    if (bytes[i++] != 0x03)
        NSLog(@"Could not set public key.");
    
    //Skip length and null
    if (bytes[i] > 0x80)
        i += bytes[i] - 0x80 + 1;
    else
        i++;
    
    if (i >= bytesLen)
        NSLog(@"Could not set public key.");
    
    if (bytes[i++] != 0x00)
        NSLog(@"Could not set public key.");
    
    if (i >= bytesLen)
        NSLog(@"Could not set public key.");
    
    publicKeyBits = [NSData dataWithBytes:&bytes[i] length:bytesLen - i];
    
    return publicKeyBits;
}

+ (SecKeyRef)addPublicKeyRef:(NSData *)publicKeyBits withTag:(NSString *)tag {
    
    NSData *keyTag = [tag dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *queryKey = [[NSMutableDictionary alloc] init];
    
    OSStatus deleteKeyStatus = noErr;
    [queryKey setObject:(id) kSecClassKey forKey:(id)kSecClass];
    [queryKey setObject:(id) kSecAttrKeyTypeRSA forKey:(id)kSecAttrKeyType];
    [queryKey setObject:keyTag forKey:(id)kSecAttrApplicationTag];
    deleteKeyStatus = SecItemDelete((CFDictionaryRef)queryKey);
    
    if (deleteKeyStatus != noErr) {
        NSLog(@"Problem deleting the key(%@) from keychain", tag);
    }
    
    OSStatus addPersistKeyStatus = noErr;
    CFTypeRef persistKeyRef = nil;
    [queryKey setObject:publicKeyBits forKey:(id)kSecValueData];
    [queryKey setObject:(id) kSecAttrKeyClassPublic forKey:(id)kSecAttrKeyClass];
    [queryKey setObject:[NSNumber numberWithBool:YES] forKey:(id)kSecReturnPersistentRef];
    
    addPersistKeyStatus = SecItemAdd((CFDictionaryRef)queryKey, &persistKeyRef);
    
    if (addPersistKeyStatus != noErr) {
        NSLog(@"Problem adding the persistent key(%@) to keychain", tag);
    }
    
    OSStatus copyKeyStatus = noErr;
    SecKeyRef keyRef = nil;
    if (persistKeyRef != nil) {
        NSLog(@"persistKeyRef != nil");
        keyRef = [self getKeyRefWithPersistentKeyRef:persistKeyRef];
        CFRelease(persistKeyRef);
    }
    else {
        NSLog(@"persistKeyRef == nil");
        [queryKey removeObjectForKey:(id)kSecValueData];
        [queryKey removeObjectForKey:(id)kSecReturnPersistentRef];
        [queryKey setObject:(id) kSecAttrKeyTypeRSA forKey:(id)kSecAttrKeyType];
        [queryKey setObject:[NSNumber numberWithBool:YES] forKey:(id)kSecReturnRef];
        
        copyKeyStatus = SecItemCopyMatching((CFDictionaryRef)queryKey,(CFTypeRef *)&keyRef);
        
        if (copyKeyStatus != noErr) {
            NSLog(@"Problem acquiring reference to the key(%@)", tag);
        }
    }
    
    if (keyRef == nil) {
        NSLog(@"keyRef is nil");
    }
    
    return keyRef;
}

+ (SecKeyRef)getKeyRefWithPersistentKeyRef:(CFTypeRef)persistentRef {
    
    NSMutableDictionary *queryKey = [[NSMutableDictionary alloc] init];
    
    OSStatus statusCheck = noErr;
	SecKeyRef keyRef = nil;
    [queryKey setObject:(__bridge id)persistentRef forKey:(id)kSecValuePersistentRef];
	[queryKey setObject:[NSNumber numberWithBool:YES] forKey:(id)kSecReturnRef];
	
	statusCheck = SecItemCopyMatching((CFDictionaryRef)queryKey, (CFTypeRef *)&keyRef);
    
    if (statusCheck != noErr)
    {
        NSLog(@"Problem get key reference with persistent key reference");
    }
    
    if (keyRef == nil) {
        NSLog(@"keyRef is nil");
    }
    
	return keyRef;
}

+ (SecKeyRef)getKeyRefWithTag:(NSString *)tag {
    
    NSData *keyTag = [tag dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *queryKey = [[NSMutableDictionary alloc] init];
    
    OSStatus copyKeyStatus = noErr;
    SecKeyRef keyRef = nil;
    [queryKey setObject:(id)kSecClassKey forKey:(id)kSecClass];
    [queryKey setObject:(id)kSecAttrKeyTypeRSA forKey:(id)kSecAttrKeyType];
    [queryKey setObject:keyTag forKey:(id)kSecAttrApplicationTag];
    [queryKey setObject:[NSNumber numberWithBool:YES] forKey:(id)kSecReturnRef];
    
    copyKeyStatus = SecItemCopyMatching((CFDictionaryRef)queryKey, (CFTypeRef *)&keyRef);
    
    if (copyKeyStatus != noErr) {
        NSLog(@"Problem acquiring reference to the key(%@)", tag);
    }
    
    if (keyRef == nil) {
        NSLog(@"keyRef is nil");
    }
    
    return keyRef;
}

+ (void)removeKeyRefWithTag:(NSString *)tag
{
    NSData *keyTag = [tag dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *queryKey = [[NSMutableDictionary alloc] init];
    
    OSStatus deleteKeyStatus = noErr;
    [queryKey setObject:(id) kSecClassKey forKey:(id)kSecClass];
    [queryKey setObject:(id) kSecAttrKeyTypeRSA forKey:(id)kSecAttrKeyType];
    [queryKey setObject:keyTag forKey:(id)kSecAttrApplicationTag];
    
    deleteKeyStatus= SecItemDelete((CFDictionaryRef)queryKey);
    
    if (deleteKeyStatus != noErr) {
        NSLog(@"Problem deleting the key(%@) from keychain", tag);
    }
    
    queryKey;
}

@end
