

#import <MapKit/MapKit.h>

// I've took it from http://stackoverflow.com/a/9219856/452641

@interface MKPolyline (EncodedString)

+ (MKPolyline *)polylineWithEncodedString:(NSString *)encodedString;

@end
