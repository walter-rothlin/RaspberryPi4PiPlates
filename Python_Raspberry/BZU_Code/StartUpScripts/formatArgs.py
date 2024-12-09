#!/usr/bin/env python

#@version 1.0
#@since 18.07.2017
#@help
#Help of command 'formatArgs'
#
#This command formats the arguments of another script.
#Arguments will be put on the same line with its options.
#
#(This does not count when informational options are given):
#The first argument has to be the arguments to be formatted.
#The arguments are split like normal (by space).
#To pass the as one arguments, just put quotes around it.
#
#The secound argument has to be pattern for the options.
#Each option is split by ';' (without the quotes).
#The options may require one or more arguments following it:
#'o' = option o without any arguments.
#'o:' = option with one argument.
#'o?' = option with zero or one argument.
#'o+' = option with one or more arguments.
#'o*' = option with zero or more arguments.
#Use '-o' to make the user have to type '--o'
#A pattern may look like this:
#'o:;i;r*;h;-h;-help;v;-v;-version'
#
#In the result, each option present in the arguments
#will be listed with its following arguments that are
#defined in the pattern (with :/?/+/*).
#It will look like this:
#o=argOfO
#i
#r=arg1OfR;arg2OfR
#args=Any;other;args;not;associated;with;an;option
#
#If any invalid options are in the arguments,
#the result will be:
#invOpt=all;invalid;options;found
#
#
#Options:
#
#INFORMATION OPTIONS (will only print information about this command)
#
#	-v, --v, --version	Prints the version of this script.
#
#	-h, --h, --help		Prints this help text.
#
#
#MODIFICATION OPTIONS (modifies the output of this command)
#
#	-f, --force	Will still print the found, valid options
#				If an invalid option has been detected.
#				At the end of the result, there will still
#				be 'invOpt=invalid;options'.
#
#
#End of help for command 'formatArgs'

import inspect, os, sys, shlex, subprocess

toPrintLater = []

def printLater(toPrint):
	global toPrintLater
	toPrintLater.append(toPrint)

def flushPrint():
	for printCall in toPrintLater:
		print printCall

optionPrefix = "-"
zeroArguments=""
oneArgument=":"
zeroOrOneArgument="?"
oneOrMoreArguments="+"
zeroOrMoreArguments="*"

outputDelimiter = ";"
outputEqulas = "="
forceOutput = False
otherArgsName = "args"
invalidOptionsName = "invOpt"

seeHelp="For more information, call 'formatArgs --help'."

#Get path of script used for help file
filepath = os.path.realpath(os.path.abspath(inspect.getfile(inspect.currentframe())))

args = sys.argv

#Parse options
if len(args[1:]) != 2: #If it is not a standart call with only arguments and pattern
	if len(args[1:]) > 2: #If it has more than two params, the first two have to be the arguments to format and the pattern
		optionArgs = args[3:]
	else: #If it has only one param, it assumes it is like --help and does not contain arguments and pattern
		optionArgs = args[1:]
	
	argString = ' '.join(optionArgs)
	formattedArgString = subprocess.check_output(["formatArgs", argString, "v;-v;-version;h;-h;-help;f;-force"]).strip()
	for arg in formattedArgString.splitlines():
		if arg == "-help" or arg == "-h" or arg == "h":
			print subprocess.check_output(["showFileHeader", filepath, "-p", "help", "-s"]).strip()
			sys.exit(0)
		elif arg == "-version" or arg == "-v" or arg == "v":
			print subprocess.check_output(["showFileHeader", filepath, "-p", "version"]).strip()
			sys.exit(0)
		elif arg == "-force" or arg == "f":
			forceOutput = True
		elif arg.startswith(otherArgsName + outputEqulas): #Non option args
			print "Argument(s) '" + arg[len(otherArgsName + outputEqulas):].replace(outputDelimiter, ", ") + " are not expected at that position."
			print seeHelp
			sys.exit(-1)
		elif arg.startswith(invalidOptionsName + outputEqulas): #Invalid options
			print "Option(s) '" + arg[len(invalidOptionsName + outputEqulas):].replace(outputDelimiter, ", ") + " do not exist."
			print seeHelp
			sys.exit(-1)


parameters = shlex.split(args[1])
pattern = args[2]

#Split option into list, get the mode of each option (like ?, + or *) and the sort it (longest first)
possibleOptions = pattern.split(";")
possibleOptionsMode = {}
for optionIndex, possibleOption in enumerate(possibleOptions):
	if possibleOption.endswith(oneArgument):
		possibleOptions[optionIndex] = possibleOption[:-1]
		possibleOptionsMode[possibleOptions[optionIndex]] = oneArgument
	elif possibleOption.endswith(zeroOrOneArgument):
		possibleOptions[optionIndex] = possibleOption[:-1]
		possibleOptionsMode[possibleOptions[optionIndex]] = zeroOrOneArgument
	elif possibleOption.endswith(oneOrMoreArguments):
		possibleOptions[optionIndex] = possibleOption[:-1]
		possibleOptionsMode[possibleOptions[optionIndex]] = oneOrMoreArguments
	elif possibleOption.endswith(zeroOrMoreArguments):
		possibleOptions[optionIndex] = possibleOption[:-1]
		possibleOptionsMode[possibleOptions[optionIndex]] = zeroOrMoreArguments
	else:
		possibleOptionsMode[possibleOptions[optionIndex]] = zeroArguments
possibleOptions.sort(key=len, reverse=True)

#Go through parameters and format them with help of the possibleOptions
otherParameters=""
invalidOptions=""
parameterIndex = 0
while parameterIndex < len(parameters):
	currentParameter = parameters[parameterIndex]
	if currentParameter.startswith(optionPrefix):
		currentParameter = currentParameter[1:] #Remove '-' prefix
		foundOptions = []
		mode = None
		for possibleOption in possibleOptions:
			if possibleOption in currentParameter:
				currentParameter = currentParameter.replace(possibleOption, "", 1)
				foundOptions.append(possibleOption)
				thisOptionMode = possibleOptionsMode[possibleOption]
				if mode == None or mode == zeroOrMoreArguments: #If previous mode is unset or compatible with all
					mode = thisOptionMode
				if mode == zeroArguments:
					if thisOptionMode == oneArgument or thisOptionMode == oneOrMoreArguments:
						print "Options incompatible: " + parameters[parameterIndex]
						if not forceOutput: sys.exit(-1)
						else: break
					#Else mode stays on zeroArguments
				elif mode == oneArgument:
					if thisOptionMode == zeroArguments:
						print "Options incompatible: " + parameters[parameterIndex]
						if not forceOutput: sys.exit(-1)
						else: break
					#Else mode stays on oneArgument
				elif mode == zeroOrOneArgument:
					if thisOptionMode == zeroArguments or thisOptionMode == oneArgument:
						mode = thisOptionMode
					elif thisOptionMode == oneOrMoreArguments:
						mode = oneArgument
					#Else mode stays on zeroOrOneArgument
				elif mode == oneOrMoreArguments:
					if thisOptionMode == zeroArguments:
						print "Options incompatible: " + parameters[parameterIndex]
						if not forceOutput: sys.exit(-1)
						else: break
					elif thisOptionMode == oneArgument or thisOptionMode == zeroOrOneArgument:
						mode = oneArgument
					#Else mode stays on oneOrMoreArguments
		
		else: #Executed when the for loop exits normally (not with break)
			if currentParameter != "":
				if invalidOptions == "":
					invalidOptions = parameters[parameterIndex]
				else:
					invalidOptions += outputDelimiter + parameters[parameterIndex]
				parameterIndex += 1
				continue
			else:
				currentParameter = parameters[parameterIndex] #Reset because it has been emptied before
			
			if mode == zeroArguments:
				for foundOption in foundOptions:
					printLater(foundOption)
				parameterIndex += 1
			elif mode == oneArgument:
				parameterIndex += 1
				if len(parameters) > parameterIndex and not parameters[parameterIndex].startswith(optionPrefix):
					optionParameter = parameters[parameterIndex]
					for foundOption in foundOptions:
						printLater(foundOption + outputEqulas + optionParameter)
					parameterIndex += 1
				else:
					print "Missing argument (:) for parameter: " + currentParameter
					if not forceOutput: sys.exit(-1)
					else: continue
			elif mode == zeroOrOneArgument:
				parameterIndex += 1
				if len(parameters) > parameterIndex and not parameters[parameterIndex].startswith(optionPrefix):
					optionParameter = parameters[parameterIndex]
					for foundOption in foundOptions:
						printLater(foundOption + outputEqulas + optionParameter)
					parameterIndex += 1
				else:
					for foundOption in foundOptions:
						printLater(foundOption)
			elif mode == oneOrMoreArguments:
				parameterIndex += 1
				optionParameters = ""
				while len(parameters) > parameterIndex and not parameters[parameterIndex].startswith(optionPrefix):
					optionParameters = optionParameters + outputDelimiter + parameters[parameterIndex]
					parameterIndex += 1
				if optionParameters == "":
					print "Missing argument (+) for parameter: " + currentParameter
					if not forceOutput: sys.exit(-1)
					else: continue
				else:
					optionParameters = optionParameters[1:] #Remove delimiter at position 0 added in first while loop
					for foundOption in foundOptions:
						printLater(foundOption + outputEqulas + optionParameters)
			elif mode == zeroOrMoreArguments:
				parameterIndex += 1
				optionParameters = ""
				while len(parameters) > parameterIndex and not parameters[parameterIndex].startswith(optionPrefix):
					optionParameters = optionParameters + outputDelimiter + parameters[parameterIndex]
					parameterIndex += 1
				if optionParameters == "":
					for foundOption in foundOptions:
						printLater(foundOption)
				else:
					optionParameters = optionParameters[1:] #Remove delimiter at position 0 added in first while loop
					for foundOption in foundOptions:
						printLater(foundOption + outputEqulas + optionParameters)
			
	else:
		if otherParameters == "":
			otherParameters = currentParameter
		else:
			otherParameters += outputDelimiter + currentParameter
		parameterIndex = parameterIndex + 1
if otherParameters != "":
	printLater(otherArgsName + outputEqulas + otherParameters)
if invalidOptions != "":
	print invalidOptionsName + outputEqulas + invalidOptions
	if not forceOutput: sys.exit(-1)


flushPrint()