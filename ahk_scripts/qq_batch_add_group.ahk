; -*-coding:utf-8 -*-
#SingleInstance,Force
SetTitleMatchMode RegEx
SetTitleMatchMode, slow
;1. qq快速加群工具
;     使用方法
;     手动点击开 查找->找群->并输入关键字后
;     会出现一系列的群，
;     然后启动此脚本后，在qq加群窗口上按下ctrl+j 来触发点击页面上加群按钮

;2. ctrl+o
;    打开所有的群
;   用法，将光标定位在第一个群的位置，然后按下ctrl-o
;   建议在qq->设置中 不要勾选合并所有窗口,以方例后续给每个窗口发消息

;3. ctrl+s 给所有打开的窗口发消息，消息内容为剪切板里的东西




addQun(x,y)
{
    WinGetClass, activeWinClass ,A
    if (activeWinClass="TXGuiFoundation")
    {
    }else{
        return false
    }


    MouseClick, left, x,y
    sleep, 3000
    MouseClick, left, 345,345      ;
    sleep, 3000
    MouseClick, left, 406,340      ;
    return true
}
click3(y)
{
    if(!addQun(266,y)){
        return false

    }
    sleep,61000
    if(!addQun(560,y)){
        return false
    }
    sleep,61000
    if(!addQun(854,y)){
        return false
    }
    return true
}
click6(y)
{
    if(!click3(y)){
        return false
    }
    sleep,60000
    if(!click3(y+170)){
        return false
    }
    sleep,120000
    return true
}
doOneLoop(n)
{
    diff :=0                    ; 每一次循环导致的像素偏差
    if(!click6(340-diff)){
        return false
    }
    Send {Down 9}
    if(!click6(320-diff)){
        return false
    }
    Send {Down 9}
    if(!click6(300-diff)){
        return false
    }
    Send {Down 9}
    if(!click6(280-diff)){
        return false

    }
    Send {Down 3}
    sleep,30000
    return true

}

doAddGroup()
{
    Loop,100{
        if(!doOneLoop(A_Index)){
            msgbox,"exit add qq group"
            return
        }
        sleep, 1000
    }
    return
}





; 打开所有的群
;用法，将光标定位在第一个群的位置，然后按下ctrl-o
;建议在qq->设置中 不要勾选合并所有窗口,以方例后续给每个窗口发消息

openAllQQGroup(){
    WinGet,wid,ID,A
    WinActivate,ahk_id %wid%
    MouseGetPos, xpos, ypos

    InputBox, groupCnt, the count of your qq group,the count of your qq group, , 200, 120
    if ErrorLevel{

        MsgBox, CANCEL was pressed.
        } else{
        Loop,%groupCnt%{
            WinActivate,ahk_id %wid%
            MouseClick,left,xpos,ypos
            Send {Left }
            Send {Right }
            Send {Down %A_Index%}
            Send {Enter}
            Send {Enter}
        }
    }
    return


 }

; 给所有打开的窗口发消息，消息内容为剪切板里的东西

sendToEach(){
  WinGet, id, list, , , Program Manager
  Loop, %id%
  {
        StringTrimRight, this_id, id%a_index%, 0
        WinGetTitle, title, ahk_id %this_id%
        WinGetClass, activeWinClass ,ahk_id %this_id%
        ; FIXME: windows with empty titles?
        if (title =="" or title=="QQ")
        {
            continue
        }

        if (activeWinClass="TXGuiFoundation")
        {
            WinActivate,ahk_id %this_id%
            send ^v
            send {Enter}
            send ^{Enter}
        }
    }

}


#IfWinActive ahk_class TXGuiFoundation
^j::doAddGroup()
^o::openAllQQGroup()
^s::sendToEach()
#IfWinActive
