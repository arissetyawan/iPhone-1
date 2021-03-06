#import "SessionDeserializer.h"
#import "Session.h"
#import "Speaker.h"
#import "JSON.h"

@implementation SessionDeserializer

- (NSArray *)parseJsonAndReturnSessions:(NSString *)html {
    NSArray* json = [html JSONValue];
    
    NSArray* items = [json valueForKeyPath:@"d.data"];
    
    NSMutableArray* sessions = [NSMutableArray array];
    for (NSDictionary *item in items) {
        Session* session = [[Session alloc] init];
        
        [session setSession:[item objectForKey:@"session"]];
        [session setTime:[item objectForKey:@"time"]];
        [session setDesc:[item objectForKey:@"desc"]];
        [session setRoom:[item objectForKey:@"room"]];
        
        NSDictionary *spkr = [item objectForKey:@"speaker"];
        NSString* name = [spkr objectForKey:@"name"];
        NSString* bio = [spkr objectForKey:@"bio"];
        NSString* img = [spkr objectForKey:@"img"];
        NSString* web = [spkr objectForKey:@"web"];
        NSString* location = [spkr objectForKey:@"location"];
        
        Speaker* speaker = [[Speaker alloc] init];
        [speaker setName:name];
        [speaker setBio:bio];
        [speaker setImg:img];
        [speaker setWeb:web];
        [speaker setLocation:location];
        
        [session setSpeaker:speaker];
        
        [sessions addObject:session];
        
        [speaker release];
        [session release];
    }
    
    return sessions;
}

@end
