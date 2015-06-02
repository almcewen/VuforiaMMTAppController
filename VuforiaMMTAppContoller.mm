
#import "UnityAppController.h"
#import "VuforiaRenderDelegate.h"
#import <UIKit/UIKit.h>



// Unity native rendering callback plugin mechanism is only supported
// from version 4.5 onwards
#if UNITY_VERSION>434

// Exported methods for native rendering callback
extern "C" void UnityRenderEvent(int marker);

#endif

extern "C" void MMTUnitySetGraphicsDevice(void* device, int deviceType, int eventType);
extern "C" void MMTUnityRenderEvent(int marker);

// Controller to support native rendering callback
@interface VuforiaMMTAppController : UnityAppController
{
}
- (void)shouldAttachRenderDelegate;
@end

@implementation VuforiaMMTAppController

- (void)shouldAttachRenderDelegate
{
    self.renderDelegate = [[VuforiaRenderDelegate alloc] init];
    
    // Unity native rendering callback plugin mechanism is only supported
    // from version 4.5 onwards
#if UNITY_VERSION>434
    UnityRegisterRenderingPlugin(NULL, &UnityRenderEvent);
    UnityRegisterRenderingPlugin(&MMTUnitySetGraphicsDevice, &MMTUnityRenderEvent);
#endif
}
@end


IMPL_APP_CONTROLLER_SUBCLASS(VuforiaMMTAppController)

