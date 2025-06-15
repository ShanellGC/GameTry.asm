// GameTry.asm.cpp : This file contains the 'main' function. Program execution begins and ends there.
//; Program Name:   Template (Template.asm)				
//; Program Description:							
//• Shanell Chavez
//• CSC 2025.X42 (CRN: 12625) 
//• Instructor: Pam Phillips
//• 6/5/2025							


INCLUDE C : \Irvine\Irvine32.inc
INCLUDELIB C : \Irvine\Irvine32.lib

.data


maxTrys DWORD 12                 // ;the max allowed of attempts;

minGuesses DWORD 1                // ; the min value allowed to guess;


maxGuesses DWORD 40                //  ; the min value allowed to guess;

userGuesses DOWORD ?              // ; stores users guess

generatedNumber DWORD ?            //; stores random number


Guesses DWORD ?                   //; tracker for the attempt / guesses



messtooMuch BYTE "The number is too high, please try again.", 0          //; output message if too high of a guess

messTooLittle BYTE " The number is too low, please try again.", 0           //; output message if too lil of a guess


messJustRight BYTE " YES ! You guessed the number. CONGRATS", 0            //; output message if guess is correct


messFailed BYTE " Exceeded! The correct number was: ", 0          //; output message if reached max trys


messPrompt BYTE " Guess a number between 1 and 40:", 0              //; output message for users to enter guess


messIncorrect BYTE " Invalid! Please enter a number between 1 and 50.", 0             //; out if num is out of range




//;  Initializes the game, generates a random number,
//; and manages the game loop.
//;  Displays prompts and messages to the user.
//; Memory Usage : Uses `generatedNumber`, `userGuesses`, and `guesses`.
//; Registers Used : EAX, EDX, ECX
//; ---------------------------------------------------- -


.code


main PROC

call GetCount               //; Get system time to use as seed


mov eax, edx               //; the timestamp value

mov ecx, maxGuesses               //; the divisor for range of guesses

div ecx                         //; EAX / ECX, remainder in EDX


add edx, minGuesses                  //; Adjust to start at  min then add


mov generatedNumber, edx                //; stores generated number



startGameLoop:

cmp attempts, maxGuesses                   //Checks if max guesses has been reached


jge gameOver                          //; If exceeded max, end the game



mov edx, OFFSET messPrompt                   //; Prompts the user for the input number


call WriteString                             //; the user for the input number


call ReadInt                          //; Reads the users input


mov userGuesses, eax                         //; stores the users input

cmp userGuesses, minGuesses                      //; input(must be within min and max)

jl invalidInput                         //; If  its below range, show invalid message


cmp userGuesses, maxGuesses


jg invalidInput                                     //; If its  above range, show invalid message


cmp userGuesses, generatedNumber                          //; Compare guesses


je correctGuess                                       //; If match, player wins


jl tooLow                                      //; If less, tell too low



jg tooHigh                                  //; If hugh, tell too hight



tooLow:                            //Show hint message

mov edx, OFFSET messTooLittle


call WriteString

inc attempts

jmp gameLoop



tooHigh:                                   //; Show hint message

mov edx, OFFSET messtooMuch


call WriteString

inc attempts

jmp gameLoop



invalidInput:                                 //; Show invalid message

mov edx, OFFSET messIncorrect


call WriteString

inc attempts                             //; Increment attempt counter

jmp gameLoop                                  //; Continue loop



correctGuess:                                              //; Show success message

mov edx, OFFSET messJustRight


call WriteString



jmp playAgainPrompt                                   //;  replay option


gameOver:                                           ///; Show failure message


mov edx, OFFSET messageFailed



call WriteString


mov eax, generatedNumber                            //; Display correct number for users




call WriteInt




jmp playAgainPrompt                                  //;  replay option


playAgainPrompt :                     //;  replay option






call Exit                                    //; Exit the program


//INVOKE ExitProcess,0

main ENDP

END main
