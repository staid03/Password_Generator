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

renewGUI:

;create GUI
gui , add , picture , x0 y0 h200 w370 , background\background.jpg
gui , font , s15
gui , add , edit , x115 y20 w150,  %newPassword%
gui , font , s20
gui , add , button , x155 y120 default , Generate
gui , font , s8
gui , add , button , x155 y175 , Open Folder
gui , add , button , x245 y175 , About
gui , show , , Password Generator
return

buttonGenerate:
{
	newPassword := generatepassword()
	gui , destroy
	goto , renewGUI	
}
return 

buttonOpenFolder:
{
	run , explorer %a_scriptdir%
}
return 
buttonAbout:
{
	aboutme = aboutme.txt
	file_foldercheck(aboutme)
	run , notepad %aboutme%
}
return 

generatepassword()
{
	;location of the wordlists
	wordlistfolder = %a_scriptdir%\wordlists\
	file_foldercheck(wordlistfolder)

	;variables of wordlist files
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

	;generate number to use to determine which list to use
	random , randomNum , 3 , 8
	randomWordList := %randomNum%letters
	
	;if using a 3 or 4 letter base word then add another 3 or 4 letter word onto it
	iflessorequal , randomNum , 4
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
	return passwordReturn
}
return

toughify(rawPassword)
{
	;make the first letter a capital
	stringlower, rawPassword, rawPassword , T
	
	;replace a letter with a symbol
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
	
	;generate a random number to use as a suffix
	random , suffixNum , 10 , 99
	upgradedPassword = %rawPassword%%suffixNum%

	return upgradedPassword
}
return 