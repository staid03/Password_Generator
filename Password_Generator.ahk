/*﻿
;Best viewed in Notepad++ with the AHK syntax file installed.
;This file runs through AutoHotkey a highly versatile freeware scripting program.
;
; AutoHotkey Version: 104805
; Language:       English
; Platform:       Windows 7
; Author:         staid03
; Version   Date        Author       Comments
;     0.1   04-MAY-18   staid03      Initial
;
; Script Function:
;    GUI to generate passwords for users
;
 
;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
*/
#singleinstance , force

mytext = %1%

gui , add , picture , x0 y0 h200 w370 , background\background.jpg
gui , font , s15
gui , add , edit , x115 y20 w150,  %mytext%
gui , font , s20
gui , add , button , x155 y120 default , Generate
gui , font , s8
gui , add , button , x155 y175 , Open Folder
gui , add , button , x245 y175 , About
gui , show , , Password Generator
return

buttonGenerate:
{
	created_password := generatepassword()
	run , %a_scriptname% %created_password%
	
}
return 

buttonOpenFolder:
{
	run , explorer %a_scriptdir%
}
return 
buttonAbout:
{
	run , notepad aboutme.txt
}
return 

generatepassword()
{
	wordlistfolder = %a_scriptdir%\wordlists\
	file_foldercheck(wordlistfolder)

	3letters = %wordlistfolder%3letterwords.txt
	4letters = %wordlistfolder%4letterwords.txt
	5letters = %wordlistfolder%5letterwords.txt
	6letters = %wordlistfolder%6letterwords.txt
	7letters = %wordlistfolder%7letterwords.txt
	8letters = %wordlistfolder%8letterwords.txt
	file_foldercheck(3letters)
	file_foldercheck(4letters)
	file_foldercheck(5letters)
	file_foldercheck(6letters)
	file_foldercheck(7letters)
	file_foldercheck(8letters)
	;3letterwords

	random , randomNum , 3 , 8
	randomWordList := %randomNum%letters
	ifless , randomNum , 5
	{
		wordOne := getRandomWord(randomWordList)
		random , randomNum , 3 , 4
		randomWordList := %randomNum%letters
		wordTwo := getRandomWord(randomWordList)
		rawPassword = %wordOne%%wordTwo%		
	}
	else
	{
		rawPassword := getRandomWord(randomWordList)
	}
	
	toughenedPassword := toughify(rawPassword)
	return toughenedPassword
}
return

file_foldercheck(fname)
{
	ifnotexist , %fname%
	{
		msgbox ,,, [___%fname%___] file/folder not found, script ending here
		exit
	}
}
return

getRandomWord(WordList)
{
	random , randomWordLine , 1 , 500
	filereadline , passwordReturn , %WordList% , %randomWordLine%
	;msgbox ,,, %passwordReturn%
	return passwordReturn
}
return

toughify(rawPassword)
{
	stringlower, rawPassword, rawPassword , T
	ifinstring , rawPassword , a
	{
		stringreplace , rawPassword , rawPassword , a , @		
	}
	else
	{
		ifinstring , rawPassword , e
		{
			stringreplace , rawPassword , rawPassword , e , 3		
		}
		else
		{
			ifinstring , rawPassword , t
			{
				stringreplace , rawPassword , rawPassword , t , 7		
			}
			else
			{
				ifinstring , rawPassword , b
				{
					stringreplace , rawPassword , rawPassword , b , 8		
				}			
				else
				{
					ifinstring , rawPassword , i
					{
						stringreplace , rawPassword , rawPassword , i , 1		
					}
					else
					{
						ifinstring , rawPassword , s
						{
							stringreplace , rawPassword , rawPassword , s , 5		
						}
					}
				}
			}
		}		
	}
	random , suffixNum , 1 , 99
	upgradedPassword = %rawPassword%%suffixNum%
	return upgradedPassword
}
return 