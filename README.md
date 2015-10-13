# RuntimeDemo
Objective-C Runtime机制的示例代码，包含以下例子：

* 方法解析和消息转发 - Message和MessageForwarding类
* Associated Objects ： NSObject+AssociatedObject Category
* Method Swizzling：UIViewController+Logging Category

使用场景:在一个函数找不到时，Objective-C提供了三种方式去补救:  
      
* 1、调用resolveInstanceMethod给个机会让类添加这个实现这个函数

* 2、调用forwardingTargetForSelector让别的对象去执行这个函数

* 3、调用methodSignatureForSelector（函数符号制造器）和forwardInvocation（函数执行器）灵活的将目标函数以其他形式执行。 
  
如果都不中，调用doesNotRecognizeSelector抛出异常。

