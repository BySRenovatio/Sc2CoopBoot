#include <AutoItConstants.au3>

HotKeySet("{END}", "Quit")
HotKeySet("{Home}", "Start")
HotKeySet("{TAB}", "pozitie")
HotKeySet("{F2}", "showChecks")

Global $Xx = 1920
Global $Yy = 0
Global $base = 0
Global $gameTime = 0

Global $xRegionIngame = 380
Global $yRegionIngame = 1010
Global $RegionIngame = 23789569

Global $xBase1Pixel = 83
Global $yBase1Pixel = 967
Global $Base1Pixel = 195822017

Global $xBase2Pixel = 109
Global $yBase2Pixel = 995
Global $Base2Pixel = 195822017

Global $xHatch1 = 1100
Global $yHatch1 = 420
Global $xHatch2 = 1040
Global $yHatch2 = 345

Global $xMineralsB1 = 555
Global $yMineralsB1 = 445
Global $xMineralsB2 = 525
Global $yMineralsB2 = 660

Global $xToolTip = 165
Global $yToolTip = 770

Global $z1X = 150
Global $z1Y = 930
Global $z2X = 120
Global $z2Y = 840
Global $z3X = 245
Global $z3Y = 975
Global $z4X = 210
Global $z4Y = 875

Global $xPlay = 215
Global $yPlay = 950
Global $xLeave = 225
Global $yLeave = 845
Global $xKerryFace = 55
Global $yKerryFace = 50
Global $xKerryPLife = 175
Global $yKerryPLife = 59
Global $VKerryLife = 359662385

Global $xOvieB1 = 1080
Global $yOvieB1 = 115
Global $xOvieB2 = 1070
Global $yOvieB2 = 70

Global $xBaseRamp = 120
Global $yBaseRamp = 960

Global $selWxB1 = 500
Global $selWyB1 = 400
Global $selWxxB1 = 750
Global $selWyyB1 = 735
Global $selWxB2 = 520
Global $selWyB2 = 650
Global $selWxxB2 = 1140
Global $selWyyB2 = 815

Global $xWorker = 690
Global $yWorker = 915
Global $xWorkerOff = 60
Global $xbRallyOvie = 60
Global $ybRallyOvie = 1020

Global $xb1Pool = 785
Global $yb1Pool = 175
Global $xb1Hatch2 = 1270
Global $yb1Hatch2 = 450
Global $xb1Evo1 = 1030
Global $yb1Evo1 = 840
Global $xb1Evo2 = 1245
Global $yb1Evo2 = 840
Global $xb1Gas1 = 620
Global $yb1Gas1 = 175
Global $xb1Gas2 = 820
Global $yb1Gas2 = 845
Global $xb1Hydra = 960
Global $yb1Hydra = 175

Global $xb2Pool = 540
Global $yb2Pool = 305
Global $xb2Hatch2 = 1270
Global $yb2Hatch2 = 450
Global $xb2Evo1 = 335
Global $yb2Evo1 = 450
Global $xb2Evo2 = 360
Global $yb2Evo2 = 300
Global $xb2Gas1 = 520
Global $yb2Gas1 = 450
Global $xb2Gas2 = 1310
Global $yb2Gas2 = 840
Global $xb2Hydra = 715
Global $yb2Hydra = 305


While 1
	Sleep(1000)
WEnd


Func Quit()
    Beep(500,100)
    Exit 0
EndFunc


Func pozitie()
	Local $aPos = MouseGetPos()
	ToolTip('X: ' & $aPos[0] - $Xx & ', Y: ' & $aPos[1] - $Yy)
 EndFunc


 Func showChecks()
	Local $check = PixelChecksum($Xx + 00, $Yy + 00, $Xx + 00 + 1, $Yy + 00 + 1)
	ToolTip($check)
 EndFunc


 Func SetDelay()
    ;;;; Set Delay
    AutoItSetOption("MouseClickDelay", 20)
    AutoItSetOption("MouseClickDownDelay", 20)
    AutoItSetOption("SendKeyDelay", 10)
    AutoItSetOption("SendKeyDownDelay", 10)
	AutoItSetOption("MouseClickDragDelay", 100)
EndFunc


Func SayGlHf()
	Send("{ENTER}")
	Sleep(100)

	Send("Hey, Gl Hf <3")
	Sleep(100)

	Send("{ENTER}")
	Sleep(100)
 EndFunc


 Func Click_Play()
	MouseClick("left", $Xx + $xPlay, $Yy + $yPlay, 1, 0)
	Sleep(500)
 EndFunc

Func Click_Leave()
    MouseClick("left", $Xx + $xLeave, $Yy + $yLeave, 1, 0)
    Sleep(2000)

    Start()
EndFunc


Func Start()
	Local $checkMenu = 0
    Local $sw = 0

	SetDelay()
    Click_Play()

    $sw = 0
    While $sw < 360
	   $checkMenu = PixelChecksum($Xx + $xRegionIngame, $Yy + $yRegionIngame, $Xx + $xRegionIngame + 10, $Yy + $yRegionIngame + 10)
	   If $checkMenu = $RegionIngame Then
		  GameStarted()
	   EndIf

	   Sleep(1000)
	   $sw += 1
    WEnd

    Start()
 EndFunc


 Func GameStarted()
    Local $stillIngame = 0
    Local $basePoz1 = 0
    Local $basePoz2 = 0

    $gameTime = 0

	SayGlHf()
	Sleep(2000)

    While 1
	  $stillIngame = PixelChecksum($Xx + $xRegionIngame, $Yy + $yRegionIngame, $Xx + $xRegionIngame + 10, $Yy + $yRegionIngame + 10)
	  Sleep(100)
	  $basePoz1 = PixelChecksum($Xx + $xBase1Pixel, $Yy + $yBase1Pixel, $Xx + $xBase1Pixel + 1, $Yy + $yBase1Pixel + 1)
	  Sleep(100)
	  $basePoz2 = PixelChecksum($Xx + $xBase2Pixel, $Yy + $yBase2Pixel, $Xx + $xBase2Pixel + 1, $Yy + $yBase2Pixel + 1)
	  Sleep(100)

	  If $stillIngame = $RegionIngame OR $basePoz1 = $Base1Pixel OR $basePoz2 = $Base2Pixel Then
		 ToolTip("Time: " & $gameTime, $Xx + $xToolTip, $Yy + $yToolTip)
	  Else
		 Sleep(18000)
		 Send("{s}")
		 Sleep(22000)
		 Click_Leave()
	  EndIf

	  If $gameTime = 3 Then
		 If $basePoz1 = $Base1Pixel Then
			$base = 1

			;;; Click Hatch
			MouseClick("left", $Xx + $xHatch1, $Yy + $yHatch1, 2, 0)
			Sleep(200)

			;;; Put on 4, 5
			Send("^4")
			Sleep(200)
			Send("^5")
			Sleep(200)

			;;; Center
			Send("4")
			Send("4")
			Sleep(200)
		 EndIf

		 If $basePoz2 = $Base2Pixel Then
			$base = 2

			;;; Click Hatch
			MouseClick("left", $Xx + $xHatch2, $Yy + $yHatch2, 2, 0)
			Sleep(200)

			;;; Put on 4, 5
			Send("^4")
			Sleep(200)
			Send("^5")
			Sleep(200)

			;;; Center
			Send("4")
			Send("4")
			Sleep(200)
		 EndIf
	  EndIf

	  If $gameTime = 5 Then
		MoveOvie()
	  EndIf

	  If $gameTime = 12 Then
		BuildDrone()
		BuildDrone()
		BuildOvie()
	  EndIf

	  If $gameTime = 27 Then
		BuildPool()
		BuildGas1()
		BuildGas2()
	  EndIf

	  If $gameTime = 30 Then
		PopGases()
		BuildHatch2()
		BuildDrone()
		BuildDrone()
		BuildDrone()
		BuildDrone()
	  EndIf

	  If $gameTime = 40 Then
		BuildEvo1()
		BuildEvo2()
		UpgradeLair()
		BuildOvie()
		RallyDrones()
	  EndIf

	  If $gameTime = 60 Then
		BuildDrone()
		BuildDrone()
		BuildDrone()
		BuildDrone()
		BuildDrone()
		BuildDrone()
	  EndIf

	  If $gameTime = 80 Then
	    EvoUpgradeK1()
		EvoUpgradeK2()
		EvoUpgradeA()
		EvoUpgradeD()
		BuildHydra()
	    UpgradeHive()
	  EndIf

	  If $gameTime = 110 Then
		BuildDrone()
		BuildDrone()
		BuildDrone()
		BuildOvie()
		BuildOvie()
	  EndIf

	  If $gameTime = 125 Then
		HydraUpgrade1()
		HydraUpgrade2()
		HydraUpgrade3()
		EvoUpgradeA()
		EvoUpgradeD()
		EvoUpgradeK3()
	  EndIf

	  If $gameTime = 175 Then
		EvoUpgradeA()
		EvoUpgradeD()
	  EndIf

	  If $gameTime >= 180 AND MOD($gameTime, 5) = 0 Then
		BuildHydras()
	  EndIf

	  If $gameTime >= 44 AND MOD($gameTime, 2) = 0 Then
		AMove()
	  EndIf

	  $gameTime += 1
	  Sleep(1000)
   WEnd
EndFunc


Func EvoUpgradeA()
	Send("6")
	Sleep(200)
	Send("a")
	Sleep(200)
EndFunc

Func EvoUpgradeD()
	Send("6")
	Sleep(200)
	Send("c")
	Sleep(200)
EndFunc

Func EvoUpgradeK1()
	Send("6")
	Sleep(200)
	Send("f")
	Sleep(200)
EndFunc

Func EvoUpgradeK2()
	Send("6")
	Sleep(200)
	Send("r")
	Sleep(200)
EndFunc

Func EvoUpgradeK3()
	Send("6")
	Sleep(200)
	Send("e")
	Sleep(200)
EndFunc

Func HydraUpgrade1()
	Send("7")
	Sleep(200)
	Send("a")
	Sleep(200)
EndFunc

Func HydraUpgrade2()
	Send("7")
	Sleep(200)
	Send("c")
	Sleep(200)
EndFunc

Func HydraUpgrade3()
	Send("7")
	Sleep(200)
	Send("f")
	Sleep(200)
EndFunc


 Func UpgradeLair()
   Send("4")
   Sleep(200)
   Send("l")
   Sleep(200)
EndFunc

Func UpgradeHive()
   Send("4")
   Sleep(200)
   Send("h")
   Sleep(200)
EndFunc


Func BuildDrone()
   Send("5")
   Sleep(200)
   Send("s")
   Sleep(200)
   Send("d")
   Sleep(100)
EndFunc

Func BuildOvie()
   Send("5")
   Sleep(200)
   Send("s")
   Sleep(200)
   Send("v")
   Sleep(200)
   MouseClick("right", $Xx + $xbRallyOvie, $Yy + $ybRallyOvie, 1, 0)
   Sleep(100)
EndFunc

Func BuildHydras()
	Send("5")
	Sleep(200)
	Send("s")
	Sleep(200)

	Send("h")
	Sleep(200)
	Send("h")
	Sleep(200)
	Send("h")
	Sleep(200)
	Send("h")
	Sleep(200)

	;;; rally Kerrigan
	MouseClick("right", $Xx + $xKerryFace, $Yy + $yKerryFace, 1, 0)
	Sleep(300)

	BuildOvie()
EndFunc


Func MoveOvie()
	If $base = 1 Then
		MouseClickDrag($MOUSE_CLICK_LEFT, $Xx + $xOvieB1, $Yy + $yOvieB1, $Xx + $xOvieB1 + 200, $Yy + $yOvieB1 + 160, 0)
		Sleep(400)
		MouseClick("right", $Xx + $xbRallyOvie, $Yy + $ybRallyOvie, 1, 0)
		Sleep(400)
	EndIf

	If $base = 2 Then
		MouseClickDrag($MOUSE_CLICK_LEFT, $Xx + $xOvieB2, $Yy + $yOvieB2, $Xx + $xOvieB2 + 200, $Yy + $yOvieB2 + 160, 0)
		Sleep(400)
		MouseClick("right", $Xx + $xbRallyOvie, $Yy + $ybRallyOvie, 1, 0)
		Sleep(400)
	EndIf
EndFunc


Func RallyDrones()
	Send("4")
	Send("4")
	Sleep(200)
	Send("5")
	Sleep(200)
	Send("g")
	Send(200)

	If $base = 1 Then
		MouseClick("left", $Xx + $xMineralsB1, $Yy + $yMineralsB1, 1, 0)
		Sleep(200)
	EndIf

	If $base = 2 Then
		MouseClick("left", $Xx + $xMineralsB2, $Yy + $yMineralsB2, 1, 0)
		Sleep(200)
	EndIf
EndFunc


Func BuildPool()
   Send("4")
   Send("4")
   Sleep(200)
   Send("s")
   Sleep(200)
   Send("d")
   Sleep(200)

   MouseClick("left", $Xx + $xWorker, $Yy + $yWorker, 1, 0)
   Sleep(200)
   Send("^9")
   Sleep(200)

   Sleep(12000)

   If $base = 1 Then
	  MouseClick("right", $Xx + $xb1Pool, $Yy + $yb1Pool, 1, 0)
	  Sleep(3000)
	  Send("9")
	  Sleep(200)
	  Send("b")
	  Sleep(200)
	  Send("s")
	  Sleep(200)
	  MouseClick("left", $Xx + $xb1Pool, $Yy + $yb1Pool, 1, 0)
	  Sleep(200)
   EndIf

   If $base = 2 Then
	  MouseClick("right", $Xx + $xb2Pool, $Yy + $yb2Pool, 1, 0)
	  Sleep(3000)
	  Send("9")
	  Sleep(200)
	  Send("b")
	  Sleep(200)
	  Send("s")
	  Sleep(200)
	  MouseClick("left", $Xx + $xb2Pool, $Yy + $yb2Pool, 1, 0)
	  Sleep(200)
   EndIf
EndFunc

Func BuildGas1()
   Send("4")
   Send("4")
   Sleep(200)
   Send("s")
   Sleep(200)
   Send("d")
   Sleep(200)

   MouseClick("left", $Xx + $xWorker, $Yy + $yWorker, 1, 0)
   Sleep(200)
   Send("^9")
   Sleep(200)

   Sleep(12000)

   If $base = 1 Then
	  MouseClick("right", $Xx + $xb1Gas1, $Yy + $yb1Gas1, 1, 0)
	  Sleep(3000)
	  Send("9")
	  Sleep(200)
	  Send("b")
	  Sleep(200)
	  Send("e")
	  Sleep(200)
	  MouseClick("left", $Xx + $xb1Gas1, $Yy + $yb1Gas1, 1, 0)
	  Sleep(200)
   EndIf

   If $base = 2 Then
	  MouseClick("right", $Xx + $xb2Gas1, $Yy + $yb2Gas1, 1, 0)
	  Sleep(3000)
	  Send("9")
	  Sleep(200)
	  Send("b")
	  Sleep(200)
	  Send("e")
	  Sleep(200)
	  MouseClick("left", $Xx + $xb2Gas1, $Yy + $yb2Gas1, 1, 0)
	  Sleep(200)
   EndIf
EndFunc

Func BuildGas2()
   Send("4")
   Send("4")
   Sleep(200)
   Send("s")
   Sleep(200)
   Send("d")
   Sleep(200)

   MouseClick("left", $Xx + $xWorker, $Yy + $yWorker, 1, 0)
   Sleep(200)
   Send("^9")
   Sleep(200)

   Sleep(12000)

   If $base = 1 Then
	  MouseClick("right", $Xx + $xb1Gas2, $Yy + $yb1Gas2, 1, 0)
	  Sleep(3000)
	  Send("9")
	  Sleep(200)
	  Send("b")
	  Sleep(200)
	  Send("e")
	  Sleep(200)
	  MouseClick("left", $Xx + $xb1Gas2, $Yy + $yb1Gas2, 1, 0)
	  Sleep(200)
   EndIf

   If $base = 2 Then
	  MouseClick("right", $Xx + $xb2Gas2, $Yy + $yb2Gas2, 1, 0)
	  Sleep(3000)
	  Send("9")
	  Sleep(200)
	  Send("b")
	  Sleep(200)
	  Send("e")
	  Sleep(200)
	  MouseClick("left", $Xx + $xb2Gas2, $Yy + $yb2Gas2, 1, 0)
   EndIf
EndFunc

Func BuildHatch2()
   Send("4")
   Send("4")
   Sleep(200)
   Send("s")
   Sleep(200)
   Send("d")
   Sleep(200)

   MouseClick("left", $Xx + $xWorker, $Yy + $yWorker, 1, 0)
   Sleep(200)
   Send("^9")
   Sleep(200)

   Sleep(12000)

   If $base = 1 Then
	  MouseClick("right", $Xx + $xb1Hatch2, $Yy + $yb1Hatch2, 1, 0)
	  Sleep(3000)
	  Send("9")
	  Sleep(200)
	  Send("b")
	  Sleep(200)
	  Send("h")
	  Sleep(200)
	  MouseClick("left", $Xx + $xb1Hatch2, $Yy + $yb1Hatch2, 1, 0)
	  Sleep(2000)
	  MouseClick("left", $Xx + $xb1Hatch2, $Yy + $yb1Hatch2, 1, 0)
	  Sleep(200)
	  Send("{SHIFTDOWN}")
	  Sleep(200)
	  Send("5")
	  Sleep(200)
	  Send("{SHIFTUP}")
	  Sleep(200)
   EndIf

   If $base = 2 Then
	  MouseClick("right", $Xx + $xb2Hatch2, $Yy + $yb2Hatch2, 1, 0)
	  Sleep(3000)
	  Send("9")
	  Sleep(200)
	  Send("b")
	  Sleep(200)
	  Send("h")
	  Sleep(200)
	  MouseClick("left", $Xx + $xb2Hatch2, $Yy + $yb2Hatch2, 1, 0)
	  Sleep(2000)
	  MouseClick("left", $Xx + $xb2Hatch2, $Yy + $yb2Hatch2, 1, 0)
	  Sleep(200)
	  Send("{SHIFTDOWN}")
	  Sleep(200)
	  Send("5")
	  Sleep(200)
	  Send("{SHIFTUP}")
	  Sleep(200)
   EndIf
EndFunc

Func BuildEvo1()
   Send("4")
   Send("4")
   Sleep(200)
   Send("5")
   Sleep(200)
   Send("s")
   Sleep(200)
   Send("d")
   Sleep(200)

   MouseClick("left", $Xx + $xWorker, $Yy + $yWorker, 1, 0)
   Sleep(200)
   Send("^9")
   Sleep(200)

   Sleep(12000)

   If $base = 1 Then
	  MouseClick("right", $Xx + $xb1Evo1, $Yy + $yb1Evo1, 1, 0)
	  Sleep(4000)
	  Send("9")
	  Sleep(200)
	  Send("b")
	  Sleep(200)
	  Send("v")
	  Sleep(200)
	  MouseClick("left", $Xx + $xb1Evo1, $Yy + $yb1Evo1, 1, 0)
	  Sleep(2000)
	  MouseClick("left", $Xx + $xb1Evo1, $Yy + $yb1Evo1, 1, 0)
	  Sleep(200)
	  Send("{SHIFTDOWN}")
	  Sleep(200)
	  Send("6")
	  Sleep(200)
	  Send("{SHIFTUP}")
	  Sleep(200)
   EndIf

   If $base = 2 Then
	  MouseClick("right", $Xx + $xb2Evo1, $Yy + $yb2Evo1, 1, 0)
	  Sleep(4000)
	  Send("9")
	  Sleep(200)
	  Send("b")
	  Sleep(200)
	  Send("v")
	  Sleep(200)
	  MouseClick("left", $Xx + $xb2Evo1, $Yy + $yb2Evo1, 1, 0)
	  Sleep(2000)
	  MouseClick("left", $Xx + $xb2Evo1, $Yy + $yb2Evo1, 1, 0)
	  Sleep(200)
	  Send("{SHIFTDOWN}")
	  Sleep(200)
	  Send("6")
	  Sleep(200)
	  Send("{SHIFTUP}")
	  Sleep(200)
   EndIf
EndFunc

Func BuildEvo2()
   Send("4")
   Send("4")
   Sleep(200)
   Send("5")
   Sleep(200)
   Send("s")
   Sleep(200)
   Send("d")
   Sleep(200)

   MouseClick("left", $Xx + $xWorker, $Yy + $yWorker, 1, 0)
   Sleep(200)
   Send("^9")
   Sleep(200)

   Sleep(12000)

   If $base = 1 Then
	  MouseClick("right", $Xx + $xb1Evo2, $Yy + $yb1Evo2, 1, 0)
	  Sleep(4000)
	  Send("9")
	  Sleep(200)
	  Send("b")
	  Sleep(200)
	  Send("v")
	  Sleep(200)
	  MouseClick("left", $Xx + $xb1Evo2, $Yy + $yb1Evo2, 1, 0)
	  Sleep(2000)
	  MouseClick("left", $Xx + $xb1Evo2, $Yy + $yb1Evo2, 1, 0)
	  Sleep(200)
	  Send("{SHIFTDOWN}")
	  Sleep(200)
	  Send("6")
	  Sleep(200)
	  Send("{SHIFTUP}")
	  Sleep(200)
   EndIf

   If $base = 2 Then
	  MouseClick("right", $Xx + $xb2Evo2, $Yy + $yb2Evo2, 1, 0)
	  Sleep(4000)
	  Send("9")
	  Sleep(200)
	  Send("b")
	  Sleep(200)
	  Send("v")
	  Sleep(200)
	  MouseClick("left", $Xx + $xb2Evo2, $Yy + $yb2Evo2, 1, 0)
	  Sleep(2000)
	  MouseClick("left", $Xx + $xb2Evo2, $Yy + $yb2Evo2, 1, 0)
	  Sleep(200)
	  Send("{SHIFTDOWN}")
	  Sleep(200)
	  Send("6")
	  Sleep(200)
	  Send("{SHIFTUP}")
	  Sleep(200)
   EndIf
EndFunc

Func BuildHydra()
   Send("4")
   Send("4")
   Sleep(200)
   Send("5")
   Sleep(200)
   Send("s")
   Sleep(200)
   Send("d")
   Sleep(200)

   MouseClick("left", $Xx + $xWorker, $Yy + $yWorker, 1, 0)
   Sleep(200)
   Send("^9")
   Sleep(200)

   Sleep(12000)

   If $base = 1 Then
	  MouseClick("right", $Xx + $xb1Hydra, $Yy + $yb1Hydra, 1, 0)
	  Sleep(4000)
	  Send("9")
	  Sleep(200)
	  Send("v")
	  Sleep(200)
	  Send("h")
	  Sleep(200)
	  MouseClick("left", $Xx + $xb1Hydra, $Yy + $yb1Hydra, 1, 0)
	  Sleep(3000)
	  MouseClick("left", $Xx + $xb1Hydra, $Yy + $yb1Hydra, 1, 0)
	  Sleep(200)
	  Send("{SHIFTDOWN}")
	  Sleep(200)
	  Send("7")
	  Sleep(200)
	  Send("{SHIFTUP}")
	  Sleep(200)
   EndIf

   If $base = 2 Then
	  MouseClick("right", $Xx + $xb2Hydra, $Yy + $yb2Hydra, 1, 0)
	  Sleep(4000)
	  Send("9")
	  Sleep(200)
	  Send("v")
	  Sleep(200)
	  Send("h")
	  Sleep(200)
	  MouseClick("left", $Xx + $xb2Hydra, $Yy + $yb2Hydra, 1, 0)
	  Sleep(2000)
	  MouseClick("left", $Xx + $xb2Hydra, $Yy + $yb2Hydra, 1, 0)
	  Sleep(200)
	  Send("{SHIFTDOWN}")
	  Sleep(200)
	  Send("7")
	  Sleep(200)
	  Send("{SHIFTUP}")
	  Sleep(200)
   EndIf
EndFunc


Func PopGases()
	;;; Center on Hatch
	Send("4")
	Send("4")
	Sleep(200)

    If $base = 1 Then
	  ;;;; Select all Workers
	  MouseClickDrag($MOUSE_CLICK_LEFT, $Xx + $selWxB1, $Yy + $selWyB1, $Xx + $selWxxB1, $Yy + $selWyyB1, 0)
	  Sleep(200)
    EndIf

    If $base = 2 Then
	  ;;;; Select all Workers
	  MouseClickDrag($MOUSE_CLICK_LEFT, $Xx + $selWxB2, $Yy + $selWyB2, $Xx + $selWxxB2, $Yy + $selWyyB2, 0)
	  Sleep(200)
    EndIf

	Send("{SHIFTDOWN}")
	Sleep(100)

	;;;; Spam Click on 7th position
	MouseClick("left", $Xx + $xWorker + 6 * $xWorkerOff, $Yy + $yWorker, 4, 0)
	MouseClick("left", $Xx + $xWorker + 6 * $xWorkerOff, $Yy + $yWorker, 4, 0)
	Sleep(200)

	Send("{SHIFTUP}")
	Sleep(100)

	If $base = 1 Then
	  MouseClick("right", $Xx + $xb1Gas1, $Yy + $yb1Gas1, 1, 0)
	  Sleep(100)
    EndIf

    If $base = 2 Then
	  MouseClick("right", $Xx + $xb2Gas1, $Yy + $yb2Gas1, 1, 0)
	  Sleep(100)
    EndIf

    Send("{SHIFTDOWN}")
    Sleep(100)

	;;;; Spam Click on 4th position
	MouseClick("left", $Xx + $xWorker + 3 * $xWorkerOff, $Yy + $yWorker, 4, 0)
	MouseClick("left", $Xx + $xWorker + 3 * $xWorkerOff, $Yy + $yWorker, 4, 0)
	Sleep(200)

	Send("{SHIFTUP}")
	Sleep(100)

	If $base = 1 Then
	  MouseClick("right", $Xx + $xb1Gas2, $Yy + $yb1Gas2, 1, 0)
	  Sleep(100)
    EndIf

    If $base = 2 Then
	  MouseClick("right", $Xx + $xb2Gas2, $Yy + $yb2Gas2, 1, 0)
	  Sleep(100)
    EndIf
EndFunc


Func AMove()
	Local $KerryLife = 0
	Local $rX = 0
	Local $rY = 0
	Local $offX = 0
	Local $offY = 0

	$rX = Random(0, 30, 1) - 15
	$rY = Random(0, 30, 1) - 15

	;;; shard 1
	If 0 <= $gameTime AND $gameTime < 80 Then
		$offX = $z1X
		$offY = $z1Y
	EndIf

	;;; shard 2
	If 80 <= $gameTime AND $gameTime < 175 Then
		$offX = $z2X
		$offY = $z2Y
	EndIf

	;;; shard 3
	If 175 <= $gameTime AND $gameTime < 260 Then
		$offX = $z3X
		$offY = $z3Y
	EndIf

	;;; shard 4
	If 260 <= $gameTime Then
		$offX = $z4X
		$offY = $z4Y
	EndIf

	;;; Check Life Mijloc
	$KerryLife = PixelChecksum($Xx + $xKerryPLife, $Yy + $yKerryPLife, $Xx + $xKerryPLife + 1, $Yy + $yKerryPLife + 1)
	Sleep(100)

	;;; Verde la Jumate - > go attack
	If $KerryLife = $VKerryLife Then
		Send("{SPACE}")
		Send("{SPACE}")
		Sleep(100)
		Send("e")
	    Sleep(100)
		Send("a")
		Sleep(100)
		MouseClick("left", $Xx + $rX + $offX, $Yy + $rY + $offY, 1, 0)
		Sleep(200)
	Else
	    Sleep(500)
		;;; Check Life Mijloc
		$KerryLife = PixelChecksum($Xx + $xKerryPLife, $Yy + $yKerryPLife, $Xx + $xKerryPLife + 1, $Yy + $yKerryPLife + 1)
		Sleep(100)

		;;; Verde la Jumate - > no, retreat
		If $KerryLife <> $VKerryLife Then
			Send("{SPACE}")
			Send("{SPACE}")
			Sleep(100)
			Send("e")
			Sleep(100)
			Send("d")
			Sleep(100)
			MouseClick("right", $Xx + $xBaseRamp, $Yy + $yBaseRamp, 1, 0)
			Sleep(200)
		EndIf
	EndIf
EndFunc
