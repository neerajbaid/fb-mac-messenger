#import "FBMApplication.h"
#import "AppDelegate.h"

@implementation FBMApplication

- (void)sendEvent:(NSEvent*)event {
    if (event.type == NSKeyDown) {
        auto chars = event.charactersIgnoringModifiers;
        if (event.modifierFlags & NSCommandKeyMask) {
            if (chars.length == 1) {
                switch ([chars characterAtIndex:0]) {
                    case u'1' ... u'9': { // Cmd-1 .. Cmd-9
                        [((AppDelegate*)self.delegate) setActiveConversationAtIndex:event.characters];
                        return;
                    }
                    case u'[': {
                        [((AppDelegate*)self.delegate) incrementActiveConversationIndexBy:-1];
                        break;
                    }
                    case u']': {
                        [((AppDelegate*)self.delegate) incrementActiveConversationIndexBy:1];
                        break;
                    }
                    default: {
                        break;
                    }
                }
            }
        } else if (event.modifierFlags & NSControlKeyMask) {
            if (event.modifierFlags & NSShiftKeyMask) {
                if (chars.length == 1) {
                    switch ([chars characterAtIndex:0]) {
                        case 25: // shift tab seems to be a different character than normal tab
                            [((AppDelegate*)self.delegate) incrementActiveConversationIndexBy:-1];
                            break;
                        default:
                            break;
                    }
                }
            } else {
                if (chars.length == 1) {
                    switch ([chars characterAtIndex:0]) {
                        case u'	':
                            [((AppDelegate*)self.delegate) incrementActiveConversationIndexBy:1;
                            break;
                        default:
                            break;
                    }
                }
            }
        }
    }
    [super sendEvent:event];
}

@end
