//
// Created by neo on 2018/4/11.
// Copyright (c) 2018 neo. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>
#import "AtomJavaScriptCore.h"
#import "AtomJSTimer.h"


//TODO: improve implement and move to AtomTypes
static inline Color4F colorWithRgba(NSString *rgba) {
    Color4F color;
    if (!rgba) {
        return color;
    }
    rgba = [rgba stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *regex = @"\\d+([.]\\d+)?";
    NSError *error = nil;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regular matchesInString:rgba options:NSMatchingReportProgress range:NSMakeRange(0, [rgba length])];
    NSString *red, *green, *blue, *alpha;
    if (!error && [matches count] > 2) {
        red = [rgba substringWithRange:[matches[0] range]];
        green = [rgba substringWithRange:[matches[1] range]];
        blue = [rgba substringWithRange:[matches[2] range]];
        if ([matches count] > 3) {
            alpha = [rgba substringWithRange:[matches[3] range]];
        } else {
            alpha = @"1.0";
        }
        if ([rgba hasPrefix:@"rgb"]) {
            color.r = red.floatValue / 255;
            color.g = green.floatValue / 255;
            color.b = blue.floatValue / 255;
            color.a = alpha.floatValue;
        } else {
            color.r = red.floatValue;
            color.g = green.floatValue;
            color.b = blue.floatValue;
            color.a = alpha.floatValue;
        }
    }

    return color;
}

@protocol CanvasContextJavaScriptInterfaceExport <JSExport>

@property(nonatomic, copy) NSString *fillStyle;

@property(nonatomic, assign) float lineWidth;

@property(nonatomic, copy) NSString *lineCap;

@property(nonatomic, copy) NSString *lineJoin;

@property(nonatomic, assign) float miterLimit;

@property(nonatomic, assign) float globalAlpha;

@property(nonatomic, copy) NSString *globalCompositeOperation;

// e.g. "40px Arial";
@property(nonatomic, copy) NSString *font;

@property(nonatomic, copy) NSString *textAlign;

@property(nonatomic, copy) NSString *textBaseline;

- (void)beginPath;

- (void)arc:(float)x :(float)y :(float)r :(float)sAngle :(float)eAngle :(bool)counterclockwise;

- (void)stroke;

- (void)fill;

- (void)moveTo:(float)x :(float)y;

- (void)lineTo:(float)x :(float)y;

- (void)rect:(float)x :(float)y :(float)width :(float)height;

- (void)fillRect:(float)x :(float)y :(float)width :(float)height;

- (void)strokeRect:(float)x :(float)y :(float)width :(float)height;

- (void)clearRect:(float)x :(float)y :(float)width :(float)height;

- (void)clip;

- (void)quadraticCurveTo:(float)cpx :(float)cpy :(float)x :(float)y;

- (void)bezierCurveTo:(float)cp1x :(float)cp1y :(float)cp2x :(float)cp2y :(float)x :(float)y;

- (void)arcTo:(float)x1 :(float)y1 :(float)x2 :(float)y2 :(float)r;

- (void)scale:(float)scaleWidth :(float)scaleHeight;

- (void)rotate:(double)angle;

- (void)translate:(float)x :(float)y;

- (void)transform:(float)a :(float)b :(float)c :(float)d :(float)e :(float)f;

- (void)setTransform:(float)a :(float)b :(float)c :(float)d :(float)e :(float)f;

- (void)fillText:(NSString *)text :(float)x :(float)y :(float)maxWidth;

- (void)strokeText:(NSString *)text :(float)x :(float)y :(float)maxWidth;

@end

@interface CanvasContextJavaScriptInterface : NSObject <CanvasContextJavaScriptInterfaceExport>

@end

@implementation CanvasContextJavaScriptInterface {
    CanvasContext2d *_canvasContext2d;
}

- (instancetype)initWithCanvasContext:(CanvasContext2d *)pCanvasContext2d {
    self = [super init];
    if (self) {
        _canvasContext2d = pCanvasContext2d;
    }

    return self;
}

- (NSString *)fillStyle {
    return @"";
}


- (void)setFillStyle:(NSString *)fillStyle {
    _canvasContext2d->setFillStyle(colorWithRgba(fillStyle));
}

- (void)beginPath {
    _canvasContext2d->beginPath();
}

- (void)arc:(float)x :(float)y :(float)r :(float)sAngle :(float)eAngle :(bool)counterclockwise {
    _canvasContext2d->arc(x, y, r, sAngle, eAngle, counterclockwise);
}


- (void)stroke {
    _canvasContext2d->stroke();
}

- (void)fill {
    _canvasContext2d->fill();
}

- (void)moveTo:(float)x :(float)y {
    _canvasContext2d->moveTo(x, y);
}

- (void)lineTo:(float)x :(float)y {
    _canvasContext2d->lineTo(x, y);
}

- (float)lineWidth {
    return 0;
}

- (void)setLineWidth:(float)lineWidth {
    _canvasContext2d->setLineWidth(lineWidth);
}

- (NSString *)lineCap {
    return @"";
}

- (void)setLineCap:(NSString *)lineCap {
    _canvasContext2d->setLineCap(std::string([lineCap UTF8String]));
}

- (NSString *)lineJoin {
    return @"";
}

- (void)setLineJoin:(NSString *)lineJoin {
    _canvasContext2d->setLineJoin(std::string([lineJoin UTF8String]));
}

- (float)miterLimit {
    return 0;
}

- (void)setMiterLimit:(float)miterLimit {
    _canvasContext2d->setMiterLimit(miterLimit);
}

- (void)rect:(float)x :(float)y :(float)width :(float)height {
    _canvasContext2d->setRect(x, y, width, height);
}

- (void)fillRect:(float)x :(float)y :(float)width :(float)height {
    _canvasContext2d->fillRect(x, y, width, height);
}

- (void)strokeRect:(float)x :(float)y :(float)width :(float)height {
    _canvasContext2d->strokeRect(x, y, width, height);
}

- (void)clearRect:(float)x :(float)y :(float)width :(float)height {
    _canvasContext2d->clearRect(x, y, width, height);
}

- (void)clip {
    _canvasContext2d->clip();
}

- (void)quadraticCurveTo:(float)cpx :(float)cpy :(float)x :(float)y {
    _canvasContext2d->quadraticCurveTo(cpx, cpy, x, y);
}

- (void)arcTo:(float)x1 :(float)y1 :(float)x2 :(float)y2 :(float)r {
    _canvasContext2d->arcTo(x1, y1, x2, y2, r);
}

- (void)scale:(float)scaleWidth :(float)scaleHeight {
    _canvasContext2d->scale(scaleWidth, scaleHeight);
}

- (void)rotate:(double)angle {
    _canvasContext2d->rotate(angle);
}

- (void)translate:(float)x :(float)y {
    _canvasContext2d->translate(x, y);
}

- (void)transform:(float)a :(float)b :(float)c :(float)d :(float)e :(float)f {
    _canvasContext2d->transform(a, b, c, d, e, f);
}

- (void)setTransform:(float)a :(float)b :(float)c :(float)d :(float)e :(float)f {
    _canvasContext2d->setTransform(a, b, c, d, e, f);
}

- (void)fillText:(NSString *)text :(float)x :(float)y :(float)maxWidth {
    _canvasContext2d->fillText(std::string([text UTF8String]), x, y, maxWidth);
}

- (NSString *)font {
    return @"";
}

- (void)setFont:(NSString *)font {
    _canvasContext2d->setFont(std::string([font UTF8String]));
}

- (NSString *)textAlign {
    return @"";
}

- (void)setTextAlign:(NSString *)textAlign {
    _canvasContext2d->setTextAlign(std::string([textAlign UTF8String]));
}

- (NSString *)textBaseline {
    return @"";
}

- (void)setTextBaseline:(NSString *)textBaseline {
    _canvasContext2d->setTextBaseline(std::string([textBaseline UTF8String]));
}

- (void)strokeText:(NSString *)text :(float)x :(float)y :(float)maxWidth {
    _canvasContext2d->strokeText(std::string([text UTF8String]), x, y, maxWidth);
}

- (float)globalAlpha {
    return 0;
}

- (void)setGlobalAlpha:(float)globalAlpha {
    _canvasContext2d->setGlobalAlpha(globalAlpha);
}

- (NSString *)globalCompositeOperation {
    return @"";
}

- (void)setGlobalCompositeOperation:(NSString *)globalCompositeOperation {
    _canvasContext2d->setGlobalCompositeOperation(std::string([globalCompositeOperation UTF8String]));
}

- (void)bezierCurveTo:(float)cp1x :(float)cp1y :(float)cp2x :(float)cp2y :(float)x :(float)y {
    _canvasContext2d->bezierCurveTo(cp1x, cp1y, cp2x, cp2y, x, y);
}
@end

@protocol CanvasJavaScriptInterfaceExport <JSExport>

- (CanvasContextJavaScriptInterface *)getContext:(NSString *)contentType;

@end

@interface CanvasJavaScriptInterface : NSObject <CanvasJavaScriptInterfaceExport>

@end

@implementation CanvasJavaScriptInterface {
    CanvasNode *_canvasNode;
}

- (instancetype)initWithCanvasNode:(CanvasNode *)canvasNode {
    self = [super init];
    if (self) {
        _canvasNode = canvasNode;
    }

    return self;
}

- (CanvasContextJavaScriptInterface *)getContext:(NSString *)contentType {
    return [[CanvasContextJavaScriptInterface alloc] initWithCanvasContext:_canvasNode->getContext2d()];
}


@end


@interface AtomJavaScriptCore ()

@property(nonatomic, strong) JSContext *jsContext;

@property(nonatomic, strong) CanvasJavaScriptInterface *canvasJavaScriptInterface;

@end

@implementation AtomJavaScriptCore {

}

- (instancetype)initWithCanvasNode:(CanvasNode *)canvasNode {
    self = [super init];
    if (self) {
        _canvasJavaScriptInterface = [[CanvasJavaScriptInterface alloc] initWithCanvasNode:canvasNode];
//        TODO:
//        JSGlobalContextRef ctx = JSGlobalContextCreate()
//        _jsContext= [JSContext contextWithJSGlobalContextRef:ctx];
        NSString *jsCoreFilePath = [[NSBundle mainBundle] pathForResource:@"core" ofType:@"js"];
        if (jsCoreFilePath) {
            _jsContext = [[JSContext alloc] init];
            [_jsContext evaluateScript:[NSString stringWithContentsOfFile:jsCoreFilePath]];
            [self initGlobalContext];
            [AtomJSTimer initJSTimers:_jsContext];
        }
    }

    return self;
}


- (void)initGlobalContext {

    JSValue *AG = _jsContext[@"AG"];
    [AG  setValue:^() {
        return _canvasJavaScriptInterface;
    } forProperty:@"getRootCanvasNode"];
}

- (void)runScriptFile:(NSString *)path {
    if (path) {
        [_jsContext evaluateScript:[NSString stringWithContentsOfFile:path]];
    }
}

@end

