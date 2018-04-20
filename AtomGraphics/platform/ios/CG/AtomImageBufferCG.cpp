//
// Created by neo on 2018/4/20.
// Copyright (c) 2018 neo. All rights reserved.
//

#include "AtomImageBufferCG.h"
#include <CoreGraphics/CGBitmapContext.h>

static void releaseImageData(void *, const void *data, size_t) {
//    delete data;
}


namespace AtomGraphics {

    ImageBufferCG::ImageBufferCG(size_t width, size_t height, size_t bytesPerRow) {
        m_backingStoreWidth = width;
        m_backingStoreHeight = height;
        m_bytesPerRow = bytesPerRow;
        m_data = malloc(m_bytesPerRow * m_backingStoreHeight);
        m_DataProvider = CGDataProviderCreateWithData(0, m_data, height * m_bytesPerRow, releaseImageData);
    }

    PlatformContext ImageBufferCG::createGraphicsContext() {
//        CGBitmapContextCreateWithData(m_data, m_backingStoreWidth, m_backingStoreHeight, 8, m_bytesPerRow, CGColorSpaceCreateDeviceRGB(), kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrder32Host, releaseBitmapContextData, this);
        return CGBitmapContextCreate(m_data, m_backingStoreWidth, m_backingStoreHeight, 8, m_bytesPerRow, CGColorSpaceCreateDeviceRGB(), kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Host);
    }

    void ImageBufferCG::releaseBitmapContextData(void *typelessBitmap, void *typelessData) {

    }

}