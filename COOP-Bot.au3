#include <AutoItConstants.au3>

HotKeySet("{END}", "Quit")
HotKeySet("{Home}", "Start")
HotKeySet("{TAB}", "pozitie")
HotKeySet("{F2}", "showChecks")
HotKeySet("{F3}", "pauseZ")

Global $Xx = 1970
Global $Yy = 0
Global $base = 0
Global $gameTime = 0

Global $z1X = 120
Global $z1Y = 950
Global $z2X = 170
Global $z2Y = 930
Global $z3X = 115
Global $z3Y = 895
Global $z4X = 90
Global $z4Y = 855
Global $z5X = 185
Global $z5Y = 870
Global $z6X = 215
Global $z6Y = 845

Global $xb1Pool = 960
Global $yb1Pool = 150
Global $xb1Hatch2 = 1200
Global $yb1Hatch2 = 445
Global $xb1Evo1 = 710
Global $yb1Evo1 = 760
Global $xb1Evo2 = 910
Global $yb1Evo2 = 760
Global $xb1Gas1 = 805
Global $yb1Gas1 = 130
Global $xb1Gas2 = 510
Global $yb1Gas2 = 750
Global $xb1Hydra = 1120
Global $yb1Hydra = 150

Global $xb2Pool = 495
Global $yb2Pool = 445
Global $xb2Hatch2 = 910
Global $yb2Hatch2 = 225
Global $xb2Evo1 = 515
Global $yb2Evo1 = 310
Global $xb2Evo2 = 345
Global $yb2Evo2 = 310
Global $xb2Gas1 = 470
Global $yb2Gas1 = 580
Global $xb2Gas2 = 1350
Global $yb2Gas2 = 530
Global $xb2Hydra = 1310
Global $yb2Hydra = 400


While 1
   Sleep(1000)
WEnd

Func pauseZ()
   While 1
	  Sleep(1000)
   WEnd
EndFunc

Func Quit()
   Exit 0
EndFunc


Func pozitie()
	Local $aPos = MouseGetPos()
	ToolTip('X: ' & $aPos[0] - $Xx & ', Y: ' & $aPos[1] - $Yy)
 EndFunc

Func showChecks()
	Local $check = PixelChecksum($Xx + 375, $Yy + 950, $Xx + 400, $Yy + 975)
	ToolTip($check)
 EndFunc

Func WRand($value)
   Return Random($value/2, $value, 1)
EndFunc

 Func SetDelay()
   ;;;; Set Delay
   AutoItSetOption("MouseClickDelay", WRand(100))
   AutoItSetOption("MouseClickDownDelay", WRand(100))
EndFunc


Func SayGlHf()
	Send("{ENTER}")
	Sleep(300)

	Send("Hey, Gl Hf <3")
	Sleep(400)

	Send("{ENTER}")
	Sleep(300)

	Send("{ENTER}")
	Sleep(300)

	Send("I will not take my expansion.")
	Sleep(400)

	Send("{ENTER}")
	Sleep(300)

	Send("{ENTER}")
	Sleep(300)

	Send("If you want it; it's yours to have :)")
	Sleep(400)

	Send("{ENTER}")
	Sleep(300)
 EndFunc


 Func Start()
	Local $checkMenu = 0
    Local $sw = 0

	SetDelay()
    Click_Play()

    $sw = 0
    While $sw < 150
	  $checkMenu = PixelChecksum($Xx + 300, $Yy + 860, $Xx + 325, $Yy + 880)
	  If $checkMenu = 3695203902 Then
		 GameStarted()
	  EndIf

	  Sleep(1000)
	  $sw += 1
    WEnd

    Start()
 EndFunc


Func Click_Play()
	MouseClick("left", $Xx + 200, $Yy + 920, 1, 0)
	Sleep(500)
 EndFunc

Func Click_Leave()
   MouseClick("left", $Xx + 220, $Yy + 820, 1, 0)
   Sleep(500)

   Start()
EndFunc


Func GameStarted()
   Local $stillIngame = 0
   Local $basePoz1 = 0
   Local $basePoz2 = 0

   $gameTime = 0

   SayGlHf()

   While 1
	  $stillIngame = PixelChecksum($Xx + 375, $Yy + 950, $Xx + 400, $Yy + 975)
	  If $stillIngame = 132907009 Then
		 $gameTime += 1
		 ToolTip($gameTime, $Xx + 390, $Yy + 885)
	  Else
		 Sleep(15000)
		 Send("{s}")
		 Sleep(15000)
		 Click_Leave()
	  EndIf

	  If $gameTime = 5 Then
		 $basePoz1 = PixelChecksum($Xx + 66, $Yy + 974, $Xx + 67, $Yy + 975)
		 $basePoz2 = PixelChecksum($Xx + 87, $Yy + 993, $Xx + 88, $Yy + 994)

		 If $basePoz1 = 239338033 Then
			$base = 1

			;;; Click Hatch
			MouseClick("left", $Xx + 1040, $Yy + 440, 2, 0)
			Sleep(500)

			;;; Put on 4,5
			Send("^4")
			Sleep(400)
			Send("^5")
			Sleep(400)

			;;; Center
			Send("4")
			Send("4")
			Sleep(400)
		 EndIf

		 If $basePoz2 = 239338033 Then
			$base = 2

			;;; Click Hatch
			MouseClick("left", $Xx + 900, $Yy + 330, 2, 0)
			Sleep(500)

			;;; Put on 4,5
			Send("^4")
			Sleep(400)
			Send("^5")
			Sleep(400)

			;;; Center
			Send("4")
			Send("4")
			Sleep(400)
		 EndIf
	  EndIf

	  If $gameTime = 8 Then
		MoveOvie()
	  EndIf

	  If $gameTime = 12 Or $gameTime = 32 Then
		 BuildDrone()
		 BuildDrone()
		 BuildOvie()
	  EndIf

	  If $gameTime = 35 Then
		 BuildPool()
	  EndIf

	  If $gameTime = 45 Then
		 BuildGas1()
		 BuildGas2()
	  EndIf

	  If $gameTime = 50 Then
		 PopGas1()
	  EndIf

	  If $gameTime = 60 Then
		 BuildHatch2()
	  EndIf

	  If $gameTime = 65 Then
		 BuildEvo1()
		 BuildEvo2()
	  EndIf

	  If $gameTime = 70 Then
		 PopGas2()
		 UpgradeLair()
	  EndIf

	  If $gameTime = 85 Or $gameTime = 105 Or $gameTime = 135 Then
		 BuildDrone()
		 BuildDrone()
		 BuildOvie()
	  EndIf

	  If $gameTime = 100 Then
		 BuildHydra()
	     UpgradeHive()
	  EndIf

	  If $gameTime = 140 Then
		 EvoUpgradeK1()
		 EvoUpgradeK2()
		 EvoUpgradeA()
		 EvoUpgradeD()
	  EndIf

	  If $gameTime = 170 Then
		HydraUpgrade1()
		HydraUpgrade2()
		HydraUpgrade3()
		EvoUpgradeK3()
	  EndIf

	  If $gameTime = 235 Then
		EvoUpgradeA()
		EvoUpgradeD()
	  EndIf

	  If $gameTime = 290 Then
		EvoUpgradeA()
		EvoUpgradeD()
	  EndIf

	  If $gameTime >= 250 AND MOD($gameTime, 20) = 0 Then
		BuildHydras()
	  EndIf

	  If $gameTime >= 70 AND MOD($gameTime, 2) = 0 Then
		AMove()
	  Else
		Sleep(1000)
	  EndIf
   WEnd
EndFunc


Func AMove()
	Local $KerryLife = 0
	Local $rX = 0
	Local $rY = 0
	Local $offX = 0
	Local $offY = 0

	$rX = Random(0, 40, 1) - 20
	$rY = Random(0, 40, 1) - 20

	;;; Z1
	If $gameTime >= 70  AND $gameTime < 180 Then
		$offX = $z1X
		$offY = $z1Y
	EndIf

	;;; Z2
	If $gameTime >= 180 AND $gameTime < 290 Then
		$offX = $z2X
		$offY = $z2Y
	EndIf

	;;; Z3
	If $gameTime >= 290 AND $gameTime < 350 Then
		$offX = $z3X
		$offY = $z3Y
	EndIf

	;;; Z4
	If $gameTime >= 350 AND $gameTime < 460 Then
		$offX = $z4X
		$offY = $z4Y
	EndIf

	;;; Z5
	If $gameTime >= 460 AND $gameTime < 520 Then
		$offX = $z5X
		$offY = $z5Y
	EndIf

	;;; Z6
	If $gameTime >= 520 AND $gameTime < 1000 Then
		$offX = $z6X
		$offY = $z6Y
	EndIf

	;;; Check Life Mijloc
	$KerryLife = PixelChecksum($Xx + 170, $Yy + 75, $Xx + 175, $Yy + 80)

	;;; Verde la Jumate - > go attack
	If $KerryLife = 35725407 Then
		Send("{SPACE}")
		Send("{SPACE}")
		Sleep(300)
		Send("a")
		Sleep(300)
		MouseClick("left", $Xx + $rX + $offX, $Yy + $rY + $offY, 1, 0)
		Sleep(400)
	Else
		Send("{SPACE}")
		Send("{SPACE}")
		Sleep(300)
		Send("d")
		Sleep(300)
		MouseClick("right", $Xx + 95, $Yy + 975, 1, 0)
		Sleep(400)
	EndIf
EndFunc

Func BuildHydras()
	Send("5")
	Sleep(300)
	Send("s")
	Sleep(300)

	Send("h")
	Sleep(300)
	Send("h")
	Sleep(300)
	Send("h")
	Sleep(300)
	Send("h")
	Sleep(300)

	;;; rally Kerrigan
	MouseClick("right", $Xx + 60, $Yy + 70, 1, 0)
	Sleep(300)

	BuildOvie()
EndFunc


Func EvoUpgradeA()
	Send("6")
	Sleep(300)
	Send("a")
	Sleep(300)
EndFunc

Func EvoUpgradeD()
	Send("6")
	Sleep(300)
	Send("c")
	Sleep(300)
EndFunc

Func EvoUpgradeK1()
	Send("6")
	Sleep(300)
	Send("f")
	Sleep(300)
EndFunc

Func EvoUpgradeK2()
	Send("6")
	Sleep(300)
	Send("r")
	Sleep(300)
EndFunc

Func EvoUpgradeK3()
	Send("6")
	Sleep(300)
	Send("e")
	Sleep(300)
EndFunc

Func HydraUpgrade1()
	Send("7")
	Sleep(300)
	Send("a")
	Sleep(300)
EndFunc

Func HydraUpgrade2()
	Send("7")
	Sleep(300)
	Send("c")
	Sleep(300)
EndFunc

Func HydraUpgrade3()
	Send("7")
	Sleep(300)
	Send("f")
	Sleep(300)
EndFunc


Func MoveOvie()
	If $base = 1 Then
		MouseClickDrag($MOUSE_CLICK_LEFT, $Xx + 1045, $Yy + 290, $Xx + 1150, $Yy + 400, 1)
		Sleep(2000)
		MouseClick("right", $Xx + 37, $Yy + 1007, 1, 0)
		Sleep(300)
	EndIf

	If $base = 2 Then
		MouseClickDrag($MOUSE_CLICK_LEFT, $Xx + 805, $Yy + 130, $Xx + 885, $Yy + 200, 1)
		Sleep(2000)
		MouseClick("right", $Xx + 37, $Yy + 1007, 1, 0)
		Sleep(300)
	EndIf
EndFunc

Func BuildDrone()
   Send("4")
   Sleep(300)
   Send("s")
   Sleep(300)
   Send("d")
   Sleep(300)
EndFunc

Func BuildOvie()
   Send("4")
   Sleep(300)
   Send("s")
   Sleep(300)
   Send("v")
   Sleep(300)
   MouseClick("right", $Xx + 37, $Yy + 1007, 1, 0)
   Sleep(300)
EndFunc


Func BuildGas1()
   Send("4")
   Send("4")
   Sleep(300)
   Send("5")
   Sleep(300)
   Send("s")
   Sleep(300)
   Send("d")
   Sleep(300)

   MouseClick("left", $Xx + 650, $Yy + 880, 2, 0)
   Sleep(300)
   Send("^9")
   Sleep(300)

   Sleep(12000)

   If $base = 1 Then
	  MouseClick("right", $Xx + $xb1Gas1, $Yy + $yb1Gas1, 1, 0)
	  Sleep(3000)
	  Send("9")
	  Sleep(300)
	  Send("b")
	  Sleep(300)
	  Send("e")
	  Sleep(300)
	  MouseClick("left", $Xx + $xb1Gas1, $Yy + $yb1Gas1, 1, 0)
	  Sleep(300)
   EndIf

   If $base = 2 Then
	  MouseClick("right", $Xx + $xb2Gas1, $Yy + $yb2Gas1, 1, 0)
	  Sleep(3000)
	  Send("9")
	  Sleep(300)
	  Send("b")
	  Sleep(300)
	  Send("e")
	  Sleep(300)
	  MouseClick("left", $Xx + $xb2Gas1, $Yy + $yb2Gas1, 1, 0)
	  Sleep(300)
   EndIf
EndFunc

Func BuildGas2()
   Send("4")
   Send("4")
   Sleep(300)
   Send("5")
   Sleep(300)
   Send("s")
   Sleep(300)
   Send("d")
   Sleep(300)

   MouseClick("left", $Xx + 650, $Yy + 880, 2, 0)
   Sleep(300)
   Send("^9")
   Sleep(300)

   Sleep(12000)

   If $base = 1 Then
	  MouseClick("right", $Xx + $xb1Gas2, $Yy + $yb1Gas2, 1, 0)
	  Sleep(3000)
	  Send("9")
	  Sleep(300)
	  Send("b")
	  Sleep(300)
	  Send("e")
	  Sleep(300)
	  MouseClick("left", $Xx + $xb1Gas2, $Yy + $yb1Gas2, 1, 0)
	  Sleep(300)
   EndIf

   If $base = 2 Then
	  MouseClick("right", $Xx + $xb2Gas2, $Yy + $yb2Gas2, 1, 0)
	  Sleep(3000)
	  Send("9")
	  Sleep(300)
	  Send("b")
	  Sleep(300)
	  Send("e")
	  Sleep(300)
	  MouseClick("left", $Xx + $xb2Gas2, $Yy + $yb2Gas2, 1, 0)
   EndIf
EndFunc


Func PopGas1()
   Send("4")
   Send("4")
   Sleep(300)
   Send("5")
   Sleep(300)
   Send("s")
   Sleep(300)
   Send("d")
   Sleep(300)
   Send("d")
   Sleep(300)
   Send("d")
   Sleep(300)
   Send("d")
   Sleep(300)

   Sleep(1500)

   If $base = 1 Then
	  MouseClick("right", $Xx + $xb1Gas1, $Yy + $yb1Gas1, 1, 0)
	  Sleep(1000)
   EndIf

   If $base = 2 Then
	  MouseClick("right", $Xx + $xb2Gas1, $Yy + $yb2Gas1, 1, 0)
	  Sleep(1000)
   EndIf
EndFunc

Func PopGas2()
   Send("4")
   Send("4")
   Sleep(300)
   Send("5")
   Sleep(300)
   Send("s")
   Sleep(300)
   Send("d")
   Sleep(300)
   Send("d")
   Sleep(300)
   Send("d")
   Sleep(300)
   Send("d")
   Sleep(300)

   Sleep(1500)

   If $base = 1 Then
	  MouseClick("right", $Xx + $xb1Gas2, $Yy + $yb1Gas2, 1, 0)
	  Sleep(1000)
   EndIf

   If $base = 2 Then
	  MouseClick("right", $Xx + $xb2Gas2, $Yy + $yb2Gas2, 1, 0)
	  Sleep(1000)
   EndIf
EndFunc


Func BuildPool()
   Send("4")
   Send("4")
   Sleep(300)
   Send("5")
   Sleep(300)
   Send("s")
   Sleep(300)
   Send("d")
   Sleep(300)

   MouseClick("left", $Xx + 650, $Yy + 880, 2, 0)
   Sleep(300)
   Send("^9")
   Sleep(300)

   Sleep(12000)

   If $base = 1 Then
	  MouseClick("right", $Xx + $xb1Pool, $Yy + $yb1Pool, 1, 0)
	  Sleep(3000)
	  Send("9")
	  Sleep(300)
	  Send("b")
	  Sleep(300)
	  Send("s")
	  Sleep(300)
	  MouseClick("left", $Xx + $xb1Pool, $Yy + $yb1Pool, 1, 0)
	  Sleep(300)
   EndIf

   If $base = 2 Then
	  MouseClick("right", $Xx + $xb2Pool, $Yy + $yb2Pool, 1, 0)
	  Sleep(3000)
	  Send("9")
	  Sleep(300)
	  Send("b")
	  Sleep(300)
	  Send("s")
	  Sleep(300)
	  MouseClick("left", $Xx + $xb2Pool, $Yy + $yb2Pool, 1, 0)
	  Sleep(300)
   EndIf
EndFunc

Func BuildHatch2()
   Send("4")
   Send("4")
   Sleep(300)
   Send("5")
   Sleep(300)
   Send("s")
   Sleep(300)
   Send("d")
   Sleep(300)

   MouseClick("left", $Xx + 650, $Yy + 880, 2, 0)
   Sleep(300)
   Send("^9")
   Sleep(300)

   Sleep(12000)

   If $base = 1 Then
	  MouseClick("right", $Xx + $xb1Hatch2, $Yy + $yb1Hatch2, 1, 0)
	  Sleep(3000)
	  Send("9")
	  Sleep(300)
	  Send("b")
	  Sleep(300)
	  Send("h")
	  Sleep(300)
	  MouseClick("left", $Xx + $xb1Hatch2, $Yy + $yb1Hatch2, 1, 0)
	  Sleep(3000)
	  MouseClick("left", $Xx + $xb1Hatch2, $Yy + $yb1Hatch2, 1, 0)
	  Sleep(300)
	  Send("{SHIFTDOWN}")
	  Sleep(300)
	  Send("5")
	  Sleep(300)
	  Send("{SHIFTUP}")
	  Sleep(600)
   EndIf

   If $base = 2 Then
	  MouseClick("right", $Xx + $xb2Hatch2, $Yy + $yb2Hatch2, 1, 0)
	  Sleep(3000)
	  Send("9")
	  Sleep(300)
	  Send("b")
	  Sleep(300)
	  Send("h")
	  Sleep(300)
	  MouseClick("left", $Xx + $xb2Hatch2, $Yy + $yb2Hatch2, 1, 0)
	  Sleep(3000)
	  MouseClick("left", $Xx + $xb2Hatch2, $Yy + $yb2Hatch2, 1, 0)
	  Sleep(300)
	  Send("{SHIFTDOWN}")
	  Sleep(300)
	  Send("5")
	  Sleep(300)
	  Send("{SHIFTUP}")
	  Sleep(600)
   EndIf
EndFunc

Func BuildHydra()
   Send("4")
   Send("4")
   Sleep(300)
   Send("5")
   Sleep(300)
   Send("s")
   Sleep(300)
   Send("d")
   Sleep(300)

   MouseClick("left", $Xx + 650, $Yy + 880, 2, 0)
   Sleep(300)
   Send("^9")
   Sleep(300)

   Sleep(12000)

   If $base = 1 Then
	  MouseClick("right", $Xx + $xb1Hydra, $Yy + $yb1Hydra, 1, 0)
	  Sleep(3000)
	  Send("9")
	  Sleep(300)
	  Send("v")
	  Sleep(300)
	  Send("h")
	  Sleep(300)
	  MouseClick("left", $Xx + $xb1Hydra, $Yy + $yb1Hydra, 1, 0)
	  Sleep(3000)
	  MouseClick("left", $Xx + $xb1Hydra, $Yy + $yb1Hydra, 1, 0)
	  Sleep(300)
	  Send("{SHIFTDOWN}")
	  Sleep(300)
	  Send("7")
	  Sleep(300)
	  Send("{SHIFTUP}")
	  Sleep(600)
   EndIf

   If $base = 2 Then
	  MouseClick("right", $Xx + $xb2Hydra, $Yy + $yb2Hydra, 1, 0)
	  Sleep(3000)
	  Send("9")
	  Sleep(300)
	  Send("v")
	  Sleep(300)
	  Send("h")
	  Sleep(300)
	  MouseClick("left", $Xx + $xb2Hydra, $Yy + $yb2Hydra, 1, 0)
	  Sleep(3000)
	  MouseClick("left", $Xx + $xb2Hydra, $Yy + $yb2Hydra, 1, 0)
	  Sleep(300)
	  Send("{SHIFTDOWN}")
	  Sleep(300)
	  Send("7")
	  Sleep(300)
	  Send("{SHIFTUP}")
	  Sleep(600)
   EndIf
EndFunc


Func BuildEvo1()
   Send("4")
   Send("4")
   Sleep(300)
   Send("5")
   Sleep(300)
   Send("s")
   Sleep(300)
   Send("d")
   Sleep(300)

   MouseClick("left", $Xx + 650, $Yy + 880, 2, 0)
   Sleep(300)
   Send("^9")
   Sleep(300)

   Sleep(12000)

   If $base = 1 Then
	  MouseClick("right", $Xx + $xb1Evo1, $Yy + $yb1Evo1, 1, 0)
	  Sleep(3000)
	  Send("9")
	  Sleep(300)
	  Send("b")
	  Sleep(300)
	  Send("v")
	  Sleep(300)
	  MouseClick("left", $Xx + $xb1Evo1, $Yy + $yb1Evo1, 1, 0)
	  Sleep(3000)
	  MouseClick("left", $Xx + $xb1Evo1, $Yy + $yb1Evo1, 1, 0)
	  Sleep(300)
	  Send("{SHIFTDOWN}")
	  Sleep(300)
	  Send("6")
	  Sleep(300)
	  Send("{SHIFTUP}")
	  Sleep(600)
   EndIf

   If $base = 2 Then
	  MouseClick("right", $Xx + $xb2Evo1, $Yy + $yb2Evo1, 1, 0)
	  Sleep(3000)
	  Send("9")
	  Sleep(300)
	  Send("b")
	  Sleep(300)
	  Send("v")
	  Sleep(300)
	  MouseClick("left", $Xx + $xb2Evo1, $Yy + $yb2Evo1, 1, 0)
	  Sleep(3000)
	  MouseClick("left", $Xx + $xb2Evo1, $Yy + $yb2Evo1, 1, 0)
	  Sleep(300)
	  Send("{SHIFTDOWN}")
	  Sleep(300)
	  Send("6")
	  Sleep(300)
	  Send("{SHIFTUP}")
	  Sleep(600)
   EndIf
EndFunc

Func BuildEvo2()
   Send("4")
   Send("4")
   Sleep(300)
   Send("5")
   Sleep(300)
   Send("s")
   Sleep(300)
   Send("d")
   Sleep(300)

   MouseClick("left", $Xx + 650, $Yy + 880, 2, 0)
   Sleep(300)
   Send("^9")
   Sleep(300)

   Sleep(12000)

   If $base = 1 Then
	  MouseClick("right", $Xx + $xb1Evo2, $Yy + $yb1Evo2, 1, 0)
	  Sleep(3000)
	  Send("9")
	  Sleep(300)
	  Send("b")
	  Sleep(300)
	  Send("v")
	  Sleep(300)
	  MouseClick("left", $Xx + $xb1Evo2, $Yy + $yb1Evo2, 1, 0)
	  Sleep(3000)
	  MouseClick("left", $Xx + $xb1Evo2, $Yy + $yb1Evo2, 1, 0)
	  Sleep(300)
	  Send("{SHIFTDOWN}")
	  Sleep(300)
	  Send("6")
	  Sleep(300)
	  Send("{SHIFTUP}")
	  Sleep(600)
   EndIf

   If $base = 2 Then
	  MouseClick("right", $Xx + $xb2Evo2, $Yy + $yb2Evo2, 1, 0)
	  Sleep(3000)
	  Send("9")
	  Sleep(300)
	  Send("b")
	  Sleep(300)
	  Send("v")
	  Sleep(300)
	  MouseClick("left", $Xx + $xb2Evo2, $Yy + $yb2Evo2, 1, 0)
	  Sleep(3000)
	  MouseClick("left", $Xx + $xb2Evo2, $Yy + $yb2Evo2, 1, 0)
	  Sleep(300)
	  Send("{SHIFTDOWN}")
	  Sleep(300)
	  Send("6")
	  Sleep(300)
	  Send("{SHIFTUP}")
	  Sleep(600)
   EndIf
EndFunc


Func UpgradeLair()
   Send("4")
   Send("4")
   Sleep(500)
   Send("l")
   Sleep(500)
EndFunc

Func UpgradeHive()
   Send("4")
   Send("4")
   Sleep(500)
   Send("h")
   Sleep(500)
EndFunc
