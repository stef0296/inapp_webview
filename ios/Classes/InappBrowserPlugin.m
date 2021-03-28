#import "InappBrowserPlugin.h"
#if __has_include(<inapp_browser/inapp_browser-Swift.h>)
#import <inapp_browser/inapp_browser-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "inapp_browser-Swift.h"
#endif

@implementation InappBrowserPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftInappBrowserPlugin registerWithRegistrar:registrar];
}
@end
