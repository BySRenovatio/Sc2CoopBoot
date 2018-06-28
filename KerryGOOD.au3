#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2 = Kerry Build Normal
 Author:         Sorin Bajenaru

#ce ----------------------------------------------------------------------------

#include <AutoItConstants.au3>
#include <Date.au3>

HotKeySet("{END}", "Quit")
HotKeySet("{Home}", "Start")
HotKeySet("{TAB}", "pozitie")
HotKeySet("{F2}", "showChecks")

Global $Xx = 1970
Global $Yy = 0
Global $base = 0
Global $gameTime = 0
Global $gameTimeStart = 0

;;; t1 4:30
Global $z1X = 150
Global $z1Y = 900
;;; t2 9:30
Global $z2X = 120
Global $z2Y = 815
;;; t3 13:30
Global $z3X = 235
Global $z3Y = 945
;;; t4 18:00
Global $z4X = 200
Global $z4Y = 855

Global $xWorker = 650
Global $yWorker = 885
Global $xWorkerOff = 55
Global $xbRallyOvie = 50
Global $ybRallyOvie = 990

Global $xb1Pool = 745
Global $yb1Pool = 190
Global $xb1Hatch2 = 1200
Global $yb1Hatch2 = 450
Global $xb1Evo1 = 970
Global $yb1Evo1 = 705
Global $xb1Evo2 = 1160
Global $yb1Evo2 = 700
Global $xb1Gas1 = 590
Global $yb1Gas1 = 190
Global $xb1Gas2 = 775
Global $yb1Gas2 = 820
Global $xb1Hydra = 1355
Global $yb1Hydra = 705
Global $xb1Mineral = 550
Global $yb1Mineral = 303

Global $xb2Pool = 515
Global $yb2Pool = 310
Global $xb2Hatch2 = 1200
Global $yb2Hatch2 = 450
Global $xb2Evo1 = 325
Global $yb2Evo1 = 445
Global $xb2Evo2 = 290
Global $yb2Evo2 = 590
Global $xb2Gas1 = 500
Global $yb2Gas1 = 444
Global $xb2Gas2 = 1240
Global $yb2Gas2 = 815
Global $xb2Hydra = 530
Global $yb2Hydra = 185
Global $xb2Mineral = 940
Global $yb2Mineral = 755


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
	Local $check = PixelChecksum($Xx + 172, $Yy + 77, $Xx + 174, $Yy + 78)
	ToolTip($check)
 EndFunc

 Func WRand($value)
    Return Random($value/2, $value, 1)
EndFunc

 Func SetDelay()
    ;;;; Set Delay
    AutoItSetOption("MouseClickDelay", WRand(50))
    AutoItSetOption("MouseClickDownDelay", WRand(50))
    AutoItSetOption("SendKeyDelay", WRand(50))
    AutoItSetOption("SendKeyDownDelay", WRand(50))
EndFunc


Func Start()
	Local $checkMenu = 0
    Local $sw = 0

	;;; SetDelay()
    Click_Play()

    $sw = 0
    While $sw < 300
	   $checkMenu = PixelChecksum($Xx + 300, $Yy + 860, $Xx + 325, $Yy + 880)
	   If $checkMenu = 3695203902 Then
		  GameStarted()
	   EndIf

	   Sleep(1000)
	   $sw += 1
    WEnd

    Start()
 EndFunc


 Func SayGlHf()
	Send("{ENTER}")
	Sleep(100)

	Send("Hey, Gl Hf <3")
	Sleep(100)

	Send("{ENTER}")
	Sleep(100)

	Send("{ENTER}")
	Sleep(100)

	Send("I'll do a one base build.")
	Sleep(100)

	Send("{ENTER}")
	Sleep(100)

	Send("{ENTER}")
	Sleep(100)

	Send("My nat, If you want it; it's yours to have :)")
	Sleep(100)

	Send("{ENTER}")
	Sleep(100)
 EndFunc


 Func Click_Play()
	MouseClick("left", $Xx + 200, $Yy + 920, 1, 0)
	Sleep(500)
 EndFunc

Func Click_Leave()
    MouseClick("left", $Xx + 220, $Yy + 820, 1, 0)
    Sleep(2000)

    Start()
EndFunc


Func GameStarted()
    Local $stillIngame = 0
    Local $basePoz1 = 0
    Local $basePoz2 = 0

    $gameTimeStart = _Date_Time_GetTickCount()

	SayGlHf()

    While 1
	  $stillIngame = PixelChecksum($Xx + 375, $Yy + 950, $Xx + 400, $Yy + 975)
	  Sleep(100)
	  $basePoz1 = PixelChecksum($Xx + 82, $Yy + 933, $Xx + 83, $Yy + 934)
	  Sleep(100)
	  $basePoz2 = PixelChecksum($Xx + 107, $Yy + 959, $Xx + 108, $Yy + 960)
	  Sleep(100)

	  If $stillIngame = 132907009 OR $basePoz1 = 195822017 OR $basePoz2 = 195822017 Then
		 $gameTime = (_Date_Time_GetTickCount() - $gameTimeStart) / 10000
		 ToolTip($gameTime*14, $Xx + 390, $Yy + 885)
	  Else
		 Sleep(18000)
		 Send("{s}")
		 Sleep(18000)
		 Click_Leave()
	  EndIf

	  If 12 <= $gameTime*14 AND $gameTime*14 < 14 Then
		 $basePoz1 = PixelChecksum($Xx + 82, $Yy + 933, $Xx + 83, $Yy + 934)
		 $basePoz2 = PixelChecksum($Xx + 107, $Yy + 959, $Xx + 108, $Yy + 960)
		 Sleep(200)

		 If $basePoz1 = 195822017 Then
			$base = 1

			;;; Click Hatch
			MouseClick("left", $Xx + 1040, $Yy + 440, 2, 0)
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

		 If $basePoz2 = 195822017 Then
			$base = 2

			;;; Click Hatch
			MouseClick("left", $Xx + 900, $Yy + 330, 2, 0)
			Sleep(200)

			;;; Put on 4, 5
			Send("^4")
			Sleep(200)
			Send("^5")
			Sleep(200)

			;;; Center
			Send("4")
			Send("4")
			Sleep(100)
		 EndIf
	  EndIf

	  If 19 <= $gameTime*14 AND $gameTime*14 < 20 Then
		MoveOvie()
	  EndIf

	  If 25 <= $gameTime*14 AND $gameTime*14 < 26 Then
		BuildDrone()
		BuildDrone()
		BuildOvie()
	  EndIf

	  If 60 <= $gameTime*14 AND $gameTime*14 < 61 Then
		BuildPool()
	  EndIf

	  If 95 <= $gameTime*14 AND $gameTime*14 < 96 Then
		BuildGas1()
		BuildGas2()
	  EndIf

	  If 150 <= $gameTime*14 AND $gameTime*14 < 151 Then
		PopGases()
	  EndIf

	  If 165 <= $gameTime*14 AND $gameTime*14 < 166 Then
		BuildHatch2()
	  EndIf

	  If 195 <= $gameTime*14 AND $gameTime*14 < 196 Then
		BuildDrone()
		BuildDrone()
		BuildDrone()
		BuildOvie()
		BuildOvie()
	  EndIf

	  If 205 <= $gameTime*14 AND $gameTime*14 < 206 Then
		BuildEvo1()
		BuildEvo2()
		UpgradeLair()
	  EndIf

	  If 275 <= $gameTime*14 AND $gameTime*14 < 276 Then
		BuildDrone()
		BuildDrone()
		BuildDrone()
	  EndIf

	  If 350 <= $gameTime*14 AND $gameTime*14 < 351 Then
	    EvoUpgradeK1()
		EvoUpgradeK2()
		EvoUpgradeA()
		EvoUpgradeD()
		BuildHydra()
	    UpgradeHive()

		BuildDrone()
		BuildDrone()
		BuildDrone()
	  EndIf

	  If 450 <= $gameTime*14 AND $gameTime*14 < 451 Then
	    BuildDrone()
		BuildDrone()
		BuildDrone()
		BuildDrone()
		BuildDrone()
		BuildDrone()

		HydraUpgrade1()
		HydraUpgrade2()
		HydraUpgrade3()
		EvoUpgradeK3()
	  EndIf

	  If 470 <= $gameTime*14 AND $gameTime*14 < 471 Then
		EvoUpgradeA()
		EvoUpgradeD()
		BuildOvie()
	  EndIf

	  If 605 <= $gameTime*14 AND $gameTime*14 < 606 Then
		EvoUpgradeA()
		EvoUpgradeD()
	  EndIf

	  If $gameTime*14 >= 610 AND MOD(INT($gameTime*14), 20) = 0 Then
		BuildHydras()
	  EndIf

	  If $gameTime*14 >= 245 AND MOD(INT($gameTime*14), 5) = 0 Then
		AMove()
	  EndIf
   WEnd
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
	If 0 <= $gameTime*14 AND $gameTime*14 < 6*60 Then
		$offX = $z1X
		$offY = $z1Y
	EndIf

	;;; shard 2
	If 6*60 <= $gameTime*14 AND $gameTime*14 < 13*60 Then
		$offX = $z2X
		$offY = $z2Y
	EndIf

	;;; shard 3
	If 12*60 <= $gameTime*14 AND $gameTime*14 < 17*60 Then
		$offX = $z3X
		$offY = $z3Y
	EndIf

	;;; shard 4
	If 17*60 <= $gameTime*14 Then
		$offX = $z4X
		$offY = $z4Y
	EndIf

	;;; Check Life Mijloc
	$KerryLife = PixelChecksum($Xx + 172, $Yy + 77, $Xx + 174, $Yy + 78)
	Sleep(100)

	;;; Verde la Jumate - > go attack
	If $KerryLife = 864093520 Then
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
		$KerryLife = PixelChecksum($Xx + 172, $Yy + 77, $Xx + 174, $Yy + 78)
		Sleep(100)

		;;; Verde la Jumate - > no, retreat
		If $KerryLife <> 864093520 Then
			Send("{SPACE}")
			Send("{SPACE}")
			Sleep(100)
			Send("d")
			Sleep(100)
			MouseClick("right", $Xx + 123, $Yy + 930, 1, 0)
			Sleep(200)
		EndIf
	EndIf
EndFunc


Func MoveOvie()
	If $base = 1 Then
		MouseClickDrag($MOUSE_CLICK_LEFT, $Xx + 1010, $Yy + 155, $Xx + 1165, $Yy + 265, 0)
		Sleep(400)
		MouseClick("right", $Xx + $xbRallyOvie, $Yy + $ybRallyOvie, 1, 0)
		Sleep(400)
	EndIf

	If $base = 2 Then
		MouseClickDrag($MOUSE_CLICK_LEFT, $Xx + 1015, $Yy + 100, $Xx + 1155, $Yy + 215, 0)
		Sleep(400)
		MouseClick("right", $Xx + $xbRallyOvie, $Yy + $ybRallyOvie, 1, 0)
		Sleep(400)
	EndIf
EndFunc


Func BuildDrone()
   Send("4")
   Sleep(200)
   Send("s")
   Sleep(200)
   Send("d")
   Sleep(100)
EndFunc

Func BuildOvie()
   Send("4")
   Sleep(200)
   Send("s")
   Sleep(200)
   Send("v")
   Sleep(200)
   MouseClick("right", $Xx + $xbRallyOvie, $Yy + $ybRallyOvie, 1, 0)
   Sleep(100)
EndFunc


Func PopGases()
	;;; Center on Hatch
	Send("4")
	Send("4")
	Sleep(200)

    If $base = 1 Then
	  ;;;; Select all Workers
	  MouseClickDrag($MOUSE_CLICK_LEFT, $Xx + 325, $Yy + 290, $Xx + 650, $Yy + 715, 0)
	  Sleep(200)
    EndIf

    If $base = 2 Then
	  ;;;; Select all Workers
	  MouseClickDrag($MOUSE_CLICK_LEFT, $Xx + 550, $Yy + 495, $Xx + 1100, $Yy + 760, 0)
	  Sleep(200)
    EndIf

	Send("{SHIFTDOWN}")
	Sleep(100)

	;;;; Spam Click on 7th position
	MouseClick("left", $Xx + $xWorker + 6 * $xWorkerOff, $Yy + $yWorker, 8, 0)
	MouseClick("left", $Xx + $xWorker + 6 * $xWorkerOff, $Yy + $yWorker, 8, 0)
	MouseClick("left", $Xx + $xWorker + 6 * $xWorkerOff, $Yy + $yWorker, 8, 0)
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
	MouseClick("left", $Xx + $xWorker + 3 * $xWorkerOff, $Yy + $yWorker, 8, 0)
	MouseClick("left", $Xx + $xWorker + 3 * $xWorkerOff, $Yy + $yWorker, 8, 0)
	MouseClick("left", $Xx + $xWorker + 3 * $xWorkerOff, $Yy + $yWorker, 8, 0)
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


Func BuildPool()
   Send("4")
   Send("4")
   Sleep(200)
   Send("s")
   Sleep(200)
   Send("d")
   Sleep(200)

   MouseClick("left", $Xx + 650, $Yy + 880, 2, 0)
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

   MouseClick("left", $Xx + 650, $Yy + 880, 2, 0)
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

   MouseClick("left", $Xx + 650, $Yy + 880, 2, 0)
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

   MouseClick("left", $Xx + 650, $Yy + 880, 2, 0)
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

   MouseClick("left", $Xx + 650, $Yy + 880, 2, 0)
   Sleep(200)
   Send("^9")
   Sleep(200)

   Sleep(12000)

   If $base = 1 Then
	  MouseClick("right", $Xx + $xb1Evo1, $Yy + $yb1Evo1, 1, 0)
	  Sleep(3000)
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
	  Sleep(3000)
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

   MouseClick("left", $Xx + 650, $Yy + 880, 2, 0)
   Sleep(200)
   Send("^9")
   Sleep(200)

   Sleep(12000)

   If $base = 1 Then
	  MouseClick("right", $Xx + $xb1Evo2, $Yy + $yb1Evo2, 1, 0)
	  Sleep(3000)
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
	  Sleep(3000)
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

   MouseClick("left", $Xx + 650, $Yy + 880, 2, 0)
   Sleep(200)
   Send("^9")
   Sleep(200)

   Sleep(12000)

   If $base = 1 Then
	  MouseClick("right", $Xx + $xb1Hydra, $Yy + $yb1Hydra, 1, 0)
	  Sleep(3000)
	  Send("9")
	  Sleep(200)
	  Send("v")
	  Sleep(200)
	  Send("h")
	  Sleep(200)
	  MouseClick("left", $Xx + $xb1Hydra, $Yy + $yb1Hydra, 1, 0)
	  Sleep(2000)
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
	  Sleep(3000)
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

Func UpgradeLair()
   Send("4")
   Send("4")
   Sleep(200)
   Send("l")
   Sleep(200)
EndFunc

Func UpgradeHive()
   Send("4")
   Send("4")
   Sleep(200)
   Send("h")
   Sleep(200)
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
	MouseClick("right", $Xx + 60, $Yy + 70, 1, 0)
	Sleep(300)

	BuildOvie()
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
