/*   Copyright 2014 APPNEXUS INC
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "ANAdAdapterBannerFacebook.h"

@interface ANAdAdapterBannerFacebook()

@property (nonatomic, strong) FBAdView *fbAdView;

@end

@implementation ANAdAdapterBannerFacebook

@synthesize delegate;

- (void)requestBannerAdWithSize:(CGSize)size
             rootViewController:(UIViewController *)rootViewController
                serverParameter:(NSString *)parameterString
                       adUnitId:(NSString *)idString
            targetingParameters:(ANTARGETINGPARAMETERS *)targetingParameters {
    self.fbAdView = [[FBAdView alloc] initWithPlacementID:idString
                                                   adSize:kFBAdSize320x50
                                       rootViewController:rootViewController];
    self.fbAdView.delegate = self;
    [self.fbAdView loadAd];
}
 
#pragma mark FBAdViewDelegate methods

- (void)adView:(FBAdView *)adView didFailWithError:(NSError *)error {
    NSLog(@"Facebook banner failed to load with error: %@", error);
    ANAdResponseCode code = ANAdResponseInternalError;
    if (error.code == 1001) {
        code = ANAdResponseUnableToFill;
    }
    [self.delegate didFailToLoadAd:(ANADRESPONSECODE)code];
}

- (void)adViewDidLoad:(FBAdView *)adView {
    [self.delegate didLoadBannerAd:adView];
}

- (void)adViewDidClick:(FBAdView *)adView {
    [self.delegate adWasClicked];
}

@end