//
//  Message.m
//  RuntimeDemo
//
//  Created by Sam Lau on 7/5/15.
//  Copyright © 2015 Sam Lau. All rights reserved.
//

#import "Message.h"
#import "MessageForwarding.h"
#import <objc/runtime.h>

//tip:
/*
 在一个函数找不到时，Objective-C提供了三种方式去补救：
 
 1、调用resolveInstanceMethod给个机会让类添加这个实现这个函数
 
 2、调用forwardingTargetForSelector让别的对象去执行这个函数
 
 3、调用methodSignatureForSelector（函数符号制造器）和forwardInvocation（函数执行器）灵活的将目标函数以其他形式执行。
 [methodSignatureForSelector让重载方有机会抛出一个函数的签名，再由后面的forwardInvocation去执行]
 
 如果都不中，调用doesNotRecognizeSelector抛出异常。
 */

@implementation Message

//- (void)sendMessage:(NSString *)word
//{
//    NSLog(@"normal way : send message = %@", word);
//}

#pragma mark - Method Resolution
/// override resolveInstanceMethod or resolveClassMethod for changing sendMessage method implementation
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(sendMessage:)) {
        class_addMethod([self class], sel, imp_implementationWithBlock(^(id self, NSString *word) {
            NSLog(@"method resolution way : send message = %@", word);
        }), "v@*");
    }
    
    return YES;
}

#pragma mark - Fast Forwarding
//- (id)forwardingTargetForSelector:(SEL)aSelector
//{
//    if (aSelector == @selector(sendMessage:)) {
//        return [MessageForwarding new];
//    }
//    
//    return nil;
//}


//#pragma mark - Normal Forwarding
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
//{
//    NSMethodSignature *methodSignature = [super methodSignatureForSelector:aSelector];
//    
//    if (!methodSignature) {
//        methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:*"];
//    }
//    
//    return methodSignature;
//}
//
//- (void)forwardInvocation:(NSInvocation *)anInvocation
//{
//    MessageForwarding *messageForwarding = [MessageForwarding new];
//    
//    if ([messageForwarding respondsToSelector:anInvocation.selector]) {
//        [anInvocation invokeWithTarget:messageForwarding];
//    }
//}

@end
