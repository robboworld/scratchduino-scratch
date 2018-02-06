package uiwidgets {
import blocks.*;

import flash.display.*;
import flash.events.*;
import flash.geom.*;
import flash.net.*;
import flash.text.*;
import flash.utils.ByteArray;

import ui.parts.UIPart;
import ui.parts.CheckBox;

import util.*;

public class BlockColorSensorCorrector extends Sprite {

        private var base:Shape;
        private var blockShape:BlockShape;
        private var blockLabel:TextField;

        // Bright controls
        private var rBoxBright:EditableLabel;
        private var gBoxBright:EditableLabel;
        private var bBoxBright:EditableLabel;


        // Color controls
        private var rBoxColor:EditableLabel;
        private var gBoxColor:EditableLabel;
        private var bBoxColor:EditableLabel;


        private var rSliderBright:Scrollbar;
        private var gSliderBright:Scrollbar;
        private var bSliderBright:Scrollbar;

        private var rSliderColor:Scrollbar;
        private var gSliderColor:Scrollbar;
        private var bSliderColor:Scrollbar;


        // current bright correction
        private var r:Number;
        private var g:Number;
        private var b:Number;


        // current color correction
        private var rColor:Number;
        private var gColor:Number;
        private var bColor:Number;


        private var application:Scratch;

        public function BlockColorSensorCorrector(application:Scratch){
                this.application = application;
                addChild(base = new Shape());
                setWidthHeight(800, 500);




                addBrightCorrection();
                addColorCorrection();
                update();
        }

        private function setWidthHeight(w:int, h:int):void {
                var g:Graphics = base.graphics;
                g.clear();
                g.beginFill(CSS.white);
                g.drawRect(0, 0, w, h);
                g.endFill();
        }

        public function apply(b:IconButton):void {
        }


        private function addBrightCorrection():void {
                makeLabel('R', 15, 35,  0, true);
                makeLabel('G', 15, 110, 0, true);
                makeLabel('B', 15, 185, 0, true);

                addChild(rBoxBright = new EditableLabel(rTextChangedBright));
                addChild(gBoxBright = new EditableLabel(gTextChangedBright));
                addChild(bBoxBright = new EditableLabel(bTextChangedBright));

                addChild(rSliderBright = new Scrollbar(10, 300, setr));
                addChild(gSliderBright = new Scrollbar(10, 300, setg));
                addChild(bSliderBright = new Scrollbar(10, 300, setb));

                rBoxBright.setWidth(50);
                gBoxBright.setWidth(50);
                bBoxBright.setWidth(50);

                rBoxBright.x = 25;
                gBoxBright.x = 100;
                bBoxBright.x = 175;
                rBoxBright.y = gBoxBright.y = bBoxBright.y = 25;

                rSliderBright.x = rBoxBright.x + 20;
                gSliderBright.x = gBoxBright.x + 20;
                bSliderBright.x = bBoxBright.x + 20;
                rSliderBright.y = gSliderBright.y = bSliderBright.y = rBoxBright.y + 30;

                r = application.colorCorrectionBrightR;
                g = application.colorCorrectionBrightG;
                b = application.colorCorrectionBrightB;
        }
        private function addColorCorrection():void {
                makeLabel('R', 15, 300, 0, true);
                makeLabel('G', 15, 375, 0, true);
                makeLabel('B', 15, 450, 0, true);

                addChild(rBoxColor = new EditableLabel(rTextChangedColor));
                addChild(gBoxColor = new EditableLabel(gTextChangedColor));
                addChild(bBoxColor = new EditableLabel(bTextChangedColor));

                addChild(rSliderColor = new Scrollbar(10, 300, setColorR));
                addChild(gSliderColor = new Scrollbar(10, 300, setColorG));
                addChild(bSliderColor = new Scrollbar(10, 300, setColorB));

                rBoxColor.setWidth(50);
                gBoxColor.setWidth(50);
                bBoxColor.setWidth(50);

                rBoxColor.x = 282;
                gBoxColor.x = 357;
                bBoxColor.x = 432;
                rBoxColor.y = gBoxColor.y = bBoxColor.y = 25;

                rSliderColor.x = rBoxColor.x + 20;
                gSliderColor.x = gBoxColor.x + 20;
                bSliderColor.x = bBoxColor.x + 20;
                rSliderColor.y = gSliderColor.y = bSliderColor.y = rBoxColor.y + 30;


                var cb:CheckBox = new CheckBox();
                cb.x = 104;
                cb.y = 67;
                addChild(cb);

                rColor = application.colorCorrectionColorR;
                gColor = application.colorCorrectionColorG;
                bColor = application.colorCorrectionColorB;
        }


        private function update():void {
                r = Math.max(0, Math.min(r, 1));
                g = Math.max(0, Math.min(g, 1));
                b = Math.max(0, Math.min(b, 1));

                rBoxBright.setContents('' + Math.round(100 * r));
                gBoxBright.setContents('' + Math.round(100 * g));
                bBoxBright.setContents('' + Math.round(100 * b));

                rBoxColor.setContents('' + Math.round(100 * 3 * rColor));
                gBoxColor.setContents('' + Math.round(100 * 3 * gColor));
                bBoxColor.setContents('' + Math.round(100 * 3 * bColor));


                rSliderBright.update(r, 0.08);
                gSliderBright.update(g, 0.08);
                bSliderBright.update(b, 0.08);


                rSliderColor.update(rColor, 0.08);
                gSliderColor.update(gColor, 0.08);
                bSliderColor.update(bColor, 0.08);


                application.setColorSensorCorrection(r, g, b);
        }

        private function rTextChangedBright():void{
                var n:Number = Number(rBoxBright.contents());
                if (n == n) r = n / 100;
                update();
        }
        private function gTextChangedBright():void{
                var n:Number = Number(gBoxBright.contents());
                if (n == n) g = n / 100;
                update();
        }
        private function bTextChangedBright():void{
                var n:Number = Number(bBoxBright.contents());
                if (n == n) b = n / 100;
                update();
        }
        private function rTextChangedColor():void{
                var n:Number = Number(rBoxColor.contents());
                if (n == n) rColor = n / 300;
                update();
        }
        private function gTextChangedColor():void{
                var n:Number = Number(gBoxColor.contents());
                if (n == n) gColor = n / 300;
                update();
        }
        private function bTextChangedColor():void{
                var n:Number = Number(bBoxColor.contents());
                if (n == n) bColor = n / 300;
                update();
        }


        private function setr(n:Number):void { r = n; update() }
        private function setg(n:Number):void { g = n; update() }
        private function setb(n:Number):void { b = n; update() }

        private function setColorR(n:Number):void{
           rColor = n;
           bColor = gColor = 1 - rColor;
           update();
        }
        private function setColorG(n:Number):void { gColor = n; update() }
        private function setColorB(n:Number):void { bColor = n; update() }


        private function makeLabel(s:String, fontSize:int, x:int = 0, y:int = 0, bold:Boolean = false):TextField {
                var tf:TextField = new TextField();
                tf.selectable = false;
                tf.defaultTextFormat = new TextFormat(CSS.font, fontSize, CSS.textColor, bold);
                tf.autoSize = TextFieldAutoSize.LEFT;
                tf.text = s;
                tf.x = x;
                tf.y = y;
                addChild(tf);
                return tf;
        }

}}
