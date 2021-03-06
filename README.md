# Xcode Code Snippets

Some code snippets be used in Xcode.   

Code Snippets Path: ~/Library/Developer/Xcode/UserData/CodeSnippets；

# Usage
```
check out the project using: git clone https://github.com/MarkStudio/XcodeCodeSnippets.git
cd /Users/Mark/XcodeCodeSnippets
./setup_snippets.sh

```

# shortcut as below:  
## mksDefineDebug 

```
#ifdef DEBUG
#define MKSLog(...) NSLog(__VA_ARGS__)
#define MKSMethod() NSLog(@"%s", __func__)
#else
#define MKSLog(...)
#define MKSMethod()
#endif
```

## mksMark

```
#pragma mark - <#comment#>
```

## mksInterface

```
@interface <#name#> ()

@end
```

## mksPrivateInterface

```
@interface <#class name#> ()

<#method#>

@end
```

## mksAssignProperty

```
@property (nonatomic, assign) <#type#> <#name#>;
```

## mksStrongProperty 

```
@property (nonatomic, strong) <#type#> *<#name#>;
```


## mksWeakProperty

```
@property (nonatomic, weak) <#type#> <#name#>;
```

## mksSynthesize
```
@synthesize <#property#> = _propertyIvar;
```


## setAssociated
```
// should has:
// static char xxxKey;
objc_setAssociatedObject(self,
                        &<#xxxKey#>,
                        <#property#>,
                        <#objc_AssociationPolicy#>);
```

## getAssociated

```
// should has:
// static char xxxKey;
objc_getAssociatedObject(self, &<#xxxKey#>);
```

## mksInitObject

```
- (id)init
{
    self = [super init];
    if (self) {
 
    }
    
    return self;
}
```

## mksSharedInstance
```
+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });    
    
    return sharedInstance;
}
```

## mksNotification

```
[[NSNotificationCenter defaultCenter] addObserver:self
                                selector:@selector(<#handle#>)
                                    name:<#name#>
                                  object:nil];
    
// post notification
[[NSNotificationCenter defaultCenter] postNotificationName:<#name#>
                                                    object:self
                                                   userInfo:<#userInfo#>];
                                                   
[[NSNotificationCenter defaultCenter] removeObserver:self
                                                name:<#name#>
                                              object:<#(nullable id)#>];
#warning should remove in observer
    - (void)<#notificationHandle#>:(NSNotification *)noti
    {
        <#handle block#>
    }
```

## mksRegisterNibCell
```
#define ReuseIdentifier @"<#reuseIdentifier#>"
    UINib *nib = [UINib nibWithNibName:<#nibName#>
                                bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:ReuseIdentifier];
```

## mksTimer
```
// 创建
self.<#var#> = [NSTimer scheduledTimerWithTimeInterval:1.5
                                                target:self
                                              selector:@selector(<#handle#>)
                                              userInfo:nil
                                               repeats:YES];
// 取消
[self.<#var#> invalidate];
```

## mksHideKeyboard

```
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
```

## swizzling
```
// should be in [NSObject load] method
static dispatch_once_t onceToken;
dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        // when swizzling a class method, use the following
        // Class class = objc_getClass((id)self);
        
        SEL originalSelector = @selector(<#originSelector#>);
        SEL swizzledSelector = @selector(<#swizzledSelector#>);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class,
                                            originalSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        }
        else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
});

```

## mksAnimationViewTransition
```
// add transition in UIView
UIViewAnimationTransition transition = <#transitionType#>;
[UIView beginAnimations:@"transition" context:nil];
[UIView setAnimationDuration:<#duration#>];
[UIView setAnimationCurve:<#curveType#>];
[UIView setAnimationRepeatAutoreverses:NO];
[UIView setAnimationTransition:transition forView:<#animationView#> cache:YES];
<#animation view change code#>
//[self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
[UIView commitAnimations];

```

## mksAnimationCATransition
```
CATransition *transition = [CATransition animation];
[transition setDelegate:<#CAAnimationDelegate#>];
transition.timingFunction = UIViewAnimationCurveEaseInOut;
[transition setFillMode:kCAFillModeForwards];
[transition setEndProgress:1.0];
[transition setDuration:1.0*transition.endProgress];
[transition setRemovedOnCompletion:NO];
// "cube","suckEffect","oglFlip",
// "rippleEffect","pageCurl","pageUnCurl",
// "cameraIrisHollowOpen","cameraIrisHollowClose"
[transition setType:<#type#>];
[self.view.layer addAnimation:transition forKey:@"animation"];
<#animation code here#>
//[self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];

```

## mksAnimationCATransitionSimple
```
CATransition *transition = [CATransition animation];
[transition setDuration:1.0];
transition.timingFunction = UIViewAnimationCurveEaseInOut;
[transition setFillMode:kCAFillModeForwards];
NSString *strSubType = kCATransitionFromTop;
[transition setType:kCATransitionPush];
[self.view.layer addAnimation:transition forKey:@"animation"];

```

## mksBaseAnimationAlpha
```
CABasicAnimation *alphaAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
[alphaAnim setFromValue:[NSNumber numberWithFloat:<#alphaFrom#>]];
[alphaAnim setToValue:[NSNumber numberWithFloat:<#alphaTo#>]];
[alphaAnim setRemovedOnCompletion:YES];
[<#view#>.layer addAnimation:alphaAnim forKey:<#key#>];

```

## mksBaseAnimationMove
```
CABasicAnimation *moveAnim = [CABasicAnimation animationWithKeyPath:@"position"];
[moveAnim setFromValue:[NSValue valueWithCGPoint:<#fromPoint#>]];
[moveAnim setToValue:[NSValue valueWithCGPoint:<#toPoint#>]];
[moveAnim setRemovedOnCompletion:YES];
[<#view#>.layer addAnimation:moveAnim forKey:<#key#>];

```

## mksBaseAnimationScale
```
CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
[scaleAnim setFromValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]];
// x，y轴缩小到0.1,Z 轴不变
[scaleAnim setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
[scaleAnim setRemovedOnCompletion:YES];
[<#view#>.layer addAnimation:scaleAnim forKey:<#key#>];

```

## mksKeyframeAnimationBezier
```
UIBezierPath *movePath = [UIBezierPath bezierPath];
[movePath moveFrPoint:<#fromPoint#>];
[movePath addQuadCurveToPoint:<#toPoint#> controlPoint:<#controlPoint#>];

CAKeyframeAnimation *keyframeAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
keyframeAnim.path = movePath.CGPath;
keyframeAnim.removedOnCompletion = YES;
[<#view#>.layer addAnimation:keyframeAnim forKey:<#key#>];

```

## mksAnimationGroup
```
CABasicAnimation *moveAnim = [CABasicAnimation animationWithKeyPath:@"position"];
moveAnim.toValue = [NSValue valueWithCGPoint:<#toPoint#>];


CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//x，y轴缩小到0.1,Z 轴不变
scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
scaleAnim.removedOnCompletion = YES;

CAAnimationGroup *animGroup = [CAAnimationGroup animation];
animGroup.animations = [NSArray arrayWithObjects:moveAnim, scaleAnim, nil];
animGroup.duration = 1;

[<#view#>.layer addAnimation:animGroup forKey:nil];

```

Refrence: https://github.com/tangqiaoboy/Xcode_tool
