#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         Sorin Bajenaru

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

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

Global $f5x = 80
Global $f5y = 880
Global $f6x = 170
Global $f6y = 970

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

;;; atk1-2 3:10 :: 6:10 :: 15:10 :: 18:10
Global $z5X = 160
Global $z5Y = 920
;;; atk3-4 9:10 :: 12:10 :: 21:10 :: 24:10
Global $z6X = 135
Global $z6Y = 895

Global $xWorker = 650
Global $yWorker = 885
Global $xWorkerOff = 55
Global $xbRallyOvie = 50
Global $ybRallyOvie = 990
Global $xbAddon = 135
Global $ybAddon = 10
Global $whereX = 0
Global $whereY = 0

Global $xb1Colo = 1375
Global $yb1Colo = 330
Global $xb1Barracks = 745
Global $yb1Barracks = 190
Global $xb1BunkerFirst = 1150
Global $yb1BunkerFirst = 540
Global $xb1Engi1 = 970
Global $yb1Engi1 = 705
Global $xb1Engi2 = 1160
Global $yb1Engi2 = 700
Global $xb1Factory = 295
Global $yb1Factory = 245
Global $xb1Armory = 1355
Global $yb1Armory = 705
Global $xb1Gas1 = 590
Global $yb1Gas1 = 190
Global $xb1Gas2 = 775
Global $yb1Gas2 = 820
Global $xb1Base2 = 820
Global $yb1Base2 = 445
Global $xb1Base2Gas1 = 425
Global $yb1Base2Gas1 = 760
Global $xb1Base2Gas2 = 935
Global $yb1Base2Gas2 = 120
Global $xb1Mineral = 550
Global $yb1Mineral = 303
Global $xb1base2Mineral = -2
Global $yb1base2Mineral = -2

Global $xb2Colo = 1099
Global $yb2Colo = 99
Global $xb2Barracks = 515
Global $yb2Barracks = 310
Global $xb2BunkerFirst = 1260
Global $yb2BunkerFirst = 445
Global $xb2Engi1 = 325
Global $yb2Engi1 = 445
Global $xb2Engi2 = 290
Global $yb2Engi2 = 590
Global $xb2Factory = 530
Global $yb2Factory = 185
Global $xb2Armory = 350
Global $yb2Armory = 310
Global $xb2Gas1 = 500
Global $yb2Gas1 = 444
Global $xb2Gas2 = 1240
Global $yb2Gas2 = 815
Global $xb2Base2 = 950
Global $yb2Base2 = 440
Global $xb2Base2Gas1 = 515
Global $yb2Base2Gas1 = 645
Global $xb2Base2Gas2 = 1385
Global $yb2Base2Gas2 = 590
Global $xb2Mineral = 940
Global $yb2Mineral = 755
Global $xb2base2Mineral = -2
Global $yb2base2Mineral = -2


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
	Local $check = PixelChecksum($Xx + 1, $Yy + 1, $Xx + 2, $Yy + 2)
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

    $gameTimeStart = _Date_Time_GetTickCount()

    While 1
	  $stillIngame = PixelChecksum($Xx + 375, $Yy + 950, $Xx + 400, $Yy + 975)

	  If $stillIngame = 132907009 Then
		 $gameTime = (_Date_Time_GetTickCount() - $gameTimeStart + 2000) / 10000
		 ToolTip($gameTime*14, $Xx + 390, $Yy + 885)
	  Else
		 Sleep(15000)
		 Send("{s}")
		 Sleep(15000)
		 Click_Leave()
	  EndIf

	  If 7 <= $gameTime*14 AND $gameTime*14 < 8 Then
		 $basePoz1 = PixelChecksum($Xx + 82, $Yy + 933, $Xx + 83, $Yy + 934)
		 $basePoz2 = PixelChecksum($Xx + 107, $Yy + 959, $Xx + 108, $Yy + 960)
		 Sleep(200)

		 ;;; ToolTip($basePoz1 & ' ' & $basePoz2, $Xx + 390, $Yy + 885)
		 ;;; Sleep(20000)

		 If $basePoz1 = 239338033 Then
			$base = 1

			;;; Click CC
			MouseClick("left", $Xx + 1040, $Yy + 440, 2, 0)
			Sleep(100)

			;;; Put on 4
			Send("^4")
			Sleep(100)

			;;; Center
			Send("4")
			Send("4")
			Sleep(100)

			;;; Click CololComp
			MouseClick("left", $Xx + $xb1Colo, $Yy + $yb1Colo, 2, 0)
			Sleep(100)

			;;; Put on 3
			Send("^3")
			Sleep(100)
		 EndIf

		 If $basePoz2 = 239338033 Then
			$base = 2

			;;; Click CC
			MouseClick("left", $Xx + 900, $Yy + 330, 2, 0)
			Sleep(100)

			;;; Put on 4
			Send("^4")
			Sleep(100)

			;;; Center
			Send("4")
			Send("4")
			Sleep(100)

			;;; Click CololComp
			MouseClick("left", $Xx + $xb2Colo, $Yy + $yb2Colo, 2, 0)
			Sleep(100)

			;;; Put on 3
			Send("^3")
			Sleep(100)
		 EndIf

		 ;;;; Select all Workers
		 MouseClickDrag($MOUSE_CLICK_LEFT, $Xx + 35, $Yy + 35, $Xx + 1765, $Yy + 745, 0)
		 Sleep(100)

		 ;;; Select first one
		 MouseClick("left", $Xx + $xWorker, $Yy + $yWorker, 1, 0)
		 Sleep(100)

		 ;;; Set it on 7
		 Send("^7")
		 Sleep(100)

		 ;;;; Select all Workers
		 MouseClickDrag($MOUSE_CLICK_LEFT, $Xx + 35, $Yy + 35, $Xx + 1765, $Yy + 745, 0)
		 Sleep(100)

		 ;;; Select second one
		 MouseClick("left", $Xx + $xWorker + $xWorkerOff, $Yy + $yWorker, 1, 0)
		 Sleep(100)

		 ;;; Set it on 8
		 Send("^8")
		 Sleep(100)

		 ;;;; Select all Workers
		 MouseClickDrag($MOUSE_CLICK_LEFT, $Xx + 35, $Yy + 35, $Xx + 1765, $Yy + 745, 0)
		 Sleep(100)

		 ;;; Select third one
		 MouseClick("left", $Xx + $xWorker + 2 * $xWorkerOff, $Yy + $yWorker, 1, 0)
		 Sleep(100)

		 ;;; Set it on 9
		 Send("^9")
		 Sleep(100)
	  EndIf

	  If 15 <= $gameTime*14 AND $gameTime*14 < 16 Then
		BuildDroneB1()
		BuildDroneB1()
	  EndIf

	  If 36 <= $gameTime*14 AND $gameTime*14 < 37 Then
		BuildOvieB1()
		BuildOvieB1()
	  EndIf

	  If 65 <= $gameTime*14 AND $gameTime*14 < 66 Then
		BuildDroneB1()
		BuildDroneB1()
		BuildDroneB1()
	  EndIf

	  If 70 <= $gameTime*14 AND $gameTime*14 < 71 Then
		BuildBarracks()
	  EndIf

	  If 95 <= $gameTime*14 AND $gameTime*14 < 96 Then
		BuildDroneB1()
		BuildDroneB1()
	  EndIf

	  If 105 <= $gameTime*14 AND $gameTime*14 < 106 Then
		SetCamera3()
		SetCamera4()
	  EndIf

	  If 137 <= $gameTime*14 AND $gameTime*14 < 138 Then
		BuildBunkerFirst()
	  EndIf

	  If 162 <= $gameTime*14 AND $gameTime*14 < 163 Then
		BuildDroneB1()
		BuildDroneB1()
		BuildDroneB1()
		BuildDroneB1()
	  EndIf

	  If 166 <= $gameTime*14 AND $gameTime*14 < 167 Then
		BuildGas1()
		BuildGas2()
	  EndIf

	  If 191 <= $gameTime*14 AND $gameTime*14 < 192 Then
	    GoRocks()
	  EndIf

	  If 198 <= $gameTime*14 AND $gameTime*14 < 199 Then
		BuildOvieB1()
		BuildOvieB1()
		BuildOvieB1()
	  EndIf

	  If 201 <= $gameTime*14 AND $gameTime*14 < 202 Then
		UpgradeColoE()
	  EndIf

	  If 204 <= $gameTime*14 AND $gameTime*14 < 205 Then
		PopGases()
	  EndIf

	  If 230 <= $gameTime*14 AND $gameTime*14 < 231 Then
		BuildAddon()
	  EndIf
	  
	  If 245 <= $gameTime*14 AND $gameTime*14 < 246 Then
		BuildDroneB1()
		BuildDroneB1()
		BuildDroneB1()
		BuildDroneB1()
	  EndIf
		
	  If 252 <= $gameTime*14 AND $gameTime*14 < 253 Then
		BuildEngi1()
		BuildEngi2()
	  EndIf

	  If 280 <= $gameTime*14 AND $gameTime*14 < 281 Then
		BuildBase2()
	  EndIf
	  
	  If 310 <= $gameTime*14 AND $gameTime*14 < 3111 Then
		BuildGas1Base2()
		BuildGas2Base2()
	  EndIf
	
	  If 380 <= $gameTime*14 AND $gameTime*14 < 261 Then
		BuildFactory()
	  EndIf

	  If 450 <= $gameTime*14 AND $gameTime*14 < 281 Then
		BuildArmory()
      EndIf
	
	  If MOD(INT($gameTime*14), 20) = 0 Then
		UseAbilityRally()
	  Else
		UseAbilitySpams()
	  EndIf
	  
	  If MOD(INT($gameTime*14), 60) = 0 Then
		UseAbilityApoc()
	  EndIf
	  
	  If MOD(INT($gameTime*14), 90) = 0 Then
		UseAbilityBC()
	  EndIf
	  
   WEnd
EndFunc


Func SetCamera3()
	MouseClick("left", $Xx + $f5x, $Yy + $f5y, 1, 0)
	Sleep(600)
	Send("^{F3}")
	Sleep(400)
EndFunc

Func SetCamera4()
	MouseClick("left", $Xx + $f6x, $Yy + $f6y, 1, 0)
	Sleep(600)
	Send("^{F4}")
	Sleep(300)

	;;; recenter base
	Send("4")
	Send("4")
	Sleep(100)
EndFunc

Func GoRocks()
    Send("2")
    Sleep(200)

    Send("r")
    Sleep(2000)

    If $base = 1 Then
	   Send("{F3}")
	   Sleep(100)

	   Send("{SHIFTDOWN}")
	   Sleep(100)

	   Send("a")
	   Sleep(200)
	   MouseClick("left", $Xx + $xb1Base2, $Yy + $yb1Base2, 1, 0)
	   Sleep(200)

	   Send("a")
	   Sleep(200)
	   MouseClick("left", $Xx + $xb1Base2Gas1, $Yy + $yb1Base2Gas1, 1, 0)
	   Sleep(200)

	   Send("a")
	   Sleep(200)
	   MouseClick("left", $Xx + $xb1Base2Gas2, $Yy + $yb1Base2Gas2, 1, 0)
	   Sleep(200)

	   Send("{SHIFTUP}")
	   Sleep(100)

	   Send("4")
	   Send("4")
	   Sleep(100)

	   Send("2")
	   Sleep(100)

	   Send("{SHIFTDOWN}")
	   Sleep(100)

	   Send("r")
	   Sleep(100)

	   MouseClick("left", $Xx + $xb1BunkerFirst, $Yy + $yb1BunkerFirst, 1, 0)
	   Sleep(100)

	   Send("{SHIFTUP}")
	   Sleep(100)
    EndIf

    If $base = 2 Then
	   Send("{F4}")
	   Sleep(100)

	   Send("{SHIFTDOWN}")
	   Sleep(100)

	   Send("a")
	   Sleep(200)
	   MouseClick("left", $Xx + $xb2Base2, $Yy + $yb2Base2, 1, 0)
	   Sleep(200)

	   Send("a")
	   Sleep(200)
	   MouseClick("left", $Xx + $xb2Base2Gas1, $Yy + $yb2Base2Gas1, 1, 0)
	   Sleep(200)

	   Send("a")
	   Sleep(200)
	   MouseClick("left", $Xx + $xb2Base2Gas2, $Yy + $yb2Base2Gas2, 1, 0)
	   Sleep(200)

	   Send("{SHIFTUP}")
	   Sleep(100)

	   Send("4")
	   Send("4")
	   Sleep(100)

	   Send("2")
	   Sleep(100)

	   Send("{SHIFTDOWN}")
	   Sleep(100)

	   Send("r")
	   Sleep(100)

	   MouseClick("left", $Xx + $xb2BunkerFirst, $Yy + $yb2BunkerFirst, 1, 0)
	   Sleep(100)

	   Send("{SHIFTUP}")
	   Sleep(100)
    EndIf
	
	Send("4")
	Send("4")
	Sleep(100)
EndFunc


Func BuildDroneB1()
   Send("4")
   Sleep(100)
   Send("s")
   Sleep(100)

   If $base = 1 Then
	  MouseClick("right", $Xx + $xb1Mineral, $Yy + $yb1Mineral, 2, 0)
	  Sleep(100)
   EndIf

   If $base = 2 Then
	  MouseClick("right", $Xx + $xb2Mineral, $Yy + $yb2Mineral, 2, 0)
      Sleep(100)
   EndIf
EndFunc

Func BuildDroneB2()
   Send("0")
   Sleep(100)
   Send("s")
   Sleep(100)

   If $base = 1 Then
	  MouseClick("right", $Xx + $xb1base2Mineral, $Yy + $yb1base2Mineral, 2, 0)
      Sleep(100)
   EndIf

   If $base = 2 Then
	  MouseClick("right", $Xx + $xb2base2Mineral, $Yy + $yb2base2Mineral, 2, 0)
      Sleep(100)
   EndIf
EndFunc

Func BuildOvieB1()
   Send("4")
   Sleep(100)
   Send("v")
   Sleep(100)

   MouseClick("right", $Xx + $xbRallyOvie, $Yy + $ybRallyOvie, 2, 0)
   Sleep(100)
EndFunc

Func BuildOvieB2()
   Send("0")
   Sleep(100)
   Send("v")
   Sleep(100)

   MouseClick("right", $Xx + $xbRallyOvie, $Yy + $ybRallyOvie, 2, 0)
   Sleep(100)
EndFunc


Func PopGases()
	;;; Center on CC
	Send("4")
	Send("4")
	Sleep(100)

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

Func PopGasesBase2()
	;;; Center on CC
	Send("0")
	Send("0")
	Sleep(100)

	;;;; Select all Workers
	MouseClickDrag($MOUSE_CLICK_LEFT, $Xx + 35, $Yy + 35, $Xx + 1765, $Yy + 745, 0)
	Sleep(200)

	Send("{SHIFTDOWN}")
	Sleep(100)

	;;;; Spam Click on 7th position
	MouseClick("left", $Xx + $xWorker + 7 * $xWorkerOff, $Yy + $yWorker, 8, 0)
	MouseClick("left", $Xx + $xWorker + 7 * $xWorkerOff, $Yy + $yWorker, 8, 0)
	MouseClick("left", $Xx + $xWorker + 7 * $xWorkerOff, $Yy + $yWorker, 8, 0)
	Sleep(200)

	Send("{SHIFTUP}")
	Sleep(100)

	If $base = 1 Then
	  MouseClick("right", $Xx + $xb1Base2Gas1, $Yy + $yb1Base2Gas1, 1, 0)
	  Sleep(100)
    EndIf

    If $base = 2 Then
	  MouseClick("right", $Xx + $xb2Base2Gas1, $Yy + $yb2Base2Gas1, 1, 0)
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
	  MouseClick("right", $Xx + $xb1Base2Gas2, $Yy + $yb1Base2Gas2, 1, 0)
	  Sleep(100)
    EndIf

    If $base = 2 Then
	  MouseClick("right", $Xx + $xb2Base2Gas2, $Yy + $yb2Base2Gas2, 1, 0)
	  Sleep(100)
    EndIf
EndFunc


Func BuildGas1()
	;;;; Select 8 worker
	Send("8")
	Sleep(100)

	If $base = 1 Then
	  ;;;; Send to the Gas1 position
	  MouseClick("right", $Xx + $xb1Gas1, $Yy + $yb1Gas1, 1, 0)
	  Sleep(3000)

	  Send("b")
	  Sleep(100)
	  Send("r")
	  Sleep(100)

	  MouseClick("left", $Xx + $xb1Gas1, $Yy + $yb1Gas1, 1, 0)
	  Sleep(100)
	  
	  Send("{SHIFTDOWN}")
	  Sleep(100)
	  
	  MouseClick("right", $Xx + $xb1Mineral, $Yy + $yb1Mineral, 1, 0)
	
	  Send("{SHIFTUP}")
  	  Sleep(100)
   EndIf

   If $base = 2 Then
	  ;;;; Send to the Gas1 position
	  MouseClick("right", $Xx + $xb2Gas1, $Yy + $yb2Gas1, 1, 0)
	  Sleep(3000)

	  Send("b")
	  Sleep(100)
	  Send("r")
	  Sleep(100)

	  MouseClick("left", $Xx + $xb2Gas1, $Yy + $yb2Gas1, 1, 0)
	  Sleep(100)
	  
	  Send("{SHIFTDOWN}")
	  Sleep(100)
	  
	  MouseClick("right", $Xx + $xb2Mineral, $Yy + $yb2Mineral, 1, 0)
	
	  Send("{SHIFTUP}")
  	  Sleep(100)
   EndIf
EndFunc

Func BuildGas2()
	;;;; Select 9 worker
	Send("9")
	Sleep(100)

	If $base = 1 Then
	  ;;;; Send to the Gas1 position
	  MouseClick("right", $Xx + $xb1Gas2, $Yy + $yb1Gas2, 1, 0)
	  Sleep(3000)

	  Send("b")
	  Sleep(100)
	  Send("r")
	  Sleep(100)

	  MouseClick("left", $Xx + $xb1Gas2, $Yy + $yb1Gas2, 1, 0)
	  Sleep(100)
	  
	  Send("{SHIFTDOWN}")
	  Sleep(100)
	  
	  MouseClick("right", $Xx + $xb1Mineral, $Yy + $yb1Mineral, 1, 0)
	
	  Send("{SHIFTUP}")
  	  Sleep(100)
   EndIf

   If $base = 2 Then
	  ;;;; Send to the Gas1 position
	  MouseClick("right", $Xx + $xb2Gas2, $Yy + $yb2Gas2, 1, 0)
	  Sleep(3000)

	  Send("b")
	  Sleep(100)
	  Send("r")
	  Sleep(100)

	  MouseClick("left", $Xx + $xb2Gas2, $Yy + $yb2Gas2, 1, 0)
	  Sleep(100)
	  
	  Send("{SHIFTDOWN}")
	  Sleep(100)
	  
	  MouseClick("right", $Xx + $xb2Mineral, $Yy + $yb2Mineral, 1, 0)
	
	  Send("{SHIFTUP}")
  	  Sleep(100)
   EndIf
EndFunc

Func BuildGas1Base2()
	;;;; Select 8 worker
	Send("8")
	Sleep(100)

	If $base = 1 Then
	  Send("{F3}")
	  Sleep(100)
	  
	  ;;;; Send to the Gas1 position
	  MouseClick("right", $Xx + $xb1Base2Gas1, $Yy + $yb1Base2Gas1, 1, 0)
	  Sleep(10000)

	  Send("b")
	  Sleep(100)
	  Send("r")
	  Sleep(100)

	  MouseClick("left", $Xx + $xb1Base2Gas1, $Yy + $yb1Base2Gas1, 1, 0)
	  Sleep(100)
   EndIf

   If $base = 2 Then
      Send("{F4}")
	  Sleep(100)
	  
	  ;;;; Send to the Gas1 position
	  MouseClick("right", $Xx + $xb2Base2Gas1, $Yy + $yb2Base2Gas1, 1, 0)
	  Sleep(10000)

	  Send("b")
	  Sleep(100)
	  Send("r")
	  Sleep(100)

	  MouseClick("left", $Xx + $xb2Base2Gas1, $Yy + $yb2Base2Gas1, 1, 0)
	  Sleep(100)
   EndIf
EndFunc

Func BuildGas2Base2()
	;;;; Select 9 worker
	Send("9")
	Sleep(100)

	If $base = 1 Then
	  Send("{F3}")
	  Sleep(100)
	  
	  ;;;; Send to the Gas1 position
	  MouseClick("right", $Xx + $xb1Base2Gas2, $Yy + $yb1Base2Gas2, 1, 0)
	  Sleep(3000)

	  Send("b")
	  Sleep(100)
	  Send("r")
	  Sleep(100)

	  MouseClick("left", $Xx + $xb1Base2Gas2, $Yy + $yb1Base2Gas2, 1, 0)
	  Sleep(100)
   EndIf

   If $base = 2 Then
      Send("{F4}")
	  Sleep(100)
	  
	  ;;;; Send to the Gas1 position
	  MouseClick("right", $Xx + $xb2Base2Gas2, $Yy + $yb2Base2Gas2, 1, 0)
	  Sleep(3000)

	  Send("b")
	  Sleep(100)
	  Send("r")
	  Sleep(100)

	  MouseClick("left", $Xx + $xb2Base2Gas2, $Yy + $yb2Base2Gas2, 1, 0)
	  Sleep(100)
   EndIf
EndFunc


Func BuildBase2()
   Send("7")
   Sleep(100)

   If $base = 1 Then
	  Send("{F3}")
	  Sleep(100)
	  
	  ;;;; Send to the CC position
	  MouseClick("right", $Xx + $xb1Base2, $Yy + $yb1Base2, 1, 0)
	  Sleep(10000)

	  Send("b")
	  Sleep(100)
	  Send("b")
	  Sleep(100)

	  MouseClick("left", $Xx + $xb1Base2, $Yy + $yb1Base2, 1, 0)
	  Sleep(2000)

	  MouseClick("left", $Xx + $xb1Base2, $Yy + $yb1Base2, 1, 0)
	  Sleep(100)
	  Send("{SHIFTDOWN}")
	  Sleep(100)
	  Send("0")
	  Sleep(100)
	  Send("{SHIFTUP}")
	  Sleep(100)
   EndIf

   If $base = 2 Then
	  Send("{F4}")
	  Sleep(100)
	  
	  ;;;; Send to the CC position
	  MouseClick("right", $Xx + $xb2Base2, $Yy + $yb2Base2, 1, 0)
	  Sleep(10000)

	  Send("b")
	  Sleep(100)
	  Send("b")
	  Sleep(100)

	  MouseClick("left", $Xx + $xb2Base2, $Yy + $yb2Base2, 1, 0)
	  Sleep(2000)

	  MouseClick("left", $Xx + $xb2Base2, $Yy + $yb2Base2, 1, 0)
	  Sleep(100)
	  Send("{SHIFTDOWN}")
	  Sleep(100)
	  Send("0")
	  Sleep(100)
	  Send("{SHIFTUP}")
	  Sleep(100)
   EndIf
EndFunc


Func BuildAddon()
	;;;; Center on CC
	Send("4")
	Send("4")
	Sleep(100)

	;;; Send command to upgrade to TechLab
	Send("5")
	Send("x")
	Sleep(2000)

	If $base = 1 Then
		MouseClick("left", $Xx + $xb1Barracks + $xbAddon, $Yy + $yb1Barracks + $ybAddon, 1, 0)
		Sleep(100)
		Send("^5")
		Sleep(100)
	EndIf
	
	If $base = 2 Then
		MouseClick("left", $Xx + $xb2Barracks + $xbAddon, $Yy + $yb2Barracks + $ybAddon, 1, 0)
		Sleep(100)
		Send("^5")
		Sleep(100)
	EndIf
	
	;;; recenter base
	Send("4")
	Send("4")
	Sleep(100)
EndFunc

Func BuildBunkerFirst()
	;;;; Center on CC
	Send("4")
	Send("4")
	Sleep(100)

	;;;; Select 7 worker
	Send("7")
	Sleep(100)

	If $base = 1 Then
	  ;;;; Send to the Bunker position
	  MouseClick("right", $Xx + $xb1BunkerFirst, $Yy + $yb1BunkerFirst, 1, 0)
	  Sleep(4000)

	  Send("b")
	  Sleep(100)
	  Send("u")
	  Sleep(100)

	  MouseClick("left", $Xx + $xb1BunkerFirst, $Yy + $yb1BunkerFirst, 1, 0)
	  Sleep(1000)

	  MouseClick("left", $Xx + $xb1BunkerFirst, $Yy + $yb1BunkerFirst, 1, 0)
	  Sleep(100)
	  Send("{SHIFTDOWN}")
	  Sleep(100)
	  Send("2")
	  Sleep(100)
	  Send("{SHIFTUP}")
	  Sleep(100)
   EndIf

   If $base = 2 Then
	  ;;;; Send to the Bunker position
	  MouseClick("right", $Xx + $xb2BunkerFirst, $Yy + $yb2BunkerFirst, 1, 0)
	  Sleep(4000)

	  Send("b")
	  Sleep(100)
	  Send("u")
	  Sleep(100)

	  MouseClick("left", $Xx + $xb2BunkerFirst, $Yy + $yb2BunkerFirst, 1, 0)
	  Sleep(2000)

	  MouseClick("left", $Xx + $xb2BunkerFirst, $Yy + $yb2BunkerFirst, 1, 0)
	  Sleep(100)
	  Send("{SHIFTDOWN}")
	  Sleep(100)
	  Send("2")
	  Sleep(100)
	  Send("{SHIFTUP}")
	  Sleep(100)
   EndIf
   
   ;;; recenter base
   Send("4")
   Send("4")
   Sleep(100)
EndFunc

Func BuildBarracks()
	;;;; Center on CC
	Send("4")
	Send("4")
	Sleep(100)

	;;;; Select 7 worker
	Send("7")
	Sleep(100)

	If $base = 1 Then
	  ;;;; Send to the Barracks position
	  MouseClick("right", $Xx + $xb1Barracks, $Yy + $yb1Barracks, 1, 0)
	  Sleep(3000)

	  Send("b")
	  Sleep(100)
	  Send("b")
	  Sleep(100)

	  MouseClick("left", $Xx + $xb1Barracks, $Yy + $yb1Barracks, 1, 0)
	  Sleep(1500)

	  MouseClick("left", $Xx + $xb1Barracks, $Yy + $yb1Barracks, 1, 0)
	  Sleep(100)
	  Send("{SHIFTDOWN}")
	  Sleep(100)
	  Send("5")
	  Sleep(100)
	  Send("{SHIFTUP}")
	  Sleep(100)
   EndIf

   If $base = 2 Then
	  ;;;; Send to the Barracks position
	  MouseClick("right", $Xx + $xb2Barracks, $Yy + $yb2Barracks, 1, 0)
	  Sleep(3000)

	  Send("b")
	  Sleep(100)
	  Send("b")
	  Sleep(100)

	  MouseClick("left", $Xx + $xb2Barracks, $Yy + $yb2Barracks, 1, 0)
	  Sleep(1500)

	  MouseClick("left", $Xx + $xb2Barracks, $Yy + $yb2Barracks, 1, 0)
	  Sleep(100)
	  Send("{SHIFTDOWN}")
	  Sleep(100)
	  Send("5")
	  Sleep(100)
	  Send("{SHIFTUP}")
	  Sleep(100)
   EndIf
   
   ;;; recenter base
   Send("4")
   Send("4")
   Sleep(100)
EndFunc

Func BuildFactory()
	;;;; Center on CC
	Send("4")
	Send("4")
	Sleep(100)

	;;;; Select 7 worker
	Send("7")
	Sleep(100)

	If $base = 1 Then
	  ;;;; Send to the Factory position
	  MouseClick("right", $Xx + $xb1Factory, $Yy + $yb1Factory, 1, 0)
	  Sleep(10000)

	  Send("v")
	  Sleep(100)
	  Send("f")
	  Sleep(100)

	  MouseClick("left", $Xx + $xb1Factory, $Yy + $yb1Factory, 1, 0)
	  Sleep(100)
   EndIf

   If $base = 2 Then
	  ;;;; Send to the Barracks position
	  MouseClick("right", $Xx + $xb2Factory, $Yy + $yb2Factory, 1, 0)
	  Sleep(10000)

	  Send("v")
	  Sleep(100)
	  Send("f")
	  Sleep(100)

	  MouseClick("left", $Xx + $xb2Factory, $Yy + $yb2Factory, 1, 0)
	  Sleep(100)
   EndIf
   
   ;;; recenter base
   Send("4")
   Send("4")
   Sleep(100)
EndFunc

Func BuildArmory()
	;;;; Select 7 worker
	Send("7")
	Sleep(100)

	If $base = 1 Then
	  ;;;; Send to the Armory position
	  MouseClick("right", $Xx + $xb1Armory, $Yy + $yb1Armory, 1, 0)
	  Sleep(4000)

	  Send("v")
	  Sleep(100)
	  Send("a")
	  Sleep(100)

	  MouseClick("left", $Xx + $xb1Armory, $Yy + $yb1Armory, 1, 0)
	  Sleep(100)
   EndIf

   If $base = 2 Then
	  ;;;; Send to the Armory position
	  MouseClick("right", $Xx + $xb2Armory, $Yy + $yb2Armory, 1, 0)
	  Sleep(4000)

	  Send("v")
	  Sleep(100)
	  Send("a")
	  Sleep(100)

	  MouseClick("left", $Xx + $xb2Armory, $Yy + $yb2Armory, 1, 0)
	  Sleep(100)
   EndIf
   
   ;;; recenter base
   Send("4")
   Send("4")
   Sleep(100)
EndFunc


Func BuildEngi1()
	;;;; Select 8 worker
	Send("8")
	Sleep(100)

	If $base = 1 Then
	  ;;;; Send to the Engi1 position
	  MouseClick("right", $Xx + $xb1Engi1, $Yy + $yb1Engi1, 1, 0)
	  Sleep(5000)

	  Send("b")
	  Sleep(100)
	  Send("e")
	  Sleep(100)

	  MouseClick("left", $Xx + $xb1Engi1, $Yy + $yb1Engi1, 1, 0)
	  Sleep(1500)

	  MouseClick("left", $Xx + $xb1Engi1, $Yy + $yb1Engi1, 1, 0)
	  Sleep(100)
	  Send("{SHIFTDOWN}")
	  Sleep(100)
	  Send("6")
	  Sleep(100)
	  Send("{SHIFTUP}")
	  Sleep(100)
   EndIf

   If $base = 2 Then
	  ;;;; Send to the Engi1 position
	  MouseClick("right", $Xx + $xb2Engi1, $Yy + $yb2Engi1, 1, 0)
	  Sleep(5000)

	  Send("b")
	  Sleep(100)
	  Send("e")
	  Sleep(100)

	  MouseClick("left", $Xx + $xb2Engi1, $Yy + $yb2Engi1, 1, 0)
	  Sleep(1500)

	  MouseClick("left", $Xx + $xb2Engi1, $Yy + $yb2Engi1, 1, 0)
	  Sleep(100)
	  Send("{SHIFTDOWN}")
	  Sleep(100)
	  Send("6")
	  Sleep(100)
	  Send("{SHIFTUP}")
	  Sleep(100)
   EndIf
   
   ;;; recenter base
   Send("4")
   Send("4")
   Sleep(100)
EndFunc

Func BuildEngi2()
	;;;; Select 9 worker
	Send("9")
	Sleep(100)

	If $base = 1 Then
	  ;;;; Send to the Engi1 position
	  MouseClick("right", $Xx + $xb1Engi2, $Yy + $yb1Engi2, 1, 0)
	  Sleep(5000)

	  Send("b")
	  Sleep(100)
	  Send("e")
	  Sleep(100)

	  MouseClick("left", $Xx + $xb1Engi2, $Yy + $yb1Engi2, 1, 0)
	  Sleep(1500)

	  MouseClick("left", $Xx + $xb1Engi2, $Yy + $yb1Engi2, 1, 0)
	  Sleep(100)
	  Send("{SHIFTDOWN}")
	  Sleep(100)
	  Send("6")
	  Sleep(100)
	  Send("{SHIFTUP}")
	  Sleep(100)
   EndIf

   If $base = 2 Then
	  ;;;; Send to the Engi1 position
	  MouseClick("right", $Xx + $xb2Engi2, $Yy + $yb2Engi2, 1, 0)
	  Sleep(5000)

	  Send("b")
	  Sleep(100)
	  Send("e")
	  Sleep(100)

	  MouseClick("left", $Xx + $xb2Engi2, $Yy + $yb2Engi2, 1, 0)
	  Sleep(1500)

	  MouseClick("left", $Xx + $xb2Engi2, $Yy + $yb2Engi2, 1, 0)
	  Sleep(100)
	  Send("{SHIFTDOWN}")
	  Sleep(100)
	  Send("6")
	  Sleep(100)
	  Send("{SHIFTUP}")
	  Sleep(100)
   EndIf
   
   ;;; recenter base
   Send("4")
   Send("4")
   Sleep(100)
EndFunc


Func UpgradeBarracks1()
	Send("5")
	Sleep(200)
	Send("r")
	Sleep(200)
EndFunc

Func UpgradeBarracks2()
	Send("5")
	Sleep(200)
	Send("g")
	Sleep(200)
EndFunc

Func UpgradeCC()
	Send("4")
	Sleep(200)
	Send("g")
	Sleep(200)
EndFunc

Func EngUpgradeA()
	Send("6")
	Sleep(200)
	;;; 2-3 times
	Send("a")
	Sleep(200)
EndFunc

Func EngUpgradeE()
	Send("6")
	Sleep(200)
	;;; 2-3 times
	Send("e")
	Sleep(200)
EndFunc

Func UpgradeColoA()
	Send("3")
	Sleep(200)
	;;; 1 time
	Send("a")
	Sleep(200)
EndFunc

Func UpgradeColoD()
	Send("3")
	Sleep(200)
	;;; 1 time
	Send("d")
	Sleep(200)
EndFunc

Func UpgradeColoE()
	Send("3")
	Sleep(200)
	;;; 3 times
	Send("e")
	Sleep(200)
EndFunc


Func UseAbilityRally()
	Send("{F5}")
	Sleep(100)

	Local $rX = 0
	Local $rY = 0
	Local $offX = 0
	Local $offY = 0

	$rX = Random(0, 10, 1) - 5
	$rY = Random(0, 10, 1) - 5

	;;; shard 1
	If 0 <= $gameTime*14 AND $gameTime*14 < 6*60 Then
		$offX = $z1X
		$offY = $z1Y
	EndIf

	;;; shard 2
	If 6*60 <= $gameTime*14 AND $gameTime*14 < 11*60 Then
		$offX = $z2X
		$offY = $z2Y
	EndIf

	;;; shard 3
	If 11*60 <= $gameTime*14 AND $gameTime*14 < 15*60 Then
		$offX = $z3X
		$offY = $z3Y
	EndIf

	;;; shard 4
	If 15*60 <= $gameTime*14 Then
		$offX = $z4X
		$offY = $z4Y
	EndIf

	;;; att 1
	If 3*60+10 <= $gameTime*14 AND $gameTime*14 < 3*60+90 Then
		$offX = $z5X
		$offY = $z5Y
	EndIf

	;;; att 2
	If 6*60+10 <= $gameTime*14 AND $gameTime*14 < 6*60+90 Then
		$offX = $z5X
		$offY = $z5Y
	EndIf

	;;; att 3
	If 9*60+10 <= $gameTime*14 AND $gameTime*14 < 9*60+90 Then
		$offX = $z6X
		$offY = $z6Y
	EndIf

	;;; att 4
	If 12*60+10 <= $gameTime*14 AND $gameTime*14 < 12*60+90 Then
		$offX = $z6X
		$offY = $z6Y
	EndIf

	;;; att 5
	If 15*60+10 <= $gameTime*14 AND $gameTime*14 < 15*60+90 Then
		$offX = $z5X
		$offY = $z5Y
	EndIf

	;;; att 6
	If 18*60+10 <= $gameTime*14 AND $gameTime*14 < 18*60+90 Then
		$offX = $z5X
		$offY = $z5Y
	EndIf

	;;; att 7
	If 21*60+10 <= $gameTime*14 AND $gameTime*14 < 21*60+90 Then
		$offX = $z6X
		$offY = $z6Y
	EndIf

	;;; att 8
	If 24*60+10 <= $gameTime*14 AND $gameTime*14 < 24*60+90 Then
		$offX = $z6X
		$offY = $z6Y
	EndIf

	MouseClick("left", $Xx + $rX + $offX, $Yy + $rY + $offY, 1, 0)
	Sleep(100)
	MouseClick("left", $Xx + $rX + $offX, $Yy + $rY + $offY, 1, 0)
	Sleep(100)

	;;;; go back to main
	Send("4")
	Send("4")
	Sleep(100)
EndFunc

Func UseAbilitySpams()
	For $ix = 100 To 1400 Step +400
		For $iy = 100 To 900 Step +400
			Send("{F5}")
			Sleep(25)
			MouseClick("left", $Xx + $ix, $Yy + $iy, 1, 0)
			Sleep(25)
		Next
	Next
EndFunc

Func UseAbilityApoc()
	Send("{F7}")
	Sleep(200)

	Local $rX = 0
	Local $rY = 0

	For $i = 1 To 8 Step +1
		$rX = Random(400, 1400, 1)
		$rY = Random(200, 900, 1)

		MouseClick("left", $Xx + $rX, $Yy + $rY, 1, 0)
		Sleep(50)
	Next

	Send("{SPACE}")
	Sleep(200)
	Send("a")
	Sleep(200)

	Send("{SHIFTDOWN}")
	Sleep(200)

	For $i = 1 To 8 Step +1
		$rX = Random(400, 1400, 1)
		$rY = Random(200, 900, 1)

		MouseClick("left", $Xx + $rX, $Yy + $rY, 1, 0)
		Sleep(50)
	Next

	Send("{SHIFTUP}")
	Sleep(200)
EndFunc

Func UseAbilityBC()
	Send("{F8}")
	Sleep(200)

	Local $rX = 0
	Local $rY = 0

	For $i = 1 To 8 Step +1
		$rX = Random(400, 1400, 1)
		$rY = Random(200, 900, 1)

		MouseClick("left", $Xx + $rX, $Yy + $rY, 1, 0)
		Sleep(50)
	Next

	Send("{SPACE}")
	Sleep(200)
	Send("a")
	Sleep(200)

	Send("{SHIFTDOWN}")
	Sleep(200)

	For $i = 1 To 8 Step +1
		$rX = Random(400, 1400, 1)
		$rY = Random(200, 900, 1)

		MouseClick("left", $Xx + $rX, $Yy + $rY, 1, 0)
		Sleep(50)
	Next

	Send("{SHIFTUP}")
	Sleep(200)
EndFunc
