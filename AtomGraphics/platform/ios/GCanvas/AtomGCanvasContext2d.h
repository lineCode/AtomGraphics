//
// Created by neo on 2018/4/9.
// Copyright (c) 2018 neo. All rights reserved.
//

#ifndef ATOMCANVASCONTEXT2DGL_H
#define ATOMCANVASCONTEXT2DGL_H


#include "AtomCanvasContext2d.h"

namespace AtomGraphics {

    class GCanvasContext2d : public CanvasContext2d {

    public:
        void setFillStyle(const Color4F &color) override;

        void setFillStyle(const CanvasPattern &pattern) override;

        void setFillStyle(const CanvasGradient &gradient) override;

        void setStrokeStyle(const Color4F &color) override;

        void setStrokeStyle(const CanvasPattern &pattern) override;

        void setStrokeStyle(const CanvasGradient &gradient) override;

        void setShadowColor() override;

        void setShadowBlur() override;

        void setShadowOffsetX() override;

        void setShadowOffsetY() override;

        CanvasPattern *createPattern() override;

        CanvasGradient *createLinearGradient(float x0, float y0, float x1, float y1) override;

        void *createRadialGradient() override;

        void setLineCap(const std::string lineCap) override;

        void setLineJoin(const std::string lineJoin) override;

        void setLineWidth(float width) override;

        void setMiterLimit(float limit) override;

        void setRect(float x, float y, float width, float height) override;

        void fillRect(float x, float y, float width, float height) override;

        void strokeRect(float x, float y, float width, float height) override;

        void clearRect(float x, float y, float width, float height) override;

        void fill() override;

        void stroke() override;

        void beginPath() override;

        void moveTo(float x, float y) override;

        void closePath() override;

        void lineTo(float x, float y) override;

        void clip() override;

        void quadraticCurveTo(float cpx, float cpy, float x, float y) override;

        void bezierCurveTo(float cp1x, float cp1y, float cp2x, float cp2y, float x, float y) override;

        void arc(float x, float y, float r, float sAngle, float eAngle, bool counterclockwise) override;

        void arcTo(float x1, float y1, float x2, float y2, float r) override;

        void isPointInPath(float x, float y) override;

        void scale(float scaleWidth, float scaleHeight) override;

        void rotate(double angle) override;

        void translate(float x, float y) override;

        void transform(float a, float b, float c, float d, float e, float f) override;

        void setTransform(float a, float b, float c, float d, float e, float f) override;

        void setFont(const std::string font) override;

        void setTextAlign(const std::string textAlign) override;

        void setTextBaseline(const std::string textBaseline) override;

        void fillText(std::string text, float x, float y, float maxWidth) override;

        void strokeText(const std::string text, float x, float y, float maxWidth) override;

        void *measureText(const std::string &text) override;

        void *drawImage(ImageBuffer *imageBuffer, float x, float y) override;

        void *drawImage(ImageBuffer *imageBuffer, float x, float y, float with, float height) override;

        void *drawImage(ImageBuffer *imageBuffer, float sx, float sy, float swith, float sheight, float x, float y, float width, float height) override;

        void *createImageData(float width, float height) override;

        void *createImageData(void *imageData) override;

        void setGlobalAlpha(float number) override;

        void setGlobalCompositeOperation(const std::string operation) override;

        void save() override;

        void restore() override;

        void createEvent() override;

        void *toDataURL() override;

        void addCommand(const std::string &command);

        void *executeCommand(const std::string &command);

        void setComponentID(const std::string &componentID);

    private:
        std::string _componentId;
    };

}

#endif //ATOMCANVASCONTEXT2DGL_H
