package main;        #has to be "main"

#
# START---------------------------------------------------------------------
# Author:        Walter Rothlin
# Description:   Contains a lot of generic Perl-functions
#
#
# Calling:       littlePerlLib.pm
#
#
# History:
# 01/13/99    V1.0  Walter Rothlin     Initial Version
# 01/19/99    V1.1  Walter Rothlin     Add Callback functions
# 01/21/99    V1.2  Walter Rothlin     Add more functions
# 01/28/99    V1.3  Walter Rothlin     Put some more function into
# 02/01/99    V1.4  Walter Rothlin     Implements new operators for WhereClause
# 02/04/99    V1.5  Walter Rothlin     Bug fixing
# 02/10/99    V1.6  Walter Rothlin     Add WhiteBoard function
# 02/11/99    V1.7  Walter Rothlin     More User defindable parts
# 02/12/99    V1.8  Walter Rothlin     Password and ModTimeStamp
# 02/20/99    V1.9  Walter Rothlin     Autofilter
# 02/20/99    V2.0  Walter Rothlin     Authorization, Function overloading
# 03/05/99    V2.1  Walter Rothlin     Wizzard First Version
# 03/12/99    V2.12 Walter Rothlin     Bug fixing, Constraints checking (Client Side),
# 03/15/99    V2.13 Walter Rothlin     User definable column sort, Column-Attributes
# 03/16/99    V2.14 Walter Rothlin     Authorization can use server login
# 03/17/99    V2.15 Walter Rothlin     Detached Insert screen with setting focus
#                                      email selector box
#                                      new function: transformFile
# 03/23/99    V2.16 Walter Rothlin     Changes for using dispatch (remote cgi)
#                                      Extends the privilige system with defaults
#                                      Built-in of $loginFailureProc in mainDoor()
#                                      Bug fix in modify, insert with default values
#                                      More ftp functions
#                                      isDebug() function
# 04/22/99    V2.17 Walter Rothlin     Use of Templates for INSERT, MODIFY and DELETE
#                                      Autofire Autofilter
#                                      New Formats:
#                                              "HomePage"   => "urlTarget:_new",
#                                              "HomePage"   => "urlTarget:_new:HomePage",
#                                              "Strasse"    => "detailLink",
#                                              "GebDate"    => "Date:Day:MonthByName",
#                                              "Amount"     => "curr:10.2",
# 04/24/99    V2.18 Walter Rothlin     Handle parameter (to, from, subject) for Sendmail
#                                             (thanks to Stephan Markwalder)
# 04/26/99    V2.19 Walter Rothlin     Reverse Sort-Order
# 04/30/99    V2.20 Walter Rothlin     Add Input Formats (Date, Curr)
#                                      Add Locking functions
#                                      Docu Generator
# 05/05/99    V2.21 Walter Rothlin     markAsDelete instead of real delete
#                                      new @myDisplayDetailFields
#                                      A lot bug fixes
# 05/13/99    V2.22 Walter Rothlin     Replaced ; by %3D as a sepChar in the whereClauses
#                                      Sort the e-mail selector box
#                                      Add french strings
# 05/20/99    V2.23 Walter Rothlin     Add detail field Order for default detail form
#                                      Made SQL methods treath save
#                                      Add purgeUnixDir, callUnixCmd
# 05/28/99    V2.24 Walter Rothlin     Add SpezialFilterSelector, SpezialFilterTextbox,
#                                          SpezialFilterSearchBox
#                                      Allow OR and AND in the where-clause
#                                      Functions to deref Hash and Array
#                                      Bug Fix for SpezFilters
#                                      Add refUserParam to callback-function for
#                                          selectHashInFltFile
#                                          selectRowsInFltFile
# 06/02/99    V2.25 Walter Rothlin     mainDoor without default privileges
#                                      language flag for mainDoor, LoginScreen, WhiteBoard
#                                      Add new string functions
# 06/16/99    V2.26 Walter Rothlin     Password forgotten
#                                      more french strings
# 06/17/99    V2.27 Walter Rothlin     Add BCC to the mail sender
#                                      Enable log file for mainDoor prepareHTMLPage..
# 06/21/99    V2.28 Walter Rothlin     Build in MailForm functions
# 06/23/99    V2.29 Walter Rothlin     More ReadFile functions
#                                      massageRecord function
#                                      Bug-Fixes ReadFileParts functions
# 06/27/99    V2.30 Walter Rothlin     Add more language function
#                                         getTransTab
#                                      Case sensitive Operators in
#                                      Case toggle for SpecFilters
#                                      Language function for e-mailer
# 06/30/99    V2.31 Walter Rothlin     Add BarChart
#                                      german month names July -> Juli (Bug fix)
# 07/19/99    V2.32 Walter Rothlin     Add new function for Insert and Modify
# 07/20/99    V2.33 Walter Rothlin     Bug fix IE detail-view
# 07/22/99    V2.34 Walter Rothlin     Unix-Commander included
# 07/28/99    V2.35 Walter Rothlin     File-Editor included
# 07/31/99    V2.36 Walter Rothlin     Gif-Browser included
# 08/03/99    V2.37 Walter Rothlin     add getCountOfColumns,addUserColumn
# 08/03/99    V2.38 Walter Rothlin     Bugfix in sendMail....
# 08/03/99    V2.39 Walter Rothlin     New function getAllMatchesFromFltFile
# 08/04/99    V2.40 Walter Rothlin     Privilege-Groups handled
# 08/04/99    V2.41 Walter Rothlin     Notification e-mail for INSERT,MODIFY,DELETE
# 08/04/99    V2.42 Walter Rothlin     Add selectFromArray
# 08/11/99    V2.43 Walter Rothlin     Add Server-Log parsing function
# 08/11/99    V2.44 Walter Rothlin     Some changes for accounting module
# 08/11/99    V2.45 Walter Rothlin     Bug fix in getPrivilege (mainDoor)
#                                      for default priv
#                                      Bug fix Unix-Commander (HTML TAGS) larger cd field
# 09/01/99    V2.46 Walter Rothlin     PDF file handling
# 09/01/99    V2.47 Walter Rothlin     Bug Fix Release
#                                        LeadYear calculation
#                                        mainDoor loginNeccesery and serverLogin used
# 09/02/99    V2.48 Walter Rothlin     MimeType Handling for *.ppt *.doc *.xls
#                                      Nice WhiteBoard (with cookies)
# 09/08/99    V2.49 Walter Rothlin     Locking for Update and Delete
#                                      Ste change requests for SpezFilters
#                                      Extend ftp function (lcd)
# 09/10/99    V2.50 Walter Rothlin     Add document archive functions
# 09/24/99    V2.51 Walter Rothlin     Add httpGet
#                                      Add new format: userDefined_1
# 10/01/99    V2.52 Walter Rothlin     Bug fix email selector for Outlook
#                                      Add isProbablyMS_Browser()
#                                      Add echo()
# 10/19/99    V2.53 Walter Rothlin     Add secDiff_YYYYMMDDhhmmss()
#                                          secDiff_hhmmss()
# 11/14/99    V2.54 Walter Rothlin    Add italian as language
# 11/22/99    V2.55 Walter Rothlin    Add MenuTree Converter functions
# 11/23/99    V2.56 Walter Rothlin    Add myFieldType and change sorting
# 12/29/99    V2.57 Walter Rothlin    Add FileUpload functions to document archive
#                                     Bug fix in transformFile using | as delimiter
# 12/30/99    V2.58 Walter Rothlin    Add function getValueFromHash,
#                                                  lookForMissingKeys
# 01/03/00    V2.59 Walter Rothlin    Add new time functions getLastDayOfMonth
# 01/06/00    V2.60 Walter Rothlin    Add sendMailwithAttachments
#                                         makeQuotedStrFromArray
# 01/12/00    V2.61 Walter Rothlin    Optimized the sortedby for all the select functions
# 01/13/00    V2.62 Walter Rothlin    Add getAllValuesFromHash_AsArray....
#                                     Modified transformFieldHidden
# 01/18/00    V2.63 Walter Rothlin	  Bug fix in accessDocumentArchive (myCgiName)
# 02/01/00    V2.64 Walter Rothlin    Add convertTXT_to_FLT
#                                         convertFLT_to_TXT
#                                         submitUnixJob and all webControls for it
# 02/08/00    V2.65 Walter Rothlin    Add getLinksFromUrl
#                                         getHttpSimple
#                                         getModDateViaHttpHeader
#                                     Bug fixed in httpGet
# 02/10/00    V2.66 Walter Rothlin    Add eastern calculation
#                                     docArchive: Locking, Subscribing, Statistics
# 02/23/00    V2.67 Walter Rothlin    Bug fixes docArchive (Language support,..)
# 02/29/00    V2.68 Walter Rothlin    DocArchive: function on a new layer
# 03/01/00    V2.69 Walter Rothlin    DocArchive: french and italian strings
# 03/01/00    V2.70 Walter Rothlin    DocArchive: Upload dirs on a select
# 03/02/00    V2.71 Walter Rothlin    Add updateAccessAndPasswdFiles to
#                                       create .htaccess and .htpasswd
# 03/06/00    V2.72 Walter Rothlin    Add archiveDate,
#                                         getModifyDateAsTimeStamp
# 03/14/00    V2.73 Walter Rothlin    Bugfixes
#                                        $logFileName not exist
#                                        a dir listed in docAccessTool doesn't exist
# 03/15/00    V2.74 Walter Rothlin    Filename with spaces are handled by docManager
# 03/17/00    V2.75 Walter Rothlin    Use control file for docManager
# 03/21/00    V2.76 Walter Rothlin    Implemented Copy function (add to Insert and Modify)
# 03/23/00    V2.77 Walter Rothlin    Add getAllMatchesFromFltFileAsHashes
# 03/29/00    V2.78 Walter Rothlin    Bug fixes DocArchive and small enhancements
# 03/30/00    V2.79 Walter Rothlin    Add new functions
#                                          linearInterpolation
#                                          paddingDate
#                                          ddmonyyTOyyyymmdd
#                                          ddmonyyyyTOyyyymmdd
# 03/30/00    V2.80 Walter Rothlin    Bug fix for docArchive (upload links)
# 04/17/00    V2.81 Walter Rothlin    Add docSetDefaultValuesFromTOP_LEVEL_COMMENT
#                                          diskUsedOnUnix
#                                          writeHashToFlatFile
# 04/20/00    V2.82 Walter Rothlin    Add cryptUNIXFile
# 04/21/00    V2.83 Walter Rothlin    Add chompArrayEntries
#                                         doLinearInterOrExtrapolation
#                                         doNumericSortArray
#                                         preparePointsHashForInterpolation
#                                         stringContains
#                                         stringStartsWith
#                                         stringEndsWith
#                                         getFirstChartersFromString
#                                         getLastChartersFromString
# 04/28/00    V2.84 Walter Rothlin    Add writeRecordHashToFile_fh
#                                         writeRecordHashToFile
#                                         postProcessFltFile
#                                         initHash
#                                         postProcessFltFile
# 05/02/00    V2.85 Walter Rothlin    Add writeGlobalsToFile_fh
# 05/12/00    V2.86 Walter Rothlin    Bug fix
# 05/17/00    V2.87 Walter Rothlin    Add sendDbViaEmail function
# 05/18/00    V2.88 Walter Rothlin    Add getAverageValue
#                                         getSummarizedValue
# 05/26/00    V2.89 Walter Rothlin    Add parse_csv
#                                         callFunction
#                                         substituteStr
#                                     Changed replacePlaceholdersStr to  
#                                     accept also function calls
#                                     Add <HR> at the end of the document archive
#                                     Add wizard function createLittlePerlLibWebDefinitions
# 05/29/00    V2.90 Walter Rothlin    Bug fix in replacePlaceholdersStr
# 05/31/00    V2.91 Walter Rothlin    Add UploadDb, LockingDb and cryptingDb
# 06/07/00    V2.92 Walter Rothlin    Add convertFromUNIX_ASCII_to_DOS_ASCII
#                                         createFltFromHash
#                                         convertCSV_to_FLT
#                                         removeSpecialCharFromHeaderLine
#                                         readFileWithIncludes
#                                     Bug fixes (Add to all filehandlers the name of the function)
# 06/12/00    V2.93 Walter Rothlin    Bug fix in transformFile
# 06/19/00    V2.94 Walter Rothlin    Add writeArrayToFile
#                                     Bug fix in createLittlePerlLibWebDefinitions
#                                                BuildaJSMenu_Hidden
# 07/07/00    V2.95 Walter Rothlin    Add countColumnValues
# 07/13/00    V2.96 Walter Rothlin    Bug fix in getSingleRecInHash (saved @part)
#                                     Add getCurrentDir
# 07/20/00    V2.97 Walter Rothlin    Add generateNewFltRecord
#                                     Add fltUpdateRecordByHash
#                                     Add getSepCharFromHeader
#                                     Add fltInsertRecordByHash
#                                     Changed generateNewRecord
#                                     Changed getTableHeader
# 07/26/00    V2.98 Walter Rothlin    Add setLSNr
#                                     Add displayCounter
# 07/26/00    V2.99 Walter Rothlin    Add trimAndRemoveEmptiesInArray
#                                         serializeTransTab
#                                         deserializeTransTab
# 08/26/00    V3.00 Walter Rothlin    Add removeEntriesFromArray
# 09/13/00    V3.01 Walter Rothlin    Add removeEntriesFromArray
# 09/25/00    V3.02 Walter Rothlin    Add addStringToFilename
#                                         setAndGetFileLock
#                                         removeFileLock
#                                         appendFltFiles
# 09/28/00    V3.03 Walter Rothlin    Add waitForFileToExists
#                                         waitForFileToNotExists
# 10/16/00    V3.04 Walter Rothlin    Add getLatestPublishedRecord
#                                         formatTextForNewsApplet
# 10/18/00    V3.05 Walter Rothlin    Mod createFileEditor to call a savedUserFct 
# 10/24/00    V3.06 Walter Rothlin    Mod putTimeStampInFileName
# 10/25/00    V3.07 Walter Rothlin    Add replaceFigureInString
#                                         getRepeatedCharStr
#                                         getFigureFromString
#                                         roundAmount
#                                         getLastModByAtFromFltFile
# 11/14/00    V3.08 Walter Rothlin    Add isUNIX_CommandExist
# 11/22/00    V3.09 Walter Rothlin    Add replaceDosEecuAndKomman
# 12/05/00    V3.10 Walter Rothlin    Bug fix in swapHash
# 12/27/00    V3.11 Walter Rothlin    Add flt as valid mime type (convert to xls)
#                                     Add docFormatTOC_Content for DocuArchive
# 01/04/01    V3.12 Walter Rothlin    Add areStringMatching (using * for pattern matching)
#                                     Used areStringMatching in
#                                              filenameMatchesPattern
#                                              dirListExtended
#                                     Changed getAvailabledocus (Made retList distinct)
#                                     Add docTOC_Sorter for DocuArchive
#                                     Add countOfArrayElements
# 01/08/01    V3.13 Walter Rothlin    Add getCalendar_asString
#                                     Changed sendmail (allow user define sendMailPath)
#                                     Added createTarFile
#                                     Added e-mail selector title
# 02/27/01    V3.14 Walter Rothlin    Added getLastWorkingDayInMonth
#                                           getLastWorkingDayInYear
#                                           getFirstWorkingDayInMonth
#                                           getFirstWorkingDayInYear
#                                           isLastWorkingDayOfMonth
#                                           isFirstWorkingDayOfMonth
#                                           isLastWorkingDayOfYear
#                                           isFirstWorkingDayOfYear
# 02/28/01    V3.15 Walter Rothlin    Bug fix in getWeekdayName
#                                     Replaced getLastDayOfMonth by getLastDayOfMonth_1
#                                     Add isWorkingDay
#                                         getLastWorkingDay
#                                         getNextWorkingDay
# 03/25/01    V3.16 Walter Rothlin    Add execPerlFct
#                                         getSubNameFromFileList
#                                         getFctDescriptionFromFileList
#                                         fctChomp
#                                     Removed filenameMatchesPattern_OLD
#                                             dirListExtended_Old
# 03/29/01    V3.17 Walter Rothlin    Add VT52_ functions
# 04/03/01    V3.18 Walter Rothlin    Add whichFilesExist
#                                         processEachElementInArray
#                                         getUnionOfArrays
#                                         getIntersectionOfArrays
#                                         getExclutionOfArrays
# 04/04/01    V3.19 Walter Rothlin    Add UNIX_Which
# 04/11/01    V3.20 Walter Rothlin    Add searchFields to createLittlePerlLibWebDefinitions
#                                         sortFltFile
#                                         formatFltHeaderAndDataString
# 04/27/01    V3.21 Stephan Markwalder  Bug fixes for docArchive (see STEPHAN)
#                                       Removed part of the sprintf and printf
# 05/04/01    V3.22 Walter Rothlin      Add yyyymmddTOddmAbrevyy
#                                           getCalendarInYYYYMMDD
#                                           addSingleQuotesToString
#                                           addDoubleQuotesToString
# 05/23/01    V3.23 Walter Rothlin      Add mkdirViaFtpRetVal
#                                           getArrayElement
#                                           getFieldFromString
#                                           removeFieldFromString
#                                           replaceFieldFromString
#                                           removeAnEntryFromArray
#                                       Add format e.g. "10*50 NoWrap"
# 06/11/01    V3.24 Walter Rothlin      Mod prepareHTML_StandardFormForIt that it takes as 1st param $DefaultPrepareAction
# 06/19/01    V3.25 Walter Rothlin      Add upgradeFltFileDefinition
# 08/03/01    V3.26 Dmitriy Volfson     Mod updateRecord to keep original file permissions
# 08/24/01    V3.27 Walter Rothlin      Bug fix $anAtomicPart $anAtomicParts
# 08/20/01    V3.28 Dmitriy Volfson     Bug missing comma 951
# 08/27/01    V3.29 Walter Rothlin      Add replaceENV_InString
# 09/12/01    V3.30 Walter Rothlin      Add zip as mime type
#                                       Add download filename
#                                       Add replaceVariables_InString
#                                       Add convertArrayMappingTblToHashMappingTbl
# 10/08/01    V3.31 Walter Rothlin      Add formatYYYYMMDD
# 10/30/01    V3.32 Walter Rothlin      Add createMarker
#                                       Mod logicTestPart to handle "in" and "IN" operator
#                                       Add compareFltFilesAndProduceReport
#                                       Add compareFltFilesReturnMissingKeysInFile2
#                                       Add compareFltFilesReturnCommonKeys
#                                       Add getPosWhereStringsStartToBeDifferent
#                                       Add makeAND_ConditionOutOfNotIn
#                                       Add makeOR_ConditionOutOfIn
# 11/21/01    V3.33 Walter Rothlin      Add addSomeWorkingDays
#                                           addSomeWorkingDaysPassHolidayArray 
#                                           getHomeCurrencyForCitycode
# 12/06/01    V3.34 Walter Rothlin      Add addDelimitersAroundHashKeys
#
# 12/11/01    V3.35 Walter Rothlin      Add processHTML_FormAndSendEmail
#                                           isEmailAddr
#                                           isReal
#                                           isInteger
#                                           isString
#                                           translateStringValue
# 12/17/01    V3.36 Walter Rothlin      Bug fix in processHTML_FormAndSendEmail
# 01/21/02    V3.37 Walter Rothlin      Bug fix docManager (eliminated chmod 0666)
# 01/22/02    V3.38 Walter Rothlin      Add compareFltFilesAndProduceReport_1
# 03/28/02    V3.39 Walter Rothlin      Add isArrayEmty
# 04/04/02    V3.40 Walter Rothlin      Add msg parameter to setAndGetLockFast,setLock
#                                       Changed getParameterNames
#                                       Add  swapFilenames 
# 05/08/02    V3.41 Walter Rothlin      Add getGMT_TimeStamp, getMyUnixDomainname, getMyUnixFullHostname
# 05/13/02    V3.42 Walter Rothlin      Add translateHashKeys, translateHashValues
# 07/29/02    V3.43 Walter Rothlin      Changed convertTXT_to_FLT (Added new parameter $trimFields, $stripDoubleQuotes)
# 07/30/02    V3.44 Walter Rothlin      Changed cryptUnixFile
# 08/06/02    V3.45 Walter Rothlin      Changed currFormat
# 09/06/02    V3.46 Walter Rothlin      Add areArraysEqual,areFilesEqual 
# 10/04/02    V3.48 Walter Rothlin      Add startSendingHeartBeat, stopSendingHeartBeat
# 11/22/02    V3.49 Walter Rothlin      Add password mailing from the login screen
# 01/08/03    V3.50 Walter Rothlin      Bug fixed in getFieldFromString
# 01/21/03    V3.51 Walter Rothlin      Add isValidTimeStampYYYYMMDDHHMMSS
# 01/23/03    V3.52 Walter Rothlin      Add splitStringByLength
#                                           splitStringByWord
# 01/31/03    V3.53 Walter Rothlin      Add doTest function and self-test routines (execPerlFct performTest)
#                                           writeTrace($doTrace,$msg)
# 02/24/03    V3.54 Walter Rothlin      Add isDateBetweenUseCalendar
# 03/11/03    V3.55 Walter Rothlin      Add sendHtmlMail (only using sendmail)
# 03/20/03    V3.56 Walter Rothlin      Add getSubsetFromArray
# 03/26/03    V3.57 Dmitriy Volfson     modified setBooleanFromYesNoStr,setBooleanFromCommonControl
# 05/01/03    V3.58 Walter Rothlin      Add functions for permutation, combination, variations
#                                       Add functions to calculate n!, n tief k
# 06/02/03    V3.59 Walter Rothlin      Add functions for linear and ccordinates.
# 06/23/03    V3.60 Walter Rothlin      Changed transformFile to have the headerLineComments from the input file in the output file
#                                       Add getParametersFromSelectString
#                                       Add selectAndExecFct,getCalendarEntriesInTimeInterval
# 08/26/03    V3.61 Walter Rothlin      Bug fixed in makeQuotedStrFromArrayElements
#                                       Add writeStringToFile
#                                           StringName functions (XML version)
# 09/11/03    V3.62 Walter Rothlin      Add getPreviousSunday, getNextSunday
# 12/18/03    V3.63 Walter Rothlin      Add showMenu_HabaEinsatzplan produceAnlassHabaFiles 
# 01/23/04    V3.64 Walter Rothlin      Add prepareMsgHashFromNotifyHash  getCalendarEntriesInTimeIntervalUsingFiles
# 04/01/04    V3.65 Walter Rothlin      Add createAsciiMenu
# 09/30/04    V3.66 Walter Rothlin      Changed waitForFileToExists, waitForFileToNotExists
#                                       Add isFileExistsAndNotGrowing, moveFileUnix, copyFileUnix, formatTime
# 01/03/05    V3.67 Walter Rothlin      Changed readFileWithIncludes added parameter withComments
# 07/18/05    V3.68 Walter Rothlin      Changed createAsciiMenu
#                                       Added createAsciiMenuAndPerformActions, getElementIndexInArray, copyFileDos
# 09/25/05    V3.69 Walter Rothlin      Fixed problem with sed command in sendMailwithAttachments
# 10/02/05    V3.70 Walter Rothlin      Added Format-Template to BuildMenuTreeHTML
#					                              Changed isFileExists (if length(fileName) == 0 return $FALSE)
# 10/14/05    V3.71 Walter Rothlin      Add replaceUmlauteByHTMLcodesInHashValues
# 10/19/05    V3.72 Walter Rothlin      createHTACCESS_ByUserList
# 11/04/05    V3.73 Walter Rothlin      Added cryptPath to cryptUNIXFile function
# 11/27/05    V3.74 Walter Rothlin      Changed mkEmailSelectorFromTab to support SMS
# 12/04/05    V3.75 Walter Rothlin      Merged different versions together
# 12/27/05    V3.76 Walter Rothlin      Chanded getLatestPublishedRecord (added applet type)
#                                       Added formatTextForNewsLED_Applet
# 12/29/05    V3.77 Walter Rothlin      Moved SMS function from csfbPerlLib.pm to littlePerlLib.pm
#                                       Changed SMS function to handle the credit-suisse.com SMS gateway
# 01/03/06    V3.78 Walter Rothlin      Changed notifyforaniversery and show_Menu_SendGeburiNotification
# 07/04/06    V3.79 Walter Rothlin      Added new UNIX command (showMenu_UnixCmd)
#                                           cleanupUnixDir
# 08/10/06    V3.80 Walter Rothlin      Added the following new tests to logicTestPart:
#                                          not_like, NOT_LIKE, not_starts, NOT_STARTS, not_ends, NOT_ENDS
#                                       Added functions isDirectoryExisting_UNIX, getDirList_UNIX, concatArrayOptimized
# 08/11/06    V3.81 Walter Rothlin      Fixed problem in getDirList_UNIX
# 08/17/06    V3.82 Walter Rothlin      Added setBitsForFltEntry
# 08/18/06    V3.83 Walter Rothlin      Added removeElementByStringValueInArray
# 09/19/06    V3.84 Walter Rothlin      Added getTagValueFromXML, makeStrFromHash
# 09/30/06    V3.85 Walter Rothlin      Added replaceWithFormFieldForFormHandler
#                                       Changed processHTML_FormAndSendEmail
# 10/10/06    V3.86 Walter Rothlin      Added getMyUnixUserId, getTransTableFromNormalFile, swapHashWithWarningForDublicates
# 10/20/06    V3.87 Walter Rothlin      Added compressBigFile, uncompressFile
# 10/24/06    V3.88 Walter Rothlin      Changed compressBigFile
# 10/25/06    V3.89 Walter Rothlin      Changed readln (added new parameter $dontAsk)
# 11/16/06    V3.90 Walter Rothlin      Added trimRemoveEmptiesAndCommentsInArray,
#                                             BuildMenuTreeJS_forHvMenu,
#                                             getHvMenuChildrenHidden
# 11/22/06    V3.91 Walter Rothlin      Changed readFileWithIncludes to handle includePath
# 11/23/06    V3.92 Walter Rothlin      Changed manipulateWhiteBoard (added new parameters)
# 11/27/06    V3.93 Walter Rothlin      Added replaceUNICODE_UmlauteInHash, replaceUNICODE_Umlaute
#                                       Changed getHttpSimple (added new parameter $verbal)
# 12/14/06    V3.94 Walter Rothlin      Added getIpFromHostname, getIpFromAlias, getFullHostnameFromAlias, getFullHostnameFromIP
# 01/24/07    V3.95 Walter Rothlin      Added changeDateFormat, replaceSpacesWithSepChar, getFilenameFromUNIX_DirEntry, getVersionDetailsFromFile
# 01/25/07    V3.96 Walter Rothlin      Closed security hole in manipulateWhiteBoard
# 01/26/07    V3.97 Walter Rothlin      Added spam filter in manipulateWhiteBoard
# 02/05/07    V3.98 Walter Rothlin      Added default value for sepChar to getTransTable
# 03/21/07    V3.99 Walter Rothlin      Added isOnePatternMatchesString, isUNIX_DirEntryA_DirectodirTreery, getFilesInDirTree
# 04/13/07    V4.00 Walter Rothlin      Added padString
# 04/25/07    V4.01 Walter Rothlin      Added ZN (Zurich-North)
# 05/16/07    V4.02 Walter Rothlin      Added displayHashTableRef, displayRecordSet, findRecordsInHashList, getRecordSetFromFile, getAllValuesSortedFromHash_AsArray
# 05/23/07    V4.03 Walter Rothlin      Added waitForFileToExistsWithCallback
# 05/30/07    V4.04 Walter Rothlin      Added formatToYYYYMMDD
# 10/12/07    V4.05 Eric Beckman        Added makeArrayEntriesDistinct_faster
#                                       and call to it from postProcessOneRecord.
#                                       Reduced elapsed time of risk sensitivity ZH
#                                       by more than 50%.
# 10/30/07    V4.06 Walter Rothlin      Changed getVersionDetailsFromFile (skipped .so, .jar, .tar)
# 11/05/07    V4.07 Walter Rothlin      Added dirListRecursive
# 02/06/08    V4.08 Walter Rothlin      Fixed error in getCurrentDir
# 05/06/08    V4.09 Eric Beckman	      Fixed bug in ends logic
# 07/14/08    V4.10 Raghu  V            Added addJobtimeToFile function to write into Log / any  file
# 11/19/08    V4.11 Walter Rothlin      Fixed bug in createUnixCommander
# 12/13/08    V4.12 Walter Rothlin      Added vCard support
#                                             vcfMimeType
#                                             replaceASCII_to_HEX_InHashValues¨
#                                             convertASCII_to_HEX
#                                             createVcardStringArrayFromFltFile
#                                             createVcardFilesFromFltFile
#                                             sendVcardFromFltFileViaHttp
# 12/15/08    V4.13 Walter Rothlin      Added comment to formHandler
# 01/13/09    V4.14 Walter Rothlin      Added diffInHashesWithSameKeys
#                                       Added $recModifiedCallback to prepareHTML_StandardFormForIt 
# 07/13/09    V4.15 Walter Rothlin      Added matrixUmwandeln
#                                       Added listPakageInfo
# 07/15/09    V4.16 Walter Rothlin      Read from package info files (added option FROMFILE)
# 09/07/09    V4.17 Walter Rothlin      Fixed problem in addSpezFilterTextbox
# 09/30/09    V4.18 Walter Rothlin      Added HTML Editor for Anschlagbrett
# 10/14/09    V4.19 Walter Rothlin      Added getUserAndDateFromChatfile
# 11/27/09    V4.20 Walter Rothlin      Added busyWait
# 12/28/09    V4.21 Walter Rothlin      Added createAndInitHash
#                                             createRefHashTblOutOfFltFile
#                                             displayHashWithHashRef
# 12/29/09    V4.22 Walter Rothlin      Added removeWhitespacesFromEachArrayEntry
# 02/19/10    V4.23 Walter Rothlin      Bugfix and enhancements in formatYYYYMMDD
#                                       Added replaceA_DefinedVariable_InString
# 04/23/10    V4.24 Walter Rothlin      Added replacePerlVariablesAndENV_InString
#                                             isStringAnURL;isAnURL
# 05/20/10    V4.25 Simon Fulcri        Added replacePlaceholdersFromHash
#                                             setHashFromStringOnSeveralLines
#                                       Bugfix replaceA_DefinedVariable_InString
# 06/01/10    V4.26 Simon Fulcri        Bugfix replaceA_DefinedVariable_InString
# 06/01/10    V4.27 Simon Fulcri        Extended setHashFromStringOnSeveralLines
# 06/11/10    V4.28 Simon Fulcri        Added getUserDetailsFromUnixPasswd
# 08/30/10    V4.29 Walter Rothlin      Overloaded writeArrayToFile by writeArrayToFileType
# 08/31/10    V4.30 Meena Gupta         Added getFirstExistingFile, getExistingFiles 
# 09/13/10    V4.31 Simon Fulcri        Merged NY and ZH version
# 03/19/12    V4.32 Walter Rothlin      Added setListFromCommonControlRemoveComments
#                                             addSec_YYYYMMDDhhmmss
#                                             removeFromString
#                                             removeFromStringUsingPositions
#                                             removeLastSepFromString
#                                             isUNIX_DirEntryA_Link
#                                       Modified sendMailwithAttachments to handle out-commented email adresses
#                                                getFilesInDirTree (fixed problems with links (shortcuts)
#                                                writeHashToFlatFile (fixed problem with sortByKey)
# 08/09/12    V4.33 Walter Rothlin      Modified getFilesInDirTree, convertArrayMappingTblToHashMappingTbl
#									    Added isUNIX_DirEntryA_File
# 09/03/12    V4.34 Walter Rothlin      Added makeQuotedFormatedStrFromArrayElements
# 09/24/12    V4.35 Walter Rothlin      Added displayArrayEnhanced
# 12/10/12    V4.36 Walter Rothlin      Modified getFilesInDirTree (added followLinks option)
#                                       Bugfixe isUNIX_DirEntryA_File
# 01-Jan-2013 V4.37 Walter Rothlin      Modified callFunction (check if function exists)
# 24-Jan-2013 V4.38 Walter Rothlin      Modified replaceFctCallHidden (to handle nested function calls)
#										Added some test functions for replaceFctCallHidden
# 31-Jan-2013 V4.39 Walter Rothlin      Fixed issue in replaceFctCallHidden (to handle $endPatterns before $startPatterns)
# 04-Feb-2013 V4.40 Walter Rothlin      Extended createHashTab (Added brakedChar parameter)
#										Added parseTemplateUsingFltStr
# 21-May-2013 V4.41 Walter Rothlin      Changes for DocuArchive (Part 1)
# 05-Jun-2013 V4.42 Walter Rothlin      Added getEnvVal, summation, product
#                                       Added new formats to formatYYYYMMDD
# 20-Mar-2014 V4.43 Walter Rothlin      Added getStringFromRegEx, getArrayFromRegEx
# 24-Apr-2014 V4.44 Walter Rothlin      Added getLastArrayElement, getLastFieldFromString
#										Changed writeStringToFile (extended error handling)
#										Changed mkUnixDir
# 06-Jun-2014 V4.45 Walter Rothlin      Changed mainDoor to work with ssl and certificates
#										Add getNamePartsFromCertificate
#										Changed createUnixCommander (removed $ infront of each line)
# 06-Jun-2014 V4.46 Walter Rothlin 		Add isCurrentHost, whichIsCurrentHostAlias
# 11-Jul-2014 V4.47 Walter Rothlin		Mod mkUnixDir
# 17-Jul-2014 V4.48 Walter Rothlin		Add replacePlaceholdersInFileFromFltFile
# 18-Aug-2014 V4.49 Walter Rothlin		Changed createFileEditor (reformated form)
# 20-Aug-2014 V4.50 Walter Rothlin		Add set_nslookupPath (not working)
# 21-Aug-2014 V4.51 Walter Rothlin		Add getPlaceholders
# 27-Aug-2014 V4.52 Walter Rothlin		More new functions for FT-11
# 25-Sep-2014 V4.53 Walter Rothlin		Implemented addPassword and delPassword
# 16-Oct-2014 V4.54 Walter Rothlin 		Cleanup for leagal parser
# 24-Oct-2014 V4.55 Walter Rothlin 		Solved nslookup problem (set_nslookupPath)
# 27-Oct-2014 V4.56 Walter Rothlin 		Cleanup for leagal parser
# 24-Nov-2014 V4.57 Walter Rothlin 		Extended changeDateFormat
# 11-Dec-2014 V4.58 Walter Rothlin 		Extended execPerlFct
# 17-Dec-2014 V4.59 Walter Rothlin 		Extended convertASCII_to_HEX
#										Added removeCR, ....
#										Added makeStrFromHashFormat
# 07-Jan-2015 V4.60 Walter Rothlin 		Added padFieldsInString
#										      encryptString, decryptString
#										      convertHEX_to_ASCII
# 15-Jan-2015 V4.61 Walter Rothlin 		Mod readFileBetweenMarkers
#										Bugfix in UNIX_Which
#										Added getPerlLibFullName
#										Added displayThisHeader
#										Added getSourceFullName
#										Added command argv functions like isCommandLineOptionSet
# 19-Jan-2015 V4.62 Walter Rothlin 		Mod createAsciiMenu
# 20-Jan-2015 V4.63 Walter Rothlin 		Added makeStrFromHashFormat_1
# 16-Feb-2015 V4.64 Walter Rothlin 		Added filterArrayWithRegEx
# 23-Feb-2015 V4.65 Walter Rothlin 		Added addNewKey_ValuesIfKeyIsNotAlreadyThere
#											  checkMask
#											  replaceStringInString
#											  getCountOfLinesFromQQ
#											  getFieldFromQQ
#											  trimQQ_String
#											  doTest_replaceStringInString ==> New structure for doTest functions! Less code!
#											  doTest_checkMask             ==> New structure for doTest functions! Less code!
#
# 25-Feb-2015 V4.66 Walter Rothlin 		Added writeLhCookie, readLhCookie
# 09-Mar-2015 V4.67 Walter Rothlin 		Small enhancements
# 13-Mar-2015 V4.68 Walter Rothlin 		Mod unterstreichen
#										Added repeatingString, stripFieldsFromString
# 26-Mar-2015 V4.69 Walter Rothlin 		Added getJavaPropertyFromFile, addFieldToString, addAnEntryToArray
# 01-Apr-2015 V4.70 Walter Rothlin 		Added getMaxFieldLengthFromStringArray, getFieldLengthFromString, padFieldsInFieldStringArray, getCountOfFieldsInstring
# 21-Apr-2015 V4.71 Walter Rothlin 		Added dos2unix, removeCRFromArrayEntries, dec2Octal, dec2Bin, dec2Hex, dec2Xzahl, octal2Dec
#                                       Added getFilePermission, getFileOwner, getFileGroup, getFileLastAccess, getFileSize
#                                       Mod displayEditorForm
# 26-Apr-2015 V4.72 Walter Rothlin      Added Studenten Zugriff
# 08-May-2015 V4.73 Walter Rothlin      Mod getLinkDestFromUnixDirEntry, getDirList_UNIX  added supressWarning
# 23-May-2015 V4.74 Walter Rothlin      Added alterCookieExpiryTime for automated testing, boxingUnterstreichen
# 30-Jul-2015 V4.75 Walter Rothlin      Added replaceUmlauteInString
# 07-Sep-2015 V4.76 Walter Rothlin      Added getFileLastModFromUNIX_DirEntry, getMonthNrByMonthName, getFieldsFromString
# 17-Dec-2015 V4.77 Walter Rothlin      Added hashTableToArrayStrFormat
#                                             createAsciiMenuMultipleSelectionWithComments
# 05-Jan-2016 V4.78 Walter Rothlin      Mod getFileLastModFromUNIX_DirEntry
#										Added displayRecSetAsTable
# 18-Feb-2016 V4.79 Walter Rothlin      Added isVersionStringValid, createFigureRangeFromTo
# 08-Mar-2016 V4.80 Walter Rothlin      Changed Path (because of Novatrend change) of /usr/bin/uuencode
# 01-Apr-2016 V4.81 Walter Rothlin      Changed createAsciiMenuMultipleSelectionWithComments added ? as option
# 02-May-2016 V4.82 Walter Rothlin      Added isFileEmpty, getPreviousWorkingDay, subSomeWorkingDays
# 30-Jun-2016 V4.83 Walter Rothlin      Modified purgeUnixDir added new parameter $withDir
# 08-May-2016 V4.84 Walter Rothlin      Modified formatation of code
# 12-Oct-2017 V4.85 Walter Rothlin      Modified processHTML_FormAndSendEmail (Injection of additional parameters)
# 25-May-2019 V4.86 Walter Rothlin      Modified RegEx in produceHTMLDescription
# Open Issues --------------------------------------------------------------
# - Fix BUG 1 (End of line)
# - replaceTab does not handle beginningOfLine
# END-----------------------------------------------------------------------
#
############################################################################
$sccsId           = "";
$libLatestVersion = "V4.86";
$libName          = "littlePerlLib.pm";
############################################################################
# General Perl hints
############################################################################
#
# Set cgi parameters in program
# -----------------------------
# param(-name=>'Action',-value=>"");
#
############################################################################
# General description
############################################################################
# Function for handling of char delimited flat files
# ++++++++++++++++++++++++++++++++++++++++++++++++++
#
# Description:
#   A char delimited file contains a table with row and columns. The fields
#   are separated with a special character (e.g. | or ;). The first line
#   contains the columnNames. The ColumnNames can have [0-9,a-z,A-Z,_] (no spaces)
#   There is a set of function which let you access a flat file like an SQL dB.
#   The parser will skip the following lines:
#      Lines start with a #
#      Empty lines
#      Lines only containing any kind of white spaces
#
# Function to manipulate flat files via a Web-Interface
# +++++++++++++++++++++++++++++++++++++++++++++++++++++
#
##  Description:
##  If there is a flat file you want to access via a web interface you only have
##  to set some (most of them have a default value) variable which then controls
##  the look and functionality of the application. After defining these variables
##  just call prepareHTML_StandardFormForIt($anAction);
##  The default values can be viewed just at the beginning of the function
##  prepareHTML_StandardFormForIt
##  $anAction normaly is "". You can also overwrite thes action by any kind fo actions. If you need to pass action = "" (Display Table) 
#   you have to pass $DefaultPrepareAction
#
##  Definitions:
##  Mandatory fields
##  ----------------
# $debug         = "FALSE";
# $tabName       = "adressTable.txt";
# $tabSepChr     = ";";
# $myCgiFormName = "myName.pl";  # name of myself (needed to call back)
# $keyFieldName  = "Hash";
# 
## If you want to UpgradeFltDefinition (header) according to the @myEditFieldOrder array
## -------------------------------------------------------------------------------------
# $checkIfTblDefIsUpToDate = $TRUE # Default: $FALSE
#
## If you maintain a automated modify timestamp
## --------------------------------------------
# $modifyDateFieldName    = "ModDate";   # if "" no Modify-Date is maintained
#
## If you maintain a automated modify by field
## -------------------------------------------
# %myFixedValues = (
#        "ChangeBy"   => $loginUserId,     # $loginUserId = getParam("loginUserId","");
#        );
#
## If you maintain a password in the table
## ---------------------------------------
# $passwordFieldName      = "PassWd";    # if "" no Password Field is maintained
# $minPasswdLen
# $pwdMissMatch
# $pwdError1
# $pwdError2
# $newPwdLabel
# $newPwdLabelVerify
# $pwdVerificationFunction
# $enableForgottenPassword   = $TRUE;
# $emailNotifyFromAdr        = "Walter.Rothlin\@WriteMe.com"
# $emailNotifyCCAdr          = "Walter.Rothlin\@WriteMe.com"
#
## If you have an application using the built-in authorization you better set these variables
## ------------------------------------------------------------------------------------------
# $linkAsHiddenForms
# $gifDelete
# $gifModify
# $gifDetails
# $gifForgotten
#
## If you would like to have a mail to all selected link
## -----------------------------------------------------
# $emailColumnName        = "email";
# $emailPwdEnabled        = $FALSE;
# $emailAsLink            = $TRUE;
# $displayEmailListStr    = "Send %s to all selected users!<BR>";
# $emailLinkStr           = "e-Mail";
#
# $emailNameColumnName    = "name";
# $emailSendBtnLb1        = "Mail";
# $emailSendBtnLb2        = "All";
# $emailSelSize           = "6";
# $emailSelTab            = "<TABLE>";

# $passwordFileEmailColumnName    # to set if the login in screen should have the "Forgotten password" button enabled
#
#
## If you would like to have a detail screen for each record
## ---------------------------------------------------------
# $showDetailTemplateName = ""; # if "" all values just listed as default for showDetails
# @myDisplayDetailFields  = (); # if it is emty, display all fields
# $fieldIsHiddenStr       = ""; # this string is displayed when a field is defined on the
#                               # template but not in @myDisplayDetailFields
# $detailViewWidth
# $detailViewHeight
# $detailScrollbars  [TRUE (default),FALSE]
# $detailToolbar     [TRUE, FALSE (default)]
# $detailStatus      [TRUE, FALSE (default)]
#
## If you would like to have your own layout for the insert screen
## ---------------------------------------------------------------
# $insertTemplateName = ""; # if "" take the standart layout
## The template should have everything between (these tages should not be
## in the template) <Form> and </Form>. The template have the following placeholders:
## {Title:Name}:{Name} {Title:PasswordVerify}:{PasswordVerify}
## {Button:Submit} {Button:Reset} {Button:Back}
#
## If you would like to have your own layout for the delete screen
## ---------------------------------------------------------------
# $deleteTemplateName = ""; # if "" take the standart layout
## The template should have everything between (these tages should not be
## in the template) <Form> and </Form>. The template have the following placeholders:
## {Title:Name}:{Name} {Title:PasswordVerify}:{PasswordVerify}
## {Button:Submit} {Button:Back}
#
## If you would like to have your own layout for the modify screen
## ---------------------------------------------------------------
# $modifyTemplateName = ""; # if "" take the standart layout
## The template should have everything between (these tages should not be
## in the template) <Form> and </Form>. The template have the following placeholders:
## {Title:Name}:{Name} {Title:NewPwd}:{NewPwd} {Title:NewPwdVery}:{NewPwdVery}
## {Button:Submit} {Button:Reset} {Button:Back}
#
## If you would like to have your own layout for the Password Forgotten screen
## ---------------------------------------------------------------------------
# $forgottenTemplateName = ""; # if "" take the standart layout
## The template should have everything between (these tages should not be
## in the template) <Form> and </Form>. The template have the following placeholders:
## {Title:Name}:{Name} {Title:NewPwd}:{NewPwd} {Title:NewPwdVery}:{NewPwdVery}
## {Button:Submit} {Button:Reset} {Button:Back}
#
## If you would like to have your own layout for the Password Forgotten email
## --------------------------------------------------------------------------
# $fNameForgottenPwdEmail = ""; # if "" take the standart layout
## It is just an ASCII template which is used for formatting the email.
## The template can have all column names in {} as placeholders.
## e.g. {Name} {NewPwd} {NewPwdVery}
#
## Here are some variable which define the look out you probably want to overwrite
## -------------------------------------------------------------------------------
# $fontFace        = "face='helvetica,arial'";
# $fontSizeDefault = "-2";
# $tableTitelFormat
# $tableEntryFormat
# $tableActionFormat
# $tableFormatSmall
# $tableFormatBig
# $colSpanInsert
# $colSpanDelete
# $colSpanModify
# $labelFormat         # Format which is used for Lables in the Insert, Modify and Delete Box
# $strAction
# $strInsert
# $strSelect
# $strAll
# $strModify
# $strDelete
# $strDetail
# $strCancel
# $strUndo
# $strClose
# $strQBE
# $currCommaChar
# $currMilSep
#
## Enable Log file for Web-Application
## ------------------------------------
# $logFileName      # define this variable to enable
# $docArchiveLogFileName = $logFileName;  # to enable a log for the document archive
#  and overwrite 
#    $logSepChar         = ";"; or "\\|"
#    $logWithWeekday     = $TRUE;
#    $logUseMonthByName  = $TRUE;
#    $logLanguage        = $language;
#
## Make your application multi language
## ------------------------------------
# $language            [$LangEnglish (default),$LangGerman, $LangFrench]
## To store the language use the following statements
## $language       = getParam("language","$LangEnglish");
## $externalParam  = "language=${language}";
#
## dB file needs to be crypted
## ---------------------------
# $cryptKeyForDbFile = "WALTERROTHLIN";
# to manualy crypt a file $crypt reverse("$key") <tableName.flt >tableName.flt_crypted
#
## Fields to control functionality (must be set too)
## -------------------------------------------------
# $fullFunction  = $FALSE;
## if $fullFunction = $TRUE overwrites all the following flags
# $insertFunction= $TRUE;
# $copyFunction  = $FALSE;
# $builtInInsert = $TRUE;
# $deleteFunction= $TRUE;
# $markAsDelete  = $FALSE;   #if true the record is only marked as deleted
# $modifyFunction= $TRUE;
# $qbeFunction   = $TRUE;
# $sortFunction  = $TRUE;
# $autoFilter    = $TRUE;
# $displayDetail = $TRUE;
# $displayTable  = $TRUE;
# $sendDbViaEmail= $TRUE;
# $uploadDb      = $TRUE;
# $lockingDb     = $TRUE;

#
#
## If you enable the function to send the dB via Excel e-mail attachment
# $sendingDbFromAdr     = "";
# $sendingDbSubject     = "New Excel-File";
# $sendingDbMsg         = "Attached a new Excel file";
# $sendingDbCcAdr       = "";
# $sendingDbBccAdr      = "";
# @sendingDbColumns     = ();    # define which coulmns should be sent. () means all
#
## If you need to add your own function (like modify delete) to each record
## ------------------------------------------------------------------------
# $ownActionFunction     = "displayPrintLink";
# sub displayPrintLink {
#   printf ("         <A HREF=\"javascript:showPage('reprint.pl?fileName=%s&printer=%s&%s')\">Reprint it!!</A></font></TD>\n",$parts[$colNameToIndex{"Filename"}],$parts[$colNameToIndex{"Printer"}],$externalParam);
# }
#
## The application will pass the parameter to the next application (example for using $externalParam)
## ---------------------------------------------------------------
# $node       = getParam("node","");
# $remoteUser = getParam("remoteUser","");
# $externalParam  = "node=${node}&remoteUser=${remoteUser}";
#
## Other
## -----
# $fixedWhereClause       = "";   # this part is added to all the user selected whereClauses
# $initialWhereClause     = "";
# $initialSortClause      = "Name";
# $recordsFoundFormatStr  = "(Adressen gefunden: <B>%s</B>)<BR>\n";   # if "" no records found displayed
#
#
## Column Types used to distinct between Numeric and Alphabetic sorting the global variable 
# %myFieldType = (        # default is String
#      "columnName1" => "Numeric",
#      "columnName2" => "Numeric",
# );
#
## If some columns have particular (discrets) values you probably want to have it translated
## the defintion in enumarationTrans takes preference to a definition in %aHash
# %enumerationTrans = (
#           "Sex:Mann"     => "Herr",
#           "Sex:Frau"     => "<CENTER><IMG SRC='/img/woman.gif' border=0>",
#           "Sex:UseHash"  => \%aHash,
#           );
#
## If the fields you want to entre have a special input format
# %myInputFormats = (
#           "GebDate"    => "Date",
#           "KontoStand" => "curr",
#           "email"      => "userDefined:myEmailParser",     # The Autofilter entries are formated too
#           "isSigned"   => "userDefined_1:formatIsSigned",  # The Autofilter entries are not formated
#           );
## an example for a myEmailParser
# sub myEmailParser {
#    my($inStr,$language)  = @_;
#    my($retVal) = "";
#    parsing.....
#    if parseError {
#       $errorReturnCode = "$ErrorString:Any error string";
#    }
#    return $retVal;
# }
#
##  If some columns have a special format like Links, Dates,...
# %spezFormat = (
#           "ModDate"    => "Date",
#           "GebDate"    => "Date:Day:MonthByName",
#           "Vorname"    => "userDefined:formatName",
#           "CalcFiled"  => "userDefined:myOwnCalcColumn",
#           "eMailAdr"   => "email",
#           "HomePage"   => "url",
#           "Name"       => "url:HomePage",
#           "HomePage"   => "urlTarget:_new",
#           "HomePage"   => "urlTarget:_new:HomePage",
#           "Privilege"  => "privilege",
#           "Strasse"    => "detailLink",
#           "Groesse"    => "float:5.2:detailLink",    #detailLink is a valid option to all none HREF formats
#           "KontoStand" => "curr:5.2",
#           );
## an example for a format method
# sub formatName {
#    my($inVal) = @_;
#    if ($inVal eq "") { $inVal = " "; }
#    $inVal = repNullStr($inVal);
#    return "<U>${inVal}</U>";
# }
## an example for a format method
# sub formatModDate {
#    my($inVal) = @_;
#    my($jetzt) = getTimeStamp();
#    my($dayDiff) = dayDifference_str2(substr($jetzt,0,8),substr($inVal,0,8));
#    $retVal = formatTimeStamp($inVal);
#    if ($dayDiff < 5) {
#       $retVal = "<font color=#ff0000>${retVal}</font>";
#    }
#    return $retVal;
# }
## an example for a format method
# sub aRealtivLink {
#    my($inVal) = @_;
#    if ($inVal eq "/") {
#       return "<A HREF=\"${inVal}\" target=_new><B>Home-Page</B></A>";
#    } else {
#       return "<A HREF=\"${inVal}\" target=_new>${inVal}</A>";
#    }
# }
#
## Having a calculated Field in the displayed table, just add it to
## %myTitles and %spezFormat using "userDefined:myOwnCalcColumn" and add it
## @myDisplayOrder (You can not Edit, Sort or have a Autofilter on it!!)
# sub myOwnCalcColumn {
#   my($inVal) = @_;
#   my($hash) = $parts[$colNameToIndex{"Hash"}];
#   return sprintf ("Hallo %s=%s",$hash,$hash+$hash);
# }
#
#
## Just a translation table between ColumnNames and Titles
## (you must list all fields in the Table)
# %myTitles = (
#          "Hash"        => "Hash",
#          "Name"        => "Name",
#          "Vorname"     => "Vorname",
#          "eMailAdr"    => "e-Mail",
#          "HomePage"    => "Home<BR> Page",
#          "GebDate"     => "Geb. Datum",
#          "ModDate"     => "Modify-Date",
#          "CalcFiled"   => "Calculated",
#          "PassWd"      => "Passwort",
#          "Sex"         => "Geschlecht",
#          "Privilege"   => "privilege",
#          "KontoStand"  => "Konto Stand",
#          );
#
## If you wish to have columns using spez cell attributes
# %myTableAttr = (
#          "CalcFiled"   => "width=100",
#          "PassWd"      => "bgcolor='#ff0000'",
#          "Preis"       => "ALIGN=RIGHT",
#          );
#
## Here you define which Columns are visible and in which order
# @myDisplayOrder = ("Vorname","Name","eMailAdr","HomePage","CalcFiled","GebDate");
#
## Here you define which Columns shoud have an autofilter
# @myAutofilterFields = ("Vorname","Name");
# $autoFireAutofilter = $TRUE;   # no Select button for Autofilters
#
## Here you define which Columns shoud have an sort link
# @mySorterFields = ("Vorname","Name");
#
## Here you define which Values should be displayed in the delete notification box
# @myDeleteNotificationOrder = ("Name","Vorname");
#
## Here you define the order in which the fields are listed in the Edit-Box
## (you must list all fields in the Table)
# @myEditFieldOrder  = ("Name","Vorname","Sex","eMailAdr","HomePage","GebDate","Hash","PassWd","ModDate");
#
## Here you define which fields are displayed in the insert and modify form and you define
## how they should be displayed
# %myEditFieldFormat = (
#        "Name"       => "static",                      # the value ist only diplayed as a static text (not editable)
#        "Vorname"    => "23",                          # is a normal textbox for 23 characters
#        "Sex"        => "[Herr,Frau,Familie]",         # is a choice
#        "Sex"        => "[1;Herr,2;Frau,3;Familie]",   # is a choice
#        "eMailAdr"   => "9",
#        "HomePage"   => "20",
#        "GebDate"    => "10",
#        "Adressen"   => "10*50 NoWrap",                # is a textarea without line wrapping
#        "Komentar"   => "10*50",                       # is a textarea
#        );
#
## Here you define which fields have default values
# %myDefaultValues = (
#        "Komentar"   => "Kein Kommentar",
#        );
#
## Here you define which fields have fixed values
# %myFixedValues = (
#        "ChangeBy"   => $loginUserId,     # $loginUserId = getParam("loginUserId","");
#        );
#
## This definitions are used to verify on the Client if the data are not violating
## any constraints. After setting that string you need to implement a function with
## the same name which has to be in JavaScript (Client-Side)
# $checkInsertModformJS = "formCheck";
#
#sub formCheck {
#print <<javaScript;
#<script language="JavaScript">
#function formCheck(form) {
#  form.Entity.value = form.Entity.value.toUpperCase();
#  if (form.Entity.value.length != 4 ) {
#     alert ("Entity-Code is 4 char long ");
#     form.Entity.focus();
#     return (false);
#  }
#  if (form.CIA.options[form.CIA.selectedIndex].value != "Yes") {
#     alert("You have to do a Y2K CIA  !")
#     form.CIA.focus();
#     return false;
#  }
#  if ((form.BranchCode.value.length != 4 ) || (isNaN(parseInt(form.BranchCode.value)))) {
#     alert ("Branch-Code must be a 4 digit number");
#     form.BranchCode.focus();
#     return (false);
#  }
#  if (form.DueDate.value.length > 0 ) {
#     if (!(confirm("By defining a due date the request is marked as emergency request. Do you want that?"))) {
#            form.DueDate.focus();
#           return false;
#         }
#  }
#  if (form.Name.value.length == 0 ) {
#     alert ("Name has to be defined");
#     form.Name.focus();
#     return (false);
#  }
#  return (true);
#}
#//-->
#</SCRIPT>
#javaScript
#}
#
# If a nofiication e-mail should sent when ever somebody makes an INSERT,MODIFY,DELETE
# ------------------------------------------------------------------------------------
## $notifyEmailFromAdr_Modify   = "Wendy\@csfb.com";
## $notifyEmailToAdr_Modify     = "Walter.Rothlin\@csfb.com";
## $notifyEmailSubject_Modify   = "Modify by ${loginUserId}";
## or
## $recModifiedCallback         = "sendEmailNotificationForModify";
##
## sub sendEmailNotificationForModify {
##   my($refToHash1,$refToHash2,$loginUserId) = @_;
##   my $msg = diffInHashesWithSameKeys($refToHash1,$refToHash2,$TRUE);
##   if ($msg ne "") {
##     my %modifierAddrHash = getSingleRecInHash($addressTable,$addressTableSepChar,"","${addrTbl_UserId}=${loginUserId}","",$FALSE); 
##     $msg  = "Liebe Regula,<BR>Ich habe folgende Adress-Details von <B>".$refToHash1->{$addrTbl_Vorname}." ".$refToHash1->{$addrTbl_Name}."</B> ge&auml;ndert:<BR><BR>${msg}<BR><BR>Viele Gr&uuml;sse<BR>".$modifierAddrHash{$addrTbl_Vorname}." ".$modifierAddrHash{$addrTbl_Name};
##     my $retMsg = sendHtmlMail($modifierAddrHash{$addrTbl_EmailSchule},"sekretariat\@pswangensz.ch","PS-Wangen Adresse geaendert",$msg,$refToHash1->{$addrTbl_EmailSchule},"Walter\@Rothlin.com");
##   }
## }
##
##
## $notifyEmailFromAdr_Insert   = "Wendy\@csfb.com";
## $notifyEmailToAdr_Insert     = "Walter.Rothlin\@csfb.com";
## $notifyEmailSubject_Insert   = "Inserted by ${loginUserId}";
##
## $notifyEmailFromAdr_Delete   = "Wendy\@csfb.com";
## $notifyEmailToAdr_Delete     = "Walter.Rothlin\@csfb.com";
## $notifyEmailSubject_Delete   = "Deleted by ${loginUserId}";
# --------------------------------------------------------------------------------------------------

# common consts
# ------------------------------------
$TRUE           = 1;
$FALSE          = 0;
$pi             = 3.1415926;
$e              = 2.718281828;

# octal codes for special characters
$char_NUL = "\000";
$char_ENQ = "\005";
$char_BEL = "\007";
$char_BS  = "\010";
$char_HT  = "\011";
$char_LF  = "\012";
$char_VT  = "\013";
$char_FF  = "\014";
$char_CR  = "\015";
$char_SO  = "\016";
$char_SI  = "\017";
$char_DC1 = "\021";
$char_DC3 = "\023";
$char_CAN = "\030";
$char_SUB = "\032";
$char_ESC = "\033";
$char_EOL = "\036";

sub pi {
	return $pi;
}

sub e {
	return $e;
}

# to anynomize the library
# ------------------------
$testNatelNr_1_base               = "797"."029590";
$testNatelNr_1                    = "0".$testNatelNr_1_base;
$testNatelNr_1_international      = "0041".$testNatelNr_1_base;
$testNatelNr_1_internationalShort = "41".$testNatelNr_1_base;

$testNatelNr_2_base               = "797"."029593";
$testNatelNr_2                    = "0".$testNatelNr_2_base;
$testNatelNr_2_international      = "0041".$testNatelNr_2_base;
$testNatelNr_2_internationalShort = "41".$testNatelNr_2_base;

$testEmailAdr_1 =  "Walter"."Rothlin\@"."credit-suisse".".com";
$testEmailAdr_2 =  "Walter"."Rothlin\@"."credit-suisse".".com";


# Environment which can be overwritten
# ------------------------------------
$nslookupCmdSOLARIS = "/usr/sbin/nslookup";
$nslookupCmdLinux   = "/usr/bin/nslookup";
$nslookupCmd        = "";
set_nslookupPath();


$uuencodeCmdSOLARIS = "uuencode";
$uuencodeCmdLinux   = "/usr/bin/uuencode";
$uuencodeCmd        = "";
set_uuencodePath();



$sendMailPath       = "/usr/lib/";
$useMailxAsDefault  = $TRUE;


############################################################################
# Common translation tables used very often
############################################################################
%wochentagNamesE = ("0" => "Sunday",
                    "1" => "Monday",
                    "2" => "Tuesday",
                    "3" => "Wednesday",
                    "4" => "Thursday",
                    "5" => "Friday",
                    "6" => "Saturday",);

%wochentagNamesD = ("0" => "Sonntag",
                    "1" => "Montag",
                    "2" => "Dienstag",
                    "3" => "Mittwoch",
                    "4" => "Donnerstag",
                    "5" => "Freitag",
                    "6" => "Samstag",);

%wochentagNamesF= ("0" => "Dimanche",
                   "1" => "Lundi",
                   "2" => "Mardi",
                   "3" => "Mercredi",
                   "4" => "Jeudi",
                   "5" => "Vendredi",
                   "6" => "Samedi",);
                                   
%wochentagNamesI= ("0" => "Domenica",
                   "1" => "Lunedi",
                   "2" => "Martedi",
                   "3" => "Mercoledi",
                   "4" => "Giovedi",
                   "5" => "Venerdi",
                   "6" => "Sabato",);

%wochentagNames = %wochentagNamesD;
%weekdayNames   = %wochentagNamesE;

%monatNamesE = ("0"  => "January",
                "1"  => "February",
                "2"  => "March",
                "3"  => "April",
                "4"  => "May",
                "5"  => "June",
                "6"  => "July",
                "7"  => "August",
                "8"  => "September",
                "9"  => "October",
                "10" => "November",
                "11" => "December",);

%monatNamesAbrevE = ("0"  => "Jan",
                     "1"  => "Feb",
                     "2"  => "Mar",
                     "3"  => "Apr",
                     "4"  => "May",
                     "5"  => "Jun",
                     "6"  => "Jul",
                     "7"  => "Aug",
                     "8"  => "Sep",
                     "9"  => "Oct",
                     "10" => "Nov",
                     "11" => "Dec",);

%monatNamesAbrevD = ("0"  => "Jan",
                     "1"  => "Feb",
                     "2"  => "Mar",
                     "3"  => "Apr",
                     "4"  => "Mai",
                     "5"  => "Jun",
                     "6"  => "Jul",
                     "7"  => "Aug",
                     "8"  => "Sep",
                     "9"  => "Okt",
                     "10" => "Nov",
                     "11" => "Dez",);

%monatNamesAbrevF = ("0"  => "Jan",
                     "1"  => "Feb",
                     "2"  => "Mar",
                     "3"  => "Apr",
                     "4"  => "Mai",
                     "5"  => "Jun",
                     "6"  => "Jul",
                     "7"  => "Aug",
                     "8"  => "Sep",
                     "9"  => "Okt",
                     "10" => "Nov",
                     "11" => "Dez",);

%monatNamesAbrevI = ("0"  => "Jan",
                     "1"  => "Feb",
                     "2"  => "Mar",
                     "3"  => "Apr",
                     "4"  => "Mai",
                     "5"  => "Jun",
                     "6"  => "Jul",
                     "7"  => "Aug",
                     "8"  => "Sep",
                     "9"  => "Okt",
                     "10" => "Nov",
                     "11" => "Dez",);

 %monatNamesAbrevToNrE = (
        "JAN" => "01",
        "FEB" => "02",
        "MAR" => "03",
        "APR" => "04",
        "MAY" => "05",
        "JUN" => "06",
        "JUL" => "07",
        "AUG" => "08",
        "SEP" => "09",
        "OCT" => "10",
        "NOV" => "11",
        "DEC" => "12",);

 %monatNamesAbrevToNrAll = (
        "JAN" => "01",
        "FEB" => "02",
        "MAR" => "03",
        "APR" => "04",
        "MAY" => "05",
        "MAI" => "05",
        "JUN" => "06",
        "JUL" => "07",
        "AUG" => "08",
        "SEP" => "09",
        "OCT" => "10",
        "OKT" => "10",
        "NOV" => "11",
        "DEC" => "12",
        "DEZ" => "12",
        );

%monatNamesD = ("0"  => "Januar",
                "1"  => "Februar",
                "2"  => "März",
                "3"  => "April",
                "4"  => "Mai",
                "5"  => "Juni",
                "6"  => "Juli",
                "7"  => "August",
                "8"  => "September",
                "9"  => "Oktober",
                "10" => "November",
                "11" => "Dezember",);

%monatNamesF= ("0"  => "Janvier",
               "1"  => "Février",
               "2"  => "Mars",
               "3"  => "Avril",
               "4"  => "Mai",
               "5"  => "Juin",
               "6"  => "Juillet",
               "7"  => "Août",
               "8"  => "Septembre",
               "9"  => "Octobre",
               "10" => "Novembre",
               "11" => "Décembre",);
                           
%monatNamesI= ("0"  => "Gennaio",
               "1"  => "Febbraio",
               "2"  => "Marzo",
               "3"  => "Aprile",
               "4"  => "Maggio",
               "5"  => "Giugno",
               "6"  => "Luglio",
               "7"  => "Agosto",
               "8"  => "Settembre",
               "9"  => "Ottobre",
               "10" => "Novembre",
               "11" => "Dicembre",);

%holidays_floating_G = (
      "-52" => "Schmutziger Donnerstag (Fasnacht)",
      "-48" => "Güdel-Montag (Fasnacht)",
      "-47" => "Kleiner-Dienstag (Fasnacht)",
      "-46" => "Aschermittwoch",
      "-42" => "Alte Fasnacht (Göttikranz)",
      "-2"  => "Karfreitag",
      "-7"  => "Palmsonntag",
      "0"   => "Ostern",
      "1"   => "Ostern-Montag",
      "7"   => "Weisser-Sonntag",
      "39"  => "Auffahrt",
      "49"  => "Pfingsten",
      "50"  => "Pfingst-Montag",
      "60"  => "Frohnleichnahm",  
);
# Andere Feiertags-Regeln
# -----------------------
%other_floating_holidays_G = (
    "Bettag"          => "3.Sonnatg im September (16.9.2001)",
    "Knabenschiesen"  => "Montag vor Bettag (10.9.2001)",
    "Siebener-Märt"   => "Wochenende nach Bettag (23.9.2001)",
    "Sechselaeuten"   => "1. Grundsätzlich findet das Sechseläuten am dritten Montag des Monats April statt"+
                         "2. Fällt dieser Termin in die Karwoche, so wird das Sechsläuten am zweiten Montag abgehalten"+
                         "3. Fällt der dritte Montag im April auf den Ostermontag, so wird das Fest auf den vierten Montag verschoben"+
                         "4. Fällt dieser Termin auf den ersten Mai, wird der Termin auf ein Wochenende anfangs April bzw. Ende März festgesetzt"+
                         "Ist nach diesem Muster ein geeigneter Termin gefunden und dieser fällt (unglücklicherweise) in die Frühlingsferien der Volksschule, so wird versucht, ein Ausweichdatum zu finden. Diese neue Regelung wurde 2001 eingeführt und kommt im Jahr 2008 erstmals zur Anwendung"+
                         "  2005 18. April" +
                         "  2006 24. April" +
                         "  2007 16. April" +
                         "  2008 14. April" +
                         "  2009 20. April" +
                         "  2010 19. April" +
                         "  2011 11. April" +
                         "  2012 16. April" +
                         "  2013 15. April" +
                         "  2014 7. April" +
                         "  2015 13. April", 

);


#MMDD
%holidays_fixed_G = (
      "0101"  => "Neujahr",
      "0102"  => "Berchtoldstag",
      "0106"  => "Drei Könige",
      "0214"  => "Valentin's Tag",
      "0319"  => "Josef's Tag",
      "0501"  => "Tag der Arbeit",
      "0704"  => "Independence Day",
      "0801"  => "CH Nationalfeiertag",
      "0815"  => "Maria Himmelfahrt",
      "1101"  => "Allerheiligen",
      "1111"  => "Fassnachts Start",
      "1208"  => "Maria Empfängnis",
      "1224"  => "Heilig Abend",
      "1225"  => "Weihnachten",
      "1226"  => "Stefan's Tag",  
      "1231"  => "Silvester",   
);

%geburis_G = (
      "0111"  => "Daniel Laib (62)",
      "0116"  => "Loris Laib (??)",
      "0127"  => "Lars Guebeli (03);Monika Bruhin (??)",
      "0201"  => "Dmitriy Volfson (76)",
      "0203"  => "Marcel Guebeli + Claudia Hochzeitstag (01)",
      "0206"  => "Tim Staub (92)",
      "0207"  => "Walter Rothlin + Rosmarie Hochzeitstag (59)",
      "0209"  => "Fabio Laib (88)",
      "0222"  => "Heinz Schefold (57)",
      "0228"  => "Tim Vogt (95)",
      "0301"  => "Max Meier (39);Nelly Steinegger (69)",
      "0303"  => "Pascal Peng (??)",
      "0305"  => "Skevi Loizou (??)",
      "0311"  => "Simone Staub (61)",
      "0319"  => "David Steineigger (59)",
      "0322"  => "Greta Cardiff (59)",
      "0325"  => "Sandro Vogt (Gisela) (01)",
      "0327"  => "Gretchen Korn (65)",
      "0417"  => "Doug Kahn (57)",
      "0422"  => "Josef Friedlos (58)",
      "0425"  => "Ueli Sauter (98)",
      "0428"  => "Lisa Korn (66)",
      "0505"  => "Walter Rothlin + Claudia Hochzeitstag (95)",
      "0523"  => "Margot Joerg (70)",
      "0526"  => "Daniela Friedlos (91);Frank Bruhin (??)",
      "0527"  => "Alice Diethelm (95)",
      "0529"  => "Ueli Sauter (59)",
      "0603"  => "Marcel Guebeli (68)",
      "0611"  => "Silvan Laib (90)",
      "0613"  => "Miguel Jimenez (45)",
      "0621"  => "Gisela Zueger (67)",
      "0622"  => "Rosmarie Friedlos (59)",
      "0706"  => "Swati Munshi (74)",
      "0715"  => "Michaela Friedlos (89)",
      "0719"  => "Remo Collet (40)",
      "0720"  => "Rosmarie Rothlin (36)",
      "0730"  => "Wigarda Hartenhof (73)",
      "0731"  => "Tobias Rothlin (96)",
      "0802"  => "Uschi Vogt (53)",
      "0805"  => "Walter Rothlin (60);Hochzeitstag Walti + Claudia (95)",
      "0827"  => "Chrigi Sauter (??)",
      "0906"  => "Stefan Wey (60)",
      "0908"  => "Noel Diethelm (97)",
      "0918"  => "Alice Troxler (54)",
      "0928"  => "Sepp Friedlos + Rosmarie Hochzeitstag(85)",
      "1012"  => "Walter Rothlin (36)",
      "1018"  => "Siebert Kruger (73)",
      "1026"  => "Emma Korn (96)",
      "1027"  => "Gaby Diethelm (67);Ken Kiener (??)",
      "1030"  => "Walter Zueger (60)",
      "1104"  => "Sonja Zueger (??)",
      "1114"  => "Claudia Collet (65)",
      "1120"  => "Regula Laib (63)",
      "1124"  => "Chester Postrero (70)",
      "1125"  => "Karin Diethelm (70)",
      "1126"  => "Gerard Staub (??)",
      "1129"  => "Lukas Rothlin (99)",
      "1202"  => "Justin Leivers (??)",
      "1214"  => "Susan Kaufman (??)",
      "1217"  => "Roli Diethelm (65)",
);

%monthNames   = %monatNamesE;
%monatNames   = %monatNamesD;

%dayInMonth = ("0"  =>  "31",
               "1"  =>  "28",
               "2"  =>  "31",
               "3"  =>  "30",
               "4"  =>  "31",
               "5"  =>  "30",
               "6"  =>  "31",
               "7"  =>  "31",
               "8"  =>  "30",
               "9"  =>  "31",
               "10" =>  "30",
               "11" =>  "31");

%AsciiToDecode = (" "  =>  "D",
                  "C"  =>  "2B",
                  "A"  =>  "7D");

%CityCurrencyTbl = (
       "ZH"  => "CHF",
       "ZN"  => "CHF",  # Zurich North
       "NY"  => "USD",
       "LN"  => "GBP",
);


%AsciiToDecodeTem = (" "  =>  "+",
                  "!"  =>  "%21",
                  "\"" =>  "%22",
                  "#"  =>  "%23",
                  "\$" =>  "%24",
                  "\%" =>  "%25",
                  "\&" =>  "%26",
                  "\'" =>  "%27",
                  "("  =>  "%28",
                  ")"  =>  "%29",
                  "+"  =>  "%2B",
                  ","  =>  "%2C",
                  "/"  =>  "%2F",
                  ":"  =>  "%3A",
                  ";"  =>  "%3B",
                  "<"  =>  "%3C",
                  "="  =>  "%3Dxxxxx",
                  ">"  =>  "%3E",
                  "?"  =>  "%3F",
                  "["  =>  "%5B",
                  "\\" =>  "%5C",
                  "]"  =>  "%5D",
                  "^"  =>  "%5E",
                  "{"  =>  "%7B",
                  "\|" =>  "%7C",
                  "}"  =>  "%7D");

$FIRST          = "XXXXFIRSTXXXXX";
$LAST           = "XXXXLASTXXXXX";
$ROOT_ID        = "root";
$NotDefined     = "XXXX";
$NotDefinedStr  = "XX Undefined XX";
$ErrorString    = "XXX ERROR XXX";
$ERROR          = "XXX ERROR XXX";
$WARNING        = "XXX WARNING XXX";
$ERROR_FOUND    = $FALSE;
$WARNING_FOUND  = $FALSE;

$LoginFailed    = "XXXXLoginFailedXXXXX";
$LangGerman     = "german";
$LangEnglish    = "english";
$LangFrench     = "french";
$LangItalian    = "italian";
$DefaultLang    = $LangEnglish;
$language       = $DefaultLang;
$deleteMark     = "## Marked as Delete: ";

$DefaultTableCellSpacing = "0";
$DefaultTableCellPadding = "3";
$DefaultTableBorder      = "1";

$DefaultPrepareAction    = "NOP";
$DefaultCryptKey         = "Bond_007";
############################################################################
# Language dependant text strings
############################################################################
$german_strSelect            = "Auswählen";
$german_strAll               = "Alle";
$german_strAction            = "Befehle";
$german_strInsert            = "Einfügen";
$german_strModify            = "Aendern";
$german_strCopy              = "Kopieren";
$german_strDelete            = "Löschen";
$german_strDetail            = "Details";
$german_strCancel            = "Abbrechen";
$german_strUndo              = "Rückgängig";
$german_strClose             = "Schliessen";
$german_strQBE               = "qbe";
$german_newPwdLabel          = "Neues Passwort";
$german_newPwdLabelVerify    = "Bestätigung";
$german_insertTitleStr       = "Datensatz einfügen";
$german_deleteTitleStr       = "Datensatz löschen";
$german_modifyTitleStr       = "Datensatz ändern";
$german_qbeTitleStr          = "SQL-Ausdruck";
$german_emailLinkStr         = "e-Mail";
$german_emailSendBtnLb1      = "Senden";
$german_emailSendBtnLb2      = "Alle auswählen";
$german_displayEmailListStr  = "Senden \%s an alle Ausgewählten!";
$german_pwdMissMatch         = "Falsches Passwort / Fehlendes Passwort";
$german_pwdError1            = "Passwort-Bestätigung falsch";
$german_pwdError2            = "Passwort muss länger als \%s sein";
$german_strLogin             = "Anmelden";
$german_strUserId            = "Benutzername";
$german_strPassword          = "Passwort";
$german_strNotAuthorized     = "Nur berechtigte Benutzer haben Zugriff";
$german_strLoginFailBtn      = "Zurück zum Anmeldung";
$german_strUnknown           = "Unbekannt";
$german_strName              = "Name";
$german_strMsg               = "Meldung";
$german_strRefreshEnter      = "Meldung absenden / Seite neu laden";
$german_strPressReturn       = "RETURN Taste drücken zum Weitermachen";
$german_strForgotten         = "Passwort";
$german_forgottenTitle       = "Passwort vergessen";
$german_strPwdSend           = "Passwort via e-mail senden";
$german_emailNotifySubject   = "Vergessenes Passwort";
$german_forgottenPwdMsg      = "Das vergessene Passwort ist \%s";
$german_strCaseMatch         = "Gross- / Kleinschreibung berücksichtigen";
$german_strFrom              = "Absender";
$german_strTo                = "An";
$german_strCc                = "Kopie an";
$german_strBcc               = "Heimliche Kopie an";
$german_strSubject           = "Betrifft";
$german_strMessage           = "Nachricht";
$german_strSendEMail         = "Nachricht senden";
$german_strClear             = "Nachricht löschen";
$german_strFieldMissing      = "Einige Angaben werden vermisst";
$german_strEnterFollowFields = "Folgende Felder müssen definiert werden";
$german_strEmailSentTo       = "Meldung wurde an <B>\%s</B> gesendet";
$german_strEmailSentError    = "Meldung konnte nicht abgesendet werden. Fehler-Meldung ist:";
$german_strBack              = "Zurück zur alten Nachricht";
$german_strNewMail           = "Neue Nachricht erfassen";
$german_strOld               = "Alt:";
$german_strNew               = "Neu:";
$german_strOnlyOld           = "Nur in Alt:";
$german_strOnlyNew           = "Nur in Neu:";
$german_strEmailAdr          = "e-Mail";
$german_strInputRequired     = "In ein zwingendes Feld wurde keine Eingabe gemacht";
$german_strFileLocked        = "File wird gerade durch einen anderen Benutzer bearbeitet";
$german_strTryAgain          = "Nochmals versuchen";
$german_strSave              = "Speichern";
$german_strYes               = "Ja";
$german_strNo                = "Nein";
$german_strReallyDelete      = "Möchten Sie wirklich <B>\%s</B> löschen?";
$german_strHasDeleted        = "<B>\%s</B> wurde gelöscht";
$german_strExecute           = "Ausführen";
$german_strExecuteTime       = "Ausführungszeit";
$german_strEmailNotifyTo     = "Ausführungsmeldung an";
$german_strJobExecAt         = "Auftrag wir am <B>\%s</B> ausgeführt";
$german_strShowJobs          = "Anzeigen der Aufträge";
$german_strNewJob            = "Neuer Auftrag";
$german_strReallyLock        = "Möchten Sie wirklich <B>\%s</B> reservieren?";
$german_strReallyUnlock      = "Möchten Sie die Reservation auf <B>\%s</B> wirklich aufheben?";
$german_strHasUnlock         = "<B>\%s</B> wurde freigeben";
$german_strLockHasSet        = "<B>\%s</B> wurde reserviert";
$german_strLockHasAlreadySet = "<B>\%s</B> ist bereits durch <B>\%s</B> reserviert";
$german_strLockHasAlreaUnset = "<B>\%s</B> ist bereits freigegeben";
$german_strNotLockOwner      = "<B>\%s</B> ist durch <B>\%s</B> reserviert";
$german_strReallySubscribe   = "Wollen Sie <B>\%s</B> bestellen?";
$german_strHasSubscribed     = "<B>\%s</B> wurde von <B>\%s</B> bestellt";
$german_strAlreadySubscribed = "Sie haben dieses Dokument bereits bestellt";
$german_strMissingEmailAdr   = "Bitte geben sie ihre e-mail Adresse ein";
$german_strReallyUnsubsribe  = "Wollen sie wirklich <B>\%s</B> abbestellen?";
$german_strHasUnsubscribe    = "<B>\%s</B> wurde abbestellt";
$german_strNotSubcriber      = "<B>\%s</B> wurde nicht von ihnen bestellt";
$german_strUpload            = "Upload";
$german_strDelete            = "Löschen";
$german_strSubscribe         = "Abo bestellen";
$german_strLock              = "Reservieren";
$german_strUnsubscribe       = "Abo löschen";
$german_strUnlock            = "Reservation löschen";
$german_strUpLoadTitle       = "Upload beendet";
$german_strUpLoadDestination = "Ziel war";
$german_strLocks             = "Reservationen";
$german_strSubscribtions     = "Abos";
$german_strManageMy          = "Verwalten meiner";
$german_strView              = "Anzeigen";
$german_strOtherFct          = "Weiter Funktionen";
$german_strLastModDoc        = "Neustest Dokument: ";
$german_strCurrent           = "Aktuell";
$german_strSendDbFile        = "Senden";
$german_strUploadDbFile      = "Laden";
$german_strIsLocked          = "Ist reserviert";
$german_strEmailSelectorTitle= "Wähle Namen aus um eine <BR>beliebige Meldung via <B>e-mail</B> an alle zu senden";
$german_strSmsSelectorTitle  = "Wähle Namen aus um eine <BR>beliebige Meldung via <B>SMS</B> an alle zu senden";
$german_strNoEmailDefined    = "Für Benutzer <B>\%s</B> ist keine e-mail Adresse definiert";
$german_strUseBuiltInEmail   = "Eingebautes e-mail Programm verwenden";

$english_strSelect            = "Select";
$english_strAll               = "All";
$english_strAction            = "Action";
$english_strInsert            = "Insert";
$english_strModify            = "Modify";
$english_strCopy              = "Copy";
$english_strDelete            = "Delete";
$english_strDetail            = "Detail";
$english_strCancel            = "Cancel";
$english_strUndo              = "Undo";
$english_strClose             = "Close";
$english_strQBE               = "qbe";
$english_newPwdLabel          = "New Password";
$english_newPwdLabelVerify    = "Verification";
$english_insertTitleStr       = "Insert Record";
$english_deleteTitleStr       = "Delete Record";
$english_modifyTitleStr       = "Modify Record";
$english_qbeTitleStr          = "SQL-Statement";
$english_emailLinkStr         = "e-Mail";
$english_emailSendBtnLb1      = "Mail";
$english_emailSendBtnLb2      = "Select all";
$english_displayEmailListStr  = "Send \%s to all selected users!";
$english_pwdMissMatch         = "Password mismatch / Password missing";
$english_pwdError1            = "Verification mismatch";
$english_pwdError2            = "Password must be longer than %s\n";
$english_strLogin             = "Login";
$english_strUserId            = "User-Name";
$english_strPassword          = "Password";
$english_strNotAuthorized     = "Only authorized user are allowed to enter!!";
$english_strLoginFailBtn      = "Back to Login";
$english_strUnknown           = "Unknown";
$english_strName              = "Name";
$english_strMsg               = "Message";
$english_strRefreshEnter      = "Post Message / Refresh Page";
$english_strPressReturn       = "Press RETURN to continue";
$english_strForgotten         = "Password";
$english_forgottenTitle       = "Password forgotten";
$english_strPwdSend           = "has been sent via email";
$english_emailNotifySubject   = "Forgotten Password";
$english_forgottenPwdMsg      = "Your Password is \%s";
$english_strCaseMatch         = "Match Cases";
$english_strFrom              = "From";
$english_strTo                = "To";
$english_strCc                = "Cc";
$english_strBcc               = "Bcc";
$english_strSubject           = "Subject";
$english_strMessage           = "Message";
$english_strSendEMail         = "Send e-mail";
$english_strClear             = "Clear";
$english_strFieldMissing      = "Some fields are missing";
$english_strEnterFollowFields = "Please enter all the following fields";
$english_strEmailSentTo       = "E-mail has been sent to \%s";
$english_strEmailSentError    = "E-mail could not be sent. Error was:";
$english_strBack              = "Back";
$english_strNewMail           = "New E-mail";
$english_strOld               = "Old:";
$english_strNew               = "New:";
$english_strOnlyOld           = "Only in old:";
$english_strOnlyNew           = "Only in new:";
$english_strEmailAdr          = "e-Mail";
$english_strInputRequired     = "Missing value for a required field";
$english_strFileLocked        = "File is currently locked by another user";
$english_strTryAgain          = "Try it again";
$english_strSave              = "Save";
$english_strYes               = "Yes";
$english_strNo                = "No";
$english_strReallyDelete      = "You really want to delete <B>\%s</B>?";
$english_strHasDeleted        = "<B>\%s</B> has been deleted";
$english_strExecute           = "Execute";
$english_strExecuteTime       = "Time to execute";
$english_strEmailNotifyTo     = "Execution notification to";
$english_strJobExecAt         = "Job will be executed at <B>\%s</B>";
$english_strShowJobs          = "Show jobs";
$english_strNewJob            = "New job";
$english_strReallyLock        = "You really want to lock <B>\%s</B>?";
$english_strReallyUnlock      = "You really want to release <B>\%s</B>?";
$english_strHasUnlock         = "<B>\%s</B> has been released";
$english_strLockHasSet        = "<B>\%s</B> has been locked";
$english_strLockHasAlreadySet = "<B>\%s</B> has already been locked by <B>\%s</B>";
$english_strLockHasAlreaUnset = "<B>\%s</B> has already been released";
$english_strNotLockOwner      = "<B>\%s</B> has been locked by <B>\%s</B>";
$english_strReallySubscribe   = "Subscribe to <B>\%s</B>?";
$english_strHasSubscribed     = "<B>\%s</B> has been subscribed by <B>\%s</B>";
$english_strAlreadySubscribed = "Already subribed to that document";
$english_strMissingEmailAdr   = "Missing e-mail address";
$english_strReallyUnsubsribe  = "You really want to cancel the subscribtion to <B>\%s</B>?";
$english_strHasUnsubscribe    = "You have canceled the subscribtion to <B>\%s</B>";
$english_strNotSubcriber      = "You have not been subscribed to <B>\%s</B>";
$english_strUpload            = "Upload";
$english_strDelete            = "Delete";
$english_strSubscribe         = "Subscribe";
$english_strLock              = "Lock";
$english_strUnsubscribe       = "Cancel Subscribtion";
$english_strUnlock            = "Cancel Lock";
$english_strUpLoadTitle       = "Upload finished";
$english_strUpLoadDestination = "Destination was";
$english_strLocks             = "Locks";
$english_strSubscribtions     = "Subscribtions";
$english_strManageMy          = "Manage my";
$english_strView              = "View";
$english_strOtherFct          = "Other Functions";
$english_strLastModDoc        = "Latest Document: ";
$english_strCurrent           = "Current";
$english_strSendDbFile        = "Send";
$english_strUploadDbFile      = "Upload";
$english_strIsLocked          = "Is locked";
$english_strEmailSelectorTitle= "Select names to send a free<BR>formatted <B>e-mail</B> message to these names";
$english_strSmsSelectorTitle  = "Select names to send a free<BR>formatted <B>SMS</B> message to these names";
$english_strNoEmailDefined    = "There is no e-mail address defined for user <B>\%s</B>";
$english_strUseBuiltInEmail   = "Use built-in e-mail client";

$french_strSelect            = "Sélectionner";
$french_strAll               = "Tous";
$french_strAction            = "Instruction";
$french_strInsert            = "Insérer";
$french_strModify            = "Modifier";
$french_strCopy              = "Copie";
$french_strDelete            = "Effacer";
$french_strDetail            = "Détailler";
$french_strCancel            = "Annuler";
$french_strUndo              = "Défaire";
$french_strClose             = "Fermer";
$french_strQBE               = "qbe";
$french_newPwdLabel          = "Nouveau mot de passe";
$french_newPwdLabelVerify    = "Confirmation";
$french_insertTitleStr       = "Insérer registre";
$french_deleteTitleStr       = "Effacer registre";
$french_modifyTitleStr       = "Modifiez registre";
$french_qbeTitleStr          = "SQL- expression";
$french_emailLinkStr         = "Courrier électronique";
$french_emailSendBtnLb1      = "Envoyer";
$french_emailSendBtnLb2      = "Sélectionner Tous";
$french_displayEmailListStr  = "Envoyer \%s à tous les personnes sélectionnées!";
$french_pwdMissMatch         = "Mauvais mot de passe";
$french_pwdError1            = "Confirmation mot de passe incorrect";
$french_pwdError2            = "Mot de passe doit avoir plus que \%s caractères";
$french_strLogin             = "Accès";
$french_strUserId            = "Nom de l'utilisateur";
$french_strPassword          = "Mot de passe";
$french_strNotAuthorized     = "Accès restreint aux personnes autorisées!!";
$french_strLoginFailBtn      = "Retour à la page d'accès ";
$french_strUnknown           = "Inconnu";
$french_strName              = "Nom";
$french_strMsg               = "Message";
$french_strRefreshEnter      = "Envoyer message / Mise a jour";
$french_strPressReturn       = "Appuyer sur la touche RETOUR pour continuer";
$french_strForgotten         = "Mot de passe";
$french_forgottenTitle       = "Mot de passe oublié";
$french_strPwdSend           = "Envoyer mot de passe par courriel";
$french_emailNotifySubject   = "Mot de passe oublié";
$french_forgottenPwdMsg      = "Le mot de passe oublié est  \%s";
$french_strCaseMatch         = "L'entrée est critique";
$french_strFrom              = "Expéditeur";
$french_strTo                = "À";
$french_strCc                = "Copie à";
$french_strBcc               = "Copie aveugle à";
$french_strSubject           = "Concernant";
$french_strMessage           = "Message";
$french_strSendEMail         = "Envoyer message";
$french_strClear             = "Effacer message";
$french_strFieldMissing      = "Certaines données sont manquantes";
$french_strEnterFollowFields = "Les données suivantes doivent être définies";
$french_strEmailSentTo       = "Message envoyé à <B>\%s</B>";
$french_strEmailSentError    = "Message non transmis:";
$french_strBack              = "Retour";
$french_strOld               = "Ancien:";
$french_strNew               = "Nouveau:";
$french_strOnlyOld           = "Seulement dans l'ancien:";
$french_strOnlyNew           = "Seulement dans le nouveau:";
$french_strEmailAdr          = "Courriel";
$french_strInputRequired     = "Cellule obligatoire laissée en blanc";
$french_strFileLocked        = "Fichier en cours d'utilisation";
$french_strTryAgain          = "Essayer à nouveau";
$french_strSave              = "Save";
$french_strYes               = "Qui";
$french_strNo                = "None";
$french_strReallyDelete      = "Vous voulez vraiment effacer <B>\%s</B>?";
$french_strHasDeleted        = "<B>\%s</B> a été effacer";
$french_strExecute           = "Exécuter";
$french_strExecuteTime       = "Temp d'éxecution";
$french_strEmailNotifyTo     = "Avis d'exécution a";
$french_strJobExecAt         = "Exécution de la mission le <B>\%s</B>";
$french_strShowJobs          = "Faire voir les commandes";
$french_strNewJob            = "Nouveau commandes";
$french_strReallyLock        = "Vous voulez vraiment réserver <B>\%s</B>?";
$french_strReallyUnlock      = "Vous voulez vraiment annuler la réservation pour<B>\%s</B>?";
$french_strHasUnlock         = "<B>\%s</B> a été liberé";
$french_strLockHasSet        = "<B>\%s</B> a été réservé";
$french_strLockHasAlreadySet = "<B>\%s</B> a été déjà réservé par <B>\%s</B>";
$french_strLockHasAlreaUnset = "<B>\%s</B> a éte déjà liberé";
$french_strNotLockOwner      = "<B>\%s</B> est réservé par <B>\%s</B>";
$french_strReallySubscribe   = "Vous voulez abonner<B>\%s</B>?";
$french_strHasSubscribed     = "<B>\%s</B> a été abonné par <B>\%s</B>";
$french_strAlreadySubscribed = "Vous avez déjà abonné ce document";
$french_strMissingEmailAdr   = "Inserez votre email s.v.p.";
$french_strReallyUnsubsribe  = "Vous voulez vraiment annuler l'abonnement pour <B>\%s</B>?";
$french_strHasUnsubscribe    = "L'abonnement <B>\%s</B> a été annulée";
$french_strNotSubcriber      = "<B>\%s</B> n'as pas été abonné par vous";
$french_strUpload            = "Upload";
$french_strDelete            = "Effacer";
$french_strSubscribe         = "Commander l'abonnement";
$french_strLock              = "Reserver";
$french_strUnsubscribe       = "Annuler l'abonnement";
$french_strUnlock            = "Annuler la réservation";
$french_strUpLoadTitle       = "Terminé Upload";
$french_strUpLoadDestination = "La destination etait";
$french_strLocks             = "Réservations";
$french_strSubscribtions     = "Abonnements";
$french_strManageMy          = "Administrer mes";
$french_strView              = "Montrer";
$french_strOtherFct          = "Autres fonctions";
$french_strLastModDoc        = "Dernier document: ";
$french_strCurrent           = "Actuel";
$french_strSendDbFile        = "????Send";
$french_strUploadDbFile      = "????Upload";
$french_strIsLocked          = "????Is locked";
$french_strEmailSelectorTitle= "????Select names to send a free<BR>formatted <B>e-mail</B> message to these names";
$french_strSmsSelectorTitle  = "????Select names to send a free<BR>formatted <B>SMS</B> message to these names";
$french_strNoEmailDefined    = "????There is no e-mail address defined for user <B>\%s</B>";
$french_strUseBuiltInEmail   = "????Use built-in e-mail client";

$italian_strSelect            = "Selezionare";
$italian_strAll               = "Tutti";
$italian_strAction            = "Comando";
$italian_strInsert            = "Inserire";
$italian_strModify            = "Cambiare";
$italian_strCopy              = "Copia";
$italian_strDelete            = "Cancellare";
$italian_strDetail            = "Dettagli";
$italian_strCancel            = "Interrompere";
$italian_strUndo              = "Revocare";
$italian_strClose             = "Chiudere";
$italian_strQBE               = "qbe";
$italian_newPwdLabel          = "Nuovo codice";
$italian_newPwdLabelVerify    = "Conferma";
$italian_insertTitleStr       = "Inserire registrazione";
$italian_deleteTitleStr       = "Cancellare registrazione";
$italian_modifyTitleStr       = "Cambiare registrazione";
$italian_qbeTitleStr          = "Stampa SQL";
$italian_emailLinkStr         = "e-Mail";
$italian_emailSendBtnLb1      = "Inviare";
$italian_emailSendBtnLb2      = "Scegliere tutti";
$italian_displayEmailListStr  = "Inviare \%s a tutti quelli scelti!";
$italian_pwdMissMatch         = "Codice sbagliato";
$italian_pwdError1            = "Conferma del codice sbagliata";
$italian_pwdError2            = "Il codice deve essere più lungo die\%s";
$italian_strLogin             = "Notifica";
$italian_strUserId            = "Nome del utente";
$italian_strPassword          = "Codice";
$italian_strNotAuthorized     = "Accesso solo per utenti autorizzati";
$italian_strLoginFailBtn      = "Ritornare alla notifica";
$italian_strUnknown           = "Ignoto";
$italian_strName              = "Nome";
$italian_strMsg               = "Messaggio";
$italian_strRefreshEnter      = "Inviare messaggio / ricaricare la pagina";
$italian_strPressReturn       = "Per continuare premere il tasto RETURN";
$italian_strForgotten         = "Codice";
$italian_forgottenTitle       = "Codice dimenticato";
$italian_strPwdSend           = "Inviare il codice via e-Mail";
$italian_emailNotifySubject   = "Codice dimenticato";
$italian_forgottenPwdMsg      = "Il codice dimenticato è \%s";
$italian_strCaseMatch         = "Tener conto di lettere maiuscole e minuscole";
$italian_strFrom              = "Emittente";
$italian_strTo                = "A";
$italian_strCc                = "Copia a";
$italian_strBcc               = "Copia nascosta a";
$italian_strSubject           = "Concerne";
$italian_strMessage           = "Messaggio";
$italian_strSendEMail         = "Inviare messaggio";
$italian_strClear             = "Cancellare messaggio";
$italian_strFieldMissing      = "Mancano alcune indicazioni";
$italian_strEnterFollowFields = "Le seguenti indicazioni devono essere definite";
$italian_strEmailSentTo       = "Il messaggio é stato inviato a<B>\%s</B>";
$italian_strEmailSentError    = "Il messaggio non é stato inviato. Errore:";
$italian_strBack              = "Ritorno al messaggio precedente";
$italian_strNewMail           = "Registrare il nuovo messaggio";
$italian_strOld               = "Vecchio:";
$italian_strNew               = "Nuovo:";
$italian_strOnlyOld           = "Solo in vecchio:";
$italian_strOnlyNew           = "Solo in nuovo:";
$italian_strEmailAdr          = "e-Mail";
$italian_strInputRequired     = "Indicazione obbligatoria lasciata in bianco";
$italian_strFileLocked        = "Il File viene momentaneamente elaborato da un altro utente";
$italian_strTryAgain          = "Riprovare nuovamente";
$italian_strSave              = "Save";
$italian_strYes               = "Si";
$italian_strNo                = "No";
$italian_strReallyDelete      = "Vuole veramente cancellare <B>\%s</B>?";
$italian_strHasDeleted        = "<B>\%s</B> è stato cancellato";
$italian_strExecute           = "Eseguire";
$italian_strExecuteTime       = "Tempo d'esecuzione";
$italian_strEmailNotifyTo     = "Avviso d'esecuzione a";
$italian_strJobExecAt         = "L'ordine sarà eseguito il<B>\%s</B>";
$italian_strShowJobs          = "Far vedere gli ordini";
$italian_strNewJob            = "Nuovi ordini";
$italian_strReallyLock        = "Vuole veramente riservare <B>\%s</B>?";
$italian_strReallyUnlock      = "Vuole veramente annullare la riservazione per <B>\%s</B>?";
$italian_strHasUnlock         = "<B>\%s</B> è stato liberato";
$italian_strLockHasSet        = "<B>\%s</B> è stato riservato";
$italian_strLockHasAlreadySet = "<B>\%s</B> é già stato riservato da <B>\%s</B>";
$italian_strLockHasAlreaUnset = "<B>\%s</B> è già stato liberato";
$italian_strNotLockOwner      = "<B>\%s</B> é stato riservato da <B>\%s</B>";
$italian_strReallySubscribe   = "Vuole abonarsi <B>\%s</B>?";
$italian_strHasSubscribed     = "<B>\%s</B> è stato abonato da <B>\%s</B>";
$italian_strAlreadySubscribed = "E già abonato a questo documento";
$italian_strMissingEmailAdr   = "Inserisca l'email per favore";
$italian_strReallyUnsubsribe  = "Vuole veramente cancellare l'abonamento per <B>\%s</B>?";
$italian_strHasUnsubscribe    = "L'abonamento per <B>\%s</B> è stato cancellato";
$italian_strNotSubcriber      = "Non è stato abonato a <B>\%s</B>";
$italian_strUpload            = "Upload";
$italian_strDelete            = "Cancellare";
$italian_strSubscribe         = "Abonare";
$italian_strLock              = "Riservare";
$italian_strUnsubscribe       = "Cancellare l'abonamento";
$italian_strUnlock            = "Cancellare la riservazione";
$italian_strUpLoadTitle       = "Upload terminato";
$italian_strUpLoadDestination = "La destinazione era";
$italian_strLocks             = "Riservazione";
$italian_strSubscribtions     = "Abonamenti";
$italian_strManageMy          = "Amministrare i miei/le mie";
$italian_strView              = "Mostrare";
$italian_strOtherFct          = "Ulteriori Funzioni";
$italian_strLastModDoc        = "Ultimo documento: ";
$italian_strCurrent           = "Attuale";
$italian_strSendDbFile        = "????Send";
$italian_strUploadDbFile      = "????Upload";
$italian_strIsLocked          = "????Is locked";
$italian_strEmailSelectorTitle= "????Select names to send a free<BR>formatted <B>e-mail</B> message to these names";
$italian_strSmsSelectorTitle  = "????Select names to send a free<BR>formatted <B>SMS</B> message to these names";
$italian_strNoEmailDefined    = "????There is no e-mail address defined for user <B>\%s</B>";
$italian_strUseBuiltInEmail   = "????Use built-in e-mail client";

sub getLangStr {
	my($strName)  = @_;
	my $language  = setDefault($language,$DefaultLang);
	if (!(($language eq $LangEnglish) || ($language eq $LangFrench) || ($language eq $LangGerman))) {
		$language = $DefaultLang;
	}
	$strName      = "${language}_${strName}";
	return $$strName;
}

sub getLangStrFromHash {
	my($strName,%transTab)  = @_;
	my $retVal = $strName;
	if (exists($transTab{$strName})) {
		$retVal = $transTab{$strName};
	}
	return $retVal;
}

sub getLangCode {
	my($aLanguage)  = @_;
	$aLanguage = setDefault($aLanguage,$DefaultLang);
	my $retVal = "e";
	if ($aLanguage eq $LangGerman) {
		$retVal = "d";
	} elsif ($aLanguage eq $LangEnglish) {
		$retVal = "e";
	} elsif  ($aLanguage eq $LangFrench) {
		$retVal = "f";
	} elsif ($aLanguage eq $LangItalian) {
		$retVal = "i";
	}
	return $retVal;
}

sub getLangStrFromHash_LangCode {
	my($strName,%transTab)  = @_;
	my $retVal = $strName;
	$strName = sprintf("${strName}_%s",getLangCode($language));
	if (exists($transTab{$strName})) {
		$retVal = $transTab{$strName};
	}
	return $retVal;
}

sub getLangStrFromHash_LangCode_NoDefaults {
	my($strName,%transTab)  = @_;
	my $retVal = "";
	$strName = sprintf("${strName}_%s",getLangCode($language));
	if (exists($transTab{$strName})) {
		$retVal = $transTab{$strName};
	}
	return $retVal;
}



############################################################################
# Function for get infos about this library itself, the caller and any other
############################################################################
sub getSCCSid {
	return $sccsId;
}

sub getLibVersion {
	return $libLatestVersion;
}

sub getLibName {
	return $libName;
}

sub getLibDescription {
	return getLibName()." ".getLibVersion()."(LibKey:".getLibKey().")";
}

sub getLibDesc {
	return getLibName()." ".getLibVersion()."(LibKey:".getLibKey().")\n".getSCCSid()."\n";
}

sub getLibKey {
	return reverseStr("{XXXXyeKbilXXXX}");
}

$version_RegEx     = "^(V|v)?\\d{1,3}\.\\d{1,3}(\.\\d{1,3}\.\\d{1,3})?\$";
sub isVersionStringValid {
	my($versionStr) = @_;
	if ($versionStr =~ $version_RegEx) {
		return $TRUE;
	} else {
		return $FALSE;
	}
}

sub doTest_isVersionStringValid {
	my($myFullName,$debugThisFct) = @_;
	$debugThisFct = setDefault($debugThisFct,$FALSE);
	my $testCases = qq {
		Nr|Version     |Expected
		01|1.1.1.1     |TRUE
		02|11.02.03.01 |TRUE
		03|11.02.03.01x|FALSE
		04|V1.1.1.1    |TRUE
		05|v1.1.1.1    |TRUE
		06|a1.1.1.1    |FALSE
		07|1.1         |TRUE
		08|V1.1        |TRUE
	};

	for (my $i = 2; $i <= getCountOfLinesFromQQ($testCases); $i++) {
		my $testCaseNr  = getFieldFromQQ($testCases,$i,1);
		my $version     = getFieldFromQQ($testCases,$i,2);
		my $expectedRes = getFieldFromQQ($testCases,$i,3);

		if ($debugThisFct) {
			print("\n==> ${myFullName}: Test-Case:${i}:${testCaseNr}\n");
			print("       version      :${version}:\n");
			print("       expectedRes  :${expectedRes}:\n");
			print("       isVersionStringValid(${version})=".isVersionStringValid($version)."\n");
		}
		if (!(isVersionStringValid($version) == ($expectedRes eq "TRUE"))) { print("ERROR: Test-Case ${testCaseNr}\n"); print("       isVersionStringValid(${version})=".isVersionStringValid($version)."        Expected:${expectedRes}:\n");}
	}
   
}
##############
### Caller ###
##############
sub getMySCCSid {
	return $mySccsId;
}

sub getMyVersion {
	return $myLatestVersion;
}

sub getMyName {
	return $myName;
}

sub getMyDescription {
	return getMyName()." ".getMyVersion();
}

sub getMyLibDesc {
	return getMyName()." ".getMyVersion()."\n".getMySCCSid()."\n";
}
#########################
### Any other library ###
#########################
sub getAnySCCSid {
	my($moduleName) = @_;
	my $varName = "${moduleName}SccsId";
	return $$varName;
}

sub getAnyVersion {
	my($moduleName) = @_;
	my $varName = "${moduleName}LatestVersion";
	return $$varName;
}

sub getAnyName {
	my($moduleName) = @_;
	return "${moduleName}.pm";
}

sub getAnyLibKey {
	my($moduleName) = @_;
	my $varName    = "${moduleName}LibKey";
	return $$varName;
}

sub getAnyDescription {
	my($moduleName) = @_;
	return getAnyName($moduleName)." ".getAnyVersion($moduleName)." (LibKey:".getAnyLibKey($moduleName).")";
}

sub getAnyDesc {
	my($moduleName) = @_;
	return getAnyName($moduleName)." ".getAnyVersion($moduleName)."\n".getAnySCCSid($moduleName)."\n";
}

############################################################################
# Function for locking enable / disable
############################################################################
# returns true if lock has been granted otherwise false
sub setAndGetLock {
	my($pathName,$lockName,$verbal)  = @_;
	my $retVal     = $TRUE;
	my $fileName   = "";
	$lockName      = setDefault($lockName,"aLockFromPerlLib");
	$pathName      = setDefault($pathName,".");
	$verbal        = setDefault($verbal,$TRUE); 
   
	$lockName =~ s/\s+//g;
	if ($lockName ne "") {
		opendir(ADIR,$pathName)   || showError(sprintf("Can't open current directory:%s",$!));
		foreach $fileName (sort readdir(ADIR)) {
			## printf ("Filename:%s:\n",$fileName);
			if ($fileName eq $lockName) {
				$retVal = $FLASE;
			}
		}
		if ($retVal) {
			open(LOCKFILE_setAndGetLock,">${pathName}${lockName}");
			if ($verbal) {
				print("Set Lock:${lockName}:\n");
			}
			close(LOCKFILE_setAndGetLock);
		}
	} else {
		print("Missing Lock-Name\n");
	}
	return $retVal;
}

sub releaseLock {
	my($pathName,$lockName,$verbal)  = @_;
	$lockName =~ s/\s+//g;
	if ($lockName ne "") {
		$verbal = setDefault($verbal,$TRUE);
		if ($verbal) {
			print("Released lock:${lockName}:\n");
		}
		unlink("${pathName}${lockName}");
	} else {
		print("Missing Lock-Name\n");
	}
}

sub setLock {
	my($lockName,$verbal,$msg)  = @_;
	open(LOCKFILE_setLock,">${lockName}") || showError(sprintf("Can't set lock: %s : %s",$lockName,$!));
	if ($msg ne "") {
		print(LOCKFILE_setLock "${msg}");
	}

	$verbal = setDefault($verbal,$TRUE); 
	if ($verbal) {
		print("<!-- Set Lock::${lockName}::-->\n");
	}
	close(LOCKFILE_setLock);
	$lockHasBeenGranted = $TRUE;
}

sub setAndGetLockFast {
	my($lockName,$verbal,$msg)  = @_;
	$lockHasBeenGranted  = $FALSE;
	# test if lock exists
	open(LOCKFILE_setAndGetLockFast,"${lockName}") || setLock($lockName,$verbal,$msg);
	close(LOCKFILE_setAndGetLockFast);
	return $lockHasBeenGranted;
}



sub releaseLockFast {
	my($lockName,$verbal)  = @_;
	unlink("${lockName}");
	$verbal = setDefault($verbal,$TRUE); 
	if ($verbal) {
		print("<!-- Release Lock::${lockName}::-->\n");
	}
}


sub setAndGetFileLock {
	my($lockName,$verbal)  = @_;
	if ($lockName ne "") {
		if (isFileExists($lockName)) {
			return $FALSE;
		}
		open(LOCKFILE_setAndGetFileLock,">${lockName}") || showError(sprintf("Can't set lock (setAndGetFileLock): %s : %s",$lockName,$!));
		$verbal = setDefault($verbal,$TRUE); 
		if ($verbal) {
			print("<!-- Set Lock::${lockName}::-->\n");
		}
		close(LOCKFILE_setAndGetFileLock);
	}
	return $TRUE;
}

sub removeFileLock {
	my($lockName)  = @_;
	if ($lockName ne "") {
		unlink($lockName);
	}
}


############################################################################
# Common function for error handling
############################################################################
sub getErrorCode {
	my($msg_ref) = @_;
	if (!(($$msg_ref eq "") || ($$msg_ref eq $TRUE))) {
		return $ERROR;
	} else {
		$$msg_ref = "";
	}
}
############################################################################
# Common function for printing to log 
############################################################################
##  $msg =  sqlToFlat($sql,$AfterSelectFileName,$db,$login,$password);
##  $ErrorCode = getErrorCode(\$msg);
##  addToLogFile($msg, $LogFile, $TRUE, $ErrorCode );

$openLogFileName_Hidden = "";


sub displayError {
  my($msg) = @_;
  $ErrorCode = getErrorCode(\$msg);
  addToLogFile($msg, $LogFile, $TRUE, $ErrorCode );
}

sub getLogfileName {
  return $openLogFileName_Hidden;
}

sub setLogfileName {
  my($fileName) = @_;
  $openLogFileName_Hidden=$fileName;
}

sub openLogFile {
  my($fileName,$header,$overwriteIfExists,$addTimeStamp) = @_;
  $overwriteIfExists     = setDefault($overwriteIfExists,$TRUE);
  $addTimeStamp          = setDefault($addTimeStamp,$TRUE);
  my $time = "";
  if  (!(-e $fileName) || ($overwriteIfExists == $TRUE)) {
    if (!open(LOGFILE_openLogFile, ">$fileName")) {
        print "Can't open log file $fileName\n";
    } else {
        $time = formatTimeStamp(getTimeStamp(), "", "", "", $language);
        if ($addTimeStamp) {
          print LOGFILE_openLogFile "Logfile opened  $time\n";
        }
        if ($header ne "") {
          print LOGFILE_openLogFile "$header\n";
        }
        close LOGFILE_openLogFile;
    }
  }
  setLogfileName($fileName);
}
 
sub closeLogFile {
  my($fileName,$addTimeStamp) = @_;
  $addTimeStamp          = setDefault($addTimeStamp,$TRUE);

  my $time     = "";
 
  if  (!(-e $fileName) ) {
      print "Can't close log file! $fileName does not exist\n";
  } else {
      if (!open(LOGFILE_closeLogFile, ">>$fileName")) {
          print "Can't close log file $fileName\n";
      } else {
          $time = formatTimeStamp(getTimeStamp(), "", "", "", $language);
          if ($addTimeStamp) {
              print LOGFILE_closeLogFile "Logfile closed  $time\n";
          }
          close LOGFILE_closeLogFile;
      }
 }
}

sub addToLogFile {
  my($msg, $fileName, $copyToSTDOUT, $ErrorCode,$addTimeStamp) = @_;
  $addTimeStamp    = setDefault($addTimeStamp,$TRUE);
  my $time   = "";
  my $logmsg = "";
  setLogfileName($fileName);
 
  if ($addTimeStamp) {
    $time = formatTimeStamp(getTimeStamp(),"","","",$language)." ";
  }

  if ($msg ne "") {
    $logmsg = "${time}${msg}\n";

    if ($ErrorCode eq $ERROR) {
      $ERROR_FOUND = $TRUE;
      $logmsg = "Error: $logmsg"; 
    }
  }
 
  if ($fileName eq "") {
   if ($copyToSTDOUT) {
      print "${logmsg}";
   }
  } else {
    if  (!(-e $fileName)) {
      print "Can't add to log file! $fileName does not exist\n";
    } else {
      if (!open(LOGFILE_addToLogFile, ">>$fileName")) {
       print "Can't add to log file $fileName\n";
      } else {
        print LOGFILE_addToLogFile "$logmsg";
 
        if ($copyToSTDOUT) {
          print("${logmsg}");
        }
       close LOGFILE_addToLogFile;
     }
   }
 }
}


############################################################################
# Function for testing the library functions
############################################################################
sub performTest {
	my(@testFctNameList) = @_;
	my $count = @testFctNameList;
	print("\n".unterstreichen(performTest));
	foreach my $testFctName (sort @testFctNameList) {
		print("---> ${testFctName}\n");
		my $libName = getFieldFromString("::",0,$testFctName,$notFoundStr);
		my $fctName = getFieldFromString("::",1,$testFctName,$notFoundStr);
		execPerlFct($fctName,$testFctName);
	}
	print("\nCount of Tests executed:${count}\n\n");
}

sub selectAndExecFct {
  my(@fctNameList) = @_;
  my $answer = 0;
  do {
    VT52_cls_home();
    print(unterstreichen("Applications","="));
    my $i = 1;
    foreach my $aFctName (@fctNameList) {
     my $libName = getFieldFromString("::",0,$aFctName,$notFoundStr);
     my $fctName = getFieldFromString("::",1,$aFctName,$notFoundStr);
     printf("%5d: ".substr($fctName,index($fctName,"showMenu_")+length("showMenu_"))."\n",$i);
     $i++;
    }

    print("\n");
    printf("%5d: Ende\n\n",0);
    $answer = readln("Auswahl (0..".($i-1).")",0);
    if (($answer > 0) && ($answer < $i)) {
       my $fctName = getFieldFromString("::",1,$fctNameList[$answer-1],$notFoundStr);
       print("\n\nCalling ${fctName}....\n",);
       &$fctName();
    }
  } until ($answer eq "0");
}

############################################################################
# Bin, Hex, Oct 
############################################################################
sub dec2Xzahl {
	my($decVal,$destZahlSystem) = @_;
	my $destZahlSystem       = setDefault($destZahlSystem,2);
	
	my $retStr = "";
	
	my $ganzZahl = abs($decVal);
	my $rest     = 0;
	while ($ganzZahl > 0) {
		$ganzZahl = int($ganzZahl/$destZahlSystem);
		$rest     = $decVal - ($ganzZahl * $destZahlSystem);
		if ($rest > 9) {
			$restStr = chr(55 + $rest);
		} else {
			$restStr = $rest;
		}
		# print("DecVal:${decVal}:   --> Ganz:${ganzZahl}:   Rest:${rest}:<BR>\n");
		$decVal = $ganzZahl;
		$retStr = $restStr . $retStr;
	}
	return $retStr;
}

sub dec2Hex {
	my($decVal) = @_;
	return dec2Xzahl($decVal,16);
}

sub dec2Bin {
	my($decVal) = @_;
	return dec2Xzahl($decVal,2);
}

sub dec2Octal {
	my($decVal) = @_;
	return dec2Xzahl($decVal,8);
}

sub octal2Dec {
	my($ordStr) = @_;
	my $retVal = 0;
	my @charList = splitStringByLength($ordStr,1);
	foreach my $aChar (@charList) {
		# print("x".$aChar." ".ord($aChar)."x<BR>\n");
		if  (($aChar ge "0") && ($aChar le "7")) {
			$retVal = ($retVal * 8) + (ord($aChar)-48);
		}
	}
	return $retVal;	
}

############################################################################
# Common function for Command-Line arguments ARGV 
############################################################################
sub getCommandLineOption {
	my($anOption,@argvParam) = @_;
	my @retValues = ();
	my $count = @argvParam;
	if ($count == 0) {
		@argvParam = @ARGV;
	}
	foreach my $anArg (@argvParam) {
		if (stringStartsWith($anArg,$anOption,$TRUE)) {
			push(@retValues,$anArg);
		}
	} 
	return @retValues;
}

sub isCommandLineOptionSet {
	my($anOption,@argvParam) = @_;
	my $retVal = $FALSE;
	my $count = @argvParam;
	if ($count == 0) {
		@argvParam = @ARGV;
	}
	if ($anOption ne "") {
		foreach my $anArg (@argvParam) {
			if (stringStartsWith($anArg,$anOption,$TRUE)) {
				$retVal = $TRUE;
				last;
			}
		} 
	}
	return $retVal;
}

sub getCommandLineOptionValue {
	my($anOption,@argvParam) = @_;
	my $retVal = "";
	my $i = 0;
	my $count = @argvParam;
	if ($count == 0) {
		@argvParam = @ARGV;
		$count = @argvParam;
	}
	for ($i=0; $i <= $count; $i++) {
		if (stringStartsWith($argvParam[$i],$anOption,$TRUE)) {
			if (($i + 1) < $count) {
				$retVal = $argvParam[$i + 1];
			}
		}
	}
	if (stringStartsWith($retVal,"-",$TRUE)) {
		$retVal = "";
	}
	return $retVal;
}

sub doTest_ARGV_Functions {
	my($myFullName,$debugThisFct) = @_;
	$debugThisFct = setDefault($debugThisFct,$FALSE);
   
	my $commandArgv = "-m listAll -l -al hhh";
	my @testArgv_1  = split(" ",$commandArgv);
   
	if ($debugThisFct) {
		print("==> testArgv_1\n");displayArray(@testArgv_1);
	}
	my @resSoll_1   = ("-m","listAll","-l","-al","hhh");
	my @resIst_1    = getCommandLineOption("",@testArgv_1);
	if ($debugThisFct) {
		print("\n==> resIst_1\n"); displayArray(@resIst_1);
		print("\n==> resSoll_1\n");displayArray(@resSoll_1);
	}
	if (!(areArraysEqual(\@resIst_1,\@resSoll_1,$TRUE,$TRUE))) {
		print("ERROR: ${myFullName} failed (A1)\n");
	}

	@resSoll_1   = ("-m");
	@resIst_1    = getCommandLineOption("-m",@testArgv_1);
	if ($debugThisFct) {
		print("\n==> resIst_1\n"); displayArray(@resIst_1);
		print("\n==> resSoll_1\n");displayArray(@resSoll_1);
	}
	if (!(areArraysEqual(\@resIst_1,\@resSoll_1,$TRUE,$TRUE))) {
		print("ERROR: ${myFullName} failed (A1)\n");
	}

	@resSoll_1   = ("-al");
	@resIst_1    = getCommandLineOption("-al",@testArgv_1);
	if ($debugThisFct) {
		print("\n==> resIst_1\n"); displayArray(@resIst_1);
		print("\n==> resSoll_1\n");displayArray(@resSoll_1);
	}
	if (!(areArraysEqual(\@resIst_1,\@resSoll_1,$TRUE,$TRUE))) {
		print("ERROR: ${myFullName} failed (A3)\n");
	}


	if (!(isCommandLineOptionSet("-al",@testArgv_1))) {
		print("ERROR: ${myFullName} failed (B1)\n");
	}

	if (!(isCommandLineOptionSet("-m",@testArgv_1))) {
		print("ERROR: ${myFullName} failed (B2)\n");
	}

	if (isCommandLineOptionSet("-h",@testArgv_1)) {
		print("ERROR: ${myFullName} failed (B3)\n");
	}


	if (!(getCommandLineOptionValue("-al",@testArgv_1) eq "hhh")) {
		print("ERROR: ${myFullName} failed (C1)\n");
	}

	if (!(getCommandLineOptionValue("-m",@testArgv_1) eq "listAll")) {
		print("ERROR: ${myFullName} failed (C2)\n");
	}

	if (getCommandLineOptionValue("-l",@testArgv_1) ne "") {
		print("ERROR: ${myFullName} failed (C3)\n");
	}

	if (getCommandLineOptionValue("-h",@testArgv_1) ne "") {
		print("ERROR: ${myFullName} failed (C4)\n");
	}

}
############################################################################
# Function for common help
############################################################################
sub displayThisHeader {
	my($thisFileName,$usageText ) = @_;
	$thisFileName = setDefault($thisFileName,$myName);

	my $thisFullfileName = getSourceFullName($thisFileName);
	if ($thisFullfileName ne "") {
		readFileBetweenMarkers($thisFullfileName,"#header_start perl_header","#header_end",$FALSE,$TRUE,$TRUE);
	} else {
		print("${usageText}\n");
		return;
	}
}

sub getSourceFullName {
	my($sourceFilename,@searchPath) = @_;
	$sourceFilename = setDefault($sourceFilename,$myName);
	
	my @defaultPaths = (
		$ENV{CSG_COMMON_PERL_LIBRARIES},
		$ENV{WRAPPERSCRIPTS_IMPLEMENTATION_DIRECTORY},
		$ENV{CSG_GMM_MAIN},
		$ENV{CSG_GMM_FUNCTIONS},
		$ENV{CSG_GMM_LIBRARIES},
		$ENV{CSG_GMM},
	);

	@searchPath = makeArrayEntriesDistinct($TRUE,concatArrayOptimized(@searchPath,@defaultPaths));
	foreach my $aPath (@searchPath) {
		# print("    aPath:${aPath}:\n");
		if (isFileExists("${aPath}/${sourceFilename}")) {
			$retVal = "${aPath}/${sourceFilename}";
			last;
		}
	}
	if ($retVal eq "") {
		if (getFileNameExtension($sourceFilename) eq "") {
			$sourceFilename = $sourceFilename.".pl";
		}
		foreach my $aPath (@searchPath) {
			# print("    aPath:${aPath}:\n");
			if (isFileExists("${aPath}/${sourceFilename}")) {
				$retVal = "${aPath}/${sourceFilename}";
				last;
			}
		}
	}
	return $retVal;
}

sub helpMe {
    my($myName)=@_;
    my $enableOut = 0;
    open(HELPFILE_helpMe,$myName) || die("ERROR: Can't open infile: $myName : $!");
    while (defined($line = <HELPFILE_helpMe>)) {
      if ($enableOut) {
        if ($line =~ /^# END/) {
            $enableOut = 0;
        } else {
            printf ("%s",substr($line,2,length($line)-2));
        }
      }
      if ($line =~ /^# START/) {
         $enableOut = 1;
      }
    }
    close(HELPFILE_helpMe);
} # end of helpMe

sub writeDebugMsg {
    my($msg)  = @_;
    if (isDebug()) {
        print("${msg}\n");
    }
} # end of writeDebugMsg

sub writeMsg {
    my($silent,$msg)  = @_;
    if ($silent eq "") { $silent = $FALSE; }
    if (!($silent)) {
        print("${msg}\n");
    }
}

sub writeTrace {
    my($doTrace,$msg)  = @_;
    if ($doTrace eq "") { $doTrace = $FALSE; }
    if ($doTrace) {
       print("${msg}\n");
    }
}

sub isDebug {
  return (($debug eq "TRUE") || ($debug eq $TRUE));
}

sub dumpVar {
    my($varName,$lableLen)  = @_;
    if (isDebug()) {
         printf("%${lableLen}s:%s:\n",$varName,$$varName);
    }
}

sub showError {
   my($msg) = @_;
   print("${msg}\n");
   die($msg);
}

sub strLable {
  my($label,$val,$ext) = @_;
  my $retVal = "";
  if ($val ne "") {
    $retVal = "${label}${val}${ext}";
  } else {
    $retVal = "";
  }
  return $retVal
}

sub pollingSleep {
   my ($interval,$lineLen,$sleptPer) = @_;
   $| = $TRUE;
   print(".");
   $sleptPer++;
   if ($sleptPer >= $lineLen) {
      $sleptPer = 0;
      print("\n");
   }
   sleep($interval);
   return $sleptPer;
}

sub displayHashTableHTMLdebug {
   my(%aHashTab)  = @_;
   if (isDebug()) {
      displayHashTableHTML(%aHashTab);
   }
}

sub displayHashTableHTML {
 my(%aHashTab)  = @_;
 my(@keyOfHash) = keys %aHashTab;
 
 print("<TABLE border=${DefaultTableBorder} cellpadding=${DefaultTableCellPadding} cellspacing=${DefaultTableCellSpacing}>\n");
 foreach $key (sort @keyOfHash) {
   printf("<TR><TD>%s</td><TD>%s</td></tr>\n",$key,repNullStr($aHashTab{$key}));
 }
 print("</TABLE>\n");
}

sub displayHashTable {
	my (%aHashTab)  = @_;
	my @keyOfHash = keys %aHashTab;
	foreach my $key (sort @keyOfHash) {
		printf("HashTab: %s => %s\n",$key,$aHashTab{$key});
	}
}

sub displayHashTableFormated {
	my ($title, $keyPreFix, $keyPostFix, $valuePreFix, $valuePostFix, $delimiter, $doPadKeyField, $doPadValField, $startLineNumber, %aHashTab)  = @_;
	$delimiter     = setDefault($delimiter,    " ==> ");
	$doPadKeyField = setDefault($doPadKeyField,$TRUE);
	$doPadValField = setDefault($doPadValField,$TRUE);

	print("${title}\n");
	my @keyOfHash = keys %aHashTab;
	my $anzEntries = @keyOfHash;
	my $padLenKey = 0;
	my $padLenVal = 0;
	if ($doPadKeyField ne "") {
		if ($doPadKeyField eq "1") {
			$padLenKey = -1*length(getLongestValFromArray(@keyOfHash));
		} else {
			$padLenKey = length(getLongestValFromArray(@keyOfHash));
		}
	}
	if ($doPadValField) {
		if ($doPadValField eq "1") {
			$padLenVal = length(getLongestValFromArray(getAllValuesFromHash_AsArray($FALSE,%aHashTab)));
		} else {
			$padLenVal = -1*length(getLongestValFromArray(getAllValuesFromHash_AsArray($FALSE,%aHashTab)));
		}
	}

	foreach my $key (sort @keyOfHash) {
		if ($startLineNumber eq "") {
			print("${keyPreFix}".padString($key,$padLenKey)."${keyPostFix}${delimiter}${valuePreFix}".padString($aHashTab{$key},$padLenVal)."${valuePostFix}\n");
		} else {
			print(padString($startLineNumber,3).":${keyPreFix}".padString($key,$padLenKey)."${keyPostFix}${delimiter}${valuePreFix}".padString($aHashTab{$key},$padLenVal)."${valuePostFix}\n");
			$startLineNumber = $startLineNumber + 1;
		}
	}
	return $anzEntries;
}

sub displayHashTableSpezial {
 my(%aHashTab)  = @_;
 my(@keyOfHash) = keys %aHashTab;
 foreach my $key (sort @keyOfHash) {
   printf(":%s: => :%s:\n",$key,$aHashTab{$key});
 }
}

sub displayHashTableRef {
   my($aHashTabRef,$name,$preFix)  = @_;
   $preFix    = setDefault($preFix,"HashTab: ");
   if ($name ne "") {
   	 print("${name}\n");
   }
   my @keyOfHash = keys %$aHashTabRef;
   foreach my $key (sort @keyOfHash) {
     print("${preFix}${key} => ".$aHashTabRef->{$key}."\n");
   }
}  


# Description
# -----------
# Input:  Hash with a ref to an hash as values
#
# Result:
# Hash:   "AUD/CAD"     => (
#                            "CcyPair"        => "AUD/CAD",
#                            "CCY2"           => "AUD",
#                            "FundB1_Name"    => "FWDTR2",
#                            "FundB2"         => "2"
#                           )
#         "AUD/CZK"     => (
#                            "CcyPair"        => "AUD/CZK",
#                            "CCY2"           => "AUD",
#                            "FundB1_Name"    => "FWDTR4",
#                            "FundB2"         => "3"
#                           )
#         "AUD/NZD"     => (
#                            "CcyPair"        => "AUD/NZD",
#                            "CCY2"           => "EUR",
#                            "FundB1_Name"    => "FWDTR5",
#                            "FundB2"         => "6"
#                           )
sub displayHashWithHashRef {
    my ($title,$displayValues,$verbal,%inHash) = @_;
    $displayValues = setDefault($displayValues,$TRUE);
    $verbal        = setDefault($verbal,$FALSE);
    
    my $retStr = "";
    	
    my @primaryKeys = keys %inHash;
    my $recCount = @primaryKeys;
    $retStr = "${title}  (RecCount:${recCount})";
    
    if ($displayValues) {
    	  $retStr = "${retStr}\n";
        foreach my $aPrimaryKey (@primaryKeys) {
        	 my $hashRef = $inHash{$aPrimaryKey};
        	 $retStr = "${retStr}${aPrimaryKey}  => (\n";
        	 my @secKeys = keys %$hashRef;
        	 foreach my $secKey (@secKeys) {
        	 	  $retStr = "${retStr}      ".padString($secKey,-20)." => ".$hashRef->{$secKey}."\n";
        	 }
        	 $retStr = "${retStr}       )\n";
        }
    }
    if ($verbal) { print($retStr); }
    return $retStr;	
}

sub hashTableToStr {
 my($sorted,%aHashTab)  = @_;
 my(@keyOfHash) = keys %aHashTab;
 my $retVal    = "";
 if ($sorted) {
   foreach $key (sort @keyOfHash) {
     $retVal = sprintf("%s%s => %s\n",$retVal,$key,$aHashTab{$key});
   }
 } else {
   foreach $key (@keyOfHash) {
     $retVal = sprintf("%s%s => %s\n",$retVal,$key,$aHashTab{$key});
   }
 }
 return $retVal;
}

sub formatNameValueHidden {
	my($keyName,$valueStr,$delStr,$keyPadLen)  = @_;
	$delStr = setDefault($delStr," ");
	
	my $retStr = "";
	if ($keyPadLen eq "") {
		$retStr = "${keyName}${delStr}${valueStr}";
	} else {
		$retStr = padString($keyName,$keyPadLen," ")."${delStr}${valueStr}";
	}
	return $retStr;
	
}


sub hashTableToArrayStrFormat {
	my($sorted,$outType,$delStr,$padded,%aHashTab)  = @_;
	$sorted  = setDefault($sorted,$TRUE);
	$outType = setDefault($outType,"Default");
	$padded  = setDefault($padded,$TRUE);
	
	my @keyOfHash = keys %aHashTab;
	my $maxKeyLen = -(maxStrLength(@keyOfHash) + 2);
	my @retVals   = ();
	
	if ($outType eq "Default") {
		$delStr = setDefault($delStr,"==> ");
	} elsif ($outType eq "JavaProperty") {
		$delStr = setDefault($delStr," ");
	}
	
	if ($sorted) {
		@keyOfHash = (sort @keyOfHash);
	}
	
	foreach my $aKey (@keyOfHash) {
		push(@retVals,formatNameValueHidden($aKey,$aHashTab{$aKey},$delStr,$maxKeyLen));
	}

	return @retVals;
}

sub hashTableToStrFormat {
	my($sorted,$outType,$delStr,%aHashTab)  = @_;
	
	my @keyOfHash = keys %aHashTab;
	
	my $maxKeyLen = -(maxStrLength(@keyOfHash) + 2);
	my $retVal    = "";
	
	if ($outType eq "Default") {
		$delStr = setDefault($delStr,"==> ");
	} elsif ($outType eq "JavaProperty") {
		$delStr = setDefault($delStr," ");
	}
	
	if ($sorted) {
		foreach my $aKey (sort @keyOfHash) {
			$retVal = $retVal.formatNameValueHidden($aKey,$aHashTab{$aKey},$delStr,$maxKeyLen)."\n";
		}
	} else {
		foreach my $aKey (@keyOfHash) {
			$retVal = $retVal.formatNameValueHidden($aKey,$aHashTab{$aKey},$delStr,$maxKeyLen)."\n";
		}
	}

	return $retVal;
}

sub displayRecordSet {
	my($recordSetRef,$recordTitle,$fieldPrefix)   = @_;
	$fieldPrefix    = setDefault($fieldPrefix,"    ");
	$recordTitle    = setDefault($recordTitle,"Record:");

	my $i = 0;
	foreach my $recordRef (@$recordSetRef) {
		displayHashTableRef($recordRef,"${recordTitle}${i}",$fieldPrefix);
		$i++;
	}
}

# Examples:
# 	Call to produce HTML-Table:
		# my %fieldTitleOrderHash = (
				# "2:SUBCMP_NAME"       => "Subcomponent-Name;Left;String;Descending",
				# "1:CMP_NAME"          => "Component-Name;Left;String;Descending",
				# "3:CODE_VERSION"      => "Code-Version;Left;String;Ascending",
				# "4:CFG_TYPE"          => "Component-Name;Left;String;Descending",
				# "5:CFG_NAME"          => "CFG_TYPE;Left;String;Descending",
				# "6:DB_CFG_VERSION"    => "DB_CFG_VERSION;Left;String;Descending",
				# "7:POST_FETCH_ACTION" => "POST_FETCH_ACTION;Left;String;Descending",
				# "8:CHANGED_BY"        => "CHANGED_BY;Left;String;Descending",
				# "9:CHANGED_TS"        => "CHANGED_TS;Left;String;Descending",
		# );
		# #                                     displayRecSetAsTable($recordSetRef, $fieldTitleOrderHashRef, $formatIt, $addTitle, $beforeFirstRecStr, $beforeFirstFieldStr, $preFieldStr, $postFieldStr, $fieldSeparator, $afterLastFieldStr, $afterLastRecStr, $emptyFieldText, $removeSepInOutput, $doDebug)
		# print("\n\n1:\n");displayLines($FALSE,displayRecSetAsTable(\@recordSet  , \%fieldTitleOrderHash  , $FALSE   , $TRUE    , "<TABLE>\n"       , "  <TR>\n"          , "    <TD>"  , "</TD>\n"    , ""             ,"  </TR>\n"        , "</TABLE>\n"    , "&nbsp"        , $removeSepInOutput, $doDebug)); halt(); 
		# print("\n\n2:\n");displayLines($FALSE,displayRecSetAsTable(\@recordSet  , \%fieldTitleOrderHash  , $TRUE    , $TRUE    , ""                , ""                  , ""          ,  ""          , "\|"           , "\n"              , ""              , ""             , $FALSE            , $doDebug)); halt(); 
		# print("\n\n3:\n");displayLines($FALSE,displayRecSetAsTable(\@recordSet  , \%fieldTitleOrderHash  , $TRUE    , $TRUE    , ""                , ""                  , ""          ,  ""          , ";"            , "\n"              , ""              , ""             , $FALSE            , $doDebug)); halt();
        # print("\n\n4:\n");displayLines($FALSE,displayRecSetAsTable(\@recordSet  , \%fieldTitleOrderHash  , $TRUE    , $TRUE    , ""                , ""                  , ""          ,  ""          , "\|"           , "\n"              , ""              , ""             , $TRUE             , $doDebug)); halt(); 
		# print("\n\n5:\n");displayLines($FALSE,displayRecSetAsTable(\@recordSet  , \%fieldTitleOrderHash  , $TRUE    , $TRUE    , ""                , ""                  , ""          ,  ""          , ";"            , "\n"              , ""              , ""             , $TRUE             , $doDebug)); halt();
sub displayRecSetAsTable {
	my($recordSetRef, $fieldTitleOrderHashRef, $formatIt, $addTitle, $beforeFirstRecStr, $beforeFirstFieldStr, $preFieldStr, $postFieldStr, $fieldSeparator, $afterLastFieldStr, $afterLastRecStr, $emptyFieldText, $removeSepInOutput, $doDebug)   = @_;
	$formatIt           = setDefault($formatIt,$TRUE);
	$addTitle           = setDefault($addTitle,$TRUE);
	$removeSepInOutput  = setDefault($removeSepInOutput,$TRUE);
	$doDebug            = setDefault($doDebug,$FALSE);
	$doDebug            = $FALSE;
	
	my %fieldTitleOrderHash = ();
	my $recordCount = @$recordSetRef;
	my $retString   = "";
	my @returnList  = ();
	
	if ($doDebug) { 
		print("recordCount:${recordCount}\n");
		print("formatIt             :${formatIt}:\n");
		print("addTitle             :${addTitle}:\n");
		print("beforeFirstRecStr    :${beforeFirstRecStr}:\n");
		print("beforeFirstFieldStr  :${beforeFirstFieldStr}:\n");
		print("preFieldStr          :${preFieldStr}:\n");
		print("postFieldStr         :${postFieldStr}:\n");
		print("fieldSeparator       :${fieldSeparator}:\n");
		print("afterLastFieldStr    :${afterLastFieldStr}:\n");
		print("afterLastRecStr      :${afterLastRecStr}:\n");
		print("emptyFieldText       :${emptyFieldText}:\n");
		print("removeSepInOutput    :${removeSepInOutput}:\n");
		halt();
	}
	
	if ($recordCount > 0) {

		if ($fieldTitleOrderHashRef eq "") {
			my $firstRecRef = @$recordSetRef[0];
			my %firstRecord = %$firstRecRef;
			my @keysOfRecord = sort (keys (%firstRecord));    # displayArray(@keysOfRecord); print("\n\n");
			my $i = 1;
			foreach my $aKey (@keysOfRecord) {
				%fieldTitleOrderHash = (%fieldTitleOrderHash,("${i}:${aKey}","${aKey};;;"));
				$i = $i + 1;
			}	
		} else {
			%fieldTitleOrderHash = %$fieldTitleOrderHashRef;
		}

		my @fieldsToDisplay = sort(keys (%fieldTitleOrderHash));
		if ($doDebug) { displayHashTable(%fieldTitleOrderHash);	print("\n\n"); displayArray(@fieldsToDisplay); print("\n\n"); halt();}
		
		foreach my $aRec (@$recordSetRef) {
			# before first record is processed
			if ($aRec == @$recordSetRef[0]) {  
				$retString = $retString.$beforeFirstRecStr;
				
				if ($addTitle) {
					foreach my $aTitleFieldWithOrderNr (@fieldsToDisplay) {
						my $aTitleField = getFieldFromString(":",1,$aTitleFieldWithOrderNr);
						if ($doDebug) { print("aTitleFieldWithOrderNr:${aTitleFieldWithOrderNr}:   First:".@fieldsToDisplay[0].":   Last:".@fieldsToDisplay[-1].":\n"); }
						# before first field is processed
						if ($aTitleFieldWithOrderNr eq @fieldsToDisplay[0]) {
							if ($doDebug) { print("Before First in Title\n"); }
							$retString = $retString.$beforeFirstFieldStr;
						} 
						
						## my $fieldVal = $aTitleField;
						my $fieldDef = $fieldTitleOrderHash{$aTitleFieldWithOrderNr};
						my $fieldVal = getFieldFromString(";",0,$fieldDef);
						if ($doDebug) { print("aTitleFieldWithOrderNr:${aTitleFieldWithOrderNr}:  fieldDef:${fieldDef}:  fieldVal:${fieldVal}: \n"); }
						if ($fieldVal eq "") {
							$fieldVal = $aTitleField; # $emptyFieldText;
						}
						$retString = $retString.$preFieldStr.$fieldVal.$postFieldStr;
						
						# after last field is processed
						if ($aTitleFieldWithOrderNr eq @fieldsToDisplay[-1]) { 
							if ($doDebug) { print("After Last in Title!     afterLastFieldStr:${afterLastFieldStr}:\n");	}					
							$retString = $retString.$afterLastFieldStr;
						} else {
							$retString = $retString.$fieldSeparator;
						}	
					}
				}
			}        

			foreach my $aFieldWithOrderNr (@fieldsToDisplay) {
				my $aField = getFieldFromString(":",1,$aFieldWithOrderNr);
				if ($doDebug) { print("aFieldWithOrderNr:${aFieldWithOrderNr}:   First:".@fieldsToDisplay[0].":   Last:".@fieldsToDisplay[-1].":\n"); }
				# before first field is processed
				if ($aFieldWithOrderNr eq @fieldsToDisplay[0]) {
					if ($doDebug) { print("Before First in Rec-set\n"); }
					$retString = $retString.$beforeFirstFieldStr;
				} 
				
				my $fieldVal = $aRec->{$aField};
				if ($fieldVal eq "") {
					$fieldVal = $emptyFieldText;
				}
				$retString = $retString.$preFieldStr.$fieldVal.$postFieldStr;
				
				# after last field is processed
				if ($aFieldWithOrderNr eq @fieldsToDisplay[-1]) {
					$retString = $retString.$afterLastFieldStr;
					if ($doDebug) { print("After Last in Rec-set!    afterLastFieldStr:${afterLastFieldStr}:\n");	}
				} else {
					$retString = $retString.$fieldSeparator;
				}
			}

			# after last record is processed
			if ($aRec == @$recordSetRef[-1]) {  
				$retString = $retString.$afterLastRecStr;
			}                                  
		}

		if ($doDebug) { print("String before splitting:\n"); print($retString); print("\n"); halt(); }
		
		if ($formatIt) {
			my @fieldLen_1  = (4);
			my @padStr_1    = (" ");
			
			@returnList = split($afterLastFieldStr,$retString);    
			if ($doDebug) { print("FormatIt!!!\nAfter splitting:\n"); displayArray(@returnList); print("\n"); halt(); }
			
			my @fieldFormats = ();
			foreach my $aFieldWithOrderNr (@fieldsToDisplay) {
				push(@fieldFormats,$fieldTitleOrderHash{$aFieldWithOrderNr});
			}
			
			# padFieldsInFieldStringArray($sepChar,$trimFirst,$effLen,$inFieldStringArrRef,$fieldLenRef,$padStrRef,$removeSepInOutput,$titleSubscribeChar,$fieldFormatStringArrRef)	
			my $unterstreichChr = "";
			if ($addTitle) {
				$unterstreichChr = "-";
			}
			my @res_1 = padFieldsInFieldStringArray($fieldSeparator,$TRUE,$FALSE,\@returnList,\@fieldLen_1,\@padStr_1,$removeSepInOutput,$unterstreichChr,\@fieldFormats,"+");
			@returnList = @res_1;                                   
			if ($doDebug) { print("After padding:\n"); displayArray(@returnList); print("\n"); halt(); }
		} else {
			@returnList = ($retString);
		}
	}
	
	return @returnList;
}


# to call displayArrayRef(\@aArray,$TRUE);  TBS Problems on BlueWindow
sub displayArrayRef {
  my($refToArray,$doLineCount) = @_;
  $doLineCount  = setDefault($doLineCount,$FALSE);
  my(@myArray)  = derefAref($refToArray);
  my $count    = 0;
  foreach my $entrie (@myArray) {
    if ($doLineCount) {
       print("${count}: ${entrie}\n");
    } else {
       print("${entrie}\n");
    }
    $count++;
  }
}

sub displayArrayReturnString {
  my(@aTab)  = @_;
  my $count = 0;
  my $retString = "";
  foreach $entrie (@aTab) {
    my $aPartOfStr = "${count}: ${entrie}";
    if ($retString eq "") {
       $retString = $aPartOfStr;
    } else {
       $retString = "${retString}\n${aPartOfStr}";
    }
    $count++;
  }
  return $retString;
}

sub displayArray {
  my(@aTab)  = @_;
  my $count = 0;
  foreach my $entrie (@aTab) {
    print("${count}: ${entrie}\n");
    $count++;
  }
}

sub displayArrayWithLength {
  my(@anArray) = @_;
  my $count = 0;
  foreach my $entrie (@anArray) {
    printf("%s (%s): %s\n",$count,length($entrie),$entrie);
    $count++;
  }
}

sub displayArrayHTMLdebug {
   my(@aTab)  = @_;
   if (isDebug()) {
     displayArrayHTML(@aTab);
   }
}

sub displayArrayHTML {
 my(@aTab,$locDebug)  = @_;
 my $count  = 0;
 my $entrie = "";
 if (($locDebug eq "") || ($locDebug eq $TRUE)) {
   foreach my $entrie (@aTab) {
     print("${count}: ${entrie}<BR>\n");
     $count++;
   }
 }
}

sub displayArrayEnhanced {
	my($doChomp,$addLineNumber,$preFix,$postFix,@anArray) = @_;
	$doChomp         = setDefault($doChomp,$TRUE);
	$addLineNumber   = setDefault($addLineNumber,$FALSE);
	$preFix          = setDefault($preFix,"");
	$postFix         = setDefault($postFix,"");

	if ($doChomp) {
		 @anArray = chompArrayEntries(@anArray);
	}
	my $counter = 0;
	foreach my $aLine (@anArray) {
		my $lineAsString = "";
		if ($addLineNumber) {
			$lineAsString = padString($counter,3).": ${preFix}${aLine}${postFix}";
		} else {
			$lineAsString = "${preFix}${aLine}${postFix}";
		}
		$counter++;
		print($lineAsString);
	}
}

sub displayArrayInLogfile {
	my($doChomp,$addLineNumber,$preFix,$postFix,$logfile,$verbal,@anArray) = @_;
	$doChomp         = setDefault($doChomp,$TRUE);
	$addLineNumber   = setDefault($addLineNumber,$FALSE);
	$preFix          = setDefault($preFix,"");
	$postFix         = setDefault($postFix,"");

	if ($doChomp) {
		 @anArray = chompArrayEntries(@anArray);
	}
	my $count=0;
	foreach my $aLine (@anArray) {
		  my $lineAsString = "";
		  if ($addLineNumber) {
		  	  $lineAsString = "${count}: ${preFix}${aLine}${postFix}";
		  } else {
		  	  $lineAsString = "${preFix}${aLine}${postFix}";
		  }
		  $count++;
		  addToLogFile($lineAsString,$logfile,$TRUE);
	}
}

sub displayLines {
  my($doLineCount,@aTab)  = @_;
  $doLineCount     = setDefault($doLineCount,$FALSE);

  my $count = 0;
  foreach my $entrie (@aTab) {
    if ($doLineCount) {
        print("${count}: ${entrie}\n");
    } else {
        print("${entrie}\n");
    }
    $count++;
  }
}

sub readln {
  my($prompt,$default,$dontAsk) = @_;
  $dontAsk     = setDefault($dontAsk,$FALSE);
    
  my $retVal = "";
  print("${prompt}");
  if (length($default) > 0) {
     print(" (${default})");
  }
  print(": ");
  if ($dontAsk) {
  	 print("${default}\n");
  	 return $default;
  }
  $retVal = <STDIN>;
  chomp($retVal);
  if (length($retVal) == 0) {
     $retVal = $default;
  }
  return $retVal;
}

sub setBooleanFromYesNoStr {
	my($inVal,$trueStr) = @_;
	$trueStr = setDefault($trueStr,"YES");
	
	$inVal   = strip($inVal);
	$trueStr = uc($trueStr);

	if (uc($inVal) eq $trueStr || uc($inVal) eq "Y" || uc($inVal) eq "JA" || uc($inVal) eq "T" || uc($inVal) eq "TRUE") {
		return $TRUE;
	} else {
		return $FALSE;
	}
}

sub halt {
   readln(getLangStr("strPressReturn"),"");
}

sub busyWait {
 	my($waitingSeconds) = @_;
 	my $startTime = getTimeStamp();
 	
 	while (secDiff_YYYYMMDDhhmmss(getTimeStamp(),$startTime) < $waitingSeconds) {
 		  # print(secDiff_YYYYMMDDhhmmss(getTimeStamp(),$startTime)."\n");
 	}
}
sub readlnWithHelp {
  my($prompt,$default,$helpStr) = @_;
  my $doLoop = $TRUE;
  my $retVal = "";
  while ($doLoop) {
    $retVal = readln($prompt,$default);
    if ($retVal eq "?") {
       print("\n${helpStr}\n");
    } else {
       $doLoop = $FALSE;
    }
  }
  return $retVal;
}

sub derefHref {
  my ($href) = @_;
  my(%hash) = ();
  @keys = keys %$href;

  foreach $key (@keys){
    $hash{$key} = $href->{$key};
  }
  return %hash;
}

sub derefAref {
  my($aref) = @_;
  my(@myArray) = ();

  for(my $i =0;$i < @$aref; $i++){
    $myArray[$i] = $aref->[$i];
  }
  return @myArray;
}

############################################################################
# Function to process SMS
############################################################################
$sms_emailGatewayAdr_Default           = "\@sms."."credit-suisse.ch";
$sms_useUnixCommand_Default            = $TRUE;
$sms_emailGatewayTrailerLength_Default = 35;
$sms_senderNumber_Default              = $testEmailAdr_1;

$sms_MaxLength                         = 150;


# email gateway wants a local number or an international with two leading zeros
# UNIX command needs an international number (with or without the leading two zeros
# ==> The common format is: international with two leading zeros
sub mkMobileNumberInternational {
 my($inNr) = @_;
 my $retNr = $inNr;
 $inNr =~ s/\D//g;
 
 my $firstChr  = substr($inNr,0,1);
 my $secondChr = substr($inNr,1,1);
 ### print("firstChr:${firstChr}:   secondChr:${secondChr}:\n");
 if (($firstChr eq "0") && ($secondChr ne "0")) { # is a swiss local number
   $retNr = "0041".substr($inNr,1);
 } elsif ($firstChr gt "0") { # is a international number without the leading 00
   $retNr = "00${inNr}";
 } 
 return $retNr;
}

sub sendSMS {
  my($msg,@numbers) = @_;
  
  my $smsEmailExtension              = setDefault($smsEmailExtension              ,$sms_emailGatewayAdr_Default);
  my $sms_useUnixCommand             = setDefault($sms_useUnixCommand             ,$sms_useUnixCommand_Default);
  my $sms_senderNumber               = setDefault($sms_senderNumber               ,$sms_senderNumber_Default);
  if ($sms_useUnixCommand) {
     $sms_emailGatewayTrailerLength_Default = 0;
  }
  my $sms_emailGatewayTrailerLength  = setDefault($sms_emailGatewayTrailerLength  ,$sms_emailGatewayTrailerLength_Default);
  
  if ($sms_emailGatewayTrailerLength > $sms_MaxLength) {
     	$sms_emailGatewayTrailerLength = 2;
  }
  
  if ($msg eq "!") {
    print("Usage: sendSMS msg number number .....\n");
    print("   number format ${testNatelNr_1_international}\n");
    print("   msg will be split into parts of ${sms_MaxLength} characters\n");
    return;
  }

  my $retVal = "";
  foreach my $aNumber (@numbers) {
    my $orgNumber = $aNumber;
    $aNumber = mkMobileNumberInternational($aNumber);
    
    if (length($aNumber) < 5) {
        my $errMsg = "${orgNumber} not a valid number";
        if ($retVal eq "") {
           $retVal = $errMsg;
        } else {
           $retVal = "${retVal}\n${errMsg}";
        }
    } else {
        my(@msgParts) = splitStringByWord($msg,$sms_MaxLength-$sms_emailGatewayTrailerLength);
        my $countOfParts = @msgParts;
        my $partsSent    = 0;

        foreach my $aMsg (@msgParts) {
           if ($countOfParts != 1) {
              if ($partsSent == 0) {
                  $aMsg = "${aMsg}..";
              } elsif ($countOfParts != $partsSent+1) {
                  $aMsg = "..${aMsg}..";
              }  elsif ($countOfParts == $partsSent+1) {
                  $aMsg = "..${aMsg}";
              }
           }
           $partsSent++;
           
           if ($sms_useUnixCommand) {
               ## printf("$aMsg sent to :${aNumber}: via UNIX command\n\n");
   	       my $unixCmd = "beeper -n -l longsm:${aNumber} -c \"${aMsg}\" 2>&1 >/dev/null"; 
               `${unixCmd}`;
           } else {
               print("<BR><B>${aMsg}</B> sent to :<B>${aNumber}</B>: via sms e-mail\n\n");
   	       sendMailwithAttachments($sms_senderNumber,"${aNumber}${smsEmailExtension}","",$aMsg);
           }
        }
    }
  }
  return $retVal;
}

sub doTest_sendShortMsg {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   if ($debugThisFct) {
      my(@userList) = (
          "SMS:".$testNatelNr_2_internationalShort." # Walti Rothlin",
         ### "EMAIL:".$testEmailAdr_1." # Walti at home",
         ### $testNatelNr_1_internationalShort." # Claudia",
         $testEmailAdr_2." # walti in the office",
      );
      my($msgLong) = qq{
          TEST TEST TEST Kann ohne zu lesen gelöscht werden.
          Dies ist eine ganz lange Meldung an Walti. Es sollte per e-mail und SMS an Walti gesendet werden.
          Hier ist noch weiterer Text um das e-mail etwas länger zu machen und noch länger so dass die 150 
          Zeichen Grenze überwunden wird und das SMS auf mehrer verteilt wird. Im Email sollte die ganze 
          Meldung in einem Einzigen kommen wobei das Subject im e-mail kürzer sein wird.

          Viele Grüsse
          Walti
          
      };
      
    print("\n\n--> Test with default values\n");
    @natelNrList = ($testNatelNr_2);
    my($msg) = "Test via Default";
    ### sendSMS($msg,@natelNrList);
    sendShortMsg($msgLong,$senderSMS,$testEmailAdr_1,$debugThisFct,@userList);
      
    print("\n\n--> Test with UNIX Command\n");
    $sms_useUnixCommand = $TRUE;
    @natelNrList = ($testNatelNr_2);
    $msg = "Test via UNIX";
    ### sendSMS($msg,@natelNrList);
    sendShortMsg($msgLong,$senderSMS,$testEmailAdr_1,$debugThisFct,@userList);
    
    print("\n\n--> Test with email gateway\n");
    $sms_useUnixCommand = $FALSE;
    @natelNrList = ($testNatelNr_2_internationalShort);
    $sms_emailGatewayTrailerLength = 100;
    $msg = "Test via email gateway";
    ### sendSMS($msg,@natelNrList);
    sendShortMsg($msgLong,$senderSMS,$testEmailAdr_1,$debugThisFct,@userList);
   }
}

sub showMenu_sendGeburiNotifications {
  $geburiFile = "${dataDir}geburi.flt";
  $addrFile   = "${dataDir}addressNotifier.flt";

  %notifyGeburiList = getCalendarEntriesInTimeIntervalUsingFiles($geburiFile);
  print("Output from getCalendarEntriesInTimeIntervalUsingFiles...<BR>\n");
  displayHashTableHTML(%notifyGeburiList);

  %msgHash = prepareMsgHashFromNotifyHash($addrFile,\%notifyGeburiList);
  print("<BR>\nOutput from prepareMsgHashFromNotifyHash...<BR>\n");
  displayHashTableHTML(%msgHash);

  print("<BR><BR>\n");
  sendShortMsgFromHash($testNatelNr_2,$testEmailAdr_1,$TRUE,%msgHash);
}

sub notifyForAniversery {
    my($startDate,$endDate,$delimStr,$outDateFormat,$aCalendarRef,$notifyMsg,$senderSMSNumber,$senderEmailAdr,$receiverListRef) = @_;
   my %aCalendar    = %$aCalendarRef;
   my @receiverList = @$receiverListRef;

   $senderSMSNumber = setDefault($senderSMSNumber,"Antwort auf ".$testNatelNr_2);
   $senderEmailAdr  = setDefault($senderEmailAdr,$testEmailAdr_1);
   if (isArrayEmty(@receiverList)) {
      @receiverList = (
          $testNatelNr_2_international."  # WR Mobile",
          $testNatelNr_1_international."  # CC Mobile",
          $testEmailAdr_1."  # Walter Rothlin e-mail",
      );
   }
   ## print("Calendar...<BR>\n");
   ## displayHashTableHTML(%aCalendar);

   ## print("receiverList...<BR>\n");
   ## displayArrayHTML(@receiverList);

   $notifyMsg = getCalendarEntriesInTimeInterval($startDate,$endDate,$delimStr,$outDateFormat,%aCalendar);
   ## print("notifyMsg:${notifyMsg}:<BR>\n");

   if ($notifyMsg ne "") {
     print("<BR>\nNotification Message:<B>${notifyMsg}</B><BR>\n<BR>\nReceiverlist:<BR>\n");
     displayArrayHTML(@receiverList);
     print("<BR>\n");
     
     
     sendShortMsg($notifyMsg,$senderSMSNumber,$senderEmailAdr,$TRUE,@receiverList);
   } else {
   	
   }
}


# Fileformat:
# Hash;Vorname;Name;Natel;email;Notification;GroupMember;ModBy;ModAt
# 1;Walter;Rothlin;0041 79 xxx xx xx;xxxxx.yyyyyyy@zzzz.ww;Both;SLRG;wrothlin;20030630090500
sub showMenu_sendShortMsg {
   my $answer = 0;
   my $senderSMSNumber = "Antwort an ".$testNatelNr_2;
   my $senderEmailAdr  = $testEmailAdr_1;
 
   my $dataFileName = "/home/wrothlin/data.flt";
   $dataFileName = readln("Data-Filename",$dataFileName);

   do {
    # retriving data
    my(@records) = getAllMatchesFromFltFileAsHashes($dataFileName,"","","");
    my(@groups)  = ();

    # preparing menu
    VT52_cls_home();
    print(unterstreichen("Send a short Msg","="));
    my $thisGroups = "";
    my $i = 1;
    foreach my $aRecord (@records) {
     printf("%5d: %-40s %-30s --> $aRecord->{Notification}\n",$i,$aRecord->{Vorname}." ".$aRecord->{Name},$aRecord->{GroupMember});
     $thisGroups = $thisGroups.",".$aRecord->{GroupMember};
     $i++;
    }
    my $maxMemberId = $i - 1;
    print("\n    Groups...\n");
    my(@listOfGroups) = split(",",$thisGroups);
    @listOfGroups = makeArrayEntriesDistinct($TRUE,@listOfGroups);

    foreach my $aGroup (@listOfGroups) {
     printf("%5d: # %-40s\n",$i,$aGroup);
     $i++;
    }
    
    print("\n");
    printf("%5d: Ende\n\n",0);
    $answer = readln("Send to (e.g. 3,6,)",0);
    if ($answer ne "0") {
         $answer =~ s/,/ /g;
         my(@selectList) = split(" ",$answer);
         @selectList = makeArrayEntriesDistinct($TRUE,@selectList);
         # remove group id from list
         my(@groupSelects) = ();
         foreach my $anId (@selectList) {
           if ($anId > $maxMemberId) {
               @selectList = removeEntriesFromArray($anId,$TRUE,@selectList);
               push(@groupSelects,$anId);
           }
         }
         ## print("MemberList...\n");
         ## displayArray(@selectList);

         ## print("GroupList...\n");
         ## displayArray(@groupSelects);

         # resolving groups

         foreach my $aGrpId (@groupSelects) {
            my $aGrpName = $listOfGroups[$aGrpId - $maxMemberId - 1];
            ## print("aGrpName:${aGrpName}:\n");
            $i = 0;
            foreach my $aRecRef (@records) {
                $i++;
                if (index($aRecRef->{GroupMember},$aGrpName) != -1) {
                    push(@selectList,$i);
                }
            }
         }

         @selectList = makeArrayEntriesDistinct($TRUE,@selectList);
         # print("Resolved MemberList...\n");
         # displayArray(@selectList);

         my(@userList) = ();
         foreach my $aSelectedItemId (@selectList) {
           my $selRecRef = $records[$aSelectedItemId - 1];
           if (uc($selRecRef->{Notification}) eq "SMS") {
             push(@userList,sprintf("%-30s",$selRecRef->{Natel})." # $selRecRef->{Vorname} $selRecRef->{Name}");
           } elsif (uc($selRecRef->{Notification}) eq "EMAIL") {
             push(@userList,sprintf("%-30s",$selRecRef->{email})." # $selRecRef->{Vorname} $selRecRef->{Name}");
           } elsif (uc($selRecRef->{Notification}) eq "BOTH") {
             push(@userList,sprintf("%-30s",$selRecRef->{email})." # $selRecRef->{Vorname} $selRecRef->{Name}");
             push(@userList,sprintf("%-30s",$selRecRef->{Natel})." # $selRecRef->{Vorname} $selRecRef->{Name}");
           }
         }
         @userList = makeArrayEntriesDistinct($TRUE,@userList);
         print("\nReceivers of the msg...\n");
         displayArray(@userList);

         $senderSMSNumber = readln("Sender SMS number",$senderSMSNumber);
         $senderEmailAdr  = readln("Sender e-mail address",$senderEmailAdr);
         my $msgToSend       = "";
         my $msgToSendFromReadln = "";
         do {
            $msgToSendFromReadln = readln("Line: (## to Exit)","");
            if ($msgToSendFromReadln ne "##") {
               $msgToSend = "${msgToSend}\n${msgToSendFromReadln}";
            }
         } until ($msgToSendFromReadln eq "##");
         sendShortMsg($msgToSend,$senderSMSNumber,$senderEmailAdr,$TRUE,@userList);
    }
  } until ($answer eq "0");

}

# IN:
#  %msgHash = (
#   "xxxxx1.yyyyyyy@zzzz.ww;079xxxxxxxxx"      => "23-Jan-04 Felix Muster (70);24-Jan-04 Mir Egal (67)"
#   "xxxxx2.yyyyyyy@zzzz.ww;079yyyyyyyyy"      => "23-Jan-04 Felix Muster (70);24-Jan-04 Mir Egal (67)"
#  )
sub sendShortMsgFromHash {
  my($senderSMS,$senderEmail,$verbal,%msgHash) = @_;
  ### displayHashTable(%msgHash);
  my @toAddrrs = keys %msgHash;
  foreach my $aToAdr (@toAddrrs) {
     my(@toAddrList) = split(";",$aToAdr);
     if (index($aToAdr,";") == -1) {
     	@toAddrList = split(",",$aToAdr);
     }
     if ($msgHash{$aToAdr} ne "") {
       if ($verbal) {
         print("sending...".$msgHash{$aToAdr}."<BR>\n");
         displayArrayHTML(@toAddrList);
       }
       sendShortMsg($msgHash{$aToAdr},$senderSMS,$senderEmail,$FALSE,@toAddrList);
     }
  }

}

# sends a msg to a list of users
# the list can have e-mail addresses or mobil numbers and looks as follow:
#   @userList = (
#         "SMS:4179xxxxxxxxx # Walti Rothlin",
#         "EMAIL:xxxxx1.yyyyyyy@zzzz.ww # Walti at home",
#         "4179xxxxxxxxx # Claudia",
#         "xxxxx2.yyyyyyy@zzzz.ww # walti in the office",
#   )
sub sendShortMsg {
  my($msg,$senderSMS,$senderEmail,$debugThisFct,@userList) = @_;
  $debugThisFct = setDefault($debugThisFct,$FALSE);

  my(@emailAddrs) = ();
  my(@smsNumbers) = ();
  foreach my $aUser (@userList) {
    if (index($aUser,"#") != -1) {
      $aUser = substr($aUser,0,index($aUser,"#"));
    } 

    $aUser =~ s/\s//g;
    my $wayToNotify    = "EMAIL";

    if (index($aUser,"\@") == -1) {
      $wayToNotify    = "SMS";
    }

    my $numberToNotify = $aUser;

    if (index($aUser,":") != -1) {
       $wayToNotify    = uc(getFieldFromString(":",0,$aUser));
       $numberToNotify = getFieldFromString(":",1,$aUser);
    }
    if ($wayToNotify eq "EMAIL") {
       writeTrace($debugThisFct,"sending email to ${numberToNotify}:<BR>\n");
       push(@emailAddrs,$numberToNotify);
    } else {
       writeTrace($debugThisFct,"sending sms to ${numberToNotify}:<BR>\n");
       push(@smsNumbers,$numberToNotify);
    }  
  }
  
  @emailAddrs = trimAndRemoveEmptiesInArray(@emailAddrs);
  @smsNumbers = trimAndRemoveEmptiesInArray(@smsNumbers);

  @emailAddrs = makeArrayEntriesDistinct($TRUE,@emailAddrs);
  @smsNumbers = makeArrayEntriesDistinct($TRUE,@smsNumbers);

  my $emailAdrList = makeQuotedStrFromArray(",","",@emailAddrs);
  my $subject = $msg;
  my $emailSubject = $subject;
  if (length($emailSubject) > 50) {
    my(@msgParts) = splitStringByWord($emailSubject,50);
    $emailSubject = $msgParts[0];
  }

  sendMailwithAttachments($senderEmail,$emailAdrList,$emailSubject,$msg,"",$ccAdr,$bccAdr);
  sendSMS("${subject} ${senderSMS}",@smsNumbers);
}

############################################################################
# Function to manipulate hashes
############################################################################

# Creating hashes
# ---------------

# Input:
# inStr:  Walti;1960;Peterliwiese 33;8855;Wangen
#
# Result:
# Hash:   0 => "Walti",
#         1 => "1960",
#         2 => "Peterliwiese 33",
sub createHashOutOfArrayStr {
   my($inStr,$sepChar,$reverse) = @_;
   $reverse = setDefault($reverse,$FALSE);
   $sepChar = setDefault($sepChar,";");
   my(%retHash) = ();
   my($count) = 0;
   my(@parts) = split($sepChar,$inStr);
   my($aPart) = "";
   foreach $aPart (@parts) {
      if ($reverse) {
         %retHash = (%retHash,($aPart,$count));
      } else {
         %retHash = (%retHash,($count,$aPart));
      }
      $count++;
   }
   return %retHash
}

# Input:
# mappingArray: xxxx --> XXXXX
#               yyyy --> YYYYY
#
# Result:
# Hash:   xxxx => "XXXXX",
#         yyyy => "YYYYY",
sub convertArrayMappingTblToHashMappingTbl {
   my($sepStr,@mappingArray) = @_;
   $sepStr = setDefault($sepStr,"-->");
   my %mappingHash = ();
   foreach my $aMappingEntry (@mappingArray) {
      my @aMappingParts = split($sepStr,$aMappingEntry);
      %mappingHash = (%mappingHash,(replaceVariables_InString(strip($aMappingParts[0])),replaceVariables_InString(strip($aMappingParts[1]))));
   }
   return %mappingHash;
}

sub getJavaPropertyFromFile {
	my($propertyFileName,$propName,$notfoundStr) = @_;
	my %propertyFileContent = convertArrayMappingTblToHashMappingTbl("=",readFile($propertyFileName));
	if (exists($propertyFileContent{$propName})) {
		return strip($propertyFileContent{$propName});
	} else {
		return $notfoundStr;
	}
}

# returns a string from a Hash
# e.g.
#  %inHash = (
#     "Name"      => "Walti",
#     "FirtsName" => "Rothlin",
#  )
# 
#  retStr = "Name=>Walti;FirtsName=>Rothlin"
#
sub makeStrFromHash {
	my($addValues, $addKeys, $keyValueSep, $entrySep, %inHash) = @_;
	$addValues   = setDefault($addValues,  $TRUE);
	$addKeys     = setDefault($addKeys,    $TRUE);
	$keyValueSep = setDefault($keyValueSep,"=>");
	$entrySep    = setDefault($entrySep,   ";");
    
	my $retString = "";
	foreach my $aField (keys %inHash) {
		my $singleEntry = "";
		if ($addValues) {
			if ($addKeys) {
				$singleEntry = "${aField}${keyValueSep}".$inHash{$aField};
			} else {
				$singleEntry = $inHash{$aField};
			}
		} elsif ($addKeys) {
			$singleEntry = $aField;
		} else {
			return $retString;
		}
		if ($retString eq "") {
			$retString = "${singleEntry}";
		} else {
			$retString = "${retString}${entrySep}${singleEntry}";
		}
	}
	 return $retString;
}

sub makeStrFromHashFormat {
	my($addValues, $addKeys, $keyValueSep, $entrySep, $keyPadden, $keyPadOffset, %inHash) = @_;
	$addValues      = setDefault($addValues,     $TRUE);
	$addKeys        = setDefault($addKeys,       $TRUE);
	$keyValueSep    = setDefault($keyValueSep,   "=>");
	$keyPadden      = setDefault($keyPadden,     $TRUE);
	$keyPadOffset   = setDefault($keyPadOffset,  0);
	$entrySep       = setDefault($entrySep,      ";");
    
	my $keyLength = getMaxStrLengthFromHash($TRUE,$FALSE,%inHash);
	if ($keyPadOffset <= 0) {
		$keyLength = -1 * ($keyLength + abs($keyPadOffset))
	} else {
		$keyLength = $keyLength + $keyPadOffset
	}

	my $retString = "";
	foreach my $aField (keys %inHash) {
		my $singleEntry = "";
		if ($addValues) {
			if ($addKeys) {
				if ($keyPadden) {
					$singleEntry = padString($aField,$keyLength)."${keyValueSep}".$inHash{$aField};
				} else {
					$singleEntry = "${aField}${keyValueSep}".$inHash{$aField};
				}
			} else {
				$singleEntry = $inHash{$aField};
			}
		} elsif ($addKeys) {
			$singleEntry = $aField;
		} else {
			return $retString;
		}
		if ($retString eq "") {
			$retString = "${singleEntry}";
		} else {
			$retString = "${retString}${entrySep}${singleEntry}";
		}
	}
	 return $retString;
}

sub makeStrFromHashFormat_1 {
	my($addValues, $addKeys, $keyValueSep, $entrySep, $keyPadden, $keyPadOffset, $sortedByKeys, %inHash) = @_;
	$addValues      = setDefault($addValues,     $TRUE);
	$addKeys        = setDefault($addKeys,       $TRUE);
	$keyValueSep    = setDefault($keyValueSep,   "=>");
	$keyPadden      = setDefault($keyPadden,     $TRUE);
	$keyPadOffset   = setDefault($keyPadOffset,  0);
	$entrySep       = setDefault($entrySep,      ";");
	$sortedByKeys   = setDefault($sortedByKeys,  $FALSE);
    
	my $keyLength = getMaxStrLengthFromHash($TRUE,$FALSE,%inHash);
	if ($keyPadOffset <= 0) {
		$keyLength = -1 * ($keyLength + abs($keyPadOffset))
	} else {
		$keyLength = $keyLength + $keyPadOffset
	}

	my $retString = "";
	my @keyList = (keys %inHash);
	if ($sortedByKeys) {
		@keyList = (sort @keyList);
	}
	foreach my $aField (@keyList) {
		my $singleEntry = "";
		if ($addValues) {
			if ($addKeys) {
				$singleEntry = padString($aField,$keyLength)."${keyValueSep}".$inHash{$aField};
			} else {
				$singleEntry = $inHash{$aField};
			}
		} elsif ($addKeys) {
			$singleEntry = $aField;
		} else {
			return $retString;
		}
		if ($retString eq "") {
			$retString = "${singleEntry}";
		} else {
			$retString = "${retString}${entrySep}${singleEntry}";
		}
	}
	 return $retString;
}

sub isHashEmpty {
	my(%aHash) = @_;
	my @keys = keys %aHash;
	my $count = @keys;
	if ($count == 0) {
		return $TRUE;
	} else {
		return $FALSE;
	}
}

sub doTest_areHashesEqual {
	my($myFullName,$debugThisFct) = @_;
	$debugThisFct = setDefault($debugThisFct,$FALSE);

	my %hashA = (
		"Walti"   => "1960",
		"Claudia" => "1965",
		"Josef"   => "Dez 1958",
	);
	my %hashB = (
		"Walti"   => "1960",
		"Claudia" => "1965",
		"Josef"   => "Dez 1958",
	);
	my %hashC = (
		"walti"   => "1960",
		"CLAUDIA" => "1965",
		"Josef"   => "DEZ 1958",
	);
	my %hashD = (
		"walti"   => "1960",
		"Josef"   => "DEZ 1958",
	);
	my %hashE = (
		"walti"   => "1960",
		"CLAUDIA" => "BLAbla",
		"Josef"   => "DEZ 1958",
	);

	if (!(areHashesEqual(\%hashA,\%hashB,$TRUE,$TRUE,$debugThisFct))) {
		print("ERROR: ${myFullName} failed (A-0)\n");
	}
	if (!(areHashesEqual(\%hashA,\%hashB,$FLASE,$TRUE,$debugThisFct))) {
		print("ERROR: ${myFullName} failed (B-0)\n");
	}
	if (!(areHashesEqual(\%hashA,\%hashB,$TRUE,$FALSE,$debugThisFct))) {
		print("ERROR: ${myFullName} failed (C-0)\n");
	}
	if (!(areHashesEqual(\%hashA,\%hashB,$FALSE,$FALSE,$debugThisFct))) {
		print("ERROR: ${myFullName} failed (D-0)\n");
	}

	if (areHashesEqual(\%hashA,\%hashC,$TRUE,$TRUE,$debugThisFct)) {
		print("ERROR: ${myFullName} failed (A-1)\n");
	}
	if (areHashesEqual(\%hashA,\%hashC,$FALSE,$TRUE,$debugThisFct)) {
		print("ERROR: ${myFullName} failed (B-1)\n");
	}
	if (areHashesEqual(\%hashA,\%hashC,$TRUE,$FALSE,$debugThisFct)) {
		print("ERROR: ${myFullName} failed (C-1)\n");
	}
	if (!(areHashesEqual(\%hashA,\%hashC,$FALSE,$FALSE,$debugThisFct))) {
		print("ERROR: ${myFullName} failed (D-1)\n");
	}
}

sub areHashesEqual {
  my($refHashA,$refHashB,$keyCaseSensitve,$valueCaseSensitve,$debugThisFct) = @_;
  $keyCaseSensitve   = setDefault($keyCaseSensitve,$TRUE);
  $valueCaseSensitve = setDefault($valueCaseSensitve,$TRUE);
  $debugThisFct      = setDefault($debugThisFct,$FALSE);
  my $retVal = $TRUE;

  ### writeTrace($debugThisFct,"keyCaseSensitve  :${keyCaseSensitve} ${TRUE}=TRUE");
  ### writeTrace($debugThisFct,"valueCaseSensitve:${valueCaseSensitve} ${TRUE}=TRUE");
  ### writeTrace($debugThisFct,"HashA:\n".hashTableToStr($TRUE,%$refHashA)."\n");
  ### writeTrace($debugThisFct,"HashB:\n".hashTableToStr($TRUE,%$refHashB)."\n");

  my(%hashA) = %$refHashA;
  my(%hashB) = %$refHashB;

  if (!($keyCaseSensitve)) {
     %hashA = changeCaseForHashKeys($TRUE,%hashA);
     %hashB = changeCaseForHashKeys($TRUE,%hashB);
     ### writeTrace($debugThisFct,"uc(HashA-key):\n".hashTableToStr($TRUE,%hashA)."\n");
     ### writeTrace($debugThisFct,"uc(HashB-key):\n".hashTableToStr($TRUE,%hashB)."\n");
  }

  my(@keysA) = keys %hashA;
  my(@keysB) = keys %hashB;
  

  ### writeTrace($debugThisFct,"keysA:\n".displayArrayReturnString(@keysA)."\n");
  ### writeTrace($debugThisFct,"keysB:\n".displayArrayReturnString(@keysB)."\n");
  if (areArraysEqual(\@keysA,\@keysB,$FALSE,$keyCaseSensitve)) {
     ### writeTrace($debugThisFct,"Keys are equal");
     if ($valueCaseSensitve) {
       ### writeTrace($debugThisFct,"Value check (Case Sensitive)");
       foreach my $aKeyFromA (@keysA) {
          if ($hashA{$aKeyFromA} ne $hashB{$aKeyFromA}) {
             ### writeTrace($debugThisFct,$hashA{$aKeyFromA}." ne ".$hashB{$aKeyFromA});
             $retVal = $FALSE;
             last;
          } 
       }
     } else {
       ### writeTrace($debugThisFct,"Value check (Case Insensitive)");
       foreach my $aKeyFromA (@keysA) {
          if (uc($hashA{$aKeyFromA}) ne uc($hashB{$aKeyFromA})) {
             ### writeTrace($debugThisFct,uc($hashA{$aKeyFromA})." ne ".uc($hashB{$aKeyFromA}));
             $retVal = $FALSE;
             last;
          } 
       }
     }
  } else {
     $retVal = $FALSE;
  }
  return $retVal;
}

# initializes all values in a hash to $initVal
sub initHash {
   my($refToHash,$initVal) = @_;
   my @keys = keys %$refToHash;
   foreach my $aKey (@keys) {
      $refToHash->{$aKey} = $initVal;
   }
}

# Input:
# @keyFields    = ("Name","Vorname","PLZ","Ort")
# $initVal      = "Empty"
#
# Result:
# Hash:   "Name"     => "Empty",
#         "Vorname"  => "Empty",
#         "PLZ"      => "Empty",
#         "Ort"      => "Empty",
sub createAndInitHash {
   my($initVal,@keyFields) = @_;
   
   my %retHash = ();
   foreach my $aKey (@keyFields) {
      %retHash = (%retHash,($aKey,$initVal));
   }
   return %retHash;
}

# Input:
# $keyFields    = "Name;Vorname;PLZ;Ort"
# $recordFields = "Walti;Rothlin;8855;Wangen"
# $keyPrefix    = "Key"
# $withBrakets  = $TRUE;
#
# Result:
# Hash:   "{Key:Name}"     => "Walti",
#         "{Key:Vorname}"  => "Rothlin",
#         "{Key:PLZ}"      => "8855",
#         "{Key:Ort}"      => "Wangen",
sub createHashTab {
	my($keyFields,$recordFields,$sepChar,$keyPrefix,$withBrakets,$braketChrOpen,$braketChrClose)  = @_;
  	$braketChrOpen          = setDefault($braketChrOpen,"{");
	$braketChrClose         = setDefault($braketChrClose,"}");
  
	my %outHashTab = ();
	my $count  = 0;
	my @keyFieldsArr    = split($sepChar,$keyFields);
	my @recordFieldsArr = split($sepChar,$recordFields);
	foreach my $locKey (@keyFieldsArr) {
		my $newKey = $locKey;
		if (length($keyPrefix) > 0) {
			$newKey = "${keyPrefix}:${newKey}";
		}
		if ($withBrakets) {
			$newKey = "${braketChrOpen}${newKey}${braketChrClose}";
		}
		%outHashTab = (%outHashTab,($newKey,$recordFieldsArr[$count]));
		$count++;
	}
	return %outHashTab;
}

# creates a hash out of a flt-table entrie
sub cretateHashTabFromStr {
   my($tabName,$tabSepChr,$strRec) = @_;
   my $header = getTableHeader($tabName);
   my %newRec = createHashTab($header,$strRec,$tabSepChr,"",$FALSE);
   return %newRec;
}

# Input:
# %KeyHash = (
#       "0835" => "ZH",
#       "0933" => "LN",
#       "0941" => "NY",
#       "1926" => "FF",
# );
# 
# %ValueHash = (
#       "0835" => "Zurich",
#       "0933" => "London",
#       "0941" => "New York",
#       "1926" => "Frankfurt",
# );
# 
#
# Result:  
# %returnHash = combineTwoHashes(\%KeyHash,\%ValueHash);
# %returnHash = (
#       "ZH" => "Zurich",
#       "LN" => "London",
#       "NY" => "New York",
#       "FF" => "Frankfurt",
# );
sub combineTwoHashes {
     my($refKeyHash,$refValueHash) = @_;
     my %resHash = ();
     my @keys = keys %$refKeyHash;
     foreach my $aKey (@keys) {
         ### printf("%s:%s:%s:\n",$aKey,$refKeyHash->{$aKey},$refValueHash->{$aKey});
         %resHash = (%resHash,($refKeyHash->{$aKey},$refValueHash->{$aKey}));
     }
     return %resHash;
}


# Input:
# %OldHash = (
#       "0835" => "ZH",
#       "0933" => "LN",
#       "0941" => "NY",
#       "1926" => "FF",
# );
# 
# %UpdateHash = (
#       "0835" => "Zurich",
#       "1926" => "Frankfurt",
# );
# 
#
# Result:  
# %returnHash = updateHash(\%OldHash,\%UpdateHash);
# %returnHash = (
#       "0835" => "Zurich",
#       "0933" => "LN",
#       "0941" => "NY",
#       "1926" => "Frankfurt",
# );
sub updateHash {
	my($refOldHash,$refUpdateHash) = @_;
	my %resHash = ();
	my %updateHash = %$refUpdateHash;
	my @keys = keys %$refOldHash;
	foreach my $aKey (@keys) {
		if (exists($updateHash{$aKey})) {
			%resHash = (%resHash,($aKey,$refUpdateHash->{$aKey}));
		} else {
			%resHash = (%resHash,($aKey,$refOldHash->{$aKey}));
		}
	}
	return %resHash;
}

# Input:
# %refInHash = (
#       "0835" => "ZH",
#       "0933" => "LN",
#       "0941" => "NY",
#       "1926" => "FF",
# );
# 
# 
#
# Result:  
# %returnHash = updateHashKeys(\%refInHash);
# %returnHash = (
#       "{0835}" => "ZH",
#       "{0933}" => "LN",
#       "{0941}" => "NY",
#       "{1926}" => "FF",
# );
sub updateHashKeys {
	my($refInHash) = @_;
	my %resHash = ();
	my %refInHash = %$refInHash;
	my @keys = keys %$refInHash;
	foreach my $aKey (@keys) {
		%resHash = (%resHash,("{${aKey}}",$refInHash{$aKey}));
	}
	return %resHash;
}

# Input:
# %aHash_1 = (
#       "0835" => "ZH",
#       "0933" => "LN",
#       "0941" => "NY",
#       "1926" => "FF",
# );
# 
# %aHash_2 = (
#       "0836" => "Zurich",
#       "1926" => "Frankfurt",
# );
# 
#
# Result:  
# %returnHash = addNewKey_ValuesIfKeyIsNotAlreadyThere(\%aHash_1,\%aHash_2);
# %returnHash = (
#       "0835" => "ZH",
#       "0933" => "LN",
#       "0941" => "NY",
#       "1926" => "FF",
#       "0836" => "Zurich",
# );
#
# %returnHash = addNewKey_ValuesIfKeyIsNotAlreadyThere(\%aHash_1,\%aHash_2,$TRUE);
# %returnHash = (
#       "0835" => "ZH",
#       "0933" => "LN",
#       "0941" => "NY",
#       "1926" => "Frankfurt",
#       "0836" => "Zurich",
# );
sub addNewKey_ValuesIfKeyIsNotAlreadyThere {
	my($aHash_1,$aHash_2,$updateValueFromExitingKeys, $doTrace, $tracePreString) = @_;
	$updateValueFromExitingKeys = setDefault($updateValueFromExitingKeys,$FALSE);
	$doTrace                    = setDefault($doTrace,$FALSE);

	my $traceStr = $tracePreString;
	my %retHash = %$aHash_1;
	# displayHashTableFormated("retHash copied from aHash_1:"    , "  ", "", "  ", "", "", $TRUE, $FALSE, "",%retHash);
	my @hash_1_Keys = keys %$aHash_1;
	my @hash_2_Keys = keys %$aHash_2;
	my $maxKeyLen = getMaxValue(length(getLongestValFromArray(@hash_1_Keys)),length(getLongestValFromArray(@hash_2_Keys))) + 1;

	foreach my $aKey (@hash_2_Keys) {
		if (exists($retHash{$aKey})) {
			if ($updateValueFromExitingKeys) {
				$retHash{$aKey} = $aHash_2->{$aKey};
				# displayHashTableFormated("Updated ${aKey},".$aHash_2->{$aKey}.":"    , "  ", "", "  ", "", "", $TRUE, $FALSE, "",%retHash);
				$traceStr = $traceStr."\nUpdated: Key: ".padString($aKey,-$maxKeyLen)." Value:".$aHash_2->{$aKey};
			}
		} else {
			%retHash = (%retHash,($aKey,$aHash_2->{$aKey}));
			# displayHashTableFormated("Added  ${aKey},".$aHash_2->{$aKey}.":"    , "  ", "", "  ", "", "", $TRUE, $FALSE, "",%retHash);
			$traceStr = $traceStr."\nAdded: Key: ".padString($aKey,-$maxKeyLen)." Value:".$aHash_2->{$aKey};
		}
	}
	if ($doTrace) {
		if ($traceStr ne $tracePreString) {
			print("${traceStr}\n\n");
		}
	}
	return %retHash;
}

sub doTest_addNewKey_ValuesIfKeyIsNotAlreadyThere {
	my($myFullName,$debugThisFct) = @_;
	$debugThisFct = setDefault($debugThisFct,$FALSE);

	my %aHash_1 = (
		"0835" => "ZH",
		"0933" => "LN",
		"0941" => "NY",
		"1926" => "FF",
	);
 
	my %aHash_2 = (
		"0836" => "Zurich",
		"1926" => "Frankfurt",
	);

	my %expectedResult = (
		"0835" => "ZH",
		"0933" => "LN",
		"0941" => "NY",
		"1926" => "FF",
		"0836" => "Zurich",
	);

	my %returnHash = addNewKey_ValuesIfKeyIsNotAlreadyThere(\%aHash_1,\%aHash_2);
	if (!(areHashesEqual(\%returnHash,\%expectedResult,$TRUE,$TRUE,$debugThisFct))) {
		print("ERROR: ${myFullName} failed (A)\n");
		displayHashTableFormated("Result  :"    , "  ", "", "  ", "", "", $TRUE, $FALSE, "",%returnHash);
		displayHashTableFormated("Expected:"    , "  ", "", "  ", "", "", $TRUE, $FALSE, "",%expectedResult);
	}

	%expectedResult = (
		"0835" => "ZH",
		"0933" => "LN",
		"0941" => "NY",
		"1926" => "Frankfurt",
		"0836" => "Zurich",
	);
	%returnHash = addNewKey_ValuesIfKeyIsNotAlreadyThere(\%aHash_1,\%aHash_2,$TRUE);
	if (!(areHashesEqual(\%returnHash,\%expectedResult,$TRUE,$TRUE,$debugThisFct))) {
		print("ERROR: ${myFullName} failed (B)\n");
		displayHashTableFormated("Result  :"    , "  ", "", "  ", "", "", $TRUE, $FALSE, "",%returnHash);
		displayHashTableFormated("Expected:"    , "  ", "", "  ", "", "", $TRUE, $FALSE, "",%expectedResult);
	}
}

# Hash manipulation
# -----------------
sub getValueFromHash {
  my($key,$undefinedStr,$reversed,%inHash) = @_;
  $reversed = setDefault($reversed,$FALSE);
  my %mappingHash = ();
  if ($reversed) {
     %mappingHash = swapHash(%inHash);
  } else {
     %mappingHash = %inHash;
  }
  if (exists($mappingHash{$key})) {
      $resVal = $mappingHash{$key};
  } else {
      $resVal = $undefinedStr;
  }
  return $resVal;
}


# Input:
# inHashTab:  "Walti"           => "0",
#             "1960"            => "1",
#             "Peterliwiese 33" => "2",
#
# Result:
# Hash:   0 => "Walti",
#         1 => "1960",
#         2 => "Peterliwiese 33",
sub swapHash {
  my(%inHashTab)  = @_;
  my %outHashTab = ();
  my @inKeys = keys %inHashTab;
  foreach $inKey (@inKeys) {
    %outHashTab = (%outHashTab,($inHashTab{$inKey} => $inKey));
  }
  return %outHashTab;
}

# Input:
# inHashTab:  "Walti"           => "0",
#             "1960"            => "1",
#             "Peterliwiese 33" => "2",
#             "Millerwiese 6"   => "2",
#
# Result:
# Hash:   0 => "Walti",
#         1 => "1960",
#         2 => "Peterliwiese 33",
sub swapHashWithWarningForDublicates {
  my($logFileName,$verbal,%inHashTab)  = @_;
  my %outHashTab = ();
  my @inKeys = keys %inHashTab;
  foreach $inKey (@inKeys) {
  	my $outKey = $inHashTab{$inKey};
  	if (exists($outHashTab{$outKey})) {
  		  my $currentVal = $outHashTab{$outKey};
  		  addToLogFile("WARNING: double entries found for Key:${outKey}",$logFileName,$verbal);
  		  addToLogFile("WARNING: Current value:${currentVal}: (".getNameForPid($currentVal).")",$logFileName,$verbal);
  		  addToLogFile("WARNING: New value    :${inKey}: (".getNameForPid($inKey).")",$logFileName,$verbal);
  	} else {
        %outHashTab = (%outHashTab,($outKey => $inKey));
    }
  }
  return %outHashTab;
}

sub replaceASCII_to_HEX_InHashValues {
  my($format,%inHashTab)  = @_;
  $format = setDefault($format,"0");
  my %outHashTab = ();
  my @inKeys = keys %inHashTab;
  foreach $inKey (@inKeys) {
    my $aVal = $inHashTab{$inKey};
    $aVal = convertASCII_to_HEX($aVal,$format);
    %outHashTab = (%outHashTab,($inKey => $aVal));
  }
  return %outHashTab;
}

sub replaceUmlauteByHTMLcodesInHashValues {
  my(%inHashTab)  = @_;
  my %outHashTab = ();
  my @inKeys = keys %inHashTab;
  foreach $inKey (@inKeys) {
    my $aVal = $inHashTab{$inKey};
    $aVal =~ s/ü/&uuml;/g;
    $aVal =~ s/ä/&auml;/g;
    $aVal =~ s/ö/&ouml;/g;
    %outHashTab = (%outHashTab,($inKey => $aVal));
  }
  return %outHashTab;
}

sub addKeyValueToHash {
   my($aKey,$aVal,%inHash) = @_;
   my(%retHash) = %inHash;
   if (exists($retHash{$aKey})) {
      $retHash{$aKey} = $aVal;
   } else {
      %retHash = (%retHash,($aKey,$aVal));
   }
   return %retHash;
}

# getMaxStrLengthFromHash
# -----------------------
# returns the maximum string length in a hash. Depending on the two flags it
# takes the key-field or the value-field or both to calculate the string length
sub getMaxStrLengthFromHash {
   my($withKey,$withValue,%valuePairs) = @_;
   my($maxLen)  = 0;
   my(@allKeys) = 0; @allKeys = keys %valuePairs;
   my($aKey)    = "";
   foreach $aKey (@allKeys) {
      my($keyLen) = 0;
      my($valLen) = 0;
      if ($withKey)                      { $keyLen = length($aKey); }
      if ($withValue)                    { $valLen = length($valuePairs{$aKey}); }
      if ($maxLen < ($keyLen + $valLen)) { $maxLen = $keyLen + $valLen; }
   }
   return $maxLen;
}


sub lookForMissingKeys {
   my(@hashNames) = @_;
   my($retStr)    = "";   
   my($aHashName) = "";
   my($countOfHashTabs) = 0;
   $countOfHashTabs     = @hashNames;
   my($i) = 0;
   if ($countOfHashTabs > 1) {
      my($refHashName) = $hashNames[0];
      my(%refHash)     = %$refHashName;
      my(@refKeys)     = keys %refHash;
      my($refKeyCount) = "";  $refKeyCount = @refKeys;
      foreach ($i=1; $i < $countOfHashTabs; $i++) {
         my($compHashName) = $hashNames[$i];
         my(%compHash)     = %$compHashName;
         my(@compKeys)     = keys %compHash;
         my($compKeyCount) = "";  $compKeyCount = @compKeys;
         if ($compKeyCount > $refKeyCount) {
            my($aTestKey) = "";
            foreach $aTestKey (@compKeys) {
               if (!(exists($refHash{$aTestKey}))) {
                  $retStr = "${retStr}Missing ${aTestKey} in ${refHashName}\n";
               }
            }
         } else {
            my($aTestKey) = "";
            foreach $aTestKey (@refKeys) {
               if (!(exists($compHash{$aTestKey}))) {
                  $retStr = "${retStr}Missing ${aTestKey} in ${compHashName}\n";
               }
            }
         }
      }
   }
   return $retStr;
}

sub doTest_diffInHashes {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my(%aHash) = (
    "Rothlin"     => "Walter",
    "Collet"      => "Claudia",
    "Friedlos"    => "Josef",
    "Meier"       => "Rosi",
    "Diethelm"    => "Gabi",
   );

   my(%bHash) = (
     "Diethelm" => "Unknown",
     "Meier"    => "Rothlin-Meier",
     "Friedlos" => "",
     "Nop"      => "NICHTS",
     "Rothlin"  => "Walter",
   );

   my(%diffHash) = (
    "In b:Diethelm" => "Unknown",
    "In b:Friedlos" => "",
    "In b:Meier"    => "Rothlin-Meier",
    "In a:Diethelm" => "Gabi",
    "In a:Friedlos" => "Josef",
    "In a:Meier"    => "Rosi",
    "Only a:Collet" => "Claudia",
    "Only b:Nop"    => "NICHTS",
   ); 

   my(%diffWrongHash) = (
    "In b:Diethelm" => "Unknown",
    "In b:Friedlos" => "",
    "In b:Meier"    => "Rothlin-MEIER",
    "In a:Diethelm" => "Gabi",
    "In a:Friedlos" => "Josef",
    "In a:Meier"    => "Rosi",
    "Only a:Collet" => "Claudia",
    "Only b:Nop"    => "NICHTS",
   ); 

   my(%diffHashCalc) = diffInHashes(\%aHash,\%bHash,"In a:","In b:","Only a:","Only b:");


   if (!(areHashesEqual(\%diffHashCalc,\%diffHash))) {
       print("ERROR: ${myFullName} failed (A)\n");
   }
   if (areHashesEqual(\%diffHashCalc,\%diffWrongHash)) {
       print("ERROR: ${myFullName} failed (B)\n");
   }
}

# %aHash = (
#    "Rothlin"     => "Walter",
#    "Collet"      => "Claudia",
#    "Friedlos"    => "Josef",
#    "Meier"       => "Rosi",
#    "Diethelm"    => "Gabi",
# );
# 
# %bHash = (
#     "Diethelm" => "Unknown",
#     "Meier"    => "Rothlin-Meier",
#     "Friedlos" => "",
#     "Nop"      => "NICHTS",
#     "Rothlin"  => "Walter",
# );
# 
# %diffHash = diffInHashes(\%aHash,\%bHash,"In a:","In b:","Only a:","Only b:");
# 
# %diffHash = (
#    In a:Diethelm  => Gabi
#    In a: Friedlos => Josef
#    In a: Meier    => Rosi
#    In b: Diethelm => Unknown
#    In b: Friedlos =>
#    In b:Meier     => Rothlin-Meier
#    Only a: Collet => Claudia
#    Only b: Nop    => NICHTS
# ); 
# 
#
sub diffInHashes {
  my($refToHash1,$refToHash2,$str1,$str2,$str1a,$str2a) = @_;
  my(%hash1)   = derefHref($refToHash1);
  my(%hash2)   = derefHref($refToHash2);
  my(%retHash) = ();
  my(@keys1)   = keys %hash1;
  my($aKey)    = "";
  foreach $aKey (@keys1) {
     my($val1) = $hash1{$aKey};
     my($val2) = "";
     if (exists($hash2{$aKey})) {
        $val2 = $hash2{$aKey};
        if ($val1 ne $val2) {
           %retHash = (%retHash,("${str1}${aKey}",$val1));
           %retHash = (%retHash,("${str2}${aKey}",$val2));
        }
        delete $hash2{$aKey};
     } else {
        %retHash = (%retHash,("${str1a}${aKey}",$val1));
     }
  }
  my(@keys2)   = keys %hash2;
  foreach $aKey (@keys2) {
     my($val2) = $hash2{$aKey};
     %retHash = (%retHash,("${str2a}${aKey}",$val2));
  }
  return %retHash;
}

sub diffInHashesWithSameKeys {
  my($refToHash1,$refToHash2,$asHTML_Table) = @_;

  my %hash1   = derefHref($refToHash1);
  my %hash2   = derefHref($refToHash2);
  my $retString = "";
  my $first     = $TRUE;
  my @keys1   = keys %hash1;
  foreach my $aKey (@keys1) {
     my $val1 = $hash1{$aKey};
     my $val2 = "";
     if (exists($hash2{$aKey})) {
        $val2 = $hash2{$aKey};
        if ($val1 ne $val2) {
           if ($first) {
             $first = $FALSE;
             $retString = "${tableFormatSmall}<TR>${tableTitelFormat}&nbsp;</TD>${tableTitelFormat}".getLangStr("strOld")."</TD>${tableTitelFormat}".getLangStr("strNew")."</TD></TR>";
           }
           $retString = $retString."<TR>${tableEntryFormat}${aKey}</TD>${tableEntryFormat}".htmlNullStr($val1)."</TD>${tableEntryFormat}".htmlNullStr($val2)."</TD></TR>";
        }
     }
  }

  if ($retString ne "") { $retString = $retString."</TABLE>"; }
  return $retString;
}


# %aHash = (
#    "Rothlin"     => "Walter",
#    "Collet"      => "Claudia",
#    "Friedlos"    => "Josef",
#    "Meier"       => "Rosi",
#    "Diethelm"    => "Gabi",
# );
# 
# %bHash = (
#    "Rothlin"     => "Walter",
#    "Collet"      => "Gaby",
#    "Friedlos"    => "Sepp",
#    "Meier"       => "Rosi",
#    "Diethelm"    => "Gabi",
# );
# 
# %diffHash = compareHashValuesWithSameKeys(\%aHash,\%bHash,"Gleich");
# 
# %diffHash = (
#    "Rothlin"     => "Gleich",
#    "Collet"      => "Gaby",
#    "Friedlos"    => "Sepp",
#    "Meier"       => "Gleich",
#    "Diethelm"    => "Gleich",
# );
#
sub compareHashValuesWithSameKeys {
  my($refToHash1,$refToHash2,$equalStr,$takeValuesFromHash2) = @_;
  $equalStr               = setDefault($equalStr,"");
  $takeValuesFromHash2    = setDefault($takeValuesFromHash2,$TRUE);
  my(%hash1)   = derefHref($refToHash1);
  my(%hash2)   = derefHref($refToHash2);
  my(%retHash) = ();
  my(@keys1)   = keys %hash1;

  foreach my $aKey (@keys1) {
     if ($hash1{$aKey} eq $hash2{$aKey}) {
         %retHash = (%retHash,("${aKey}",$equalStr));
     } else {
         if ($takeValuesFromHash2) {
            %retHash = (%retHash,("${aKey}",$hash2{$aKey}));
         } else {
            %retHash = (%retHash,("${aKey}",$hash1{$aKey}));
         }
     }
  }
  return %retHash;
}

sub stripHashValues {
   my($keyToo,%inHash)    = @_;
   my(%retVal)    = ();
   my(@keyOfHash) = keys %inHash;
   my($key)       = "";
   foreach $key (@keyOfHash) {
     if ($keyToo) {
            %retVal = (%retVal,(strip($key),strip($inHash{$key})));
         } else {
            %retVal = (%retVal,($key,strip($inHash{$key})));
         }
   }
   return %retVal;
}

sub doTest_translateHashKeys {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my(%inHash) = (
     "Rothlin"     => "Walter",
     "Collet"      => "Claudia",
     "Friedlos"    => "Josef",
     "Meier"       => "Rosi",
     "Diethelm"    => "Gabi",
   );

   my(%keyTrans) = (
      "Diethelm" => "Unknown",
      "Meier"    => "Rothlin-Meier",
      "Friedlos" => "",
      "Nop"      => "NICHTS",
   );

   my(%expectedResultHash_1) = (
     "Rothlin"       => "Walter",
     "Collet"        => "Claudia",
     "Unknown"       => "Gabi",
     "Rothlin-Meier" => "Rosi",   
   );

   my(%expectedResultHash_2) = (
     "Rothlin"       => "Walter",
     "Collet"        => "Claudia",
     "Unknown"       => "Gabi",
     ""              => "Josef",
     "Rothlin-Meier" => "Rosi",   
   );

   my(%unexpectedResultHash_1) = (
     "Rothlin"       => "Walter",
     "Collet"        => "claudia",
     "Unknown"       => "Gabi",
     "Rothlin-Meier" => "Rosi",   
   );

   my(%outHash) = translateHashKeys(\%inHash,\%keyTrans);

   if (!(areHashesEqual(\%expectedResultHash_1,\%outHash))) {
       print("ERROR: ${myFullName} failed (A)\n");
   }
   if (areHashesEqual(\%unexpectedResultHash_1,\%outHash)) {
       print("ERROR: ${myFullName} failed (B)\n");
   }

   %outHash = translateHashKeys(\%inHash,\%keyTrans,$FALSE);

   if (!(areHashesEqual(\%expectedResultHash_2,\%outHash))) {
       print("ERROR: ${myFullName} failed (C)\n");
   }
   if (areHashesEqual(\%unexpectedResultHash_1,\%outHash)) {
       print("ERROR: ${myFullName} failed (D)\n");
   }

}


# 
# %inHash = (
#    "Rothlin"     => "Walter",
#    "Collet"      => "Claudia",
#    "Friedlos"    => "Josef",
#    "Meier"       => "Rosi",
#    "Diethelm"    => "Gabi",
# );
#
# %keyTrans = (
#     "Diethelm" => "Unknown",
#     "Meier"    => "Rothlin-Meier",
#     "Friedlos" => "",
#     "Nop"      => "NICHTS",
# );
#
# %resultHash = (
#    "Rothlin"       => "Walter",
#    "Collet"        => "Claudia",
#    "Unknown"       => "Gabi",
#    "Rothlin-Meier" => "Rosi",
#   
# );
#
# Call:  %resultHash = translateHashKeys(\%inHash,\%keyTrans);
sub translateHashKeys {
  my($refToHashInHash,$refToTransHash,$removeIfNewKeyIsEmpty) = @_;
  $removeIfNewKeyIsEmpty = setDefault($removeIfNewKeyIsEmpty,$TRUE);
  my(%inHash)      = derefHref($refToHashInHash);
  my(%transHash)   = derefHref($refToTransHash);
  
  ### printf("\ninHash....\n");
  ### displayHashTable(%inHash);
  ### printf("\ntransHash....\n");
  ### displayHashTable(%transHash);
  my(%retHash) = ();   
    
  my(@keysInHash)   = keys %inHash;
  foreach my $aInKey (@keysInHash) {
     ### print("Testing key :${aInKey}:\n");
     if (exists($transHash{$aInKey})) {
     	 my $newKey = $transHash{$aInKey};
     	 ### print(":${aInKey}:  --> :${newKey}:\n");
     	 if (($newKey eq "") && ($removeIfNewKeyIsEmpty)) {
     	 } else {
     	    %retHash = (%retHash,($newKey,$inHash{$aInKey}));	
     	 }
     } else {
         %retHash = (%retHash,($aInKey,$inHash{$aInKey}));	
     }
  }
  ### printf("\nretHash....\n");
  ### displayHashTable(%retHash);
  return %retHash;
}

sub changeCaseForHashKeys {
  my($toUpperCase,%inHash) = @_;
  $toUpperCase = setDefault($toUpperCase,$TRUE);
  
  my(%retHash) = ();   
    
  my(@keysInHash)   = keys %inHash;
  if ($toUpperCase) {
     foreach my $aInKey (@keysInHash) {
       %retHash = (%retHash,(uc($aInKey),$inHash{$aInKey}));	
     }
  } else {
     foreach my $aInKey (@keysInHash) {
       %retHash = (%retHash,(lc($aInKey),$inHash{$aInKey}));	
     }
  }
  return %retHash;
}

sub changeCaseForHash {
  my($keyToUpperCase,$valueToUpperCase,%inHash) = @_;
  
  my(%retHash) = ();   
    
  my(@keysInHash)   = keys %inHash;
  if (($keyToUpperCase eq $TRUE) && ($valueToUpperCase eq $TRUE)) {
     foreach my $aInKey (@keysInHash) {
       %retHash = (%retHash,(uc($aInKey),uc($inHash{$aInKey})));	
     }
  } elsif (($keyToUpperCase eq $TRUE) && ($valueToUpperCase eq $FALSE)) {
     foreach my $aInKey (@keysInHash) {
       %retHash = (%retHash,(uc($aInKey),lc($inHash{$aInKey})));	
     }
  } elsif (($keyToUpperCase eq $TRUE) && ($valueToUpperCase eq "")) {
     foreach my $aInKey (@keysInHash) {
       %retHash = (%retHash,(uc($aInKey),$inHash{$aInKey}));	
     }


  } elsif (($keyToUpperCase eq $FALSE) && ($valueToUpperCase eq $TRUE)) {
     foreach my $aInKey (@keysInHash) {
       %retHash = (%retHash,(lc($aInKey),uc($inHash{$aInKey})));	
     }
  } elsif (($keyToUpperCase eq $FALSE) && ($valueToUpperCase eq $FALSE)) {
     foreach my $aInKey (@keysInHash) {
       %retHash = (%retHash,(lc($aInKey),lc($inHash{$aInKey})));	
     }
  } elsif (($keyToUpperCase eq $FALSE) && ($valueToUpperCase eq "")) {
     foreach my $aInKey (@keysInHash) {
       %retHash = (%retHash,(lc($aInKey),$inHash{$aInKey}));	
     }


  } elsif (($keyToUpperCase eq "") && ($valueToUpperCase eq $TRUE)) {
     foreach my $aInKey (@keysInHash) {
       %retHash = (%retHash,($aInKey,uc($inHash{$aInKey})));	
     }
  } elsif (($keyToUpperCase eq "") && ($valueToUpperCase eq $FALSE)) {
     foreach my $aInKey (@keysInHash) {
       %retHash = (%retHash,($aInKey,lc($inHash{$aInKey})));	
     }
  } elsif (($keyToUpperCase eq "") && ($valueToUpperCase eq "")) {
     foreach my $aInKey (@keysInHash) {
       %retHash = (%retHash,($aInKey,$inHash{$aInKey}));	
     }


  } else {
     %retHash = %inHash;
  }
  return %retHash;
}

# 
# %inHash = (
#    "Rothlin"     => "Walter",
#    "Collet"      => "Claudia",
#    "Friedlos"    => "Josef",
#    "Meier"       => "Rosi",
#    "Diethelm"    => "Gabi",
# );
#
# %keyTrans = (
#     "Diethelm" => "Unknown",
#     "Meier"    => "Rothlin-Meier",
#     "Friedlos" => "",
#     "Nop"      => "NICHTS",
# );
#
# %resultHash = (
#    "Rothlin"     => "Walter",
#    "Collet"      => "Claudia",
#    "Friedlos"    => "",
#    "Meier"       => "Rothlin-Meier",
#    "Diethelm"    => "Unknown",
#   
# );
#
# Call:  %resultHash = translateHashKeys(\%inHash,\%keyTrans);
sub translateHashValues {
  my($refToHashInHash,$refToTransHash) = @_;
  my(%inHash)      = derefHref($refToHashInHash);
  my(%transHash)   = derefHref($refToTransHash);
  
  ## printf("\ninHash....\n");
  ## displayHashTable(%inHash);
  ## printf("\ntransHash....\n");
  ## displayHashTable(%transHash);
  my(%retHash) = ();   
    
  my(@keysInHash)   = keys %inHash;
  foreach my $aInKey (@keysInHash) {
     if (exists($transHash{$aInKey})) {
     	 my $newValue = $transHash{$aInKey};
         %retHash = (%retHash,($aInKey,$newValue));	
     } else {
         %retHash = (%retHash,($aInKey,$inHash{$aInKey}));	
     }
  }
  ## printf("\nretHash....\n");
  ## displayHashTable(%retHash);
  return %retHash;
}
    
# returns a sorted list of keys for an hash where the values are numbers
# e.g.   Walter => 5
#        Heidi  => 8
#        Kurt   => 6
# returns ("Heidi","Kurt","Walter")
sub getKeyListForSortedValuesInHash {
   my($reverseOrder,%inHash)  = @_;
   my(@retKeys) = ();
   my(@keys)    = (); @keys = keys %inHash;
   my(%tmpHash) = ();
   my($key)     = "";
   # first make a hash like
   #  005:001 => Walter
   #  008:002 => Heidi
   #  006:003 => Kurt
   my($count)   = 0;
   foreach $key (@keys) {
      my($newKey) = sprintf("%s:%s",paddenNull($inHash{$key},"15","0"),paddenNull($count,"15","0"));
      %tmpHash = (%tmpHash,($newKey,$key));
      $count++;
   }

   @keys = keys %tmpHash;
   if ($reverseOrder) {
      foreach $key (reverse(sort @keys)) {
        push(@retKeys,$tmpHash{$key});
      }
   } else {
      foreach $key (sort @keys) {
        push(@retKeys,$tmpHash{$key});
      }
   }
   return @retKeys;
}

sub getSortedKeysFromHashUsingValueAsChainElements {
  my($sepStr,%inHash) = @_;
  my(@retArray) = ();
  my(@allKeys) = sort(keys %inHash);
  my $countOfKeys = @allKeys;
  ### printf("countOfKeys:${countOfKeys}:\n");

  foreach my $aKey (@allKeys) {
    ### printf("aKey:${aKey}:\n");
    next if (foundInArray($aKey,@retArray));
    next if ($inHash{$aKey} eq "0");
    @retArray = concatArray(@retArray,getChainFor($aKey,$sepStr,%inHash));
    ### displayArray(@retArray);
    ### print("----> 1:");halt();
  }

  ### printf("Delete only\n");

  foreach my $aKey (@allKeys) {
    ### printf("aKey:${aKey}:\n");
    next if (foundInArray($aKey,@retArray));
    push(@retArray,$aKey);
    push(@retArray,$sepStr);
    ### displayArray(@retArray);
    ### print("----> 1:");halt();
  }
  return @retArray;
}


# %inputHash = (
#     3451862 => 0,
#     3454445 => 3458174,
#     3454460 => 0,
#     3454578 => 3458167,
#     3454631 => 3458155,
#     3458155 => 0,
#     3458167 => 3459014,
#     3458174 => 0,
#     3459014 => 0,
# );
#
# @dealNrs = getSortedKeysFromHashUsingValueAsChainElements("NewChain",%inputHash);
#
# @dealNrs =  (
#     3454445,
#     3458174,
#     NewChain,
#     3454578,
#     3458167,
#     3459014,
#     NewChain,
#     3454631,
#     3458155,
#     NewChain,
#     3451862,
#     3454460
# );

sub getChainFor {
  my($startKey,$sepStr,%chain) = @_;
  my(@retArray) = ();
  push(@retArray,$startKey);
  while ($chain{$startKey} ne "0") {
     if (exists($chain{$startKey})) {
        $startKey = $chain{$startKey};
        push(@retArray,$startKey);
     } else {
        printf("WARNING: DealNum ${startKey} not found\n");
        last;
     }
  }
  ### displayArray(@retArray);
  if ($sepStr ne "") {
    push(@retArray,$sepStr);
  }
  ### print("-->2:");halt();
  return @retArray;
}

# sorted by values
sub getAllValuesFromHash_AsArray {
     my($doSort,%inHash) = @_;
     my(@retList) = ();
     my(@listKeys) = ();
     @listKeys = keys %inHash;
     my($aKey) = "";
     foreach $aKey (@listKeys) {
        push(@retList,$inHash{$aKey});
     }
     if ($doSort) {
       @retList = sort @retList;
     }
     return @retList;
}

# sorted by key
sub getAllValuesSortedFromHash_AsArray {
	my($doSort,%inHash) = @_;
	my @retList = ();
	my @listKeys = keys %inHash;
	# print("In getAllValuesSortedFromHash_AsArray\n");
	# print("HashTable:\n");displayHashTable(%inHash);
	# print("Keys     :\n");displayArray(@listKeys);

	if ($doSort) {
		foreach my $aKey (sort @listKeys) {
			push(@retList,$inHash{$aKey});
		}
	} else {
		foreach my $aKey (@listKeys) {
			push(@retList,$inHash{$aKey});
		}
	}
	# print("Result     :\n");displayArray(@retList);
	return @retList;
}

# Input:
# %inHash   0 => "Walti",
#           1 => "1960",
#           2 => "Peterliwiese 33",
# $delimiter = "|"
# $quoteStr  = "\"";
#
# Result:
# "Walti"|"1960"|"Peterliwiese 33"
sub getAllValuesFromHash_AsString {
     my($delimiter,$quoteStr,$doSort,%inHash) = @_;
     my($retStr) = "";
     my(@list) = getAllValuesFromHash_AsArray($doSort,%inHash);
     $retStr = makeQuotedStrFromArray($delimiter,$quoteStr,@list);
     return $retStr;
}


sub getAllKeysFromHash_AsArray {
     my($doSort,%inHash) = @_;
     my(@retList) = ();
     @retList = keys %inHash;
     if ($doSort) {
       @retList = sort @retList;
     }
     return @retList;
}

# Input:
# %inHash   0 => "Walti",
#           1 => "1960",
#           2 => "Peterliwiese 33",
# $delimiter = "|"
# $quoteStr  = "\"";
#
# Result:
# "0"|"1"|"2"
sub getAllKeysFromHash_AsString {
     my($delimiter,$quoteStr,$doSort,%inHash) = @_;
     my($retStr) = "";
     my(@list) = getAllKeysFromHash_AsArray($doSort,%inHash);
     $retStr = makeQuotedStrFromArray($delimiter,$quoteStr,@list);
     return $retStr;
}

sub addDelimitersAroundHashKeys {
  my($leftDel,$rightDel,%inHash) = @_;
  my(%outHash) = ();
  my(@allKeys) = (); @allKeys = keys %inHash;

  foreach my $aKey (@allKeys) {
    %outHash = (%outHash,("${leftDel}${aKey}${rightDel}",$inHash{$aKey}));
  }
  return %outHash;
}


sub writeHashToFlatFile {
	my($filename,$delimiter,$keyFieldTitle,$valueFieldTitle,$hashFieldTitle,$sortedByKey,%aHash) = @_;
	if ($delimiter ne ";") {
		$delimiter = "\|";
	}
	my @allKeys = keys %aHash;
	if ($sortedByKey) {
	  @allKeys = sort(@allKeys);
	}
	open(OUTF_writeHashToFlatFile,">${filename}") || showError(sprintf("ERROR (writeHashToFlatFile): Can't open outfile: %s : %s",$filename,$!));
	print(OUTF_writeHashToFlatFile "${hashFieldTitle}${delimiter}${keyFieldTitle}${delimiter}${valueFieldTitle}\n");
	my $aKey = "";
	my $hashCounter = 1;
	foreach $aKey (@allKeys) {
		my($aValue) = $aHash{$aKey};
		$aValue =~ s/\n/\<BR\>/g;
		print(OUTF_writeHashToFlatFile "${hashCounter}${delimiter}${aKey}${delimiter}$aValue\n");
		$hashCounter++;
	}
	close(OUTF_writeHashToFlatFile);
}


# writes a hash to a flat file as one record
# e.g.
#  %record = (
#      "FirstName" => "Walti",
#      "Name"      => "Rothlin",
#      "PLZ"       => "8855",
#   );
#  
#  @nameOrder = ("PLZ","Name","FirtsName");
#
#   writeRecordHashToFile_fh($fh,"\\|",$refOutRecordHash,@nameOrder);
#   --> 8855|Rothlin|Walti
#
sub writeRecordHashToFile_fh {
	my($fh,$delimiter,$refOutRecordHash,@nameOrder) = @_;
	my $first    = $TRUE;
	my $oLine_1  = "";
	my $aVarName = "";
	foreach $aVarName (@nameOrder) {
		if ($first) {
			$first = $FALSE;
			$oLine_1 = sprintf("%s",$refOutRecordHash->{$aVarName});
		} else {
			$oLine_1 = sprintf("${oLine_1}${delimiter}%s",$refOutRecordHash->{$aVarName});
		}
	}
	print($fh "${oLine_1}\n");
}

sub writeRecordHashToFile {
	my($filename,$delimiter,$refOutRecordHash,@nameOrder) = @_;
	open(OUTPUT_writeRecordHashToFile, ">> $filename") || die "Error (writeRecordHashToFile):Can't append open $filename: $!\n"; 
	writeRecordHashToFile_fh(OUTPUT_writeRecordHashToFile,$delimiter,$refOutRecordHash,@nameOrder);
	close OUTPUT_writeRecordHashToFile;
}

# writes global variables to a flat file
# e.g.
#  
#  $REC1_PLZ       = "8855";
#  $REC1_FIRSTNAME = "Walti";
#  $REC1_NAME      = "Rothlin";
#  @nameOrder = ("PLZ","Name","FirstName");
#
#   writeGlobalsToFile_fh($fh,"\\|","REC1_",$TRUE,@nameOrder);
#   --> 8855|Rothlin|Walti
#
sub writeGlobalsToFile_fh {
	my($fh,$delimiter,$varPrefix,$globalsAreUppercase,@nameOrder) = @_;
	my $first      = $TRUE;
	my $oLine_1    = "";
	my $aVarName   = "";
	foreach $aVarName (@nameOrder) {
		my $globalVarName  = sprintf("${varPrefix}%s",uc($aVarName));
		my $globalVarValue = $$globalVarName;
		if ($first) {
			$first = $FALSE;
			$oLine_1 = $globalVarValue;
		} else {
			$oLine_1 = "${oLine_1}${delimiter}${globalVarValue}";
		}
	}
	print($fh "${oLine_1}\n");
}

sub writeGlobalsToFile {
	my($filename,$delimiter,$varPrefix,$globalsAreUppercase,@nameOrder) = @_;
	open(OUTPUT_writeGlobalsToFile, ">> $filename") || die "Error (writeGlobalsToFile):Can't append open $filename: $!\n"; 
	writeGlobalsToFile_fh(OUTPUT_writeGlobalsToFile,$delimiter,$varPrefix,$globalsAreUppercase,@nameOrder);
	close OUTPUT_writeGlobalsToFile;
}

# IN:
# %notifyGeburiList = (
#   "Hans Muster"  => "23-Jan-04 Felix Muster (70);24-Jan-04 Mir Egal (67)"
#   "Kurt Muster"  => "23-Jan-04 Felix Muster (70);24-Jan-04 Mir Egal (67)"
# )
#
# addrFile:
#   Name|notifAddrs|
#   Kurt Muster|xxxxx1.yyyyyyy@zzzz.ww;079 xxx yy zz|
#   Hans Muster|xxxxx2.yyyyyyy@zzzz.ww;078 xxx yy zz|
#
# %return = (
#    "xxxxx1.yyyyyyy@zzzz.ww,079 xxx yy zz"	=> "23-Jan-04 Felix Muster (70);24-Jan-04 Mir Egal (67)"
#    "xxxxx2.yyyyyyy@zzzz.ww,078 xxx yy zz"	=> "23-Jan-04 Felix Muster (70);24-Jan-04 Mir Egal (67)"
# )
sub prepareMsgHashFromNotifyHash {
   my($addrFile,$notifyGeburiListRef,$adrNameFN,$natelNotifyFN,$emailNotifyFN) = @_;

   $adrNameFN      = setDefault($adrNameFN,     "UserId");
   $natelNotifyFN  = setDefault($adrNotifyFN,   "NATEL");
   $emailNotifyFN  = setDefault($emailNotifyFN, "Email");

   my %notifyGeburiList = %$notifyGeburiListRef;
   ### displayHashTable(%notifyGeburiList);

   my @records = getAllMatchesFromFltFileAsHashes($addrFile);
   foreach my $record (@records) {
   	
      my $notifyDest = $record->{$natelNotifyFN}.",".$record->{$emailNotifyFN};
      $notifyDest =~ s/^,//g;
      $notifyDest =~ s/,$//g;
      %addrrHash = (%addrrHash,($record->{$adrNameFN},$notifyDest));
   }
   ### displayHashTable(%addrrHash);

   my %retHash = ();
   %retHash = combineTwoHashes(\%addrrHash,\%notifyGeburiList);
   return %retHash;
}




# IN: (UNIX Date today is Jan 23, 2004
#  Datum|Name|Notify|
#  0102|Fritz Muster (44)|Mir Egal;Schnurz Wurst|
#  0123|Bita Muster (70)|Mir Egal;Schnurz Wurst|
#  0124|Thomas Muster (67)|Mir Egal;Schnurz Wurst|
#  0202|Hans Muster (56)||
#  0202|Emanuel Muster (65)||
#  0220|Weiqing Muster (59)||
#
# %return = (
#   "Schnurz Wurst"	=> "23-Jan-04 Bita Muster (70);24-Jan-04 Thomas Muster (67)"
#   "Mir Egal" 		=> "23-Jan-04 Bita Muster (70);24-Jan-04 Thomas Muster (67)"
# )
sub getCalendarEntriesInTimeIntervalUsingFiles {
   my($geburiFile,$startDate,$endDate,$delimStr,$outDateFormat,$gebDatumFN,$gebNameFN,$gebNotifyFN) = @_;
   my $todayDateStr  = substr(getTimeStamp(),0,8);

   $gebDatumFN  = setDefault($gebDatumFN, "Datum");
   $gebNameFN   = setDefault($gebNameFN,  "Name");
   $gebNotifyFN = setDefault($gebNotifyFN,"Notify");


   $daysInAdvance = setDefault($daysInAdvance,0);
   $startDate     = setDefault($startDate,$todayDateStr);
   $endDate       = setDefault($endDate,daysAddToYYYYMMDD($startDate+2));
   if ($startDate > $endDate) { 
     my $tmpDate = $startDate;
     $startDate  = $endDate;
     $endDate    = $tmpDate;
   }
   my $dateInCalendarInclYear = $TRUE;
   ### print("startDate:${startDate}:  endDate:${endDate}:\n");

   $delimStr      = setDefault($delimStr,";");
   $outDateFormat = setDefault($outDateFormat,"DD-Mmm-YY");


   my @records = getAllMatchesFromFltFileAsHashes($geburiFile);
   my @calendarKey = ();
   my %aCalendar   = ();
   my %notifyTable = ();
   foreach my $record (@records) {
         push(@calendarKey,$record->{$gebDatumFN});
         %aCalendar = (%aCalendar,($record->{$gebDatumFN},$record->{$gebNameFN}));
         %notifyTable = (%notifyTable,($record->{$gebNameFN},$record->{$gebNotifyFN}));
   }

   ### print("\notifyTable...\n");
   ### displayHashTable(%notifyTable);

   ### print("\calendar...\n");
   ### displayHashTable(%aCalendar);

   ### print("\calendarKey...\n");
   ### displayArray(@calendarKey);

   if (length($calendarKey[0]) < 8) {
     $dateInCalendarInclYear = $FALSE;
   }


   my(@datesInQuestion) = ();
   my $tmpDate = $startDate;
   do {
       push(@datesInQuestion,$tmpDate);
       $tmpDate = daysAddToYYYYMMDD($tmpDate+1);
   } until ($tmpDate > $endDate);

   ### print("\ndatesInQuestion...\n");
   ### displayArray(@datesInQuestion);

   my %notifyHash = ();
   foreach my $aDateWithYear (@datesInQuestion) {
     my $aCalendarKey = $aDateWithYear;
     if (!($dateInCalendarInclYear)) {
        $aCalendarKey = substr($aCalendarKey,4,4);
     }
     $aCalendarVal = $aCalendar{$aCalendarKey};
     if ($aCalendarVal ne "") {
        my $formatedDateStr = $aDateWithYear;
        $formatedDateStr = formatYYYYMMDD($aDateWithYear,$outDateFormat,$language,"","");

        my $toAddrsses = $notifyTable{$aCalendarVal};

        my(@toAdrList) = split($delimStr,$toAddrsses);
        foreach my $singletoAdr (@toAdrList) {
          ### print("singletoAdr:${singletoAdr}:  aCalendarVal:${aCalendarVal}:\n");
          if (exists($notifyHash{$singletoAdr})) {
              $notifyHash{$singletoAdr} = $notifyHash{$singletoAdr}.";${formatedDateStr} ${aCalendarVal}";
          } else {
              %notifyHash = (%notifyHash,($singletoAdr,"${formatedDateStr} ${aCalendarVal}"));
          }
        }
     }
   }
   return %notifyHash;
}

############################################################################
# Function for manipulating arrays
############################################################################
sub removeCRFromArrayEntries {
	my @inArray  = @_;
	my @outArray = ();
	foreach my $aEntry (@inArray) {
		$aEntry = removeCR($aEntry);
		push(@outArray,$aEntry);
	}
	return @outArray;
}

sub chompArrayEntries {
	my @inArray  = @_;
	my @outArray = ();
	foreach my $aEntry (@inArray) {
		chomp($aEntry);
		push(@outArray,$aEntry);
	}
	return @outArray;
}

sub doNumericSortArray {
	my(@inArray) = @_;
	return (sort { $a <=> $b } @inArray);
}

sub doAlphabeticalSortArray {
	my(@inArray) = @_;
	return (sort @inArray);
}

sub doTest_getMultipleEntriesFromArray {
   my($myFullName,$debugThisFct) = @_;

   $debugThisFct = setDefault($debugThisFct,$FALSE);

   # ------------------------------------------------------------
   my(@testCase1) = (
      "Walti",
      "Claudia",
      "Tobias",
      "Lukas",
      "Michaela",
      "Daniela",
   );
 
   my(@resSoll_1) = ();

   my @resIst_1    = getMultipleEntriesFromArray($TRUE,@testCase1);
   if ($debugThisFct) {
      displayArray(@resIst_1);
   }
   if (!(areArraysEqual(\@resIst_1,\@resSoll_1,$TRUE,$TRUE))) {
       print("ERROR: ${myFullName} failed (A)\n");
   }

   @resIst_1    = getMultipleEntriesFromArray($FALSE,@testCase1);
   if ($debugThisFct) {
      displayArray(@resIst_1);
   }
   if (!(areArraysEqual(\@resIst_1,\@resSoll_1,$TRUE,$TRUE))) {
       print("ERROR: ${myFullName} failed (B)\n");
   }
  
   # ------------------------------------------------------------
   my(@testCase2) = (
      "Walti",
      "Claudia",
      "Tobias",
      "Lukas",
      "Walti",
      "Daniela",
   );
 
   my(@resSoll_2) = ("Walti");

   my @resIst_2    = getMultipleEntriesFromArray($TRUE,@testCase2);
   if ($debugThisFct) {
      displayArray(@resIst_2);
   }
   if (!(areArraysEqual(\@resIst_2,\@resSoll_2,$TRUE,$TRUE))) {
       print("ERROR: ${myFullName} failed (C)\n");
   }

   @resIst_2    = getMultipleEntriesFromArray($FALSE,@testCase2);
   if ($debugThisFct) {
      displayArray(@resIst_2);
   }
   if (!(areArraysEqual(\@resIst_2,\@resSoll_2,$TRUE,$TRUE))) {
       print("ERROR: ${myFullName} failed (D)\n");
   }

   # ------------------------------------------------------------
   my(@testCase3) = (
      "Walti",
      "Claudia",
      "Tobias",
      "Lukas",
      "WALTI",
      "Daniela",
   );
 
   my(@resSoll_3) = ("WALTI");

   my @resIst_3    = getMultipleEntriesFromArray($TRUE,@testCase3);
   if ($debugThisFct) {
      displayArray(@resIst_3);
   }
   if (!(areArraysEqual(\@resIst_3,\@resSoll_1,$TRUE,$TRUE))) {
       print("ERROR: ${myFullName} failed (E)\n");
   }

   @resIst_3    = getMultipleEntriesFromArray($FALSE,@testCase3);
   if ($debugThisFct) {
      displayArray(@resIst_3);
   }
   if (!(areArraysEqual(\@resIst_3,\@resSoll_3,$TRUE,$TRUE))) {
       print("ERROR: ${myFullName} failed (F)\n");
   }
}

sub getMultipleEntriesFromArray {
	my($caseSensitve,@inList) = @_;
	my @retList = ();
	my @tmpList = ();

	foreach my $aItem (@inList) {
		if (!(foundInArrayWithCase($aItem,$caseSensitve,@tmpList))) {
			push(@tmpList,$aItem);
		} else {
			push(@retList,$aItem);
		}
	}
	return @retList;
}

sub makeArrayEntriesDistinct {
	my($eliminateEmptyLines,@inList) = @_;
	return makeArrayEntriesDestinct($eliminateEmptyLines,@inList);
}

# wrong spelling of Distinct!!! Use fct makeArrayEntriesDistinct
sub makeArrayEntriesDestinct {
	my($eliminateEmptyLines,@inList) = @_;

	# print("\n\nBBBBB3333333\n");displayArray(@inList);
	my @retList = ();
	foreach my $aItem (@inList) {
		# print("aItem:${aItem}:\n");

		if (!(($eliminateEmptyLines) && ($aItem eq ""))) {
			if (!(foundInArray($aItem,@retList))) {
				push(@retList,$aItem);
			}
		}
	}
	return @retList;
}

sub makeQuotedStrFromArray {
	my($delimStr,$quoteStr,@aList) = @_;
	my $retStr  = "";
	my $first   = $TRUE;
	foreach my $aItem (@aList) {
		if ($first) {
			$retStr = "${quoteStr}${aItem}${quoteStr}";
			$first  = $FALSE;
		} else {
			$retStr = "${retStr}${delimStr}${quoteStr}${aItem}${quoteStr}";
		}
	}
	return $retStr;
}

sub doTest_makeQuotedStrFromArrayElements {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my(@testCase1) = (
      "Walti",
      "Claudia",
      "Tobias",
      "Lukas",
      "Michaela",
      "Daniela",
   );
 
   my $resIst    = "";
   my $resSoll_1 = "'Walti','Claudia','Tobias','Lukas','Michaela','Daniela'";
   my $resSoll_2 = "'Claudia','Tobias','Lukas'";

   $resIst    = makeQuotedStrFromArrayElements(",","'","","",@testCase1);
   if ($resSoll_1 ne $resIst) {
       print("ERROR: ${myFullName} failed (A)\n");
   }
   if (($resSoll_1 ne $resIst) || ($debugThisFct)) {
       print("  Result:${resIst}:\n");
       print("  Expect:${resSoll_1}:\n");
   }

   $resIst    = makeQuotedStrFromArrayElements(",","'","1","3",@testCase1);
   if ($resSoll_2 ne $resIst) {
       print("ERROR: ${myFullName} failed (B)\n");
   }
   if (($resSoll_2 ne $resIst) || ($debugThisFct)) {
       print("  Result:${resIst}:\n");
       print("  Expect:${resSoll_2}:\n");
   }

}

sub makeQuotedFormatedStrFromArrayElements {
	my($delimStr,$quoteStr,$fromIndex,$toIndex,$countOfElemntsPerLine,$lineEnd,$indent,@aList) = @_;
	$fromIndex  = setDefault($fromIndex,0);
	$anzElements = @aList;
	$toIndex     = setDefault($toIndex  ,$anzElements-1);

	if ($fromIndex < 0)               { $fromIndex = 0; }
	if ($toIndex   > $anzElements -1) { $toIndex = $anzElements-1; }

	my $retStr  = "";
	my $aItem   = "";
	my $first   = $TRUE;
	my $countPerLine = 0;

	for (my $i =$fromIndex;$i <= $toIndex; $i++) {
		$countPerLine = $countPerLine + 1;
		if ($first) {
			$retStr = "${quoteStr}".$aList[$i]."${quoteStr}";
			$first  = $FALSE;
		} else {
			$retStr = "${retStr}${delimStr}${quoteStr}".$aList[$i]."${quoteStr}";
		}
		if ($countPerLine >= $countOfElemntsPerLine) {
			if ($i < $toIndex) {
				$retStr = $retStr.$lineEnd."\n".$indent;
				$countPerLine = 0;
			}
		}
	}
	return $retStr;
}

# bug fix 20030826:
#    old: for (my $i =$fromIndex;$i <= $toIndex; $i++)
#
sub makeQuotedStrFromArrayElements {
	my($delimStr,$quoteStr,$fromIndex,$toIndex,@aList) = @_;
	$fromIndex = setDefault($fromIndex,0);
	$anzElements = @aList;
	$toIndex   = setDefault($toIndex  ,$anzElements-1);

	if ($fromIndex < 0)               { $fromIndex = 0; }
	if ($toIndex   > $anzElements -1) { $toIndex = $anzElements-1; }

	my $retStr  = "";
	my $aItem   = "";
	my $first   = $TRUE;

	for (my $i =$fromIndex;$i <= $toIndex; $i++) {
		if ($first) {
			$retStr = "${quoteStr}".$aList[$i]."${quoteStr}";
			$first  = $FALSE;
		} else {
			$retStr = "${retStr}${delimStr}${quoteStr}".$aList[$i]."${quoteStr}";
		}
	}
	return $retStr;
}

sub makeStrFromArray {
	my($delimStr,@aList) = @_;
	my $retStr = "";
	foreach my $aItem (@aList) {
		if ($retStr eq "") {
			$retStr = $aItem;
		} else {
			$retStr = "${retStr}${delimStr}${aItem}";
		}
	}
	return $retStr;
}

sub concatArrayOptimized {
	my(@aList,@bList) = @_;
	return (@aList,@bList);
}

sub concatArray {
  my(@aList,@bList) = @_;
  my(@retList)  = ();
  my($listItem) = "";
  foreach $listItem (@aList) {
     push(@retList,$listItem);
  }
  foreach $listItem (@bList) {
     push(@retList,$listItem);
  }
  return @retList;
}

sub doTest_concatArrayEntries {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my(@arrA) = (
     "Walti",
     "Claudia",
     "Franz",
   );


   my(@arrB) = (
     "Rothlin",
     "Collet",
     "Hager",
   );

   my(@resSoll) = (
     "Walti Rothlin",
     "Claudia Collet",
     "Franz Hager",
   );

   my(@resIst) = concatArrayEntries(\@arrA,\@arrB," ");
   if ($debugThisFct) {
      displayArray(@resIst);
   }
   if (!(areArraysEqual(\@resIst,\@resSoll,$TRUE,$TRUE))) {
       print("ERROR: ${myFullName} failed (A)\n");
   }
}

sub concatArrayEntries {
   my($arr1Ref,$arr2Ref,$sepStr,$startStr,$endStr) = @_;
   my(@retArr) = ();

   my $count = @$arr1Ref;
   for (my $i=0; $i<$count; $i++) {
     push(@retArr,"${startStr}".$arr1Ref->[$i]."${sepStr}".$arr2Ref->[$i]."${endStr}");
   }
   return @retArr;
}


sub doTest_areArraysEqual {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my(@arrA) = (
     "Walti",
     "Claudia",
     "Franz",
   );


   my(@arrB) = (
     "Walti",
     "Franz",
     "Claudia",
   );

   my(@arrC) = (
     "Walti",
     "Claudia",
     "Franz",
   );

   my(@arrD) = (
     "Walti",
     "Franz",
     "Claudia",
   );

   my(@arrE) = (
     "WALTI",
     "franz",
     "ClAuDiA",
   );

   if (!(areArraysEqual(\@arrA,\@arrB,$FALSE,$TRUE))) {
       print("ERROR: ${myFullName} failed (A)\n");
   }
   if (areArraysEqual(\@arrA,\@arrB,$TRUE,$TRUE)) {
       print("ERROR: ${myFullName} failed (B)\n");
   }
   if (!(areArraysEqual(\@arrA,\@arrC,$TRUE,$TRUE))) {
       print("ERROR: ${myFullName} failed (C)\n");
   }
   if (!(areArraysEqual(\@arrA,\@arrC,$FALSE,$TRUE))) {
       print("ERROR: ${myFullName} failed (D)\n");
   }
   if (!(areArraysEqual(\@arrD,\@arrE,$FALSE,$FALSE))) {
       print("ERROR: ${myFullName} failed (E)\n");
   }
   if (!(areArraysEqual(\@arrD,\@arrE,$TRUE,$FALSE))) {
       print("ERROR: ${myFullName} failed (F)\n");
   }

}

sub areArraysEqual {
  my($refSetA,$refSetB,$orderIsRelevant,$caseSensitve) = @_;
  $orderIsRelevant = setDefault($orderIsRelevant,$TRUE);
  $caseSensitve    = setDefault($caseSensitve,$TRUE);

  my(@setA)  = @$refSetA;
  my(@setB)  = @$refSetB;
  my $countSetA  = @setA;
  my $countSetB  = @setB;
  if ($countSetA != $countSetB) {
    return $FALSE;
  }

  my $i = 0;
  foreach my $elemA (@setA) {
    if ($orderIsRelevant) {
       if ($caseSensitve) {
         if ($setB[$i] ne $elemA) {
           return $FALSE;
         }
       } else {
         if (uc($setB[$i]) ne uc($elemA)) {
           return $FALSE;
         }
       }
    } else {
       if (!(foundInArrayWithCase($elemA,$caseSensitve,@setB))) {
         return $FALSE;
       }
    }
    $i++;
  }
  return $TRUE;
}

sub isOnePatternMatchesString {
  my($string,@patterns) = @_;
  foreach my $aPattern (@patterns) {
  	 ## print("Checking if Pattern :${aPattern}: is in String:${string}:\n");
  	 if (index($string,$aPattern) != -1) {
  	 	  return $TRUE;
  	 }
  }
  return $FLASE;
}

sub foundInArray {
	my($aValue,@myArray) = @_;
	my $retVal  = $FALSE;

	foreach my $element (@myArray) {
		if ($element eq $aValue) {
			$retVal = $TRUE;
			last;
		}
	}
	return foundInArrayWithCase($aValue,$TRUE,@myArray);
}

sub filterArrayWithRegEx {
	my($aRegEx,@myArray) = @_;
	my @retList = ();

	foreach my $element (@myArray) {
		# print("element:${element}:     aRegEx:${aRegEx}:");
		if ($element =~ /$aRegEx/) {
			# print("    matches!!!!");
			push(@retList,$element);
		}
		# print("\n");
	}
	return @retList;
}

sub foundInArrayWithCase {
  my($aValue,$caseSensitve,@myArray) = @_;
  $caseSensitve = setDefault($caseSensitve,$TRUE);

  my($retVal)  = $FALSE;
  my($element) = "";
  if ($caseSensitve) {
    foreach $element (@myArray) {
     if ($element eq $aValue) {
       $retVal = $TRUE;
       last;
     }
    }
  } else {
    foreach $element (@myArray) {
     if (uc($element) eq uc($aValue)) {
       $retVal = $TRUE;
       last;
     }
    }
  }
  return $retVal;
}

sub doTest_isArrayEmty {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my(@notEmtyList) = ("Walti","Claudia");
   my(@emptyList)   = ();


   if (!(isArrayEmty(@emptyList))) {
       print("ERROR: ${myFullName} failed (A)\n");
   }
   if (isArrayEmty(@notEmtyList)) {
       print("ERROR: ${myFullName} failed (B)\n");
   }

}

sub isArrayEmty {
	my(@aArr) = @_;
	my $count = @aArr;
	if ($count == 0) {
		return $TRUE;
	} else {
		return $FALSE;
	}
}

sub getElementIndexInArray {
	my($aValue,@myArray) = @_;
	my $retVal  = $FALSE;
	my $pos     = 0;
  
	foreach my $element (@myArray) {
		if ($element eq $aValue) {
			return $pos;
		} else {
			$pos++;	
		}
	}
}

sub getArrayElement {
	my($indexStartWithZero,$outOfRangeStr,@aArray) = @_;
	my $countOfElements = @aArray;
	if (($indexStartWithZero < 0) || ($indexStartWithZero >= $countOfElements)) {
		return $outOfRangeStr;
	} else {
		return $aArray[$indexStartWithZero];
	}
}

sub getArrayElements {
	my($reqIndexes, $outOfRangeStr, $startIndex, @aArray) = @_;
	$outOfRangeStr       = setDefault($outOfRangeStr,    "ERROR getArrayElements:INDEX OUT OF RANGE");
	$startIndex          = setDefault($startIndex,       0);
	
	my $debug = $FALSE;
	
	if ($debug) {
		print("in getArrayElements...\n");
		print("reqIndexes   :${reqIndexes}:\n");
		print("outOfRangeStr:${outOfRangeStr}:\n");
		print("startIndex   :${startIndex}:\n");
		print("  arrayContent:\n");
		displayArray(@aArray);
		halt();
	}
	my @retVal = ();
	my @listOfIndexes = split(";",$reqIndexes);
	foreach my $anIndex (@listOfIndexes) {
		if ($debug) { print("  ${anIndex} - ${startIndex} "); }
		my $aVal = getArrayElement($anIndex - $startIndex,$outOfRangeStr,@aArray);
		if ($aVal ne $outOfRangeStr) {
			if ($debug) { print("  --> ${aVal}"); }
			push(@retVal,$aVal);
		}
		if ($debug) { print("\n"); }
	}
	if ($debug) { 
		print("  retVal:\n");
		displayArray(@retVal);
		halt();
	}
	return @retVal;
}

sub getLastArrayElement {
	my(@aArray) = @_;
	my $countOfElements = @aArray;
	return $aArray[$countOfElements-1];
}

# returns the max value (numbers) of an array
sub getMaxValFromArray {
	my(@inArray)  = @_;
	my $maxVal   = "";

	foreach my $aElement (@inArray) {
		if ($maxVal eq "") {
			$maxVal = $aElement;
		} else {
			if ($aElement > $maxVal) {
				$maxVal = $aElement;
			}
		}
	}
	return $maxVal;
}

# returns the min value (numbers) of an array
sub getMinValFromArray {
	my(@inArray)  = @_;
	my $minVal   = "";
	foreach my $aElement (@inArray) {
		if ($minVal eq "") {
			$minVal = $aElement;
		} else {
			if ($aElement < $minVal) {
				$minVal = $aElement;
			}
		}
	}
	return $minVal;
}

# returns the max value (strings) of an array
sub getLongestValFromArray {
	my(@inArray)  = @_;
	my $maxVal   = "";
	foreach my $aElement (@inArray) {
		if ($maxVal eq "") {
			$maxVal = $aElement;
		} else {
			if (length($aElement) > length($maxVal)) {
				$maxVal = $aElement;
			}
		}
	}
	return $maxVal;
}

# returns the min value (strings) of an array
sub getShortestValFromArray {
	my(@inArray)  = @_;
	my $minVal  = "";
	foreach my $aElement (@inArray) {
		if ($minVal eq "") {
			$minVal = $aElement;
		} else {
			if (length($aElement) < length($minVal)) {
				$minVal = $aElement;
			}
		}
	}
	return $minVal;
}


sub selectFromArray {
	my($pattern,$caseSensitive,@inArray) = @_;
	my @retArray     = ();
	my @patternParts = split(";",$pattern);

	## print("selectFromArray::   pattern      :${pattern}\n");
	## print("selectFromArray::   caseSensitive:${caseSensitive}\n");
	my $aEntry = "";
	foreach $aEntry (@inArray) {
		my @patternParts = split(";",$pattern);
		foreach my $aPatternPart (@patternParts) {
			## print("selectFromArray::   aPatternPart (1):${aPatternPart}\n");
			## print("selectFromArray::   aEntry          :${aEntry}\n");
			if ($caseSensitive) {
				if ($aEntry =~ $aPatternPart) {
					## print("selectFromArray::   ======> matches\n");
					push(@retArray,$aEntry);
				}
			} else {
				my $locVal = lowerCase($aEntry);
				my $locPat = lowerCase($aPatternPart);
				if ($locVal =~ $locPat) {
					push(@retArray,$aEntry);
				}
			}
			## print("\n");
		}
	}
	return @retArray;
}

sub doTest_getSubsetFromArray {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my(@mainList) = (
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
   );


   my(@expectedResult_1) = (
    "0",
    "1",
    "2",
    "3",
    "4",
   );

   my(@expectedResult_2) = (
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
   );

   my(@unexpectedResult) = (

   );

   my (@result) = getSubsetFromArray(0,4,@mainList);
   if($debugThisFct) {print("Test case A\n"); displayArray(@result); }

   if (!(areArraysEqual(\@result,\@expectedResult_1,$FALSE))) {
       print("ERROR: ${myFullName} failed (A)\n");
   }

   @result = getSubsetFromArray(4,0,@mainList);
   if($debugThisFct) {print("Test case B\n"); displayArray(@result); }
   if (!(areArraysEqual(\@result,\@expectedResult_1,$FALSE))) {
       print("ERROR: ${myFullName} failed (B)\n");
   }

   @result = getSubsetFromArray(-10,4,@mainList);
   if($debugThisFct) {print("Test case C\n"); displayArray(@result); }
   if (!(areArraysEqual(\@result,\@expectedResult_1,$FALSE))) {
       print("ERROR: ${myFullName} failed (C)\n");
   }

   @result = getSubsetFromArray(5,10,@mainList);
   if($debugThisFct) {print("Test case D\n"); displayArray(@result); }
   if (!(areArraysEqual(\@result,\@expectedResult_2,$FALSE))) {
       print("ERROR: ${myFullName} failed (D)\n");
   }

   @result = getSubsetFromArray(12,5,@mainList);
   if($debugThisFct) {print("Test case E\n"); displayArray(@result); }
   if (!(areArraysEqual(\@result,\@expectedResult_2,$FALSE))) {
       print("ERROR: ${myFullName} failed (E)\n");
   }

   @result = getSubsetFromArray(5,"",@mainList);
   if($debugThisFct) {print("Test case F\n"); displayArray(@result); }
   if (!(areArraysEqual(\@result,\@expectedResult_2,$FALSE))) {
       print("ERROR: ${myFullName} failed (F)\n");
   }

}

# returns an array containing the elements (including) $fromIndex to $toIndex starting from 0
sub getSubsetFromArray {
	my($fromIndex,$toIndex,@inArray) = @_;
	my $count = @inArray;
   
	$fromIndex   = setDefault($fromIndex,0);
	$toIndex     = setDefault($toIndex,$count-1);

	my @retArray = ();
	if ($fromIndex > $toIndex) {
		my $tmp = $fromIndex;
		$fromIndex = $toIndex;
		$toIndex   = $tmp;
	}
	if ($fromIndex < 0) { $fromIndex = 0; }
	if ($toIndex < 0) { $toIndex = 0; }
	if ($toIndex >= ($count - 1)) { $toIndex = $count - 1; }
 
	for ( my $i=$fromIndex; $i <= $toIndex; $i++) {
		push(@retArray,$inArray[$i]);
	}

	return @retArray;
}

sub removeEntriesFromArray {
	my($pattern,$caseSensitive,@inArray) = @_;
	my @retArray     = ();
	my @patternParts = split(";",$pattern);

	foreach my $aEntry (@inArray) {
		my @patternParts = split(";",$pattern);
		my $aPatternPart = "";
		foreach $aPatternPart (@patternParts) {
			if ($caseSensitive) {
				if (!($aEntry =~ $aPatternPart)) {
					push(@retArray,$aEntry);
				}
			} else {
				my $locVal = lowerCase($aEntry);
				my $locPat = lowerCase($aPatternPart);
				if (!($locVal =~ $locPat)) {
					push(@retArray,$aEntry);
				}
			}
		}
	}
	return @retArray;
}

sub removeElementByStringValueInArray {
	my($aValue,$compareCaseSensitve,@myArray) = @_;
	$compareCaseSensitve = setDefault($compareCaseSensitve,$TRUE);
	my @retArray  = ();
  
	if ($compareCaseSensitve) {
		foreach my $element (@myArray) {
			if ($element ne $aValue) {
				push(@retArray,$element);
			}
		}
	} else {
		foreach my $element (@myArray) {
			if (lc($element) ne lc($aValue)) {
				push(@retArray,$element);
			}
		}
	}
	return @retArray;
}

sub doTest_getSubsetFromArray {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);
   my @mainList = (
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "k",
   );
   
   my @resultatList = (
    "a",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "k",
   );
   
   
   
   my @result = removeElementByStringValueInArray("b","",@mainList);
   if($debugThisFct) {print("Test case A\n"); displayArray(@result); }

   if (!(areArraysEqual(\@result,\@resultatList,$TRUE))) {
       print("ERROR: ${myFullName} failed (A)\n");
   }
   
   @result = removeElementByStringValueInArray("B",$FALSE,@mainList);
   if($debugThisFct) {print("Test case B\n"); displayArray(@result); }

   if (!(areArraysEqual(\@result,\@resultatList,$TRUE))) {
       print("ERROR: ${myFullName} failed (B)\n");
   }
   
}

sub removeAnEntryFromArray {
	my($indexStartWithZero,@inArray) = @_;
	my @retArray = ();

	my $i = 0;
	foreach my $aEntry (@inArray) {
		if ($indexStartWithZero != $i) {
			push(@retArray,$aEntry);
		}
		$i++;
	}
	return @retArray;
}

sub addAnEntryToArray {
	my($indexStartWithZero, $newValue, @inArray) = @_;
	my @retArray = ();

	my $countOfElements = @inArray;
	if ($indexStartWithZero >= ($countOfElements - 1)) { 
		@retArray = @inArray;
		push(@retArray,$newValue);
	} else {
		if ($countOfElements == 0) {
			push(@retArray,$newValue);
		} else {
			my $i = 0;
			foreach my $aEntry (@inArray) {
				if ($indexStartWithZero == $i) {
					push(@retArray,$newValue);
				}
				push(@retArray,$aEntry);
				$i++;
			}
		}
	}
	return @retArray;
}

# returns a hash with x/y values given a array of record an
# the position (staring at 0) where x and y could be found
#
# e.g.
#  @recordArray = (
#        "walti|5.34|6.7|rothlin",
#        "claudia|7|6.7|collet",
#        "karin|6.9|7.4|meichtry",
#        "hans|22|12.56|rothlin",
#        "kurt|445|32|haerri",
#        "doug|78.9|41.23|kahn",)
# %points = preparePointsHashForInterpolation(1,2,"\\|",@recordArray);
# 
# return: %points = (
#        5.34 => 6.7,
#        7    => 6.7,
#        6.9  => 7.4,
#        22   => 12.56,
#        445  => 32,
#        78.9 => 41.23,)
sub preparePointsHashForInterpolation {
	my($xValPos,$yValPos,$delim,$silent,$errorMsg,@recordArray) = @_;
	$silent   = setDefault($silent,$FALSE);
	$errorMsg = setDefault($errorMsg,"WARNING:preparePointsHashForInterpolation:");
	my %points  = ();

	foreach my $aRecord (@recordArray) {
		chomp($aRecord);
		my @recordParts = split($delim,$aRecord);
		if (!($silent)) {
			if (exists($points{$recordParts[$xValPos]})) {
				printf("$errorMsg:%s is replaced by %s at %s\n",$points{$recordParts[$xValPos]},$recordParts[$yValPos],$recordParts[$xValPos]);
			}
		}
		%points = (%points,($recordParts[$xValPos],$recordParts[$yValPos]));
	}
	return %points;
}

sub trimArray {
	my (@array) = @_;
	my @stripped = ();
 
	foreach my $element (@array) {
		$element = strip($element);
		@stripped = (@stripped, $element);
	}
	return @stripped;
}

sub trimAndRemoveEmptiesInArray {
	my (@array) = @_;
	my @stripped = ();
 
	foreach my $element (@array) {
		$element = strip($element);
		if ($element ne "") {
			@stripped = (@stripped, $element);
		}
	}
	return @stripped;
}

sub trimRemoveEmptiesAndCommentsInArray {
	my (@array)  = @_;
	my @stripped = ();
 
	foreach my $element (@array) {
		$element = strip($element);
		if (($element eq "") || ($element =~ /^#/)) { next; }
		@stripped = (@stripped, $element);
	}
	return @stripped;
}

sub removeWhitespacesFromEachArrayEntry {
	my (@array)  = @_;
	my @retList = ();
 
	foreach my $element (@array) {
		$element   =~ s/\s//g;
		push(@retList, $element);
	}
	return @retList;
}

sub doUpperCaseArray {
	my (@array) = @_;
	my @retArr  = ();
 
	foreach my $element (@array) {
		$element = uc($element);
		@retArr = (@retArr, $element);
	}
	return @retArr;
}

sub doLowerCaseArray {
	my (@array) = @_;
	my @retArr  = ();
 
	foreach my $element (@array) {
		$element = lc($element);
		@retArr = (@retArr, $element);
	}
	return @retArr;
}

sub writeStringToFile {
	my($fileName,$append,$multiLineStr,$exitIfError) = @_;
	$append      = setDefault($append     ,$FALSE);
	$exitIfError = setDefault($exitIfError,$TRUE);
	my $retString = "";
	if ($append) {
		open(TABFILE_writeStringToFile,">>${fileName}") || ($retString = "ERROR (writeStringToFile append): Can't open file: ".$fileName." : ".$!);
	} else {
		open(TABFILE_writeStringToFile,">${fileName}") || ($retString = "ERROR (writeStringToFile): Can't open file: ".$fileName." : ".$!);
	}
	if ($retString ne "") {
		if ($exitIfError) {
			showError($retString);
		}
	}
	print(TABFILE_writeStringToFile "${multiLineStr}");
	close(TABFILE_writeStringToFile);
	return $retString;
}

sub writeArrayToFile {
	my($fileName,$append,@lines) = @_;
	$append = setDefault($append,$FALSE);
	writeArrayToFileType($fileName,$append,"",@lines);
}

sub writeArrayToFileType {
	my($fileName,$append,$fileType,@lines) = @_;
	$append   = setDefault($append,$FALSE);
	$fileType = setDefault($fileType,"UNIX");
  
	if ($append) {
		open(TABFILE_writeArrayToFile,">>${fileName}") || showError(sprintf("ERROR (writeArrayToFile append): Can't open file: %s : %s",$fileName,$!));
	} else {
		open(TABFILE_writeArrayToFile,">${fileName}") || showError(sprintf("ERROR (writeArrayToFile): Can't open file: %s : %s",$fileName,$!));
	}

	foreach my $aLine (@lines) {
		if ($fileType eq "UNIX") {
			print(TABFILE_writeArrayToFile "${aLine}\n");
		} else {
			print(TABFILE_writeArrayToFile "${aLine}\r\n");
		}
	}
	close(TABFILE_writeArrayToFile);
}

sub readArrayFromFile {
	my($fileName) = @_;
	my @retArray = ();

	open(TABFILE_readArrayFromFile,"${fileName}") || showError(sprintf("ERROR (readArrayFromFile): Can't open file: %s : %s",$fileName,$!));
	my $aLine = "";
	while (defined($aLine = <TABFILE_readArrayFromFile>)) {
		chomp($aLine);
		push(@retArray,$aLine);
	} # end of while
	close(TABFILE_readArrayFromFile);
	return @retArray;
}

sub countOfArrayElements {
	my(@inArray) = @_;
	my $count = @inArray;
	return $count;
}

# Iterates through every element and calls a user function. The return value of that 
# function is added to the return array
#
# sub dumyFct {
#  my($inVal) = @_;
#  return "AAAA_${inVal}_BBB";
# }
#
# displayArray(processEachElementInArray("dumyFct",@aList));
#
sub processEachElementInArray {
	my($fct,@inArray) = @_;
	my @retArray = ();
	if ($fct eq "") {
		return @inArray;
	}
	foreach my $aEntry (@inArray) {
		push(@retArray,&$fct($aEntry));
	}
	return @retArray;
}

sub doTest_getUnionOfArrays {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my(@mainList) = (
    "Walti",
    "Peter",
    "Claudia",
   );

   my(@otherList) = (
     "Walti",
     "Hans",
     "Gaby",
   );

   my(@expectedResult) = (
    "Walti",
    "Hans",
    "Gaby",
    "Peter",
    "Claudia",
   );

   my(@unexpectedResult) = (
    "Walti",
    "Gaby",
    "Peter",
    "Claudia",
   );

   my (@result) = getUnionOfArrays(\@mainList,\@otherList);

   if (!(areArraysEqual(\@result,\@expectedResult,$FALSE))) {
       print("ERROR: ${myFullName} failed (A)\n");
   }
   if (areArraysEqual(\@result,\@unexpectedResult,$FALSE)) {
       print("ERROR: ${myFullName} failed (A)\n");
   }   
}

sub doTest_swapArrayFields {
	my($myFullName,$debugThisFct) = @_;
	$debugThisFct = setDefault($debugThisFct,$FALSE);

	my @orgList = (
		"0",
		"1",
		"2",
		"3",
	);

	my @resSollList = (
		"0",
		"2",
		"1",
		"3",
	);

	if ($debugThisFct) {
		swapArrayFields(1,2,\@orgList);
		displayArray(@orgList);
	}
	if (!(areArraysEqual(\@orgList,\@resSollList,$FALSE,$TRUE))) {
		print("ERROR: ${myFullName} failed (A)\n");
	}
}

sub swapArrayFields {
	my($i,$k,$refArray) = @_;
  
	my $helpStore   = $refArray->[$i];
	$refArray->[$i] = $refArray->[$k];
	$refArray->[$k] = $helpStore;
} 

############################################################################
# Function for arrays as set /mask
############################################################################

# Union of two sets
# -----------------
# @mainList = (
#    "Walti",
#    "Peter",
#    "Claudia",
# );
#
# @otherList = (
#    "Walti",
#    "Hans",
#    "Gaby",
# );
#
# getUnionOfArrays(\@mainList,\@otherList)
# --> @result = (
#       "Walti",
#       "Peter",
#       "Claudia",
#       "Hans",
#       "Gaby",
#     )
#
sub getUnionOfArrays {
  my($refMainSet,$refToOtherSet) = @_;
  my(@retArray) = ();
  my(@mainSet)   = @$refMainSet;
  my(@otherSet)  = @$refToOtherSet;
  my $countMainSet  = @mainSet;
  my $countOtherSet = @otherSet;

  @retArray = @mainSet;
  foreach my $aElement (@otherSet) {
      if (!(foundInArray($aElement,@mainSet))) {
         push(@retArray,$aElement);
      }
  } 
  return @retArray;
}


sub doTest_getIntersectionOfArrays {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my(@mainList) = (
    "Walti",
    "Peter",
    "Claudia",
   );

   my(@otherList) = (
     "Walti",
     "Hans",
     "Gaby",
   );

   my(@expectedResult) = (
    "Walti",
   );

   my(@unexpectedResult) = (
    "Walti",
    "Gaby",
    "Peter",
    "Claudia",
   );

   my (@result) = getIntersectionOfArrays(\@mainList,\@otherList);

   if (!(areArraysEqual(\@result,\@expectedResult,$FALSE))) {
       print("ERROR: ${myFullName} failed (A)\n");
   }
   if (areArraysEqual(\@result,\@unexpectedResult,$FALSE)) {
       print("ERROR: ${myFullName} failed (A)\n");
   }   
}

# Intersection of two sets
# ------------------------
# @mainList = (
#    "Walti",
#    "Peter",
#    "Claudia",
# );
#
# @otherList = (
#    "Walti",
#    "Hans",
#    "Gaby",
# );
#
# getIntersectionOfArrays(\@mainList,\@otherList)
# --> @result = (
#       "Walti",
#     )
#
sub getIntersectionOfArrays {
	my($refMainSet,$refToOtherSet) = @_;
	my @retArray = ();
	my @mainSet   = @$refMainSet;
	my @otherSet  = @$refToOtherSet;
	my $countMainSet  = @mainSet;
	my $countOtherSet = @otherSet;

	foreach my $aElement (@otherSet) {
		if (foundInArray($aElement,@mainSet)) {
			push(@retArray,$aElement);
	}
	} 
	return @retArray;
}

sub doTest_getExclutionOfArrays {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my(@mainList) = (
    "Walti",
    "Peter",
    "Claudia",
   );

   my(@otherList) = (
     "Walti",
     "Hans",
     "Gaby",
   );

   my(@expectedResult) = (
    "Peter",
    "Claudia",
   );

   my(@unexpectedResult) = (
    "Walti",
    "Gaby",
    "Peter",
    "Claudia",
   );

   my (@result) = getExclutionOfArrays(\@mainList,\@otherList);

   if (!(areArraysEqual(\@result,\@expectedResult,$FALSE))) {
       print("ERROR: ${myFullName} failed (A)\n");
   }
   if (areArraysEqual(\@result,\@unexpectedResult,$FALSE)) {
       print("ERROR: ${myFullName} failed (A)\n");
   }   
}

# Exclution of two sets
# ---------------------
# @mainList = (
#    "Walti",
#    "Peter",
#    "Claudia",
# );
#
# @otherList = (
#    "Walti",
#    "Hans",
#    "Gaby",
# );
#
# getExclutionOfArrays(\@mainList,\@otherList)
# --> @result = (
#       "Peter",
#       "Claudia",
#     )
#
sub getExclutionOfArrays {
	my($refMainSet,$refToOtherSet) = @_;
	my @retArray = ();

	my @mainSet   = @$refMainSet;
	my @otherSet  = @$refToOtherSet;
	my $countMainSet  = @mainSet;
	my $countOtherSet = @otherSet;

	foreach my $aElement (@mainSet) {
		if (!(foundInArray($aElement,@otherSet))) {
			push(@retArray,$aElement);
		}
	} 
	return @retArray;
}


# check mask
#-----------
# $mask        = "**---";
# $valueToMask = "-----";
#
# checkMash("-----","**---")  ==> true
sub checkMask {
	my($valueToMask,$mask,$setVal,$resetVal) = @_;
	$setVal   = setDefault($setVal,  "*");
	$resetVal = setDefault($resetVal,"-");

	# print("checkMask(${valueToMask},${mask}):\n");
	for (my $i = 0; $i < length($mask); $i++) {
		# print("i:${i}:     ".substr($mask,$i,1)."\n");
		if (substr($mask,$i,1) eq $setVal) {
			$valueToMask = replaceStringInString($valueToMask,$i,$resetVal);
			# print("valueToMask:${valueToMask}:\n");
		}
	}
	# print("valueToMask:${valueToMask}:\n"); print("\n");
	if (stringContains($valueToMask,$setVal)) {
		return $FALSE;
	} else {
		return $TRUE;
	}
}

sub doTest_checkMask {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

	my $testCases = qq {
		Nr|InStr|Mask |Expected
		01|-----|**---|TRUE
		02|*----|**---|TRUE
		03|-*---|**---|TRUE
		04|**---|**---|TRUE
		05|--*--|**---|FALSE
		06|*-*--|**---|FALSE
		07|*-*--|-**--|FALSE
		08|*-*--|***--|TRUE
		09|*-*-*|***-*|TRUE
		10|*-*-*|*-*-*|TRUE
	};

	for (my $i = 2; $i <= getCountOfLinesFromQQ($testCases); $i++) {
		my $testCaseNr  = getFieldFromQQ($testCases,$i,1);
		my $testString  = getFieldFromQQ($testCases,$i,2);
		my $mask        = getFieldFromQQ($testCases,$i,3);
		my $expectedRes = setBooleanFromYesNoStr(getFieldFromQQ($testCases,$i,4));
		if ($debugThisFct) {
			print("\n==> ${myFullName}: Test-Case:${i}:${testCaseNr}\n");
			print("       testString :${testString}:\n");
			print("       mask       :${mask}:\n");
			print("       expectedRes:${expectedRes}:\n");
			print("       checkMask(${testString},${mask})=".checkMask($testString,$mask)."\n");
		}
		if (!(checkMask($testString,$mask) eq $expectedRes)) { print("ERROR: Test-Case ${testCaseNr}\n"); print("       checkMask(${testString},${mask})=".checkMask($testString,$mask)."        Expected:${expectedRes}:\n");}
	}
}

############################################################################
# Function for two dimmesional arrays
############################################################################


sub doTest_2DimArr {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my(@twoDimArray) = (
      "A1","A2","A3","A4",
      "B1","B2","B3","B4",
      "C1","C2","C3","C4",
      "D1","D2","D3","D4",
      "E1","E2","E3","E4",
   );

   if ($debugThisFct) {
      display2DimArr(4,5,\@twoDimArray);
      setElement2DimArr(2,3,4,\@twoDimArray,"xxxxD3xxxx");
      display2DimArr(4,5,\@twoDimArray);
      print("D3:",getElement2DimArr(2,3,4,\@twoDimArray)."\n");
      print("C-Row (2)\n");
      displayArray(getRow2DimArr(2,4,\@twoDimArray));
      print("3-Column (2)\n");
      displayArray(getColumn2DimArr(2,4,5,\@twoDimArray));
   }
}

sub init2DimArr {
  my($fieldRef,$xMax,$yMax,$initVal) = @_;
  @$fieldRef = ();
  for (my $i=0; $i < ($xMax*$yMax); $i++) {

       push(@$fieldRef,$initVal);
  }
}

# two dimmensional arrays start always with 0/0
sub calcIndexFor2DimArr {
  my($yPos,$xPos,$xMax) = @_;
  $xMax--;
  return ($yPos*($xMax+1))+$xPos;
}

sub getElement2DimArr {
  my($xPos,$yPos,$xMax,$fieldRef) = @_;
  return $fieldRef->[calcIndexFor2DimArr($yPos,$xPos,$xMax)];
}

sub setElement2DimArr {
  my($xPos,$yPos,$xMax,$fieldRef,$newVal) = @_;
  $fieldRef->[calcIndexFor2DimArr($yPos,$xPos,$xMax)] = $newVal;
}

sub getRow2DimArr {
  my($yPos,$xMax,$fieldRef) = @_;
  my(@retList) = ();
  $xMax--;
  for (my $x1=0; $x1 <= $xMax; $x1++) {
    push(@retList,$fieldRef->[calcIndexFor2DimArr($yPos,$x1,$xMax+1)]);
  }
  return @retList;
}

sub getColumn2DimArr {
  my($xPos,$xMax,$yMax,$fieldRef) = @_;
  my(@retList) = ();
  $xMax--;
  $yMax--;
  for (my $y1=0; $y1 <= $yMax; $y1++) {
    push(@retList,$fieldRef->[calcIndexFor2DimArr($y1,$xPos,$xMax+1)]);
  }
  return @retList;
}


sub display2DimArrWithTitles {
  my($xMax,$yMax,$fieldRef,$columnHeadRef,$rowHeadRef,$columHeadCol,$rowHeadCol) = @_;
  open(OUTPUT_display2DimArrWithTitles, ">&STDOUT") || die "Error (display2DimArrWithTitles): $!\n"; 
  display2DimArrWithTitles_fh(OUTPUT_display2DimArrWithTitles,$xMax,$yMax,$fieldRef,$columnHeadRef,$rowHeadRef,$columHeadCol,$rowHeadCol);
  close(OUTPUT_display2DimArrWithTitles);
}

sub display2DimArrWithTitles_fh {
  my($fh,$xMax,$yMax,$fieldRef,$columnHeadRef,$rowHeadRef) = @_;
  
  $xMax--;
  $yMax--;
  my $maxLength            = maxStrLength(@$fieldRef) + 1;
  my $maxRowTitleLength    = maxStrLength(@$rowHeadRef) + 1;
  my $maxColumnTitleLength = maxStrLength(@$columnHeadRef) + 1;

  $maxLength = getMaxValFromArray($maxLength,$maxColumnTitleLength);

  printf($fh "%-${maxRowTitleLength}s","");
  for (my $x1=0; $x1 <= $xMax; $x1++) {
     printf($fh "%-${maxLength}s",$columnHeadRef->[$x1]." ");
  }
  print($fh "\n");

  for (my $y1=0; $y1 <= $yMax; $y1++) {
    for (my $x1=0; $x1 <= $xMax; $x1++) {
       if ($x1==0) { printf($fh "%-${maxRowTitleLength}s",$rowHeadRef->[$y1]." "); }
       printf($fh "%-${maxLength}s",$fieldRef->[calcIndexFor2DimArr($y1,$x1,$xMax+1)]." ");
    }
    print($fh "\n");
  }
}

sub display2DimArrWithTitlesHTML {
  my($xMax,$yMax,$fieldRef,$columnHeadRef,$rowHeadRef,$columHeadCol,$rowHeadCol) = @_;
  open(OUTPUT_display2DimArrWithTitlesHTML, ">&STDOUT") || die "Error (display2DimArrWithTitlesHTML): $!\n"; 
  display2DimArrWithTitlesHTML_fh(OUTPUT_display2DimArrWithTitlesHTML,$xMax,$yMax,$fieldRef,$columnHeadRef,$rowHeadRef,$columHeadCol,$rowHeadCol);
  close(OUTPUT_display2DimArrWithTitlesHTML);
}

sub display2DimArrWithTitlesHTML_fh {
  my($fh,$xMax,$yMax,$fieldRef,$columnHeadRef,$rowHeadRef,$columHeadCol,$rowHeadCol) = @_;

  $columHeadCol = setDefault($columHeadCol,"silver");
  $rowHeadCol   = setDefault($rowHeadCol,"silver");

  $xMax--;
  $yMax--;

  print($fh "<TABLE border=1 cellpadding=3 cellspacing=0>\n");
  print($fh "<TR><TD>&nbsp;</TD>");
  for (my $x1=0; $x1 <= $xMax; $x1++) {
     print($fh "<TD bgcolor=${columHeadCol}><CENTER>".$columnHeadRef->[$x1]."</TD>");
  }
  print($fh "</TR>\n");

  for (my $y1=0; $y1 <= $yMax; $y1++) {
    for (my $x1=0; $x1 <= $xMax; $x1++) {
       if ($x1==0) { print($fh "<TR><TD bgcolor=${rowHeadCol}><CENTER>".$rowHeadRef->[$y1]."</TD>"); }
       print($fh "<TD><CENTER>".$fieldRef->[calcIndexFor2DimArr($y1,$x1,$xMax+1)]."</TD>");
    }
    print($fh "</TR>\n");
  }
  print($fh "</TABLE>\n");
}



sub display2DimArr {
  my($xMax,$yMax,$fieldRef) = @_;

  $xMax--;
  $yMax--;
  my $maxLength = maxStrLength(@$fieldRef) + 1;
  for (my $y1=0; $y1 <= $yMax; $y1++) {
    for (my $x1=0; $x1 <= $xMax; $x1++) {
       printf("%-${maxLength}s",$fieldRef->[calcIndexFor2DimArr($y1,$x1,$xMax+1)]." ");
    }
    print("\n");
  }
}


sub doTest_ScheduleResolver {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

#    ! not possible
#    in each row 3 are requested
#    in each column max 2 are allowed

   my(@einsatzplan) = (
      "*","*","*","*",
      "*","*","*","*",
      "*","!","*","*",
      "*","*","!","*",
      "*","*","!","*",
   );


   # As many entries as the einsatzplan has rows
   my(@peoplePerEinsatz) = (
      3,
      3,
      3,
      3,
      3,
   );

   my(@einsatzDescription) = (
      "5.5.2003",
      "6.5.2003",
      "12.5.2003",
      "13.5.2003",
      "19.5.2003",   
   );
   
   # As many entries as the einsatzplan has columns
   my(@maxEinsatzPerPeople) = (
      5,
      3,
      5,
      5,
   );
   
   my(@peopleNames) = (
     "Walter Rothlin",
     "Karin Diethelm",
     "Markus Züger",
     "Hermann Annen",
   );

   @peopleNames = (
     "WR",
     "KD",
     "MZ",
     "HA",
   );

   if ($debugThisFct) {
     ## readScheduleResolverData("registerList_testNeg.flt","scheduleResolverDescFile.flt",\@peoplePerEinsatz,\@einsatzDescription,\@maxEinsatzPerPeople,\@peopleNames,\@einsatzplan);
     ## displayArray(@peoplePerEinsatz);
     ## displayArray(@einsatzDescription);

     ## displayArray(@maxEinsatzPerPeople);
     ## displayArray(@peopleNames);

     scheduleResolver(\@einsatzplan,\@peoplePerEinsatz,\@peopleNames,\@maxEinsatzPerPeople,\@einsatzDescription,$FALSE);
   }
}

sub processScheduleResolverData {
   my($personDataFileName,$descDataFileName,$outFilename,$htmlVersion) = @_;
   $htmlVersion = setDefault($htmlVersion,$FALSE);

   my(@einsatzplan) = ();

   # As many entries as the einsatzplan has rows
   my(@peoplePerEinsatz) = ();
   my(@einsatzDescription) = ();
   
   # As many entries as the einsatzplan has columns
   my(@maxEinsatzPerPeople) = ();
   my(@peopleNames) = ();

   print("Daten lesen....\n");
   readScheduleResolverData($personDataFileName,$descDataFileName,\@peoplePerEinsatz,\@einsatzDescription,\@maxEinsatzPerPeople,\@peopleNames,\@einsatzplan);
   print("Daten verarbeiten....\n");
   scheduleResolver(\@einsatzplan,\@peoplePerEinsatz,\@peopleNames,\@maxEinsatzPerPeople,\@einsatzDescription,$htmlVersion);

}

sub readScheduleResolverData {
   my($personDataFileName,$descDataFileName,$peoplePerEinsatzRef,$einsatzDescriptionRef,$maxEinsatzPerPeopleRef,$peopleNamesRef,$einsatzplanRef) = @_;
   @$peoplePerEinsatzRef = ();
   @$einsatzDescriptionRef = ();
   my(@descListRef) = getAllMatchesFromFltFileAsHashes($descDataFileName,"\\|","","");
   foreach my $recordRef(@descListRef) {
     push(@$peoplePerEinsatzRef,$recordRef->{PeopleRequested});
     push(@$einsatzDescriptionRef,$recordRef->{Description});
   }

   @$maxEinsatzPerPeopleRef = ();
   @$peopleNamesRef = ();
   @$einsatzplanRef = ();

   my(@dutyListRef) = getAllMatchesFromFltFileAsHashes($personDataFileName,"\\|","","");

   my $xMax = @dutyListRef;
   my $yMax = @$einsatzDescriptionRef;
   init2DimArr($einsatzplanRef,$xMax,$yMax,"*");

   my $x=0;
   foreach my $recordRef(@dutyListRef) {
     push(@$peopleNamesRef,$recordRef->{ModBy});
     push(@$maxEinsatzPerPeopleRef,$recordRef->{MaxEinsaetze});
     my $y=0;
     foreach my $aDate (@$einsatzDescriptionRef) {
        my $colHead   =  $aDate;   $colHead   =~ s/\W//g;
        my $newVal = $recordRef->{$colHead};
        if ((uc($newVal) eq "JA") || (uc($newVal) eq "YES")) { $newVal = "*"; } else { $newVal = "!"; }
        setElement2DimArr($x,$y,$xMax,$einsatzplanRef,$newVal);
        $y++;
     }
     $x++;
   }
   ## display2DimArr($xMax,$yMax,$einsatzplanRef);
}


sub scheduleResolver {
   my($einsatzplanRef,$peoplePerEinsatzRef,$peopleNamesRef,$maxEinsatzPerPeopleRef,$einsatzDescriptionRef,$htmlOutput) = @_;

     my(@rowTitles) = concatArrayEntries($einsatzDescriptionRef,$peoplePerEinsatzRef," (","",")");
     my(@colTitles) = concatArrayEntries($peopleNamesRef,$maxEinsatzPerPeopleRef," (","",")");

     my $countOfRows = @$peoplePerEinsatzRef;  my $countOfDesc      = @$einsatzDescriptionRef;
     my $countOfCol  = @$peopleNamesRef;       my $countOfmaxDuties = @$maxEinsatzPerPeopleRef;

     # Validating the input data
     # =========================
     if ($countOfRows != $countOfDesc) {
       print("ERROR: Not the same number of task description (${countOfDesc}) and requested people for each task (${countOfRows})\n");
       return;
     }
     if ($countOfCol != $countOfmaxDuties) {
       print("ERROR: Not the same number of people names (${countOfCol}) and max duties per person (${countOfmaxDuties})\n");
       return;
     }
     my $countOfElem = @$einsatzplanRef;
     if ($countOfElem != ($countOfRows * $countOfCol)) {
       print("ERROR: Only ${countOfElem} elemnts defined in a field of ${countOfRows} * ${countOfCol}\n");
       return;
     }

     if ($htmlOutput) {
         @rowTitles = concatArrayEntries($einsatzDescriptionRef,$peoplePerEinsatzRef,"<BR>");
         @colTitles = concatArrayEntries($peopleNamesRef,$maxEinsatzPerPeopleRef,"<BR>");
         print("Ausgangslage<BR>\n");
         display2DimArrWithTitlesHTML($countOfCol,$countOfRows,$einsatzplanRef,\@colTitles,\@rowTitles);
         print("<BR>\n");
     } else {
         print("Ausgangslage\n");
         display2DimArrWithTitles($countOfCol,$countOfRows,$einsatzplanRef,\@colTitles,\@rowTitles);
         print("\n");
     }

     # do some calculation on how many tries to do
     # =========================================== 
     my $totalTries = -1;
     for (my $i=0; $i < $countOfRows; $i++) {
        my(@res) = getIndexesForEmptyFields(getRow2DimArr($i,$countOfCol,$einsatzplanRef));
        my $count = @res;
        print("For ".$einsatzDescriptionRef->[$i]." ".$peoplePerEinsatzRef->[$i]." people are requested and ${count} where available! ");
        my $rowTries = nTiefk($count,$peoplePerEinsatzRef->[$i]);
        if ($totalTries == -1) { $totalTries = $rowTries; } else { $totalTries = $totalTries * $rowTries; }
        print("==> ${rowTries} combinations\n");
     }
     print("Total tries: ${totalTries}\n");


     @scheduleResolverSolution_GLOBAL = ();
     for (my $i=0; $i<$countOfRows; $i++) {
       push(@scheduleResolverSolution_GLOBAL,"AAAAAA");
     }
     $scheduleResolverLevel_GLOBAL    = -1;

     $scheduleResolverCountOfRows_GLOBAL = $countOfRows;
     $scheduleResolverCountOfCol_GLOBAL  = $countOfCol;

     $scheduleResolverCountOfResult_GLOBAL  = 0;
     $scheduleResolverEinsatzplanRef_GLOBAL = $einsatzplanRef;

     @peoplePerEinsatz_GLOBAL    = @$peoplePerEinsatzRef;
     @peopleNames_GLOBAL         = @$peopleNamesRef;
     @maxEinsatzPerPeople_GLOBAL = @$maxEinsatzPerPeopleRef;
     @einsatzDescription_GLOBAL  = @$einsatzDescriptionRef;

     $scheduleResolverDisplayHTML_GLOBAL = $htmlOutput;

     $scheduleResolverTryCounter_GLOBAL = 0;
     ### $scheduleResolverCallRecu_GLOBAL = $TRUE;

     %scheduleResolverTestCounter_GLOBAL = ();
     for (my $i=0; $i<$scheduleResolverCountOfCol_GLOBAL; $i++) {
       %scheduleResolverTestCounter_GLOBAL = (%scheduleResolverTestCounter_GLOBAL,($i,0));
     }
     searchForScheduleSolution(0);
}


sub searchForScheduleSolution {
    my($level) = @_;

    my(@param) = (
       $level,
    );
    if ($level >= $scheduleResolverCountOfRows_GLOBAL) {
       ### print("At the end ${scheduleResolverLevel_GLOBAL}\n");
       return;
    }
    if (!(performFctOnAllCombinations("scheduleResolveOneDate",\@param,$peoplePerEinsatz_GLOBAL[$level],getIndexesForEmptyFields(getRow2DimArr($level,$scheduleResolverCountOfCol_GLOBAL,$scheduleResolverEinsatzplanRef_GLOBAL))))) {
       print("Problem found in line ${level}! Not enough people to fullfill the requirements\n");
       return;
    }
    
}

sub scheduleResolverInitTestCounter {
  for (my $i=0; $i<$scheduleResolverCountOfCol_GLOBAL; $i++) {
     $scheduleResolverTestCounter_GLOBAL{$i} = 0;
  }
}

sub scheduleResolveOneDate {
   my($feldRef,$num,$maxNum,@param) = @_;
   my $countOfElem = @feld;
   my $level = @param[0];
   $scheduleResolverSolution_GLOBAL[$level]=makeQuotedStrFromArray(",","",@$feldRef);

   $scheduleResolverTryCounter_GLOBAL++;
   print("Tried ${scheduleResolverTryCounter_GLOBAL}  (Level:${level})\n");

   

      displayArray(@scheduleResolverSolution_GLOBAL);halt();

      if (testScheduleResolverResult()) {
          if ($level >= $scheduleResolverCountOfRows_GLOBAL-1) {
            $scheduleResolverCountOfResult_GLOBAL++;
            ### $scheduleResolverCallRecu_GLOBAL = $FALSE;
            if ($scheduleResolverDisplayHTML_GLOBAL) {
               displayScheduleResolverResultHTML();
               print("<BR>\n");
            } else {
               displayScheduleResolverResult();
               print("\n");
            }
          }
          searchForScheduleSolution($level+1);
      } else {
          print("NOT a valid solution\n");
      }
   
}

sub scheduleResolveOneDate_OLDDDD {
   my($feldRef,$num,$maxNum,@param) = @_;
   my $countOfElem = @feld;
   my $level = @param[0];
   $scheduleResolverSolution_GLOBAL[$level]=makeQuotedStrFromArray(",","",@$feldRef);

   $scheduleResolverTryCounter_GLOBAL++;
   print("Tried ${scheduleResolverTryCounter_GLOBAL}  (Level:${level})\n");
   displayArray(@scheduleResolverSolution_GLOBAL);halt();


   if ($level >= $scheduleResolverCountOfRows_GLOBAL-1) {

 
      if (testScheduleResolverResult()) {
          $scheduleResolverCountOfResult_GLOBAL++;
          if ($scheduleResolverDisplayHTML_GLOBAL) {
             displayScheduleResolverResultHTML();
             print("<BR>\n");
          } else {
             displayScheduleResolverResult();
             print("\n");
          }
      } else {
          ### print("NOT a valid solution\n");
      }
   }
   searchForScheduleSolution($level+1);
}

sub displayScheduleResolverResult {
   print("Result:${scheduleResolverCountOfResult_GLOBAL}\n");
   my(@resultTable) = ();

   my $count = @scheduleResolverSolution_GLOBAL;
   ## my(@rowTitles) = concatArrayEntries(\@peoplePerEinsatz_GLOBAL,\@einsatzDescription_GLOBAL,"==>");
   my(@rowTitles) = @einsatzDescription_GLOBAL;
   for (my $i=0; $i<$count; $i++) {
      print($rowTitles[$i]." (".$peoplePerEinsatz_GLOBAL[$i].") ");
      my(@parts) = split(",",$scheduleResolverSolution_GLOBAL[$i]);
      foreach my $aNameNr (@parts) {
         print($peopleNames_GLOBAL[$aNameNr].";");
      }
      print("\n");
   }

   print("\n");
   print("Einsatz-Statistik\n");
   my(%einsatzStatistikHash) = ();
   for (my $i=0; $i<$scheduleResolverCountOfCol_GLOBAL; $i++) {
      #### $einsatzStatistikHash{$i} = 0;
   }
   for (my $i=0; $i<$count; $i++) {
      my(@parts) = split(",",$scheduleResolverSolution_GLOBAL[$i]);
      my $einsatzDate = $einsatzDescription_GLOBAL[$i];

      foreach my $aNameNr (@parts) {

         if (exists($einsatzStatistikHash{$aNameNr})) {
             $einsatzStatistikHash{$aNameNr} = $einsatzStatistikHash{$aNameNr}.";${einsatzDate}";
         } else {
             %einsatzStatistikHash = (%einsatzStatistikHash,($aNameNr,$einsatzDate));
         }
      }
   }
   my(@nameNrs) = keys %einsatzStatistikHash;
   my(@auslastungsListe) = ();
   foreach my $aNameNr (@nameNrs) {
     my $auslastungsZiffer = $scheduleResolverTestCounter_GLOBAL{$aNameNr} / $maxEinsatzPerPeople_GLOBAL[$aNameNr];
     push(@auslastungsListe,$auslastungsZiffer);
     print($peopleNames_GLOBAL[$aNameNr]." (".$scheduleResolverTestCounter_GLOBAL{$aNameNr}." -> ${auslastungsZiffer}) ".$einsatzStatistikHash{$aNameNr}."\n");

   }
   print("Average:".calcAverageFromArray(@auslastungsListe)."\n");
   halt();
   ### displayHashTable(%einsatzStatistikHash);
   ### displayHashTable(%scheduleResolverTestCounter_GLOBAL);
   ### print("Valid solution\n");
}

sub displayScheduleResolverResultHTML {
   print("Result:${scheduleResolverCountOfResult_GLOBAL}<BR>\n");
   print("<TABLE border=1 cellpadding=3 cellspacing=0>\n");
   my(@resultTable) = ();

   my $count = @scheduleResolverSolution_GLOBAL;
   ## my(@rowTitles) = concatArrayEntries(\@peoplePerEinsatz_GLOBAL,\@einsatzDescription_GLOBAL,"==>");
   my(@rowTitles) = @einsatzDescription_GLOBAL;
   for (my $i=0; $i<$count; $i++) {
      print("<TR><TD bgcolor=silver>".$rowTitles[$i]."</TD><TD>".$peoplePerEinsatz_GLOBAL[$i]."</TD>");
      my(@parts) = split(",",$scheduleResolverSolution_GLOBAL[$i]);
      foreach my $aNameNr (@parts) {
         print("<TD>".$peopleNames_GLOBAL[$aNameNr]."</TD>");
      }
      print("</TR>\n");
   }
   print("</TABLE><BR>\n");

   print("Einsatz-Statistik<BR>\n");
   print("<TABLE border=1 cellpadding=3 cellspacing=0>\n");
   my(%einsatzStatistikHash) = ();
   for (my $i=0; $i<$scheduleResolverCountOfCol_GLOBAL; $i++) {
      #### $einsatzStatistikHash{$i} = 0;
   }
   for (my $i=0; $i<$count; $i++) {
      my(@parts) = split(",",$scheduleResolverSolution_GLOBAL[$i]);
      my $einsatzDate = $einsatzDescription_GLOBAL[$i];

      foreach my $aNameNr (@parts) {

         if (exists($einsatzStatistikHash{$aNameNr})) {
             $einsatzStatistikHash{$aNameNr} = $einsatzStatistikHash{$aNameNr}.";${einsatzDate}";
         } else {
             %einsatzStatistikHash = (%einsatzStatistikHash,($aNameNr,$einsatzDate));
         }
      }
   }
   my(@nameNrs) = keys %einsatzStatistikHash;
   my(@auslastungsListe) = ();
   foreach my $aNameNr (@nameNrs) {
     my $auslastungsZiffer = $scheduleResolverTestCounter_GLOBAL{$aNameNr} / $maxEinsatzPerPeople_GLOBAL[$aNameNr];
     push(@auslastungsListe,$auslastungsZiffer);
     print("<TR><TD bgcolor=silver>".$peopleNames_GLOBAL[$aNameNr]."</TD><TD>".$scheduleResolverTestCounter_GLOBAL{$aNameNr}."</TD><TD>${auslastungsZiffer}</TD><TD>");
     my $aStr = $einsatzStatistikHash{$aNameNr};
     $aStr =~ s/;/\<\/TD\>\<TD\>/g;
     
     print("${aStr}</TD></TR>\n");

   }
   print("</TABLE>\nAverage:".calcAverageFromArray(@auslastungsListe)."<BR>\n");
   ### displayHashTable(%einsatzStatistikHash);
   ### displayHashTable(%scheduleResolverTestCounter_GLOBAL);
   ### print("Valid solution\n");
}

sub testScheduleResolverResult {
  my $countOfRows = @scheduleResolverSolution_GLOBAL;
  scheduleResolverInitTestCounter();
  for (my $i=0; $i<$countOfRows; $i++) {
     if ($scheduleResolverSolution_GLOBAL[$i] eq "AAAAAA") { return $TRUE; }
     my(@parts) = split(",",$scheduleResolverSolution_GLOBAL[$i]);
     foreach my $aPart (@parts) {
        $scheduleResolverTestCounter_GLOBAL{$aPart}++;
        if ($scheduleResolverTestCounter_GLOBAL{$aPart} > $maxEinsatzPerPeople_GLOBAL[$aPart]) { return $FALSE; }
     }
  }  
  return $TRUE;
}


sub getIndexesForEmptyFields {
  my(@fieldList) = @_;
  my(@retList) = ();
  my $count = @fieldList;
  for (my $i=0; $i<$count; $i++) {
     if ($fieldList[$i] ne "!") {
       push(@retList,$i);
     }
  }
  return @retList;
}


############################################################################
# Function for StringName XML string/file manipulation 
############################################################################
sub getTagValueFromXML {
	my($tagName,$XML_String) = @_;
	$XML_String =~ s/\n/ /g;
	$XML_String =~ s/\r//g;
	$XML_String =~ s/"//g;
	$tagName    =~ s/"//g;
	$tagName    = strip($tagName);
	$XML_String = strip($XML_String);
	## print("--> looking for ::::${tagName}::::....\n\n");
	## print(" in ....\n");
	## print("::::${XML_String}::::\n\n");
	my $startPosOfStartTag = index($XML_String,"<${tagName}");
	if ($startPosOfStartTag == -1)  {
		$startPosOfStartTag = index($XML_String,"${tagName}");
		if ($startPosOfStartTag == -1)  { 
			# print("INDEX: ".index("<session-factory>                   <property name=hibernate.connection.driver_class>oracle.jdbc.driver.OracleDriver</property>              <property name=hibernate.connection.url>j",
																	   # "<property name=hibernate.connection.driver_class>")."\n");
			# print("INDEX: ".index($XML_String,
																	   # "<property name=hibernate.connection.driver_class>")."\n");
			# print("INDEX: ".index("<session-factory>                   <property name=hibernate.connection.driver_class>oracle.jdbc.driver.OracleDriver</property>              <property name=hibernate.connection.url>j",
																	   # $tagName)."\n");
			# print("INDEX: ".index($XML_String,,
																	   # $tagName)."\n");																		   
			# return "AAAA";
			return "";
		}
	}
	## print("A:${startPosOfStartTag}:\n\n");
	my $tmpStr = substr($XML_String,$startPosOfStartTag);
	## print("0:${tmpStr}:\n\n");
	my $endPosOfStartTag = index($tmpStr,">");
	if ($endPosOfStartTag == -1) { return "cccc"; }
	my $tmpStr = substr($tmpStr,$endPosOfStartTag+1);
	## print("1:${tmpStr}:\n\n");
	my $startPosOfEndTag = index($tmpStr,"${tagName}>");
	## print("B:${startPosOfEndTag}:\n\n");
	if ($startPosOfEndTag == -1)  {
		$startPosOfEndTag = index($tmpStr,"</");
		if ($startPosOfEndTag == -1)  {
			return ""; 
		} else {
			$startPosOfEndTag = $startPosOfEndTag + 2;
		}
	}
	my $tmpStr = substr($tmpStr,0,$startPosOfEndTag-2);
	## print("2:${tmpStr}:\n\n");
	return $tmpStr;
}

sub getNameValuePairsAndReplaceNamesFromStringNameFile {
   my($inFileName,$outFileName,$refToNameValHash) = @_;

   my $aMultiLineStr = readFileIntoStr($inFileName);
   my $outString = getNameValuePairsAndReplaceNamesFromStringNameString($aMultiLineStr,$refToNameValHash);
   writeStringToFile($outFileName,$FALSE,$outString);
}

sub doTest_getNameValuePairsAndReplaceNamesFromStringNameString {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);


   # Test Cases Prepare
   # ------------------
   my(%nameValueTable) = ();
   my $outString = "";

   my $XML_String_1 = qq {Ein String mit <StringName=Level_1><StringName=Level_11>Val_11</StringName><StringName=Level_12>Val_12</StringName><StringName=Level_13>Val_13</StringName></StringName>{Level_1}und hier ist das ende};

   my $resultStr_1  = qq {Ein String mit Val_11Val_12Val_13Val_11Val_12Val_13und hier ist das ende};

   my(%resHash_1) = (
       "{Level_11}" => "Val_11",
       "{Level_12}" => "Val_12",
       "{Level_13}" => "Val_13",
       "{Level_1}"  => "Val_11Val_12Val_13",
   );


   my $XML_String_2 = qq {
        preStr_11
        <StringName=Level_11>Val_11</StringName> postString_11
        <StringName=Level_1> 
          preString_12 <StringName=Level_12>Val_12</StringName>
          <StringName=Level_13>Val_13</StringName> 
        </StringName>
        und hier ist das ende 
        Auch nein hier kommen noch einige Variablen 
        {Level_1}
        {Level_11}
        Nun ist es fertig
      };

   my $resultStr_2 = qq {
        preStr_11
        Val_11 postString_11
         
          preString_12 Val_12
          Val_13 
        
        und hier ist das ende 
        Auch nein hier kommen noch einige Variablen 

          preString_12 Val_12
          Val_13 
        
        Val_11
        Nun ist es fertig
      };

   my(%resHash_2) = (
       "{Level_11}" => "Val_11",
       "{Level_12}" => "Val_12",
       "{Level_13}" => "Val_13",
       "{Level_1}"  => qq{"
          preString_12 Val_12
          Val_13 
        "},
   );
     
   %nameValueTable = ();
   $outString = getNameValuePairsAndReplaceNamesFromStringNameString($XML_String_1,\%nameValueTable);
   if (!(areHashesEqual(\%nameValueTable,\%resHash_1,$TRUE,$TRUE,$debugThisFct))) {
       print("ERROR: ${myFullName} failed (A-0)\n");
   }
   if ($outString ne $resultStr_1) {
       print("ERROR: ${myFullName} failed (A-1)\n");
   }
   if ($debugThisFct) {
     displayHashTable(%nameValueTable);
     print("${outString}\n${resultStr_1}\n");
   }

return;

   %nameValueTable = ();
   $outString = getNameValuePairsAndReplaceNamesFromStringNameString($XML_String_2,\%nameValueTable);
   if (!(areHashesEqual(\%nameValueTable,\%resHash_2,$TRUE,$TRUE,$debugThisFct))) {
       print("ERROR: ${myFullName} failed (B-0)\n");
   }
   if ($outString ne $resultStr_2) {
       print("ERROR: ${myFullName} failed (B-1)\n");
   }
   if ($debugThisFct) {
     displayHashTable(%nameValueTable);
     print("---->>>>>:\n${outString}\n---->>>>>:\n${resultStr_2}\n");
   }


}

sub getNameValuePairsAndReplaceNamesFromStringNameString {
   my($inString,$refToNameValHash) = @_;

   my $retStr      = "";
   my $tagsFound   = $TRUE;
   my @tokenList   = tokenizerStringName($inString);
   my $countOfTags = @tokenList;

   while ($tagsFound) {

       $tagsFound = $FALSE;
       my $startTagPos = -1;
       my $endTagPos   = -1;
       my $tagName     = "";
       my $tagVal      = "";

       for (my $i=0; $i < $countOfTags; $i++) {
          if (index($tokenList[$i],"<StringName=") == 0) {
             $startTagPos = $i;
             $tagsFound = $TRUE;
             $tagVal = "";

          } elsif (index($tokenList[$i],"</StringName>") == 0) {
             $endTagPos = $i;
             if ($startTagPos != -1) {
                $tagName = "{".getStringNameName($tokenList[$startTagPos])."}";
                $tokenList[$startTagPos] = "";
                $tokenList[$endTagPos]   = "";
                ## print("------> (${callLevel}:4) tagName:${tagName}:\n              tagVal:${tagVal}\n\n");
                $refToNameValHash->{$tagName} = $tagVal;
                $startTagPos = -1;
             }
          } else {
             $tagVal = "${tagVal}".$tokenList[$i];
          }
       }
   }

   foreach my $aTokenStr (@tokenList) {
      $retStr = "${retStr}${aTokenStr}";
   }

   $retStr = replacePlaceholdersStr($retStr,%$refToNameValHash);
   return $retStr;
}

sub tokenizerStringName {
    my($inString) = @_;
    my @tokenList = ();
    my $restString = $inString;

    while (length($restString) > 0) {
    	my $startPosStartString    = index($restString,"<StringName=");
        if ($startPosStartString < 0) { $startPosStartString = 100000; }
    	my $startPosEndStartString = index($restString,"</StringName>");
    	my $nextTokenPos = getMinValFromArray($startPosStartString,$startPosEndStartString);

    	if ($nextTokenPos == 0) {
    	   my $endTagPos = index($restString,">");
           push(@tokenList,substr($restString,0,$endTagPos + 1));
           $restString = substr($restString,$endTagPos + 1);
        } elsif ($nextTokenPos == -1) {
           push(@tokenList,$restString);
           $restString = "";
        } else {
           push(@tokenList,substr($restString,0,$nextTokenPos));
    	   $restString = substr($restString,$nextTokenPos);
    	}
    }    
    return @tokenList;
}

sub getStringNameName {
   my($startTagStr) = @_;
   my $startPos = index($startTagStr,"=");
   my $endPos   = index($startTagStr,">");
   if (($startPos == -1) ||
       ($endPos   == -1)) {
       return "ERROR in startTagStr:${startTagStr}:";
   } else {
       my $retVal = substr($startTagStr,$startPos + 1, $endPos - $startPos - 1);
       return $retVal;
   }
}

##########################################################
# Function on Matrix                                   ###
##########################################################

# matrixUmwandeln
# ------------------
# History:
# 07/13/09    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# 
#
# Input File: 
## Y-Achsen|X-Achsen|Wert
## Y1|xA|10
## Y1|xB|30
## Y1|xC|50
## Y1|xD|60
## Y2|xA|20
## Y2|xC|70
## Y3|xB|40
#
# return Value:
##  |xA|xB|xC|xD
##  Y1|10|30|50|60|
##  Y2|20||70|
##  Y3||40|
#
# Load this output in EXCEL
##    |xA|xB|xC|xD
##  Y1|10|30|50|60|
##  Y2|20|  |70|
##  Y3|  |40|
sub matrixUmwandeln {
	 my($inputSepChar,$outputSepChar,$fileName,$xAxiesName,$yAxiesName,$valueFN) = @_;
	 my $fileString = "";
	 
   my %fieldTypes = ();
   
   my @outPutFields = (
       $yAxiesName,
       $xAxiesName,
       $valueFN,
   );
   
   
   ## print("fileName:${fileName}:\n"); halt();
   sortFltFile($fileName,"","",$yAxiesName."|".$xAxiesName,\%fieldTypes,\@outPutFields);
   ## print("Sorted!!!!\n"); halt();
   
   @xValues = getColumnValues($fileName,$sepChar,$xAxiesName,"",$xAxiesName,$TRUE);   ## displayArray(@xValues); halt();
   @yValues = getColumnValues($fileName,$sepChar,$yAxiesName,"",$yAxiesName,$TRUE);   ## displayArray(@yValues); halt();
   
   # Spalten-Ueberschriften schreiben
   my %xTransHash = ();
   my $xCount = 1;
   foreach my $xValue (@xValues) {
   	 $fileString = $fileString.$outputSepChar.$xValue;
   	 %xTransHash = (%xTransHash,($xValue,$xCount));
   	 $xCount = $xCount + 1;
   }
   ## displayHashTable(%xTransHash); halt();
   
   my @records = getAllMatchesFromFltFileAsHashes($fileName,$inputSepChar,"","");
   
   my $firstY_value = "";
   my $currentPos   = 1;
   my $actPos       = 0;
   foreach $record (@records ) {
   	 ## print($record->{$yAxiesName}."\n");halt();
   	 $actPos = $xTransHash{$record->{$xAxiesName}};
     if ($firstY_value ne $record->{$yAxiesName}) {
     	   $firstY_value = $record->{$yAxiesName};
     	   $currentPos   = 1;
     	   ## print("New Line: ".$record->{$yAxiesName}."\n");
     	   $fileString = $fileString."\n".$record->{$yAxiesName}.$outputSepChar;
     }
     my $tmpStr = addMatrixValueHidden($currentPos,$actPos,$record->{$valueFN},$outputSepChar);
 	   if ($tmpStr ne "") {
 	       $fileString = $fileString.$tmpStr;
 	       $currentPos = $actPos + 1;
 	   }
   }
   $fileString = $fileString."\n";
   ## addToLogFile("List of Package-Info:\n".$fileString,$logFileName,$verbal);
   return $fileString;   
}

sub addMatrixValueHidden {
	 my($currentPos,$posToStore,$valueToWrite,$outputSepChar) = @_;	 
	 my $retStr = "";
	 if (($currentPos > $posToStore) ) {
	 	    print("ERROR currentPos:${currentPos}  posToStore.${posToStore}   ${valueToWrite}\n");
	 	    return "";
	 }
	 for ( my $i=$currentPos; $i<$posToStore; $i++) {
	 	   $retStr = $retStr.$outputSepChar;
	 }
   $retStr = $retStr.$valueToWrite.$outputSepChar;
	 return $retStr;
}

############################################################################
# Function for hashes or arrays which are a little bit complicated
############################################################################


# returns a hash table with all elements from an array as keys and the values
# are how many times the name appears in the array
#
# For meaning of $doTrim and $caseChangeMode look at definition
# of function massageRecord
sub countApperanceOfNames {
   my($takeOriginalStr,$doTrim,$caseChangeMode,@inArray) = @_;
   my(%retHash)  = ();
   my($aElement) = "";
   foreach $aElement (@inArray) {
     if (!($takeOriginalStr)) {
        $aElement = massageRecord($aElement,";",$doTrim,$caseChangeMode);
     }
     if (exists($retHash{$aElement})) {
        $retHash{$aElement} = $retHash{$aElement} + 1;
     } else {
        %retHash = (%retHash,($aElement,1));
     }
   }
   return %retHash;
}

############################################################################
# permutations, combinations and variations
############################################################################
sub doTest_performFctOnAllPermutations {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my(@feldXXXXyy) = (
      "A",
      "B",
      "C",
      "D",
   );

   my(@expectedResult) = (
      "A,B,C,D",
      "B,A,C,D",
      "C,B,A,D",
      "B,C,A,D",
      "A,C,B,D",
      "C,A,B,D",
      "D,B,C,A",
      "B,D,C,A",
      "C,B,D,A",
      "B,C,D,A",
      "D,C,B,A",
      "C,D,B,A",
      "A,D,C,B",
      "D,A,C,B",
      "C,D,A,B",
      "D,C,A,B",
      "A,C,D,B",
      "C,A,D,B",
      "A,B,D,C",
      "B,A,D,C",
      "D,B,A,C",
      "B,D,A,C",
      "A,D,B,C",
      "D,A,B,C",
   );

   my(@locParam) = (
       "Walti",
       7777,
   );
   

   if ($debugThisFct) {
     performFctOnAllPermutations("displayOnePermutationResultInOnLine",\@locParam,@feldXXXXyy);
     displayArray(getAllPermutations(@feldXXXXyy));
   }

   my(@resultList) = getAllPermutations(@feldXXXXyy);
   if (!(areArraysEqual(\@resultList,\@expectedResult,$TRUE,$TRUE))) {
       print("ERROR: ${myFullName} failed (A)\n");
       if ($debugThisFct) {
           print("ResultArray\n");
           displayArray(@resultList);

           print("\nExpected-ResultArray\n");
           displayArray(@expectedResult);

       }
   }

   if (areArraysEqual(\@resultList,\@feldXXXXyy,$TRUE,$TRUE)) {
       print("ERROR: ${myFullName} failed (A-1)\n");
       if ($debugThisFct) {
           print("ResultArray\n");
           displayArray(@resultList);

           print("\nExpected-ResultArray\n");
           displayArray(@expectedResult);

       }
   }

}

sub getAllPermutations {
  my(@elemetList) = @_;

  @permutationResult_GLOBAL = ();
  performFctOnAllPermutations("putPermutationResultToList","",@elemetList);
  return @permutationResult_GLOBAL;
}


sub performFctOnAllPermutations {
  my($fctName,$fctParameterRef,@elemetList) = @_;

  my $performFctOnAllPermutationsNumOfPerm = 0;
  my $countOfElements = @elemetList;
  my $performFctOnAllPermutationsMaxNumOfPerm = factorials($countOfElements);
  @elemetList = ("....",@elemetList);
  permutation($countOfElements,\@elemetList,$fctName,\$performFctOnAllPermutationsNumOfPerm,$performFctOnAllPermutationsMaxNumOfPerm,@$fctParameterRef);
}

# ------------------------------------------------------------------------------------------------

sub doTest_performFctOnAllCombinations {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my(@feldXXXXyy) = (
      "A",
      "B",
      "C",
      "D",
      "E",
      "F",
   );

   my(@expectedResult) = (
      "A,B,C",
      "A,B,D",
      "A,B,E",
      "A,B,F",
      "A,C,D",
      "A,C,E",
      "A,C,F",
      "A,D,E",
      "A,D,F",
      "A,E,F",
      "B,C,D",
      "B,C,E",
      "B,C,F",
      "B,D,E",
      "B,D,F",
      "B,E,F",
      "C,D,E",
      "C,D,F",
      "C,E,F",
      "D,E,F",
   );

   my(@locParam) = (
       "Walti",
       7777,
   );

   if ($debugThisFct) {
     if (performFctOnAllCombinations("displayOnePermutationResultInOnLine",\@locParam,3,@feldXXXXyy)) { print("Result(s) found.\n"); } else { print("No Result found!\n") ; }
     printf("\n");

     displayArray(getAllCombinations(3,@feldXXXXyy));
     printf("\n");

     if (performFctOnAllCombinations("displayOnePermutationResultInOnLine",\@locParam,6,@feldXXXXyy)) { print("Result(s) found.\n"); } else { print("No Result found!\n") ; }
     printf("\n");

     if (performFctOnAllCombinations("displayOnePermutationResultInOnLine",\@locParam,7,@feldXXXXyy)) { print("Result(s) found.\n"); } else { print("No Result found!\n") ; }
     printf("\n");
   }

   my(@resultList) = getAllCombinations(3,@feldXXXXyy);
   if (!(areArraysEqual(\@resultList,\@expectedResult,$TRUE,$TRUE))) {
       print("ERROR: ${myFullName} failed (A)\n");
       if ($debugThisFct) {
           print("ResultArray\n");
           displayArray(@resultList);

           print("\nExpected-ResultArray\n");
           displayArray(@expectedResult);

       }
   }

   if (areArraysEqual(\@resultList,\@feldXXXXyy,$TRUE,$TRUE)) {
       print("ERROR: ${myFullName} failed (A-1)\n");
       if ($debugThisFct) {
           print("ResultArray\n");
           displayArray(@resultList);

           print("\nExpected-ResultArray\n");
           displayArray(@expectedResult);

       }
   }

}

sub getAllCombinations {
  my($groupSize,@elemetList) = @_;

  @permutationResult_GLOBAL = ();
  performFctOnAllCombinations("putPermutationResultToList","",$groupSize,@elemetList);
  return @permutationResult_GLOBAL;
}

# Alle Kombinationen (Keine Wiederholungen, Reihenfolgen unwichtig) (z.B. Alle 2 Gruppen aus 7 Mannschaften => 21)
sub performFctOnAllCombinations {
  my($fctName,$fctParameterRef,$groupSize,@elemetList) = @_;
  my $countOfElements = @elemetList;
  my $maxCountOfCombinations = nTiefk($countOfElements,$groupSize);
  if ($groupSize > $countOfElements) { return $FALSE; }
  my $countOfCombination = 0;
  my(@combine)  = ();
  combinations(\@elemetList,0,\@combine,$groupSize,0,$countOfElements - $groupSize,$fctName,\$countOfCombination,$maxCountOfCombinations,@$fctParameterRef);
  return $TRUE;
}

# ------------------------------------------------------------------------------------------------

sub doTest_performFctOnAllVariations {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my(@feldXXXXyy) = (
      "A",
      "B",
      "C",
      "D",
   );

   my(@expectedResult) = (
      "A,B,C",
      "B,A,C",
      "C,B,A",
      "B,C,A",
      "A,C,B",
      "C,A,B",
      "A,B,D",
      "B,A,D",
      "D,B,A",
      "B,D,A",
      "A,D,B",
      "D,A,B",
      "A,C,D",
      "C,A,D",
      "D,C,A",
      "C,D,A",
      "A,D,C",
      "D,A,C",
      "B,C,D",
      "C,B,D",
      "D,C,B",
      "C,D,B",
      "B,D,C",
      "D,B,C",
   );

   my(@locParam) = (
       "Walti",
       7777,
   );

   if ($debugThisFct) {
     performFctOnAllVariations("displayOnePermutationResultInOnLine",\@locParam,3,@feldXXXXyy);
     displayArray(getAllVariations(3,@feldXXXXyy));
   }

   my(@resultList) = getAllVariations(3,@feldXXXXyy);
   if (!(areArraysEqual(\@resultList,\@expectedResult,$TRUE,$TRUE))) {
       print("ERROR: ${myFullName} failed (A)\n");
       if ($debugThisFct) {
           print("ResultArray\n");
           displayArray(@resultList);

           print("\nExpected-ResultArray\n");
           displayArray(@expectedResult);

       }
   }

   if (areArraysEqual(\@resultList,\@feldXXXXyy,$TRUE,$TRUE)) {
       print("ERROR: ${myFullName} failed (A-1)\n");
       if ($debugThisFct) {
           print("ResultArray\n");
           displayArray(@resultList);

           print("\nExpected-ResultArray\n");
           displayArray(@expectedResult);

       }
   }

}

sub getAllVariations {
  my($groupSize,@elemetList) = @_;

  @permutationResult_GLOBAL = ();
  performFctOnAllVariations("putPermutationResultToList","",$groupSize,@elemetList);
  return @permutationResult_GLOBAL;
}

# Alle Variationen (Keine Wiederholungen, Reihenfolgen wichtig) (z.B. Alle 2 Gruppen aus 7 Mannschaften mit Heimspielen => 42)
sub performFctOnAllVariations {
  my($fctName,$fctParameterRef,$groupSize,@elemetList) = @_;
  my $countOfElements = @elemetList;
  if ($groupSize > $countOfElements) { return $FALSE; }
  my $maxCountOfVariations = nTiefk($countOfElements,$groupSize) * factorials($groupSize);
  my $countOfVariation = 0;

  my(@combine)  = ();
  variations(\@elemetList,0,\@combine,$groupSize,0,$countOfElements - $groupSize,$fctName,\$countOfVariation,$maxCountOfVariations,@$fctParameterRef);
  return $TRUE;
}

# ------------------------------------------------------------------------------------------------


# Alle Variationen von n-groups out of a k elements ==> (n tief k) * n!
sub variations {
  my($mat, $start, $combine, $sizec, $column, $loop, $fctName, $variationCountRef, $maxCountOfVariations,@fctParameter) = @_;

  my $localloop  = $loop;
  my $localstart = $start;
	
  if($column > ($sizec-1)) 	{
     # generate all permutation from that combination
     my(@elemetList) = @$combine;
     my $countOfElements = @elemetList;
     @elemetList = ("....",@elemetList);
     permutation($countOfElements,\@elemetList,$fctName,$variationCountRef,$maxCountOfVariations,@fctParameter);
     return;
  }

  for (my $i=0; $i <= $loop; $i++) {
    $combine->[$column]=$mat->[$start+$i];
    $localstart++;
    variations($mat,$localstart,$combine,$sizec,$column+1,$localloop,$fctName,$variationCountRef,$maxCountOfVariations,@fctParameter);
    $localloop--;
  }
  return;
}

# Alle Kombinationen von n-groups out of a k elements ==> n tief k
sub combinations {
  my($mat, $start, $combine, $sizec, $column, $loop, $fctName, $combinationCountRef, $maxCountOfCombinations,@fctParameter) = @_;

  my $localloop  = $loop;
  my $localstart = $start;
	
  if($column > ($sizec-1)) 	{
     $$combinationCountRef++;
     &$fctName($combine,$$combinationCountRef,$maxCountOfCombinations,@fctParameter);
     return;
  }

  for (my $i=0; $i <= $loop; $i++) {
    $combine->[$column]=$mat->[$start+$i];
    $localstart++;
    combinations($mat,$localstart,$combine,$sizec,$column+1,$localloop,$fctName,$combinationCountRef,$maxCountOfCombinations,@fctParameter);
    $localloop--;
  }
  return;
}

# Alle Vertauschungen von n Elementen ==> n!
sub permutation {
   my($ind,$fieldRef,$fctName,$permutationCountRef,$maxOfPermutation,@fctParameter) = @_;
   $fctName = setDefault($fctName,"displayOnePermutationResultInOnLine");
   if ($ind == 1) {
      $$permutationCountRef++;
      my(@retList) = @$fieldRef;
      @retList = getSubsetFromArray(1,"",@retList);
      &$fctName(\@retList,$$permutationCountRef,$maxOfPermutation,@fctParameter);
   } else {
      permutation($ind - 1,$fieldRef,$fctName,$permutationCountRef,$maxOfPermutation,@fctParameter);
      foreach (my $i=1; $i <= ($ind - 1); $i++) {
         swapArrayFields($i,$ind,$fieldRef);
         permutation($ind - 1,$fieldRef,$fctName,$permutationCountRef,$maxOfPermutation,@fctParameter);
         swapArrayFields($i,$ind,$fieldRef);
      }
   }
}



sub putPermutationResultToList {
   my($feldRef,$num,$maxNum,@param) = @_;
   my $countOfElem = @feld;
   push(@permutationResult_GLOBAL,makeQuotedStrFromArray(",","",@$feldRef));
}

sub displayOnePermutationResultInOnLine {
   my($feldRef,$num,$maxNum,@param) = @_;
   my $countOfElem = @feld;
   print("${num}/$maxNum: ".makeQuotedStrFromArray(",","",@$feldRef)."  ==> ".makeQuotedStrFromArray(",","",@param)."\n");
}
############################################################################
# math functions
############################################################################
sub summation {
	my($summand_1,$summand_2) = @_;
	return $summand_1 + $summand_2;
}

sub product {
	my($factor_1,$factor_2) = @_;
	return $factor_1 * $factor_2;
}

sub doTest_nTiefk {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);
   
   if (!(nTiefk(5,3) == 10)) {
       print("ERROR: ${myFullName} failed (A)\n");
   }
   if (!(nTiefkNormal(5,3) == nTiefk(5,3))) {
       print("ERROR: ${myFullName} failed (B)\n");
   }
}


# n! / (k! * (n-k)!)
sub nTiefkNormal {
  my($n,$k) = @_;
  if ($n == $k) { return 0; }
  return facultaet($n) / (facultaet($k) * facultaet($n-$k));
}

# n*(n-1)*(n-2)*(n-3)*...(n-k+1) / k!
sub nTiefk {
  my($n,$k) = @_;
  if ($n == $k) { return 1; }
  my $q = $n;
  for(my $i =1; $i < $k; $i++){
    $q = $q * ($n -$i);
  }
  return $q / facultaet($k);
}

sub doTest_factorials {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);
   
   if (!(facultaet(5) == 120)) {
       print("ERROR: ${myFullName} failed (A)\n");
   }
}

# return value!
sub factorials {
  my($value) = @_;
  return facultaet($value);
}

# return value!
sub facultaet {
  my($value) = @_;
  if ($value == 2) { return 2; }
  if ($value == 1) { return 1; }
  if ($value < 1)  { return 0; }
  return $value * facultaet($value - 1);
}

sub doTest_zehnHoch {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   if (!(zehnHoch(2) == 100)) {
       print("ERROR: ${myFullName} failed (A)\n");
   }
   if (!(zehnHoch(-2) == 0.01)) {
       print("ERROR: ${myFullName} failed (B)\n");
   }
   if (!(zehnHoch(-3) == 0.001)) {
       print("ERROR: ${myFullName} failed (C)\n");
   }
}

sub zehnHoch {
  my($potenz) = @_;
  my $retVal = 1;
  my $isNegativ = ($potenz < 0);
  $potenz = abs($potenz);
  foreach (my $i=1; $i<=$potenz; $i++) {
      $retVal *= 10;
  }
  if ($isNegativ) {
    $retVal = 1/$retVal;
  }  
  return $retVal;
}

sub sqr {
  my($inVal) = @_;
  return $inVal * $inVal;
}


# The two points (x1/y1) and (x2/y2) define a line. The function returns
# the y value for x defined by that line 
sub linearInterpolation {
   my($x1,$y1,$x2,$y2,$x) = @_;
   my($a)  = 100000000;
   if ($x1 != $x2) {
      $a = (($y1-$y2)/($x1-$x2));
   } else {
      return "";
   }
   my($c)  = $y1 - ($a*$x1);
   my($y)  = ($a*$x) + $c;
   return $y
}

# Passing %points (x/y values) this functions finds the best two points to do
# an Interpolation or Extrapolation
# e.g.  %points = (
#          -1 => 1,
#          1  => 1,
#          2  => 3,
#          3  => 2,
#          4  => 5,
#          5  => 10,
#      )'
#
# To prepare %points use function preparePointsHashForInterpolation()
sub doLinearInterOrExtrapolation {
    my($x,%points) = @_;
    my($doTrace)   = $FALSE;


    # check first if requested value is already a defined point
    if (exists($points{$x})) {
        if ($doTrace) { print("Requested value found already in given points\n"); }
        return $points{$x};
    }

    # look for the best two points to do the Inter-/Extra-Polation
    my($lowerX)       = "";
    my($lowerY)       = "";
    my($higherX)      = "";
    my($higherY)      = "";

    my(@xValues) = ();
    @xValues = keys %points;
    my(@sortedxValues) = ();
    @sortedxValues = (sort { $a <=> $b } @xValues);
    my($countOfPoints) = 0;
    $countOfPoints = @sortedxValues;
    if ($countOfPoints < 2) {
       return "ERROR: Need minimum 2 points to interpolate";
    }
    my($xValue) = "";
    my($first)  = $TRUE;
    my($xMin)   = $sortedxValues[0];
    my($xMax)   = $sortedxValues[$countOfPoints-1];
    if ($doTrace) { print("xMin:${xMin}:   xMax:${xMax}\n"); }
    if ($x <= $xMin) {
         if ($doTrace) { print("Extrapolation on lower end for ${x}\n"); }
         $lowerX   = $sortedxValues[0];
         $higherX  = $sortedxValues[1];
    } elsif ($x >= $xMax) {
         if ($doTrace) { print("Extrapolation on higher end for ${x}\n"); }
         $lowerX   = $sortedxValues[$countOfPoints-2];
         $higherX  = $sortedxValues[$countOfPoints-1];
    } else {
         if ($doTrace) { print("Interpolation possible for ${x}\n"); }
         foreach $xValue (@sortedxValues) {
           if ($doTrace) { print("xValue:${xValue}:\n"); }
           if ($xValue <= $x) {
             $lowerX    = $xValue;
             $higherX   = $xValue;
           }
           if ($xValue >= $x) {
             $higherX   = $xValue;
             last;
           }
         }
    }
    $lowerY   = $points{$lowerX};
    $higherY  = $points{$higherX};

    if ($doTrace) { print("Lower :(${lowerX}/${lowerY})\n"); }
    if ($doTrace) { print("Higher:(${higherX}/${higherY})\n"); }


    # calculate y for x using that line
    my($y) = linearInterpolation($lowerX,$lowerY,$higherX,$higherY,$x);
    if ($doTrace) { print("y=${y}\n\n"); }
    return $y;
}

sub calcAverageFromArray {
  my(@inArr) = @_;
  my $count = @inArr;
  if ($count == 0) { return -1; }
  return calcSumFromArray(@inArr) / $count;
}

sub calcSumFromArray {
  my(@inArr) = @_;
  my $sum = 0;
  foreach my $aElem (@inArr) {
     $sum = $sum + $aElem;
  }
  return $sum;
}

sub calcSqrFromEachArrayElement {
  my(@inArr) = @_;
  my(@res)   = ();
  foreach my $aElem (@inArr) {
     push(@res,$aElem*$aElem);
  }
  return @res;
}


sub doTest_calcVarianceFromArray {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my(@testSeries) = (
      "0.8","0.48",
      "0.2","0.48",
      "0.4","0.48",
      "0.5","0.48",
      "0.5","0.48",
   );

   my $expectedRes = "0.020888"."888888"."8888";

   my $varinance = calcVarianceFromArray(@testSeries);
   if ($debugThisFct) {
     print("Variance is ${varinance}\n");
   }

   if (($varinance ne $expectedRes)) {
       print("ERROR: ${myFullName} failed (A) Ist:${varinance}  Soll:${expectedRes}\n");
   }
}

# n*sum(x^2) - (sum(x))^2 / n*(n-1)
sub calcVarianceFromArray {
  my(@inArr) = @_;
  my $n = @inArr;
  my $sum = calcSumFromArray(@inArr);
  my $sumFromSqr = calcSumFromArray(calcSqrFromEachArrayElement(@inArr));
  my $sqrFromSum = sqr($sum);
  my $quotient = $n*($n-1);

  return (($n*$sumFromSqr) - $sqrFromSum) / $quotient;
}


# all linearFct are based on the y=ax+b;
sub linearGet_a {
   my($x1,$y1,$x2,$y2) = @_;
   return (($y1-$y2) / ($x1-$x2));
}

sub linearGet_b {
   my($x1,$y1,$x2,$y2) = @_;
   return $y1 - (linearGet_a($x1,$y1,$x2,$y2)* $x1);
}

sub linearGet_y2 {
   my($a,$b,$x2) = @_;
   return ($a * $x2) + $b;
}

sub linearGet_x2 {
   my($a,$b,$y2) = @_;
   return ($y2 - $b) / $a;
}

# Schnittpunkt
sub linearGet_x0 {
   my($a1,$b1,$a2,$b2) = @_;
   return ($b2 - $b1) / ($a1 - $a2);
}

sub linearGet_y0 {
   my($a1,$b1,$a2,$b2) = @_;
   return ($a1 * linearGet_x0($a1,$b1,$a2,$b2)) + $b1;
}

sub linearGet_distance {
   my($x1,$y1,$x2,$y2) = @_;
   return sqrt(sqr($x2 - $x1) + sqr($y2 - $y1));
}

sub linearGet_Alpha {
   my($x1,$y1,$x2,$y2,$inGrad) = @_;
   $inGrad = setDefault($inGrad,$TRUE);
   return kartesischToPolarGet_Alpha($x2-$x1,$y2-$y1,$inGrad);
}

sub polarToKartesischGet_x {
   my($alpha,$distance,$inGrad) = @_;
   $inGrad = setDefault($inGrad,$TRUE);
   return sinAlpha($alpha,$inGrad)*$distance;
}

sub polarToKartesischGet_y {
   my($alpha,$distance,$inGrad) = @_;
   $inGrad = setDefault($inGrad,$TRUE);
   return cosAlpha($alpha,$inGrad)*$distance;
}

sub kartesischToPolarGet_Alpha {
   my($x,$y,$inGrad) = @_;
   $inGrad = setDefault($inGrad,$TRUE);
   my $angle = 0;
   if ($x == 0) {
     if ($y>0) { 
        $angle = 0; 
     } else {
        $angle = $pi; 
     }
   }

   if ($y == 0) {
     if ($x>0) { 
        $angle = $pi/2; 
     } else {
        $angle = $pi*1.5; 
     }
   }


   if (($x>0) && ($y>0)) { $angle = arcTan($x/$y,$FALSE); }
   if (($x>0) && ($y<0)) { $angle = ($pi/2) + arcTan(abs($y)/$x,$FALSE); }
   if (($x<0) && ($y<0)) { $angle = $pi + arcTan(abs($x)/abs($y),$FALSE); }
   if (($x<0) && ($y>0)) { $angle = ($pi*1.5) +arcTan($y/abs($x),$FALSE); }
   if ($inGrad) { $angle = radToDegree($angle); }
   return $angle;
}

sub kartesischToPolarGet_Distance {
   my($x1,$y1) = @_;
   return sqrt(sqr($x1) + sqr($y1));
}



sub doTest_trigonometrie {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   if ($debugThisFct) {
     print(" 90 Grad should be ".radToDegree($pi/2)." Grad\n");
     print("180 Grad should be ".radToDegree($pi)." Grad\n");

     print(" ${pi} Rad should be ".degreeToRad(180)." Rad\n");
     print(" ".($pi/2)." Rad should be ".degreeToRad(90)." Rad\n\n");

     print("0.8 should be ".sinAlpha(53.13)."\n");
     print("0.6 should be ".cosAlpha(53.13)."\n");
     print("1.333 should be ".tanAlpha(53.13)."\n\n");

     print("53.13 should be ".arcSin(0.8)."\n");
     print("53.13 should be ".arcCos(0.6)."\n");
     print("53.13 should be ".arcTan(1.333)."\n\n");

     print("4 should be ".polarToKartesischGet_x(53.13,5)."\n");    
     print("3 should be ".polarToKartesischGet_y(53.13,5)."\n");   
     print("3 should be ".polarToKartesischGet_x(143.13,5)."\n");    
     print("-4 should be ".polarToKartesischGet_y(143.13,5)."\n");   
     print("-4 should be ".polarToKartesischGet_x(233.13,5)."\n");    
     print("-3 should be ".polarToKartesischGet_y(233.13,5)."\n");   
     print("-3 should be ".polarToKartesischGet_x(323.13,5)."\n");    
     print("4 should be ".polarToKartesischGet_y(323.13,5)."\n\n");   

     print("5 should be ".kartesischToPolarGet_Distance(4,3)."\n"); 
     print("53.13 should be ".kartesischToPolarGet_Alpha(4,3)."\n");    
     print("5 should be ".kartesischToPolarGet_Distance(3,-4)."\n"); 
     print("143.13 should be ".kartesischToPolarGet_Alpha(3,-4)."\n");    
     print("5 should be ".kartesischToPolarGet_Distance(-4,-3)."\n"); 
     print("233.13 should be ".kartesischToPolarGet_Alpha(-4,-3)."\n");    
     print("5 should be ".kartesischToPolarGet_Distance(-3,4)."\n"); 
     print("323.13 should be ".kartesischToPolarGet_Alpha(-3,4)."\n\n");    

     print("5 should be ".kartesischToPolarGet_Distance(0,5)."\n"); 
     print("0 should be ".kartesischToPolarGet_Alpha(0,5)."\n");    
     print("5 should be ".kartesischToPolarGet_Distance(5,0)."\n"); 
     print("90 should be ".kartesischToPolarGet_Alpha(5,0)."\n");   
     print("5 should be ".kartesischToPolarGet_Distance(0,-5)."\n"); 
     print("180 should be ".kartesischToPolarGet_Alpha(0,-5)."\n");
     print("5 should be ".kartesischToPolarGet_Distance(-5,0)."\n"); 
     print("270 should be ".kartesischToPolarGet_Alpha(-5,0)."\n");     

     mapCalculation();
   }
}

sub showMenu_mapCalculation {
   my $answer = "";
   my $x1,$y1,$x2,$y2,$x0,$y0,$a1,$b1,$a2,$b2 = 0;
   my $distance = 0;
   my $angle1,$angle2 = 0;
   do {
     VT52_cls_home();
     print(unterstreichen("MAP-Calc","="));
     print("1: 2 Punkte                   ==> Distance, Azimut\n");
     print("2: 1 Punkt, Distance, Azimut  ==> 2.Punkt\n");
     print("3: 2 Punkte und je ein Azimut ==> Schnittpunkt-Punkt\n");
     print("4: 2 Geraden                  ==> Schnittpunkt-Punkt\n");


     print("\n");
     print("0: Ende\n");
     $answer = readln("Auswahl",0);
     print("\n");
     if ($answer eq "1") {
        $x1 = readln("x1",$x1);
        $y1 = readln("y1",$y1);
        $x2 = readln("x2",$x2);
        $y2 = readln("y2",$y2);

        $distance = linearGet_distance($x1,$y1,$x2,$y2);
        $angle1   = linearGet_Alpha($x1,$y1,$x2,$y2,$TRUE);

        print("Azimut:${angle1}  Distanz:${distance}\n");
     }

     if ($answer eq "2") {
        $x1 = readln("x1",$x1);
        $y1 = readln("y1",$y1);
        $distance = readln("distance",$distance);
        $angle1 = readln("angle1",$angle1);

        $x2 = $x1 + polarToKartesischGet_x($angle1,$distance);
        $y2 = $y1 + polarToKartesischGet_y($angle1,$distance);

        print("x2:${x2}  y2:${y2}\n");
     }

     if ($answer eq "3") {
        $x1 = readln("x1",$x1);
        $y1 = readln("y1",$y1);
        $angle1 = readln("angle1",$angle1);

        my $x1a = $x1 + polarToKartesischGet_x($angle1,1);
        my $y1a = $y1 + polarToKartesischGet_y($angle1,1);
        $a1 = linearGet_a($x1,$y1,$x1a,$y1a);
        $b1 = linearGet_b($x1,$y1,$x1a,$y1a);
        print("x1a:${x1a}  y1a:${y1a}   a1:${a1}  b1:${b1}\n");


        $x2 = readln("x2",$x2);
        $y2 = readln("y2",$y2);
        $angle2 = readln("angle2",$angle2);

        my $x2a = $x2 + polarToKartesischGet_x($angle2,1);
        my $y2a = $y2 + polarToKartesischGet_y($angle2,1);
        $a2 = linearGet_a($x2,$y2,$x2a,$y2a);
        $b2 = linearGet_b($x2,$y2,$x2a,$y2a);
        print("x2a:${x2a}  y2a:${y2a}   a2:${a2}  b2:${b2}\n");

        my $x0 = linearGet_x0($a1,$b1,$a2,$b2);
        my $y0 = linearGet_y0($a1,$b1,$a2,$b2);

        print("x0:${x0}  y0:${y0}\n");
     }

     if ($answer eq "4") {
        $a1 = readln("a1",$a1);
        $b1 = readln("b1",$b1);

        $a2 = readln("a2",$a2);
        $b2 = readln("b2",$b2);
 

        my $x0 = linearGet_x0($a1,$b1,$a2,$b2);
        my $y0 = linearGet_y0($a1,$b1,$a2,$b2);

        print("x0:${x0}  y0:${y0}\n");
     }
     
   } until ($answer eq "0");
}

sub radToDegree {
   my($rad) = @_;
   return 180 *  $rad / $pi;
}

sub degreeToRad {
   my($degree) = @_;
   return $pi *  $degree / 180;
}

# sin(x) = hypothenuse / gegenkathete  ==> use sin() fct from perl
sub sinAlpha {
  my($alpha,$inGrad) = @_;
  $inGrad = setDefault($inGrad,$TRUE);
  if ($inGrad) { $alpha = degreeToRad($alpha); }
  return sin($alpha);
}

# cos(x) = hypothenuse / ankathete     ==> use cos() fct from perl
sub cosAlpha {
  my($alpha,$inGrad) = @_;
  $inGrad = setDefault($inGrad,$TRUE);
  if ($inGrad) { $alpha = degreeToRad($alpha); }
  return cos($alpha);
}

# tan(x) = ankathete/ gegenkathete
sub tanAlpha {
  my($alpha,$inGrad) = @_;
  $inGrad = setDefault($inGrad,$TRUE);
  if ($inGrad) { $alpha = degreeToRad($alpha); }
  return (sin($alpha) / cos($alpha));
}

sub arcSin {
  my($quotient,$inGrad) = @_;
  $inGrad = setDefault($inGrad,$TRUE);
  my $angle = atan2($quotient, sqrt(1-$quotient * $quotient));
  if ($inGrad) { $angle = radToDegree($angle); }
  return $angle;
}

sub arcCos {
  my($quotient,$inGrad) = @_;
  $inGrad = setDefault($inGrad,$TRUE);
  my $angle = atan2(sqrt(1-$quotient * $quotient),$quotient);
  if ($inGrad) { $angle = radToDegree($angle); }
  return $angle;
}

sub arcTan {
  my($quotient,$inGrad) = @_;
  $inGrad = setDefault($inGrad,$TRUE);
  my $angle = atan2($quotient,1);
  if ($inGrad) { $angle = radToDegree($angle); }
  return $angle;
}


############################################################################
# Function for figure-string manipulating
############################################################################
sub trunc {
	my($inVal) = @_;
	$inVal =~ s/\'//g;
	my @parts  = split(/\./,$inVal);
	my $retVal = $parts[0] + 0;
	return $retVal;
}

sub round {
	my($inVal) = @_;
	$inVal =~ s/\'//g;
	$inVal = $inVal + 0.5;
	my @parts  = split(/\./,$inVal);
	my $retVal = $parts[0] + 0;
	return $retVal;
}

sub doTest_roundAmount {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   if (!(roundAmount("23.456",2,$FALSE) eq "23.46")) {
       print("ERROR: ${myFullName} failed (A)\n");
   }
   if (!(roundAmount("23.454",2,$FALSE) eq "23.45")) {
       print("ERROR: ${myFullName} failed (B)\n");
   }
   if (!(roundAmount(2345.123+0.5,0,$FALSE) eq "2346")) {
       print("ERROR: ${myFullName} failed (C)\n");
   }
   if (!(roundAmount(2345.67+0.5,0,$FALSE) eq "2346")) {
       print("ERROR: ${myFullName} failed (D)\n");
   }
   if (!(roundAmount("23.452",2,$TRUE) eq "23.45")) {
       print("ERROR: ${myFullName} failed (E)\n");
   }
   if (!(roundAmount("23.474",2,$TRUE) eq "23.45")) {
       print("ERROR: ${myFullName} failed (F)\n");
   }
   if (!(roundAmount("23.475",2,$TRUE) eq "23.50")) {
       print("ERROR: ${myFullName} failed (G)\n");
   }


   if (!(roundAmount("100.325",2,$TRUE) eq "100.35")) {
       print("ERROR: ${myFullName} failed (H)\n");
   }
   if (!(roundAmount("100.315",2,$TRUE) eq "100.30")) {
       print("ERROR: ${myFullName} failed (J)\n");
   }
   if (!(roundAmount("100.335",2,$TRUE) eq "100.35")) {
       print("ERROR: ${myFullName} failed (I)\n");
   }
   if (!(roundAmount("100.335",2,$FALSE) eq "100.34")) {
       print("ERROR: ${myFullName} failed (K)\n");
   }
   if (!(roundAmount("100.355",2,$TRUE) eq "100.35")) {
       print("ERROR: ${myFullName} failed (L)\n");
   }
   if (!(roundAmount("100.375",2,$TRUE) eq "100.40")) {
       print("ERROR: ${myFullName} failed (M)\n");
   }
   if (!(roundAmount("100.385",2,$TRUE) eq "100.40")) {
       print("ERROR: ${myFullName} failed (N)\n");
   }
   if (!(roundAmount("100.985",2,$TRUE) eq "101.00")) {
       print("ERROR: ${myFullName} failed (O)\n");
   }
}

sub roundAmount {
  my($inVal,$stellen,$rundeZu5) = @_;
  my $isNegativ = $FALSE;

  if ($inVal < 0) {
     $isNegativ = $TRUE;
     $inVal =~ s/-//g;
  }
  my $factor = 1;

  if ($rundeZu5) {
      $factor = 2;
  }
  if ($stellen > 1) {
     if ($factor == 2) {
       $factor = $factor * zehnHoch($stellen - 1);
     } else {
       $factor = $factor * zehnHoch($stellen);
     }
  }
  my $retVal = $inVal * $factor;
  $retVal = round($retVal);
  $retVal = $retVal/$factor;
  
  # add 0 at the end
  my $nachKommastellen = length($retVal) - index($retVal,".") - 1;
  if (index($retVal,".") == -1) {
    $nachKommastellen = 0;
    if ($stellen > 0) {
      $retVal = "${retVal}.";
    }
  }
  ### print("retVal:$retVal:       nachKommastellen:${nachKommastellen}\n");
  if ($nachKommastellen < $stellen) {
     $retVal = sprintf("${retVal}%s",getRepeatedCharStr($stellen - $nachKommastellen,"0"));
  } 

  if ($isNegativ) {
     $retVal = "-${retVal}";
  }
  return $retVal;
}

# if stellenZahl < 0 the padding is done at the end otherwise at the beginning
sub paddenNull {
    my($inZahl,$stellenZahl,$padChr)  = @_;
    my($formatStr) = sprintf ("%%%ss",$stellenZahl);
    my($tmpStr)    = sprintf ($formatStr,$inZahl);
    $tmpStr =~ s/ /$padChr/g;
    return $tmpStr;
} # end of paddenNull

sub doTest_realFormat {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my($expectedRes) = "124.5678";
   my($resStr)      = realFormat("124,5678",4,"0",".");
   if (!($resStr eq $expectedRes)) {
       print("ERROR: ${myFullName} failed (A)\n");
   }

   $expectedRes = "124.5678";
   $resStr      = realFormat("    124,5678    ",4,"0",".");
   if (!($resStr eq $expectedRes)) {
       print("ERROR: ${myFullName} failed (B)\n");
   }

   $expectedRes = "124,56";
   $resStr      = realFormat("124,5678",2,"0",",");
   if (!($resStr eq $expectedRes)) {
       print("ERROR: ${myFullName} failed (C)\n");
   }

   $expectedRes = "124.5678";
   $resStr      = realFormat("124,5678",4,"0",".");
   if (!($resStr eq $expectedRes)) {
       print("ERROR: ${myFullName} failed (D)\n");
   }

   $expectedRes = $ERROR;
   $resStr      = realFormat("124,5aaa678",4,"0",".");
   if (!($resStr eq $expectedRes)) {
       print("ERROR: ${myFullName} failed (E)\n");
   }

   $expectedRes = "-123.4567";
   $resStr      = realFormat("-123.456789",4,"0",".",$TRUE,$TRUE);
   if (!($resStr eq $expectedRes)) {
       print("ERROR: ${myFullName} failed (F)\n");
   }

   $expectedRes = $ERROR;
   $resStr      = realFormat("-123.456789",4,"0",".",$TRUE,$FALSE);
   if (!($resStr eq $expectedRes)) {
       print("ERROR: ${myFullName} failed (G)\n");
   }

   $expectedRes = $ERROR;
   $resStr      = realFormat("-123.45-6789",4,"0",".");
   if (!($resStr eq $expectedRes)) {
       print("ERROR: ${myFullName} failed (H)\n");
   }

}

# replaces in a string a , with a . for the decimal separator.
# returns $ERROR if the conversion fails
sub realFormat {
	my($inZahl,$decimals,$padChr,$decSep,$doCut,$allowNegativValues)  = @_;
	$padChr             = setDefault($padChr,"0");
	$decSep             = setDefault($decSep,".");
	$doCut              = setDefault($doCut,$TRUE);
	$allowNegativValues = setDefault($allowNegativValues,$TRUE);


	my @fields  = ();
	my $retVal  = "";
	my $sign    = "";

	$inZahl  =~ s/ //g;
	$inZahl  =~ s/,/./g;
    
		if ((index($inZahl,"-") == 0) && ($allowNegativValues)) {
		$sign = "-";
		$inZahl  =~ s/-//;
	}
	@fields = split(/\./,$inZahl);
	my $count = @fields;
	if ($count > 2) {
		return $ERROR;
	}
	my $nachKomma = paddenNull("",-$decimals,$padChr);
	if ($count == 2) {
		$nachKomma = paddenNull($fields[1],-$decimals,$padChr);
	}
	my $vorKomma = $fields[0];
	if (($doCut) && (length($nachKomma)>$decimals)) {
		$nachKomma = substr($nachKomma,0,$decimals);
	}
	if (($vorKomma =~ /\D/) || ($nachKomma =~ /\D/)) {
		return $ERROR;
	}
	$retVal = "${sign}${vorKomma}${decSep}${nachKomma}";
	return $retVal;
}

sub readCurr {
	my($inZahl,$language)  = @_;
	$language = setDefault($language,$DefaultLang);
	my $retVal   = "";
	my $decPoint = "";

	$inZahl = strip($inZahl);
	$inZahl  =~ s/\'//g;
	if (($inZahl=~ /\./) && ($inZahl=~ /\,/)) {
		if ($language eq $LangEnglish) {
			$decPoint = ".";
		} else {
			$decPoint = ",";
		}
	} elsif (($inZahl=~ /\./) && (!($inZahl=~ /\,/))) {
		$decPoint = ".";
	} elsif ((!($inZahl=~ /\./)) && ($inZahl=~ /\,/)) {
		$decPoint = ",";
	} else {
		$decPoint = ".";
		$inZahl = "${inZahl}.";
	}

	my @fields = ();
	if ($decPoint eq ".") {
		@fields = split(/\./,$inZahl);
	} else {
		@fields = split(/,/,$inZahl);
	}
	my $vorKomma  = $fields[0];   $vorKomma  =~ s/\D//g;
	my $nachKomma = $fields[1];   $nachKomma =~ s/\D//g;
	$retVal = "${vorKomma}${decPoint}${nachKomma}";
	return $retVal;
} # end of readCurr

sub doTest_currFormat {
	my($myFullName,$debugThisFct) = @_;
	$debugThisFct = setDefault($debugThisFct,$FALSE);

	if (!(currFormat("-731.0",2,"0",".","'",$TRUE) eq "-731.00")) {
		print("ERROR: ${myFullName} failed (A)\n");
	}
	if (!(currFormat(157.0067,2,0,".","'") eq "157.00")) {
		print("ERROR: ${myFullName} failed (B)\n");
	}
	if (!(currFormat("-157.0067",2,0,".","'") eq "-157.00")) {
		print("ERROR: ${myFullName} failed (C)\n");
	} 
}

sub currFormat {
	my($inZahl,$decimals,$padChr,$commaChar,$milSep,$rundeZu5)  = @_;

	$rundeZu5 = setDefault($rundeZu5,$FALSE);
	my @fields   = ();
	my $retVal   = "";
	my $isNegativ = $FALSE;
	if ($commaChar eq "") { $commaChar = "."; }
	if ($milSep    eq "") { $milSep    = "'"; }

	$inZahl  =~ s/ //g;
	$inZahl  =~ s/,/./g;

	$inZahl = roundAmount($inZahl,$decimals,$TRUE);
	@fields = split(/\./,$inZahl);

	my $nachKomma   = paddenNull($fields[1],-$decimals,$padChr);
	my $i           = 0;
	my $count       = 0;
	my $vorKomma    = "";
	my $vorKommaStr = $fields[0]; 
	if (index($vorKommaStr,"-") >= 0) {
		$isNegativ = $TRUE;
		$vorKommaStr = abs($vorKommaStr);
	}
	foreach ($i=length($vorKommaStr)-1; $i>=0; $i--) {
		$vorKomma = substr($vorKommaStr,$i,1).$vorKomma;
		$count++;
		if (($count >=3) && ($i>0)) {
			$vorKomma = "${milSep}${vorKomma}";
			$count = 0;
		}
	}
	$retVal = "${vorKomma}${commaChar}${nachKomma}";
	if ($isNegativ) {
		$retVal = "-${retVal}";
	}
	return $retVal;
} # end of zahlFormat


sub doTest_getFigureFromString {
	my($myFullName,$debugThisFct) = @_;
	$debugThisFct = setDefault($debugThisFct,$FALSE);

	my $aString = "Dies ist ein Betrag von 13'456.78 4567 zu bezahlen bis";
	my $amount  = getFigureFromString($aString,30,".","'",$FALSE);

	if (!($amount eq "13'456.78")) {
		print("ERROR: ${myFullName} failed (A)\n");
	}
}

# returns a figure out from a string where $decimalPos is the decimal seperator
# first character ist 0
# e.g.
# $aString = "Dies ist ein Betrag von 13'456.78 zu bezahlen bis";
# $amount  = getFigureFromString($aString,30,".","'");
#   --> 13'456.78
sub getFigureFromString {
   my($str,$decimalPos,$decChar,$milSep,$eliminatMilSep) = @_;
   $decChar        = setDefault($decChar,".");
   $milSep         = setDefault($milSep,"'");
   $eliminatMilSep = setDefault($eliminatMilSep,$TRUE);

   my $retStr = "";
   my $charAtDecPos = substr($str,$decimalPos,1);
   if ($charAtDecPos eq $decChar) {
       my $lowPos  = $decimalPos-1;
       my $highPos = $decimalPos+1;
       while (substr($str,$highPos,1) =~ /\d/) {
            $highPos++;
       }
       while ((substr($str,$lowPos,1) =~ /\d/) ||
              (substr($str,$lowPos,1) eq $milSep)) {
            $lowPos--;
       }
       $retStr = substr($str,$lowPos+1,$highPos-$lowPos-1);
   }
   if ($eliminatMilSep) {
      $retStr =~ s/$milSep//g;
   }
   return $retStr;
}

sub doTest_getIntegerFromString {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my($aString) = "Dies ist ein Betrag von 13'456 zu bezahlen bis";
   my($amount)  = getIntegerFromString($aString,29,"'");

   if (!($amount eq "13456")) {
       print("ERROR: ${myFullName} failed (A)\n");
   }
}

# returns an integer out from a string where $leftStartPos is the last char of that figure
# first character is 0
# e.g.
# $aString = "Dies ist ein Betrag von 13'456 zu bezahlen bis";
# $amount  = getIntegerFromString($aString,29,"'");
#   --> 13'456
sub getIntegerFromString {
   my($str,$leftStartPos,$milSep,$eliminatMilSep) = @_;
   $milSep         = setDefault($milSep,"'");
   $eliminatMilSep = setDefault($eliminatMilSep,$TRUE);

   my $retStr = "";
   my $charAtDecPos = substr($str,$leftStartPos,1);
   ### print("charAtDecPos:${charAtDecPos}:\n");
   if ($charAtDecPos =~ /\d/) {
       my $lowPos  = $leftStartPos-1;
       my $highPos = $leftStartPos+1;
       while ((substr($str,$lowPos,1) =~ /\d/) ||
              (substr($str,$lowPos,1) eq $milSep)) {
            $lowPos--;
       }
       $retStr = substr($str,$lowPos+1,$highPos-$lowPos-1);
   }
   if ($eliminatMilSep) {
      $retStr =~ s/$milSep//g;
   }
   return $retStr;
}

sub doTest_replaceFigureInString {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my($aString)   = "Dies ist ein Betrag von 234     13'456.78    4567 zu bezahlen bis";
   my($expectRes) = "Dies ist ein Betrag von 234         20.45    4567 zu bezahlen bis";
   my($resStr)    = replaceFigureInString($aString,"20.45",38,".","'");
   if (!($resStr eq $expectRes)) {
       print("ERROR: ${myFullName} failed (A)\n");
   }


   $aString    = "Dies ist ein Betrag von 13456,78 zu bezahlen bis";
   $expectRes  = "Dies ist ein Betrag von    20,4  zu bezahlen bis";
   $resStr     = replaceFigureInString($aString,"20,4",29,",");
   if (!($resStr eq $expectRes)) {
       print("ERROR: ${myFullName} failed (A)\n");
   }

   $expectRes  = "Dies ist ein Betrag von    20,4588 zu bezahlen bis";
   $resStr     = replaceFigureInString($aString,"20,4588",29,",");
   if (!($resStr eq $expectRes)) {
       print("ERROR: ${myFullName} failed (A)\n");
   }

   $expectRes  = "Dies ist ein Betrag von 12345620,4588 zu bezahlen bis";
   $resStr     = replaceFigureInString($aString,"12345620,4588",29,",");
   if (!($resStr eq $expectRes)) {
       print("ERROR: ${myFullName} failed (A)\n");
   }

}

# returns a string where $oldFigureStr ist replaced by $newFigureStr
# first character ist 0
# e.g.
#   $aString = "Dies ist ein Betrag von 13456,78 zu bezahlen bis";
#   $bString = replaceFigureInString($aString,"13456,78","20,45",29);
#   -->        "Dies ist ein Betrag von    20,45 zu bezahlen bis"
sub replaceFigureInString {
   my($inStr,$newFigureStr,$decPos,$decChar,$milSep) = @_;
   $decChar = setDefault($decChar,".");
   $milSep  = setDefault($milSep,"'");

   my $retStr = $inStr;
   my $charAtDecPos = substr($inStr,$decPos,1);
   if ($charAtDecPos eq $decChar) {
       my $lowPos  = $decPos-1;
       my $highPos = $decPos+1;

       my $aSpaceCame = $FASLE;
       while ($TRUE)  {
            if ($aSpaceCame) {
               if (substr($inStr,$highPos,1) =~ /\s/) {

               } else {
                   last;
               }
            } else {
               if (substr($inStr,$highPos,1) =~ /\s/) {
                   $aSpaceCame = $TRUE;
               } elsif (substr($inStr,$highPos,1) =~ /\d/) {

               } else {
                   last;
               }               
            }
            $highPos++;
       }

       $aSpaceCame = $FASLE;
       while ($TRUE) {
            if ($aSpaceCame) {
               if (substr($inStr,$lowPos,1) =~ /\s/) {

               } else {
                   last;
               }
            } else {
               if (substr($inStr,$lowPos,1) =~ /\s/) {
                   $aSpaceCame = $TRUE;
               } elsif ((substr($inStr,$lowPos,1) =~ /\d/) ||
                        (substr($inStr,$lowPos,1) eq $milSep)) {

               } else {
                   last;
               }               
            }
            $lowPos--;
       }
       my $firstPart = substr($inStr,0,$lowPos+1);
       my $secPart   = substr($inStr,$highPos);
       my $midPart   = substr($inStr,$lowPos+1,$highPos-$lowPos-1);

       ### print("firstPart:${firstPart}:\n");
       ### print("midPart  :${midPart}:\n");
       ### print("secPart  :${secPart}:\n");

       my $oldPreComLen = index($midPart,$decChar);
       my $newPreComLen = index($newFigureStr,$decChar);
       if ($oldPreComLen > $newPreComLen) {
          # 13456,78  replaced by 20,78
          $newFigureStr = sprintf("%s${newFigureStr}",getRepeatedCharStr($oldPreComLen - $newPreComLen)); 
          ### print("newFigureStr:${newFigureStr}:\n");
       } else {
          $newFigureStr = " ${newFigureStr}";
       } 
       my $oldPostComLen = length($midPart)      - index($midPart,$decChar);
       my $newPostComLen = length($newFigureStr) - index($newFigureStr,$decChar);
       if ($oldPostComLen > $newPostComLen) {
          # 13456,78  replaced by 13456,4
          $newFigureStr = sprintf("${newFigureStr}%s",getRepeatedCharStr($oldPostComLen - $newPostComLen)); 
          ### print("newFigureStr:${newFigureStr}:\n");
       } else {
          $newFigureStr = "${newFigureStr} ";
       }
       $retStr = "${firstPart}${newFigureStr}${secPart}"; 
   }
   return $retStr;
}

sub doTest_replacePlaceholdersFromHash {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my $inputString_1 = qq{
       <DEAL type='\${DEAL_type}'>
         <TradeNR>\${TradeNR}</TradeNr>
         <Version>\${Version}</Version>
         <Currency>\${Currency}</Currency>
       </DEAL>",
   };
   
   my %inputHash_1 = (
       "DEAL_type"  => "SWAP",
       "TradeNR"   => 21569132,
       "Version"   => 1,
       "Currency"  => "CHF",   
   );

   my $expectedResult_1 = qq{
       <DEAL type='SWAP'>
         <TradeNR>21569132</TradeNr>
         <Version>1</Version>
         <Currency>CHF</Currency>
       </DEAL>",
   };  
   
   my $resultStr = replacePlaceholdersFromHash($inputString_1,\%inputHash_1);
   if ($debugThisFct) {
      print("\n\nResult:${resultStr}:\n");
      print("Expected Result:${expectedResult_1}:\n");
   }
   if (!($resultStr eq $expectedResult_1)) {
       print("ERROR: ${myFullName} failed (Testcase 1)\n");
   }
}


sub replacePlaceholdersFromHash {
	my($inputString,$mappingRecRef) = @_;
	my $returnStr = $inputString;
	
	my @listOfVariableNames = keys %$mappingRecRef;
		
	foreach my $aVariableName (@listOfVariableNames) {
		my $aValue = $mappingRecRef->{$aVariableName};
		# print("aVariableName:${aVariableName}:   ==> aValue:${aValue}:\n");
		$returnStr = replaceA_DefinedVariable_InString($returnStr,$aVariableName,$aValue);
  }
	return $returnStr;
}

sub setBooleanFromCommonControl {
   my($inVal) = @_;

   return setBooleanFromYesNoStr ($inVal);
}

sub setStringFromCommonControl {
   my($inVal,$defaultVal,$replaceEnvVars) = @_;
   $replaceEnvVars = setDefault($replaceEnvVars,$TRUE); 
   if ($replaceEnvVars) {
     $inVal = replaceENV_InString($inVal);
   }
   if ($inVal eq "") {
     $inVal  = $defaultVal;
   }
   return $inVal;
}

sub setIntegerFromCommonControl {
   my($inVal,$defaultVal,$replaceEnvVars) = @_;
   $replaceEnvVars = setDefault($replaceEnvVars,$TRUE); 
   if ($replaceEnvVars) {
     $inVal = replaceENV_InString($inVal);
     $inVal =~ s/\D//g;
   }
   if ($inVal eq "") {
     $inVal  = $defaultVal;
     $inVal =~ s/\D//g;
   }
   return $inVal;
}

sub setListFromCommonControl {
   my($inVal,$onlyUseBRSep) = @_;
   $onlyUseBRSep = setDefault($onlyUseBRSep,$FALSE);
   if (!($onlyUseBRSep)) {
      $inVal =~ s/\<BR\>/\,/g;
      return trimArray(split("\,",$inVal));
   } else {
      $inVal =~ s/\<BR\>/;;;;;/g;
      return trimArray(split(";;;;;",$inVal));

   }
}

sub setListFromCommonControlRemoveComments {
   my($inVal,$onlyUseBRSep,$removeComments) = @_;
   $onlyUseBRSep   = setDefault($onlyUseBRSep,$FALSE);
   $removeComments = setDefault($removeComments,$TRUE);
   if ($removeComments) {
       return trimRemoveEmptiesAndCommentsInArray(setListFromCommonControl($inVal,$onlyUseBRSep));
   } else {
       return setListFromCommonControl($inVal,$onlyUseBRSep);
   }
}

sub doTest_setHashFromCommonControl {
	my($myFullName,$debugThisFct) = @_;
	$debugThisFct = setDefault($debugThisFct,$FALSE);

	my $testStr = "Walti => rothlin  <BR> claudia   => Collet";
 
	displayHashTable();

	my %hashRes = setHashFromCommonControl($testStr);

	my %hashResOk = (
		"Walti"   => "rothlin",
		"claudia" => "Collet",
	);

	my %hashResWrong = (
		"walti"   => "rothlin",
		"claudia" => "coll",
	);

	if (!(areHashesEqual(\%hashRes,\%hashResOk,$TRUE,$TRUE,$debugThisFct))) {
		print("ERROR: ${myFullName} failed (A)\n");
	}
	if (areHashesEqual(\%hashRes,\%hashResWrong,$TRUE,$TRUE,$debugThisFct)) {
		print("ERROR: ${myFullName} failed (A-1)\n");
	}
}


sub setHashFromCommonControl {
   my($inVal,$onlyUseBRSep,$keyValSepStr) = @_;
   $keyValSepStr = setDefault($keyValSepStr,"=>");
   return convertArrayMappingTblToHashMappingTbl($keyValSepStr,setListFromCommonControl($inVal,$onlyUseBRSep));
}

sub setHashFromCommonControlRemovingEmtyAndComments {
   my($inVal,$onlyUseBRSep,$keyValSepStr) = @_;
   $keyValSepStr = setDefault($keyValSepStr,"=>");
   return convertArrayMappingTblToHashMappingTbl($keyValSepStr, setListFromCommonControlRemoveComments($inVal,$onlyUseBRSep));
}

sub doTest_setHashFromStringOnSeveralLines {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my $inputStringFromCommonControl_1 = (
      ":SWAP =>
      select *
      from process_locks
      where LOCK_NAME = '${dealNumFromUserProcess}'
      
      :TERM =>
      select *
      from process_locks
      where LOCK_NAME = '${dealNumFromUserProcess}'"
   );

   my %expectedResult_1 = (
      "SWAP" => "select *
      from process_locks
      where LOCK_NAME = '${dealNumFromUserProcess}'",
      "TERM" => "select *
      from process_locks
      where LOCK_NAME = '${dealNumFromUserProcess}'",
   );   
   
   my %hashRes_1 = setHashFromStringOnSeveralLines($inputStringFromCommonControl_1);
   
   if ($debugThisFct) {
     print("\n\nResult\n");
     displayHashTable(%hashRes_1);
   
     print("Expected Result\n");
     displayHashTable(%expectedResult_1);
   }
   
   if (!(areHashesEqual(\%hashRes_1,\%expectedResult_1,$TRUE,$TRUE,$debugThisFct))) {
       print("ERROR: ${myFullName} failed (Testcase 1)\n");
   }
};

	
sub setHashFromStringOnSeveralLines {
   my($inVal,$hashEntriesDelimiter,$keyValueDelimiter) = @_;
   $hashEntriesDelimiter = setDefault($hashEntriesDelimiter,":");
   $keyValueDelimiter    = setDefault($keyValueDelimiter,"=>");
   
   my %returnHash = ();
   my @listOfKeyValues = split($hashEntriesDelimiter,$inVal);
   
   foreach my $oneKeyValue (@listOfKeyValues) {
   	  if ($oneKeyValue ne "") {
   	  	my($aKey,$aValue) = split($keyValueDelimiter,$oneKeyValue);
   	  	$aKey = strip($aKey);
   	  	$aValue = strip($aValue);   	  	
   	  	%returnHash = (%returnHash,($aKey,$aValue));
   	  }
   }
   return %returnHash;
}

############################################################################
# Function for screen handling (VT52)
############################################################################
$isVT52_Terminal = $TRUE;

sub VT52_cls {
   if ($isVT52_Terminal) { print("\033[2J"); }
}

sub VT52_home {
   if ($isVT52_Terminal) { print("\033[H"); }
}

sub VT52_cls_home {
   VT52_cls();
   VT52_home();
}

sub VT52_setReverse {
   if ($isVT52_Terminal) { print("\033[7m"); }
}

sub VT52_setNormal {
   if ($isVT52_Terminal) { print("\033[0m"); }
}

sub VT52_printReverse {
  my($aText) = @_;
  VT52_setReverse();
  print("${aText}");
  VT52_setNormal();
}

sub VT52_setBlink {
   if ($isVT52_Terminal) { print("\033[5m"); }
}
 
sub VT52_printBlink {
  my($aText) = @_;
  VT52_setBlink();
  print("${aText}");
  VT52_setNormal();
}

sub VT52_setBold {
   if ($isVT52_Terminal) { print("\033[1m"); }
}
 
sub VT52_printBold {
  my($aText) = @_;
  VT52_setBold();
  print("${aText}");
  VT52_setNormal();
}

sub VT52_setDouble {
   if ($isVT52_Terminal) { print("\033#6"); }
}
 
sub VT52_printDouble {
  my($aText) = @_;
  VT52_setDouble();
  print("${aText}");
  VT52_setNormal();
}

sub VT52_setUnder {
   if ($isVT52_Terminal) { print("\033[4m"); }
}
 
sub VT52_printUnder {
  my($aText) = @_;
  VT52_setUnder();
  print("${aText}");
  VT52_setNormal();
}


############################################################################
# Function for string manipulating
############################################################################
sub removeCR {
	my($inputStr) = @_;
	$inputStr =~ s/$char_CR//g;
	return $inputStr;
}

sub removeLF {
	my($inputStr) = @_;
	$inputStr =~ s/$char_LF//g;
	return $inputStr;
}


sub getEnvVal {
	my($varName,$notFoundStr) = @_;
	if (exists($ENV{${varName}})) {
		return $ENV{$varName};
	} else {
		return $notFoundStr;
	}
}

sub replaceUNICODE_UmlauteInHash {
	 my(%inRec)     = @_;
	my %retRec     = %inRec;
	my @recKeys = keys %retRec;
	foreach my $aKey (@recKeys) {
		$retRec{$aKey} = replaceUNICODE_Umlaute($retRec{$aKey});
	}   
	return %retRec;
}

sub replaceUNICODE_Umlaute {
	my($inLine)     = @_;
	my $retVal      = $inLine;
	$retVal =~ s/Ã¤/ä/g;
	$retVal =~ s/Ã¶/ö/g;
	$retVal =~ s/Ã¼/ü/g;
	$retVal =~ s/Ã©/é/g;
	$retVal =~ s/Ã¨/è/g;
	$retVal =~ s/Ãº/u/g;
	$retVal =~ s/Ã/Ö/g;
	$retVal =~ s/Ö§/c/g;
	$retVal =~ s/'//g;
	return $retVal;
}

sub replaceDOS_Umlaute {
   my($inLine)     = @_;
   my $retVal      = $inLine;

   $retVal =~ s/ö/ /g;
   
   # Spezialzeichen
   $retVal =~ s/æ/µ/g;
   $retVal =~ s/í/ø/g;

   # Deutsche Umlaute
   $retVal =~ s/„/ä/g;
   $retVal =~ s//ü/g;
   $retVal =~ s/”/ö/g;
   $retVal =~ s/Ž/Ae/g;
   $retVal =~ s/š/Ue/g;
   $retVal =~ s/™/Oe/g;
      
   # Französische Sepzialzeichen
   $retVal = replaceDosEecuAndKomman($retVal);
   $retVal =~ s/Š/è/g;   # e graf
   $retVal =~ s/ƒ/â/g;   # a mit Dach
   $retVal =~ s/…/à/g;   # a graf
   $retVal =~ s/Œ/i/g;   # i mit Dach
   $retVal =~ s/‡/ç/g;   # c mit 5 untendran
   $retVal =~ s/“/o/g;   # o mit Dach
   $retVal =~ s/ˆ/ê/g;   # e mit Dach   

   # Unterstreich Character   
   $retVal =~ s/Ä/_/g;

   return $retVal;
}

sub replaceUmlauteInString {
  my($inString)  = @_;
  $inString =~ s/ü/ue/g;
  $inString =~ s/ä/ae/g;
  $inString =~ s/ö/oe/g;
  $inString =~ s/é/e/g;

  return $inString;
}

# special treatment for , and e mit ecu
sub replaceDosEecuAndKomman {
	my($aLine) = @_;
	my $retLine = "";
	my @singleChracters = (); @singleChracters = split("",$aLine);
	foreach my $singleChr (@singleChracters) {
		if (ord($singleChr) == 44) {
			$retLine = "${retLine},";
		} elsif (ord($singleChr) == 130) {
			$retLine = "${retLine}é";        
		} else {
			$retLine = "${retLine}${singleChr}";
		}   
	}
	return $retLine;
}

# input: "aAäöü\nz"
# output format=0:
#   6141E4F6FC0A7A
#
# output format=1:
#  61
#  41
#  E4
#  F6
#  FC
#  0A
#  7A
#
# output format=2:
#  a=>61
#  A=>41
#  õ=>E4
#  ÷=>F6
#  ³=>FC
#
#  =>0A
#  z=>7A
#
# input: "aAäöü !\nz~"
# output format=3 (quoted-printable)
# aA=E4=F6=FC=20!=0Az~
#
# input: "Zürich"
# output format=3 (quoted-printable)
# Z=FCrich
sub convertASCII_to_HEX {
	 my($inStr,$format) = @_;
	 $format = setDefault($format,"0");

	my $outStr    = "";
	my $markerStr = "";
	my $retStr = "";
	my $tmpOutStr = "";
	my @charList = split("",$inStr);
	my $iii = 1;
	# foreach my $aChar (@charList) {
	#	print($iii.": ${aChar}  ".uc(unpack('H*',$aChar))."\n");
	#	$iii = $iii + 1;
	# }

	foreach my $aChar (@charList) {
		if ($format == "0") {
			$outStr = $outStr.uc(unpack('H*',$aChar));
		} elsif ($format == "1") {
			$outStr = $outStr.uc(unpack('H*',$aChar))."\n";
		} elsif ($format == "2") {
			$outStr = $outStr.$aChar."=>".uc(unpack('H*',$aChar))."\n";
		} elsif ($format == "3") {
			if ((ord($aChar) < ord(" ")) || (ord($aChar) > ord("~"))) {
				$outStr = $outStr."=".uc(unpack('H*',$aChar));
			} else {
				$outStr = $outStr.$aChar;
			}
		} elsif ($format == "4") {
			if ((ord($aChar) < ord(" ")) || (ord($aChar) > ord("~"))) {
				$tmpOutStr    = $tmpOutStr."=".uc(unpack('H*',$aChar));
				$markerStr = $markerStr."^  ";
			} else {
				$tmpOutStr    = $tmpOutStr.$aChar;
				$markerStr = $markerStr." ";
			}
			if ((length($tmpOutStr) > 0) && ((length($tmpOutStr) % 160) == 0)){
				$retStr    = $retStr.$tmpOutStr."\n".$markerStr."\n\n";
				$tmpOutStr = "";
				$markerStr = "";
			}
			$outStr = $retStr.$tmpOutStr."\n".$markerStr;
		}
	}
	return $outStr;
}

sub convertHEX_to_ASCII {
	my($inStr) = @_;
	my $retString = pack('H*',$inStr);
	return $retString;
}

sub doTest_convertHEX_to_ASCII {
	my($myFullName,$debugThisFct) = @_;
	$debugThisFct = setDefault($debugThisFct,$FALSE);

	my $inString  = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
	if (!(convertHEX_to_ASCII(convertASCII_to_HEX($inString)) eq $inString)) {
		print("ERROR: ${myFullName} failed (A)\n");
		print("     Result:".convertHEX_to_ASCII(convertASCII_to_HEX($inString)).":\n");
		print("     Expect:".$inString.":\n");
	}
	$inString  = ".öä$¨üè!?=)(/&%ç*+°§";
	if (!(convertHEX_to_ASCII(convertASCII_to_HEX($inString)) eq $inString)) {
		print("ERROR: ${myFullName} failed (B)\n");
		print("     Result:".convertHEX_to_ASCII(convertASCII_to_HEX($inString)).":\n");
		print("     Expect:".$inString.":\n");
	}
	$inString  = ".\<\\";
	if (!(convertHEX_to_ASCII(convertASCII_to_HEX($inString)) eq $inString)) {
		print("ERROR: ${myFullName} failed (C)\n");
		print("     Result:".convertHEX_to_ASCII(convertASCII_to_HEX($inString)).":\n");
		print("     Expect:".$inString.":\n");
	}
}

# returns an array of all the fields in a string separated by a comma
# It also handles escape characters an commas in quotes strings
# $line = q<XYZZY,"","O'Reilly, Inc","Wall, Larry","a \"glug\" bit,",5,
#           ERROR, Core Dumped">;
# @fields = parse_csv($line);
# displayArray(@fields);
#
# will return
# 0: XYZZY
# 1:
# 2: O'Reilly, Inc
# 3: Wall, Larry
# 4: a \"glug\" bit,
# 5: 5
# 6: ERROR, Core Dumped
sub parse_csv {
   my $text = shift;
   my @new  = ();
   push(@new, $+) while $text =~ m{
       "([^\"\\]*(?:\\.[^\"\\]*)*)",?
          |  ([^,]+),?
          | ,
     }gx;
   push(@new, undef) if substr($text, -1,1) eq ',';
   return @new;
}

# returns an array with parts of the in string. The parts are splited by the defined length
sub splitStringByLength {
	my($inStr,$reqLength) = @_;
	my @retParts = ();
	my $remainingStr = $inStr;
	while (length($remainingStr) > $reqLength) {
		push(@retParts,substr($remainingStr,0,$reqLength));
		$remainingStr = substr($remainingStr,$reqLength,length($remainingStr) - $reqLength);
	}
	push(@retParts,$remainingStr);
	return @retParts;
}

sub splitStringByWord {
	my($inStr,$reqLength) = @_;
	my @retParts = ();
	my @wordList = split(/\s+/,$inStr);

	my $aBlock = "";
	foreach my $singleWord (@wordList) {
		if ((length($aBlock) + length($singleWord) + 1) > $reqLength) {
			push(@retParts,$aBlock);
			$aBlock = "";
		} 
		if ($aBlock eq "") {
			$aBlock = $singleWord;
		} else {
			$aBlock = "${aBlock} ${singleWord}"; 
		}
	}
	push(@retParts,$aBlock);
	return @retParts;
}

sub splitStringByLine {
	my($inStr) = @_;
	return split(/\n/,$inStr);
}

sub getStringFromRegEx {
	my($inStr1,$regEx,$sepChar) = @_;
	$sepChar     = setDefault($sepChar,";");
	return makeQuotedStrFromArray($sepChar,"",getArrayFromRegEx($inStr1,$regEx));
}

sub getArrayFromRegEx {
	my($inStr1,$regEx) = @_;
	$sepChar     = setDefault($sepChar,";");
	my $retStr = "";
	## print("RegEs:${regEx}:\n");
	my @listOfFields  = $inStr1 =~ /($regEx)/g;
	return @listOfFields;
}

sub doTest_getStringFromRegEx {
	my($myFullName,$debugThisFct) = @_;
	$debugThisFct = setDefault($debugThisFct,$FALSE);

	my $aTestStr = "wwww1234 678965 kkkkk 1234.345kkkk456ss12";
	my $aPattern = "\\d+"; 
	my $expectedRes = "1234;678965;1234;345;456;12";
	if (getStringFromRegEx($aTestStr,$aPattern) ne $expectedRes) {
		print("ERROR: ${myFullName} failed (A)\n");
		print("   Expected: ${expectedRes}\n");
		print("   Result  : ".getStringFromRegEx($aTestStr,$aPattern)."\n");
	}

	$aPattern = "\\d+\\.?\\d+"; 
	$expectedRes = "1234;678965;1234.345;456;12";
	if (getStringFromRegEx($aTestStr,$aPattern) ne $expectedRes) {
		print("ERROR: ${myFullName} failed (A)\n");
		print("   Expected: ${expectedRes}\n");
		print("   Result  : ".getStringFromRegEx($aTestStr,$aPattern)."\n");
	}
}

# returns the last $countOfChars from $inStr.
# If length($inStr) < $countOfChars) it returns $inStr
sub getLastChartersFromString {
	my($inStr,$countOfChars) = @_;
	if (length($inStr) > $countOfChars) {
		return substr($inStr,length($inStr)-$countOfChars,$countOfChars)
	} else {
		return $inStr;
	}
}

# returns the first $countOfChars from $inStr.
# If length($inStr) < $countOfChars) it returns $inStr
sub getFirstChartersFromString {
	my($inStr,$countOfChars) = @_;
	if (length($inStr) > $countOfChars) {
		return substr($inStr,0,$countOfChars)
	} else {
		return $inStr;
	}
}

sub doTest_stringEndsWith {
	my($myFullName,$debugThisFct) = @_;
	$debugThisFct = setDefault($debugThisFct,$FALSE);

	my $aStr     = "/Common/Control/";
	my $aPattern = "/"; 

	if (!(stringEndsWith($aStr,$aPattern))) {
		print("ERROR: ${myFullName} failed (A)\n");
	}

	$aStr     = "/Common/Control";
	$aPattern = "l"; 
	if (!(stringEndsWith($aStr,$aPattern))) {
		print("ERROR: ${myFullName} failed (B)\n");
	}

	$aStr     = "Walter Rothlin";
	$aPattern = "thloin"; 
	if (stringEndsWith($aStr,$aPattern)) {
		print("ERROR: ${myFullName} failed (C)\n");
	}

	$aStr     = "Walter Rothlin";
	$aPattern = "rothlin"; 
	if (stringEndsWith($aStr,$aPattern)) {
		print("ERROR: ${myFullName} failed (D)\n");
	}


	$aStr     = "Walter Rothlin";
	$aPattern = "rothlin"; 
	if (stringEndsWith($aStr,$aPattern)) {
		print("ERROR: ${myFullName} failed (E)\n");
	}
}

sub stringEndsWith {
	my($inString,$pattern,$caseSensitive) = @_;
	$caseSensitive = setDefault($caseSensitive,$TRUE);
	if (!($caseSensitive)) {
		$inString = uc($inString);
		$pattern  = uc($pattern);
	}
	my $inStrPart = getLastChartersFromString($inString,length($pattern));
	if ($inStrPart eq $pattern) {
		return $TRUE;
	} else {
		return $FALSE;
	}
}

sub doTest_stringStartsWith {
	my($myFullName,$debugThisFct) = @_;
	$debugThisFct = setDefault($debugThisFct,$FALSE);

	my $aStr     = "Walter Rothlin";
	my $aPattern = "Walter"; 

	if (!(stringStartsWith($aStr,$aPattern,$TRUE))) {
		print("ERROR: ${myFullName} failed (A)\n");
	}

	$aStr     = "Walter Rothlin";
	$aPattern = "alter"; 
	if (stringStartsWith($aStr,$aPattern,$TRUE)) {
		print("ERROR: ${myFullName} failed (B)\n");
	}

	$aStr     = "Walter Rothlin";
	$aPattern = "walter";
	if (!(stringStartsWith($aStr,$aPattern,$FALSE))) {
		print("ERROR: ${myFullName} failed (C)\n");
	}
}

sub stringStartsWith {
	my($inString,$pattern,$caseSensitive) = @_;
	$caseSensitive = setDefault($caseSensitive,$TRUE);

	if (!($caseSensitive)) {
		$inString = uc($inString);
		$pattern  = uc($pattern);
	}
	if (index($inString,$pattern) == 0) {
		return $TRUE;
	} else {
		return $FALSE;
	}
}

sub doTest_stringContains {
	my($myFullName,$debugThisFct) = @_;
	$debugThisFct = setDefault($debugThisFct,$FALSE);

	my $aStr     = "Walter Rothlin";
	my $aPattern = "alter r"; 

	if (stringContains($aStr,$aPattern,$TRUE)) {
		print("ERROR: ${myFullName} failed (A)\n");
	}

	if (!(stringContains($aStr,$aPattern,$FALSE))) {
		print("ERROR: ${myFullName} failed (B)\n");
	}
}

sub stringContains {
	my($inString,$pattern,$caseSensitive) = @_;
	$caseSensitive = setDefault($caseSensitive,$TRUE);
	if (!($caseSensitive)) {
		$inString = uc($inString);
		$pattern  = uc($pattern);
	}
	if (index($inString,$pattern) != -1) {
		return $TRUE;
	} else {
		return $FALSE;
	}
}

# returns the position (starting at 0 where the strings start to be different. If the strings are the same
# it returns -1
sub getPosWhereStringsStartToBeDifferent {
  my ($str_1,$str_2) = @_;
  my @str_1_arr = split(//,$str_1);
  my @str_2_arr = split(//,$str_2);
  my $count_1 = @str_1_arr;
  my $count_2 = @str_2_arr;

  my $count = $count_1;
  if ($count_1 > $count_2) {
    $count = $count_2;
  }

  my $i=0;
  for ($i=0; $i <= $count; $i++) {
    if ($str_1_arr[$i] ne $str_2_arr[$i]) {
       return $i;
    }
  }
  if ($count_1 == $count_2) {
     return -1;
  } else {
     return $count;
  }
}

sub replaceSpacesWithSepChar {
	  my($inVal) = @_;
    my $retVal = $inVal;
    $retVal =~ s/\s+/;/g;
    return $retVal;
}

# stellenZahl < 0 string will be aligned left
sub padString {
	my($inStr,$stellenZahl,$padChr)  = @_;
	$padChr = setDefault($padChr," ");
	return paddenNull($inStr,$stellenZahl,$padChr);
}

# strip trailing and leading blanks (whitespaces)
sub strip {
   my($aString)  = @_;
   $aString =~ s/(\s+$)//;
   $aString =~ s/(^\s+)//;
   return $aString;
}

# "15" = removeLeadingChr("0015","0"));
# "15" = removeLeadingChr("  15"," "));
sub removeLeadingChr {
  my($aString,$leadChr) = @_;
  my($retVal)    = $aString;
  $retVal =~ s/^${leadChr}+//;
  return $retVal;
}

sub replacePercentChar {
  my($inStr)  = @_;
  my($retStr) = $inStr;
  $retStr =~ s/\%/\%\%/g;
  return $retStr;
}

# Trims every field in a | or ; delimited string and returns a new delimited string
#    $doTrim = $TRUE   ==> Cuts whitespaces at the beginning and at the end
#    $caseChangeMode
#         $modToUpperCase            ==> Change all Uppercase                             e.g. WaLtI  ==> WALTI
#         $modToLowerCase            ==> Change all Lowercase                             e.g. WaLtI  ==> walti
#         $modToFirstUpperCase       ==> Change First Char to Uppercase                   e.g. waLtI  ==> WaLtI
#         $modToFirstLowerCase       ==> Change First Char to Lowercase                   e.g. WaLtI  ==> waLtI
#         $modToOnlyFirstUpperCase   ==> Change First Char to Uppercase rest Lowercase    e.g. waLtI  ==> Walti
#         $modToOnlyFirstLowerCase   ==> Change First Char to Lowercase rest Uppercase    e.g. WaLtI  ==> wALTI
$modToUpperCase            = 1;   # often used  WaLtI  ==> WALTI
$modToLowerCase            = 2;   # often used  WaLtI  ==> walti
$modToFirstUpperCase       = 3;
$modToFirstLowerCase       = 4;
$modToOnlyFirstUpperCase   = 5;   # often used  waLtI  ==> Walti
$modToOnlyFirstLowerCase   = 6;

sub massageRecord {
   my($aRecord,$delim,$doTrim,$caseChangeMode) = @_;
   $doTrim   = setDefault($doTrim,  $TRUE);

   my($doUpperCase)            = $FALSE;
   my($doLowerCase)            = $FALSE;
   my($doFirstUpperCase)       = $FALSE;
   my($doFirstLowerCase)       = $FALSE;
   my($doOnlyFirstUpperCase)   = $FALSE;
   my($doOnlyFirstLowerCase)   = $FALSE;

   if ($caseChangeMode eq $modToUpperCase) {
       $doUpperCase = $TRUE;
   } elsif ($caseChangeMode eq $modToLowerCase) {
       $doLowerCase = $TRUE;
   } elsif ($caseChangeMode eq $modToFirstUpperCase) {
       $doFirstUpperCase = $TRUE;
   } elsif ($caseChangeMode eq $modToFirstLowerCase) {
       $doFirstLowerCase = $TRUE;
   } elsif ($caseChangeMode eq $modToOnlyFirstUpperCase) {
       $doOnlyFirstUpperCase = $TRUE;
   } elsif ($caseChangeMode eq $modToOnlyFirstLowerCase) {
       $doOnlyFirstLowerCase = $TRUE;
   }

   my($delChar)     = $delim;
   my($newRecord)   = "";
   my(@recordParts) = split($delim,$aRecord);
   my($aPart)       = "";

   if ($delim ne ";") {
     $delChar = "\|";
   }
   foreach $aPart (@recordParts) {
      if ($doTrim) {
        $aPart =~ s/(^\s+)//;
        $aPart =~ s/(\s+$)//;
      }
      if ($doUpperCase) {
        $aPart = uc($aPart);
      }
      if ($doLowerCase) {
        $aPart = lc($aPart);
      }
      if ($doFirstUpperCase) {
        $aPart = ucfirst($aPart);
      }
      if ($doFirstLowerCase) {
        $aPart = lcfirst($aPart);
      }
      if ($doOnlyFirstUpperCase) {
        $aPart = ucfirst(lc($aPart));
      }
      if ($doOnlyFirstLowerCase) {
        $aPart = lcfirst(up($aPart));
      }
      if ($newRecord eq "") {
         $newRecord = $aPart;
      } else {
         $newRecord = "${newRecord}${delChar}${aPart}";
      }
   }
   return $newRecord;
}


# returns a string in reverse order Walti -> itlaW
sub reverseStr {
   my($aString)  = @_;
   my($retStr)   = "";
   my($i)        = 1;
   foreach ($i=1; $i<=length($aString); $i++) {
      $retStr = sprintf("%s%s",$retStr,substr($aString,length($aString)-$i,1));
   }
   return $retStr;
}

sub setDefault {
  my($inVal,$defaultValue) = @_;
  my($retVal)  = $defaultValue;
  if (length($inVal) > 0) {
     $retVal = $inVal;
  }
  return $retVal;
}

sub replaceTab {
  my($inVal,$tabWidth,$padChr,$inWholeLine) = @_;
  $tabWidth    = setDefault($tabWidth,5);
  $padChr      = setDefault($padChr," ");
  $inWholeLine = setDefault($inWholeLine,$TRUE);
  my($tmpStr)    = $inVal;
  my($formatStr) = sprintf ("%%%ss",$tabWidth);
  my($tabStr)    = sprintf ($formatStr,$padChr);
  $tabStr =~ s/ /$padChr/g;
  ## print("tabWidt:${tabWidth}:\n");
  ## print("padChr:${padChr}:\n");
  ## printf ("Format:${formatStr}:\n");
  ## printf ("TabStr:${tabStr}:\n");

  if ($inWholeLine) {
     $tmpStr =~ s/\t/$tabStr/g;
  } else {
     ###### TBS WALTI
  }
  return $tmpStr;
}


# e.g.
#
# --> execPerlFct getPlaceholders "" \\[ \\]
# 0: [Ort]
# 1: [PLZ]
#
# -->  execPerlFct getPlaceholders
# 0: {PLZ}
#
# -->  execPerlFct getPlaceholders "" -x- -x-
# 0: -x-Geburtsdatum-x-
#
# -->   execPerlFct getPlaceholders "" "\(-:" ":-\)"
# 0: (-:Geburtstag:-)
#
sub getPlaceholders {
	my($inStr,$startPattern,$endPattern) = @_;
	$inStr         = setDefault($inStr,  "Mein Name ist [Name] {Name} {Vorname} und lebe in {Wohnort}. Der -x-Geburt-sdatum-x- ffff-x-Geburtsdatum-x-ffff ist (-:Geburtstag:-)");     # for automated testing
	$startPattern  = setDefault($startPattern,  "\\{");
	$endPattern    = setDefault($endPattern,    "\\}");
	my $regEx = "${startPattern}[\\w-]+${endPattern}";
	# print("inStr:${inStr}:\n");
	# print("regEx:${regEx}:\n");
	$_ = $inStr;
	# my @placeholders = /\{\w+\}/g;
	my @placeholders = /$regEx/g;
	return makeArrayEntriesDistinct($TRUE,@placeholders);
}


# Call:
# execPerlFct replacePlaceholdersInFileFromFltFile templateFileName nameValueFile [outFile] [Fieldname for Names] [Fieldnames for Values]
#
##	an example:
## templateFileName ($CSG_GMM_DATA/Test_TemplateFile.txt):
# This is a long {aaa} 
# multi line {ccc} version

# of a test file {bbb} with place holders 
# in it.
## 
## nameValueFile ($CSG_GMM_DATA/Test_NameValue.flt):
# Field_1|Field_2|Field_3|Field_4
# aaa|A|AA|AAA
# bbb|B|BB|BBB
# ccc|C|CC|CCC
## 
# execPerlFct replacePlaceholdersInFileFromFltFile $CSG_GMM_DATA/Test_TemplateFile.txt  $CSG_GMM_DATA/Test_NameValue.flt
## returns:
# This is a long A
# multi line C version
# of a test file B with place holders
# in it.
# 
# execPerlFct replacePlaceholdersInFileFromFltFile $CSG_GMM_DATA/Test_TemplateFile.txt  $CSG_GMM_DATA/Test_NameValue.flt "" Field_1 Field_4
## returns:
# This is a long AAA
# multi line CCC version
# of a test file BBB with place holders
# in it.
sub replacePlaceholdersInFileFromFltFile {
	my ($templateFileName, $tableFileName, $resultFileName, $fieldNameOfName, $fieldNameOfValue, $logFileName, $verbal) = @_;
	if (($fieldNameOfName eq "") || ($fieldNameOfValue eq "")) {
		($fieldNameOfName, $fieldNameOfValue) = getTableHeaderAsArray($tableFileName);
	}
	if (isFileExists($templateFileName) && isFileExists($tableFileName)) {
		my (%transTab) = ();
		%transTab = getTransTable($tableFileName,"","",$fieldNameOfName,$fieldNameOfValue,"{\%s}");
		### displayHashTable(%transTab);
		my @lines  = replacePlaceholdersInFile($templateFileName,%transTab);   
		displayLines($FALSE,@lines);
		if ($resultFileName ne "") {
			writeArrayToFile($resultFileName,$FALSE,@lines);
		}
	} else {
		if (!(isFileExists($templateFileName))) {
			print("ERROR in replacePlaceholdersInFileFromFltFile: templateFileName:${templateFileName}: not found\n");
		}
		if (!(isFileExists($tableFileName))) {
			print("ERROR in replacePlaceholdersInFileFromFltFile: tableFileName:${tableFileName}: not found\n");
		}
	}
}

# {UserFct:parseTemplateUsingFltStr(
#       {UserFct:selectToFltString(${IQ_DB1},"CSOWNER",{UserFct:getPassword(csowner)},"select 
# 		ID ID,
# 		BID_FIELD BID_1,
# 		CCY1 CCY_1,
# 		CCY2 CCY_2
# 		from CSG_FX_SPOT_RICS")},"
#        ein template mit [BID_1] [CCY_1] with
#        [CCY_2]",$TRUE)}
sub parseTemplateUsingFltStr {
	my ($fltStr,$templateStr,$breakLine) = @_;
	my (@fltLines) = ();
	@fltLines      = trimRemoveEmptiesAndCommentsInArray(split("\n",$fltStr));
	my $headerLine = shift @fltLines;
	my $fieldSep   = getSepCharFromHeader($headerLine,$TRUE);
	my (%aHashRec) = ();
	my $retStr     = "";
	foreach my $aLine (@fltLines) {
	    %aHashRec = createHashTab($headerLine,$aLine,$fieldSep,"",$TRUE,"[","]");
		$retStr = $retStr . replacePlaceholdersStr($templateStr,%aHashRec);
		if ($breakLine) {
			$retStr = $retStr . "\n";
		}
	}
    return $retStr;
}

# replacePlaceholdersStr
# ----------------------
# History:
# 02/03/99    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# replaces all placeholder defined in the transList and returns
# a new string
# The Placeholder can also be a full fuction call
# 
# e.g.
# %transList = (
#    "{normalerPlaceholder}"                      => "NORMAL",
# );
# 
# $aLine = "Dies ist ein {normalerPlaceholder} Placeholder and that is the result ({CallUserFctHidden:sayHalloWalti(1,\"Walterli\",\"Me,Too\")}) of a function call";
# printf("${aLine}\n%s\n",replacePlaceholdersStr($aLine,%transList));

$CallUserFct  = "CallUserFctHidden";

sub replacePlaceholdersStr {
   my($inStr,%transList)   = @_;
   my $retStr              = replaceENV_InString($inStr);
   my(@placeholderNames)   = keys %transList;
   foreach $placeholderName  (@placeholderNames) {
     my $translatedPlaceholder = $transList{$placeholderName};
     if ($translatedPlaceholder eq $CallUserFct) {
         my($fctCall) = $placeholderName;
         $fctCall =~ s/^{//g;
         $fctCall =~ s/}$//g;
         my($replaceVal) = callFunction($fctCall);
         $retStr = substituteStr($retStr,$placeholderName,$replaceVal,$TRUE);
     } else {
         my $replaceVal  = $transList{$placeholderName};
         $retStr = substituteStr($retStr,$placeholderName,$replaceVal,$TRUE);
     }
   }
   # check if there is still a function call to replace
   $retStr = replaceFctCallHidden($retStr);
   return $retStr;
}


sub replaceFctCallHidden {
	my($inStr,$debugThisFct)  = @_;
	$debugThisFct = setDefault($debugThisFct,$FALSE);
	my $retStr = $inStr;
	
	while (index($retStr,"{${CallUserFct}:") != -1) {
		if ($debugThisFct) { 
			print(doIndent()."retStr      :${retStr}:\n");
			print(doIndent()."            :01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890\n");
			print(doIndent()."            :          |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |\n");
			print(doIndent()."            :          10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190\n");
		}
		my($startPos, $endPos) = searchStartEndOfDeepestNestedExpression($retStr,"{${CallUserFct}:","}",$debugThisFct);      if ($debugThisFct) { print("    startPos       :${startPos}:          endPos:${endPos}:\n"); }
		if  (($startPos < 0) || ($endPos < 0)) { last; } 
		my $placeholderName = substr($retStr,$startPos,$endPos - $startPos + 1);                                             if ($debugThisFct) { print("    placeholderName:${placeholderName}:\n"); }
		my $preStr = substr($retStr,0,$startPos);                                                                            if ($debugThisFct) { print("    preStr         :${preStr}:\n"); }
		my $endStr = substr($retStr,$endPos + 1,length($retStr) - $endPos);                                                  if ($debugThisFct) { print("    endStr         :${endStr}:\n"); print("    Length(retStr) :".length($retStr).":\n");}
        $replacedVal  = callPlaceholderFunction($placeholderName);
        $retStr = $preStr . $replacedVal . $endStr;
		if ($debugThisFct) { print(doIndent()."retStr:${retStr}:\n\n"); }
	}
	return $retStr;
}

sub callPlaceholderFunction {
	my($placeholderFct)  = @_;
	my $fctCall = $placeholderFct;
	$fctCall =~ s/^{$CallUserFct://g;
	$fctCall =~ s/}$//g;
	return callFunction($fctCall);
}

sub doTest_replaceFctCallHidden {
	my($myFullName,$debugThisFct) = @_;
	$debugThisFct = setDefault($debugThisFct,$FALSE);
	$CallUserFct  = "UserFct";
	my $inStr        = "Pre}Text {UserFct:processItem_A({UserFct:processItem_B({UserFct:processItem_C(X)})})} middle Text {UserFct:processItem_A({UserFct:processItem_AB({UserFct:processItem_C(Y)}, {UserFct:processItem_C(Z)})})} end Text";
	my $expRes       = "Pre}Text A_B_C_X middle Text A_AB_C_Y_ C_Z end Text";
	my $startPos     = 0;
	my $startPattern = "{UserFct:";
	my $endPattern   = "}";
	
	if (!(replaceFctCallHidden($inStr,$debugThisFct) eq $expRes)) {
		print("ERROR: ${myFullName} failed (A)\n");
		print("Res:".replaceFctCallHidden($inStr,$TRUE).":\n");
		print("Exp:".$expRes.":\n");
	}
	
	$inStr        = "{UserFct:getNextSunday({UserFct:getLastDayOfMonth_yyyymmdd(201412)})}";
	$expRes       = "20150104";
	$startPos     = 0;
	$startPattern = "{UserFct:";
	$endPattern   = "}";
	if (!(replaceFctCallHidden($inStr,$debugThisFct) eq $expRes)) {
		print("ERROR: ${myFullName} failed (A)\n");
		print("Res:".replaceFctCallHidden($inStr,$TRUE).":\n");
		print("Exp:".$expRes.":\n");
	}
}

# test fct for doTest_replaceFctCallHidden
sub processMultiline {
	my($multiLineStr_1,$multiLineStr_2) = @_;
	print("multiLineStr_1:${multiLineStr_1}:\n");
	print("multiLineStr_2:${multiLineStr_2}:\n\n\n");
	return "FROM_PROCESS_MULTILINE";
}

sub processItem_AB {
	my($itemStr_1,$itemStr_2) = @_;
	## print("In processItem: itemStr_1:${itemStr_1}:\n");
	return "AB_${itemStr_1}_${itemStr_2}";
}

sub processItem_A {
	my($itemStr_1) = @_;
	## print("In processItem: itemStr_1:${itemStr_1}:\n");
	return "A_${itemStr_1}";
}

sub processItem_B {
	my($itemStr_1) = @_;
	## print("In processItem: itemStr_1:${itemStr_1}:\n");
	return "B_${itemStr_1}";
}

sub processItem_C {
	my($itemStr_1) = @_;
	## print("In processItem: itemStr_1:${itemStr_1}:\n");
	return "C_${itemStr_1}";
}


sub searchStartEndOfDeepestNestedExpression {
	my($inStr,$startPattern,$endPattern,$debugThisFct) = @_;
	$debugThisFct = setDefault($debugThisFct,$FALSE);
	if ($debugThisFct) {
		print("========================>\n\ninStr       :${inStr}:\n");
		print("            :01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890\n");
		print("            :          |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |         |\n");
		print("            :          10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190\n");
		print("startPattern:${startPattern}:\n");
		print("endPattern  :${endPattern}:\n\n");
	}
	
	my $fStartPos = index($inStr,$startPattern);
	if ($fStartPos < 0) { return (-1,-1); }
	
	my $endPos   = index($inStr,$endPattern,$fStartPos + 1);	
	my $startPos = $endPos - 1;
	
    while ($TRUE) {	
		if ($debugThisFct) { print("startPos:${startPos}:     endPos:${endPos}:\n"); }
	    if ($startPos < 0) { last; }
		if (index($inStr,$startPattern,$startPos) == $startPos) { if ($debugThisFct) { print("Gefunden: ${startPos}\n"); } last; }
        $startPos = $startPos - 1;
	}
	if ($debugThisFct) { print("========================>startPos:${startPos}:     endPos:${endPos}:\n"); }
	return ($startPos,$endPos);	
}

sub substituteStr {
	my($inStr,$pattern,$replaceStr,$global) = @_;
	### print("\n\nIn substitudeStr\n");
	### print("inStr:${inStr}:\n");
	### print("pattern:${pattern}:\n");
	### print("replaceStr:${replaceStr}:\n");
	my $startPos = index($inStr,$pattern);
	if ($startPos == -1) {
		return $inStr;
	}
	### print("startPos:${startPos}\n");
	my $firstPart = substr($inStr,0,$startPos);
	my $endPart   = substr($inStr,$startPos+length($pattern));
	### print("firstPart:${firstPart}:\n");
	### print("endPart:${endPart}:\n");
	my $retStr = "${firstPart}${replaceStr}${endPart}";
	### print("retStr:${retStr}\n");
	if ($global) {
		$retStr = substituteStr($retStr,$pattern,$replaceStr,$global);
	}
	return $retStr;
}

sub trimQQ_String {
	my($qqString) = @_;
	my @lines = splitStringByLine($qqString);

	my $countOfLines = @lines;
	@lines = trimArray(getSubsetFromArray(1,$countOfLines-2,@lines));
	return makeStrFromArray("\n",@lines);
}

sub getCountOfLinesFromQQ {
	my($qqString) = @_;
	my @lines = splitStringByLine($qqString);
	@lines = trimRemoveEmptiesAndCommentsInArray(@lines);
	return @lines;
}

sub getFieldFromQQ {
	my($qqString,$lineNr,$fieldNr,$delimiter,$doTrim,$notFoundStr) = @_;
	$delimiter      = setDefault($delimiter,"\\|");
	$doTrim         = setDefault($doTrim,$TRUE);
	$notFoundStr    = setDefault($notFoundStr,"getFieldFromQQ: field not found!");

	my @lines = splitStringByLine($qqString);
	@lines = trimRemoveEmptiesAndCommentsInArray(@lines);
	my $retStr = getFieldFromString($delimiter,$fieldNr-1,$lines[$lineNr-1],$notFoundStr);
	if ($doTrim) {
		$retStr = strip($retStr);
	}
	return $retStr;
}

## $commentMarkerStr = "^(?!(=|#))"  Filters all lines starting with = or #
## $fieldSep = "\\s+"                Splits fields between whitespaces
sub getRecordSetFromQQ {
	my($qqString, $lineSep, $fieldSep, $commentMarkerStr, $doTrimFields) = @_;
	$lineSep          = setDefault($lineSep,"\n");
	$fieldSep         = setDefault($fieldSep,";");
	$doTrimFields     = setDefault($doTrimFields,$FALSE);
	
	my @recordSet = ();
	my @lines = split($lineSep, $qqString);
	if ($commentMarkerStr ne "") {
		@lines = filterArrayWithRegEx($commentMarkerStr,@lines);
	}
	$firstLine = shift @lines;
	my @fieldNames = split($fieldSep,$firstLine);
	my %aInitRecord = ();
	
	foreach $aFieldName (@fieldNames) {
		%aInitRecord = (%aInitRecord,($aFieldName,""));
		# print("aFieldName :${aFieldName}:\n");
	}
	# displayHashTable(%aInitRecord);
	
	foreach $aRecord (@lines) {
		my @fieldValues = split($fieldSep,$aRecord);
		my %aRecord = %aInitRecord;
		my $i = 0;
		foreach $aFieldValue (@fieldValues) {
			if ($doTrimFields) {
				$aFieldValue = strip($aFieldValue);
			}
			$aRecord{$fieldNames[$i]} = $aFieldValue;
			$i = $i + 1;
		}
		# displayHashTable(%aRecord);print("\n");
		push(@recordSet,\%aRecord);
	}
	return @recordSet;
}

sub doTest_replaceStringInString {
	my($myFullName,$debugThisFct) = @_;
	$debugThisFct = setDefault($debugThisFct,$FALSE);
	my $testCases = qq {
		Nr|InStr|Position|ReplaceStr|Expected
		01|12345|1       |x         |1x345
		02|12345|2       |xy        |12xy5
		03|12345|3       |xy        |123xy
	};

	for (my $i = 2; $i <= getCountOfLinesFromQQ($testCases); $i++) {
		my $testCaseNr  = getFieldFromQQ($testCases,$i,1);
		my $testString  = getFieldFromQQ($testCases,$i,2);
		my $position    = getFieldFromQQ($testCases,$i,3);
		my $replaceStr  = getFieldFromQQ($testCases,$i,4);
		my $expectedRes = getFieldFromQQ($testCases,$i,5);
		if ($debugThisFct) {
			print("\n==> ${myFullName}: Test-Case:${i}:${testCaseNr}\n");
			print("       testString :${testString}:\n");
			print("       position   :${position}:\n");
			print("       replaceStr :${replaceStr}:\n");
			print("       expectedRes:${expectedRes}:\n");
			print("       replaceStringInString(${testString},${position},${replaceStr})=".replaceStringInString($testString,$position,$replaceStr)."\n");
		}
		if (!(replaceStringInString($testString,$position,$replaceStr) eq $expectedRes)) { print("ERROR: Test-Case ${testCaseNr}\n"); print("       replaceStringInString(${testString},${position},${replaceStr})=".replaceStringInString($testString,$position,$replaceStr)."        Expected:${expectedRes}:\n");}
	}
}

# replaceStringInString("12345","2","xy") => "12xy5"
sub replaceStringInString {
	my($inStr,$startPos,$replaceStr) = @_;
	# print("inStr:${inStr}:   startPos:${startPos}:   replaceStr:${replaceStr}:\n");
	return substr($inStr,0,$startPos).$replaceStr.substr($inStr,$startPos+length($replaceStr))
}

# Change case WalTi --> walti
sub lowerCase {
  my($inStr) =  @_;
  return lc($inStr);
}

# Change case WalTi --> walTi
sub lowerCaseFirstCharOnly {
  my($inStr) =  @_;
  return lcfirst($inStr);
}

# Change case WalTi --> wALTI
sub lowerCaseFirstChar {
  my($inStr) =  @_;
  return lcfirst(uc($inStr));
}

# Change case WalTi --> WALTI
sub upperCase {
  my($inStr) =  @_;
  return uc($inStr);
}

# Change case walTi --> WalTi<br>
sub upperCaseFirstCharOnly {
  my($inStr) =  @_;
  return ucfirst($inStr);
}

# Change case walTi --> Walti<br>
sub upperCaseFirstChar {
  my($inStr) =  @_;
  return ucfirst(lc($inStr));
}

sub isString {
   my($value,$minLen,$maxLen,$errMsg) = @_;
   $errMsg = setDefault($errMsg,"Not an string with length between $minLen ... $maxLen");
   if ((length($value) >= $minLen) && (length($value) <= $maxLen)) {
       return $TRUE;
   } else {
       return $FALSE,$errMsg;
   }
}

sub isInteger {
   my($value,$minVal,$maxVal,$errMsg) = @_;
   $errMsg = setDefault($errMsg,"Not an integer between $minVal ... $maxVal");
   if ($value =~ /\D/) {
      return $FALSE,$errMsg;
   } else {
      if (($value >= $minVal) && ($value <= $maxVal)) {
         return $TRUE;
      } else {
         return $FALSE,$errMsg;
      }
   }

}

sub isReal {
   my($value,$minVal,$maxVal,$commaChr,$milSepChr,$errMsg) = @_;
   $commaChr  = setDefault($commaChr,"."); if ($commaChr eq ".") { $commaChr = "\."; }
   $milSepChr = setDefault($milSepChr,",");
   $errMsg    = setDefault($errMsg,"Not an real between $minVal ... $maxVal");
   $value =~ s/$milSepChr//g;

   my(@valPart) = split($commaChr,$value);
   my $partCount = @valPart;
   if ($partCount > 2) {
      return $FALSE,$errMsg;
   } elsif ($partCount == 2) {
      if (($valPart[0] =~ /\D/) ||
          ($valPart[1] =~ /\D/))  {
         return $FALSE,$errMsg;
      }
   } else {
      if ($valPart[0] =~ /\D/)  {
         return $FALSE,$errMsg;
      }
   }
   if (($value >= $minVal) && ($value <= $maxVal)) {
       return $TRUE;
   } else {
       return $FALSE,$errMsg;
   }
}

sub isEmailAddr {
   my($value,$errMsg) = @_;
   $errMsg    = setDefault($errMsg,"Not a valid e-mail address");

   my(@valPart) = split("\@",$value);
   my $partCount = @valPart;
   if ($partCount == 2) {
      return $TRUE;
   } else {
      return $FALSE,$errMsg;
   }
}

sub isAnURL {
  my($value,$errMsg) = @_;
  $errMsg    = setDefault($errMsg,"Not a valid URL");

  if ($value =~ m/^http\:\/\/[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}/) {
  	  return $TRUE;
  } else {
  	  return $FALSE,$errMsg;
  }
}

sub isStringAnURL {
  my($value) = @_;

  if ($value =~ m/^http\:\/\/[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}/) {
  	  return $TRUE;
  } else {
  	  return $FALSE;
  }
}

sub doTest_isAnURL {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my $urlToTest = "";
   if ($debugThisFct) {
     
     $urlToTest = "http://www.rothlin.com/del/text.html";
     if ((isStringAnURL($urlToTest) != $TRUE)) {
     	  print("ERROR: ${myFullName} failed (A)\n");
     }
     
     $urlToTest = "http:www.rothlin.com/del/text.html";
     if ((isStringAnURL($urlToTest) == $TRUE)) {
     	  print("ERROR: ${myFullName} failed (B)\n");
     }
     
     $urlToTest = "http://www.rothlin.com/del/cgi-bin/text.pl";
     if ((isStringAnURL($urlToTest) != $TRUE)) {
     	  print("ERROR: ${myFullName} failed (C)\n");
     }
     
     $urlToTest = "www.rothlin.com/del/text.html";
     if ((isStringAnURL($urlToTest) == $TRUE)) {
     	  print("ERROR: ${myFullName} failed (D)\n");
     }
  }
}
sub translateStringValue {
   my($sepStr,$value,@transPairs) = @_;
   $sepStr = setDefault($sepStr,"=>");

   my %transTab   = ();
   my $defaultVal = "";
   my $defaultValSet = $FALSE;
   foreach my $aTrans (@transPairs) {
      if (index($aTrans,$sepStr) != -1) {
         my @parts = split($sepStr,$aTrans);
         %transTab = (%transTab,($parts[0],$parts[1]));
      } else {
         $defaultVal = $aTrans;
         $defaultValSet = $TRUE;
      }
   }
   if (exists($transTab{$value})) {
      return $transTab{$value};
   } else {
      if ($defaultValSet) {
          return $defaultVal;
      } else {
          return $value;
      }
   }
}

sub repeatingString {
	my($strToRepeat,$countOfRepeats)     = @_;
	$countOfRepeats = setDefault($countOfRepeats,1);

	my $retVal   =  "";
	for (my $i=1; $i <= $countOfRepeats; $i++) {
		$retVal = "${retVal}${strToRepeat}";
	}
	return $retVal
}

sub boxingUnterstreichen {
	my($text,$uChr,$startChr,$countOfLineSpaces)     = @_;
	$uChr              = setDefault($uChr,             "=");
	$startChr          = setDefault($startChr,         " ");
	$countOfLineSpaces = setDefault($countOfLineSpaces,2);

	if ($startChr  eq "NOP") { $startChr = ""; }
	my $retVal   =  "${startChr}${text}\n";
	my $underStr = repeatingString($uChr,length($text));

	$retVal = "${startChr}${underStr}\n${retVal}${startChr}${underStr}";
	for (my $i=1; $i<=$countOfLineSpaces; $i++) {
		$retVal = $retVal."\n";
	}
	return $retVal
}

sub unterstreichen {
	my($text,$uChr,$startChr,$countOfLineSpaces,$sepU_Char,$fieldLengtArrRef)     = @_;
	$uChr              = setDefault($uChr,             "=");
	$startChr          = setDefault($startChr,         " ");
	$countOfLineSpaces = setDefault($countOfLineSpaces,2);

	my @fieldLengthArr = @$fieldLengtArrRef;
	# print("sepU_Char:${sepU_Char}:\n"); displayArray(@fieldLengthArr);
	
	if ($startChr  eq "NOP") { $startChr = ""; }
	my $retVal   = "${startChr}${text}\n";
	my $underStr = repeatingString($uChr,length($text));

	if ($sepU_Char ne "") {
		# print("underStr (1):${underStr}:\n");
		$underStr = "";
		foreach my $aPos (@fieldLengthArr) {
			$underStr = $underStr . repeatingString($uChr,abs($aPos)).$sepU_Char;
		}
		# print("underStr (2):${underStr}:\n");
	}
	$retVal = "${retVal}${startChr}${underStr}";
	
	for (my $i=1; $i<=$countOfLineSpaces; $i++) {
		$retVal = $retVal."\n";
	}
	return $retVal
}

sub createUnderLine {
	my($text,$uChr)     = @_;
	$uChr     = setDefault($uChr,    "=");

	my $underStr = "";
	for (my $i=1; $i <= length($text); $i++) {
		$underStr = "${underStr}${uChr}";
	}
	return $underStr;
}

# returns a string where $endMark is at $markerPos. It maybe padded with $fillChr
# e.g.
# $resStr =createMarker(5,"-","^");
#   --> "----^"
sub createMarker {
	my($markerPos,$fillChr,$endMark) = @_;
	$fillChr     = setDefault($fillChr,"-");
	$endMark     = setDefault($endMark,"^");

	my $underStr  = "";
	if ($markerPos < 0) {
		return $underStr;
	}
	for (my $i=0; $i < $markerPos; $i++) {
		$underStr = "${underStr}${fillChr}";
	}
	return "${underStr}${endMark}";
}

sub doIndent {
	my($indent,$iStr)  = @_;
	$indent = setDefault($indent,10);
	$iStr   = setDefault($iStr,"-");
	return getRepeatedCharStr($indent,$iStr)."> ";
}

# returns a string where $repChar has been repeated $repTimes times
# e.g.
# $resStr =getRepeatedCharStr(5,"0");
#   --> "00000"
sub getRepeatedCharStr {
	my($repTimes,$repStr) = @_;
	$repStr = setDefault($repStr," ");

	my $retStr = "";
	foreach (my $i=1; $i<=$repTimes; $i++) {
		$retStr = "${retStr}${repStr}";
	}
	return $retStr;
}

sub getMaxValue {
	my(@valueList) = @_;
	my $maxVal = 0;
	foreach my $aVal (@valueList) {
		if ($aVal > $maxVal) {
			$maxVal = $aVal;
		}
	}
	return $maxVal
}

sub getMinValue {
	my(@valueList) = @_;
	my $minVal = 0;
	foreach my $aVal (@valueList) {
		if ($aVal < $minVal) {
			$minVal = $aVal;
		}
	}
	return $minVal
}

sub maxStrLength {
	my(@strList) = @_;

	my $maxLen   = 0;
	foreach my $aStr (@strList) {
		if (length($aStr) > $maxLen) {
			$maxLen = length($aStr);
		}
	}
	return $maxLen
}

sub minStrLength {
	my(@strList) = @_;
	my $aStr     = "";
	my $minLen   = 1000000;
	foreach $aStr (@strList) {
		if (length($aSt) < $minLen) {
			$minLen = $aSt;
		}
	}
	return $minLen
}

sub getNameFromEmail {
	my($aEmailAdr,$removePoints) = @_;
	$removePoints = setDefault($removePoints,$FALSE);
 
	my @parts  = split("@",$aEmailAdr);
	my $retVal = $parts[0];
	$retVal =~ s/\\//g;
	if ($removePoints) {
		$retVal =~ s/\./ /g;
	}
	return $retVal;
}

sub getHostFromEmail {
	my($aEmailAdr) = @_;
	my @parts = split("@",$aEmailAdr);
	return $parts[1];
}

sub quoteEmailAddress {
	my($aEmailAdr) = @_;
	my $retVal = $aEmailAdr;
	$retVal =~ s/\\@/\@/g;
	$retVal =~ s/\@/\\@/g;
	return $retVal;
}

sub unquoteEmailAddress {
	my($aEmailAdr) = @_;
	my $retVal = $aEmailAdr;
	$retVal =~ s/\\@/\@/g;
	return $retVal;
}

sub doTest_areStringMatching {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my($aString) = "/root/20000101_LN_TIQ_FAS_MACRO_HEDGE_FEED.flt";

   my(@patternList) = (
                "/root/20000101_LN_TIQ_FAS_MACRO_HEDGE_FEED.flt",
                "*",
                "*.flt",
                "/root/20000101_*",
                "/root/20000101_*.flt",
                "*_LN_*",
                "*_LN_*.flt",

                "*.FLT",
                "/root/20000102_*",
                "/root/20000102_*.flt",
                "*_ZH_*",
                "*_ZH_*flt",
                "*_LN_*flt",
                "*_LN_*f*",
                "*_LN_*FAS*FEED*.fl*",


               );

   # test cases with valid dates
   # ---------------------------
   if (!(areStringMatching($aString,$patternList[0],$usingWildcard))) {
       print("ERROR: ${myFullName} failed (A)\n");
   }
   if (!(areStringMatching($aString,$patternList[1],$usingWildcard))) {
       print("ERROR: ${myFullName} failed (B)\n");
   }
   if (!(areStringMatching($aString,$patternList[2],$usingWildcard))) {
       print("ERROR: ${myFullName} failed (C)\n");
   }
   if (!(areStringMatching($aString,$patternList[3],$usingWildcard))) {
       print("ERROR: ${myFullName} failed (D)\n");
   }
   if (!(areStringMatching($aString,$patternList[4],$usingWildcard))) {
       print("ERROR: ${myFullName} failed (E)\n");
   }
   if (!(areStringMatching($aString,$patternList[5],$usingWildcard))) {
       print("ERROR: ${myFullName} failed (F)\n");
   }
   if (!(areStringMatching($aString,$patternList[6],$usingWildcard))) {
       print("ERROR: ${myFullName} failed (G)\n");
   }
   if (!(areStringMatching($aString,$patternList[12],$usingWildcard))) {
       print("ERROR: ${myFullName} failed (H)\n");
   }
   if (!(areStringMatching($aString,$patternList[13],$usingWildcard))) {
       print("ERROR: ${myFullName} failed (I)\n");
   }
   if (!(areStringMatching($aString,$patternList[14],$usingWildcard))) {
       print("ERROR: ${myFullName} failed (J)\n");
   }

   # test cases with invalid dates
   # -----------------------------
   if (areStringMatching($aString,$patternList[7],$usingWildcard)) {
       print("ERROR: ${myFullName} failed (A-1)\n");
   }
   if (areStringMatching($aString,$patternList[8],$usingWildcard)) {
       print("ERROR: ${myFullName} failed (B-1)\n");
   }
   if (areStringMatching($aString,$patternList[9],$usingWildcard)) {
       print("ERROR: ${myFullName} failed (C-1)\n");
   }
   if (areStringMatching($aString,$patternList[10],$usingWildcard)) {
       print("ERROR: ${myFullName} failed (D-1)\n");
   }
   if (areStringMatching($aString,$patternList[11],$usingWildcard)) {
       print("ERROR: ${myFullName} failed (E-1)\n");
   }

}

# can handle the following cases
#   *   aa*   *aa   aa*bb *aa* *aaa*bbb*ccc (or any combinations)
sub areStringMatching {
	my($aString,$pattern,$usingWildcard) = @_;
	$usingWildcard = setDefault($usingWildcard,$TRUE);

	if ($usingWildcard) {
		if ($pattern eq "*") { return $TRUE; }
			## print(":${pattern}: ");   
			$pattern =~ s/\./\\\./g;     # esqape a . in the origninal pattern
			$pattern =~ s/\*/\.\*/g;     # replace a * with the regular expression .*
			$pattern = "^${pattern}\$";  # Adds boundery characters
			## print(" ----> :${pattern}:\n");
			return ($aString =~ /${pattern}/);
		} else {
			return ($aString eq $pattern);
		}
}

sub fctChomp {
	my($inLine) = @_;
	chomp($inLine);
	return $inLine;
}

sub formatFltHeaderAndDataString {
	my($header,$data) = @_;
	my %retVal = ();
	my $delChr  = ";";
	if (index($header,"\|") != -1) {
		$delChr = "\\|";
	}
	my @headerElements = split($delChr,$header);
	my @dataElements   = split($delChr,$data);
	my $i = 0;
	foreach $aHeaderElement (@headerElements) {
		%retVal = (%retVal,($aHeaderElement,$dataElements[$i]));
		$i++;
	}
	return %retVal;
}

sub formatFltDataString {
	my($dataString) = @_;
	my $header   = "";
	my $data     = "";

	if (index($dataString,"\<BR\>") == -1) {
		($header,$data) = split("\n",$dataString);
	} else {
		($header,$data) = split("\<BR\>",$dataString);
	}
	return formatFltHeaderAndDataString($header,$data);
}

sub addSingleQuotesToString {
	my($aStr) = @_;
	return "'${aStr}'";
}

sub addDoubleQuotesToString {
	my($aStr) = @_;
	return "\"${aStr}\"";
}


# field string functions
# ----------------------
sub doTest_getFieldFromString {
  my($myFullName,$debugThisFct) = @_;
  $debugThisFct = setDefault($debugThisFct,$FALSE);

  my $notFoundStr = "NOT_FOUND";
  my $sepChar = ".";
  my $aString = "/app/lighthouse.ftpUse.Arg8.NotUseLoc ";
  if (!(getFieldFromString($sepChar,0,$aString,$notFoundStr) eq "/app/lighthouse")) {
      print("ERROR: ${myFullName} failed (A)\n");
  }
  if (!(getFieldFromString($sepChar,1,$aString,$notFoundStr) eq "ftpUse")) {
      print("ERROR: ${myFullName} failed (B)\n");
  }
  if (!(getFieldFromString($sepChar,2,$aString,$notFoundStr) eq "Arg8")) {
      print("ERROR: ${myFullName} failed (C)\n");
  }
  if (!(getFieldFromString($sepChar,3,$aString,$notFoundStr) eq "NotUseLoc ")) {
      print("ERROR: ${myFullName} failed (D)\n");
  }
  if (!(getFieldFromString($sepChar,4,$aString,$notFoundStr) eq "NOT_FOUND")) {
      print("ERROR: ${myFullName} failed (E)\n");
  }
  if (!(getFieldFromString($sepChar,5,$aString,$notFoundStr) eq "NOT_FOUND")) {
      print("ERROR: ${myFullName} failed (F)\n");
  }

  $sepChar = "_";
  $aString = "walti_rothlin_8855_wangen";
  if (!(getFieldFromString($sepChar,0,$aString,$notFoundStr) eq "walti")) {
      print("ERROR: ${myFullName} failed (G)\n");
  }
  if (!(getFieldFromString($sepChar,1,$aString,$notFoundStr) eq "rothlin")) {
      print("ERROR: ${myFullName} failed (H)\n");
  }
  if (!(getFieldFromString($sepChar,2,$aString,$notFoundStr) eq "8855")) {
      print("ERROR: ${myFullName} failed (I)\n");
  }
  if (!(getFieldFromString($sepChar,3,$aString,$notFoundStr) eq "wangen")) {
      print("ERROR: ${myFullName} failed (K)\n");
  }
  if (!(getFieldFromString($sepChar,4,$aString,$notFoundStr) eq "NOT_FOUND")) {
      print("ERROR: ${myFullName} failed (L)\n");
  }
  if (!(getFieldFromString($sepChar,5,$aString,$notFoundStr) eq "NOT_FOUND")) {
      print("ERROR: ${myFullName} failed (M)\n");
  }
  if (!(getFieldFromString($sepChar,-1,$aString,$notFoundStr) eq "NOT_FOUND")) {
      print("ERROR: ${myFullName} failed (N)\n");
  }

}

sub doTest_padFieldsInString {
	my($myFullName,$debugThisFct) = @_;
	$debugThisFct = setDefault($debugThisFct,$FALSE);

	my $aString  = "11.1.1.13";
	my $fieldLen = "4";
	my $padChr   = "0";
	my $sepChr   = ".";
	my $expRes   = "0011.0001.0001.0013";
	if (!(padFieldsInString($aString,$fieldLen,$padChr,$sepChr) eq $expRes)) {
		print("ERROR: ${myFullName} failed (A)\n");
		print("     Result:".padFieldsInString($aString,$fieldLen,$padChr,$sepChr).":\n");
		print("     Expect:".$expRes.":\n");
	}

	$aString  = "11|1|1|13";
	$fieldLen = "4";
	$padChr   = " ";
	$sepChr   = "\|";
	$expRes   = "  11|   1|   1|  13";
	if (!(padFieldsInString($aString,$fieldLen,$padChr,$sepChr) eq $expRes)) {
		print("ERROR: ${myFullName} failed (B)\n");
		print("     Result:".padFieldsInString($aString,$fieldLen,$padChr,$sepChr).":\n");
		print("     Expect:".$expRes.":\n");
	}
}

sub padFieldsInString {
	my($inString,$fieldLength,$padChar,$sepChar) = @_;
	$fieldLength = setDefault($fieldLength,0);
	$padChar     = setDefault($padChar," ");
	$sepChar     = setDefault($sepChar," ");

	my $splitChr = $sepChar;
	if ($sepChar eq ".") {
		$splitChr = "\\.";
	}
	if ($sepChar eq "\|") {
		$splitChr = "\\|";
	}

	my $retStr = "";
	my @strParts = split($splitChr,$inString);
	# print("inString:${inString}:\n");
	# displayArrayWithLength(@strParts);

	foreach my $entrie (@strParts) {
		if ($retStr eq "") {
			$retStr = padString($entrie,$fieldLength,$padChar);
		} else {
			$retStr = $retStr.$sepChar.padString($entrie,$fieldLength,$padChar);
		}
	}
	return $retStr;
}

sub getCountOfFieldsInstring {
	my($sepChar,$inString) = @_;
	$sepChar     = setDefault($sepChar," ");
	$trimFirst = setDefault($trimFirst,$TRUE);
	
	my $splitChr = $sepChar;
	if ($sepChar eq ".") {
		$splitChr = "\\.";
	}
	if ($sepChar eq "\|") {
		$splitChr = "\\|";
	}
	my @strParts = split($splitChr,$inString);
	my $count = @strParts;
	return $count;
}

sub padFieldsIndividualyInString {
	my($sepChar,$inString,$trimFirst,$fieldLengthsRef,$padCharsRef,$removeSepInOutput) = @_;
	$sepChar           = setDefault($sepChar," ");
	$trimFirst         = setDefault($trimFirst,$TRUE);
	$removeSepInOutput = setDefault($removeSepInOutput,$FALSE);
	
	my $splitChr = $sepChar;
	if ($sepChar eq ".") {
		$splitChr = "\\.";
	}
	if ($sepChar eq "\|") {
		$splitChr = "\\|";
	}

	my @fieldLengths       = derefAref($fieldLengthsRef);
	my @padStrings         = derefAref($padCharsRef);
	## print("fieldLengths:\n");      displayArray(@fieldLengths);
	## print("padStrings:\n");        displayArray(@padStrings);

	my $retStr = "";
	my @strParts = split(/$splitChr/,$inString);
	## print("inString:${inString}:   splitChr:${splitChr}:\n");
	## displayArrayWithLength(@strParts);
	
	## my $splitChrTest = ";";
	## my $aStringTets  = "ddddd;llll; ; ;";
	## my @strPartsTest = split(/$splitChrTest/,$aStringTets);
	## print("aStringTets:${aStringTets}:   splitChrTest:${splitChrTest}:\n");
	## displayArrayWithLength(@strPartsTest);
	## halt();

	my $i = 0;
	foreach my $entrie (@strParts) {
		my $padChar      = $padStrings[$i];
		my $fieldLength  = $fieldLengths[$i];
		if ($trimFirst) { $entrie = strip($entrie); }
		if ($retStr eq "") {
			$retStr = padString($entrie,$fieldLength,$padChar);
		} else {
			if ($removeSepInOutput) {
				$retStr = $retStr.padString($entrie,$fieldLength,$padChar);
			} else {
				$retStr = $retStr.$sepChar.padString($entrie,$fieldLength,$padChar);
			}
		}
		$i = $i + 1;
	}

	return $retStr;
}


sub doTest_getMaxFieldLengthFromStringArray {
	my($myFullName,$debugThisFct) = @_;
	$debugThisFct = setDefault($debugThisFct,$FALSE);

	my @inFieldStringArr = (
		"walti   ; Claudia;M;   Peterliwiese   ; 8855",
		"waltiMax   ; Claudia Collet ;F;Etzelstrasse; 88",
		"max   ; remo;X;Strasse;88558",
	);

	my @expRes_1  = (8,14,1,12,5);
	my @expRes_2  = (11,16,1,18,5);
	my $sepChar   = ";";

	my @res_1 = getMaxFieldLengthFromStringArray($sepChar,$TRUE,@inFieldStringArr);
	if (!(areArraysEqual(\@res_1,\@expRes_1,$TRUE,$TRUE))) {
		print("ERROR: ${myFullName} failed (A)\n");
		print("Result  :\n");displayArray(@res_1);
		print("Expected:\n");displayArray(@expRes_1);
	}

	@res_1 = getMaxFieldLengthFromStringArray($sepChar,$FALSE,@inFieldStringArr);
	if (!(areArraysEqual(\@res_1,\@expRes_2,$TRUE,$TRUE))) {
		print("ERROR: ${myFullName} failed (B)\n");
		print("Result  :\n");displayArray(@res_1);
		print("Expected:\n");displayArray(@expRes_2);
	}
}

sub getFieldLengthFromString {
	my($sepChar,$inString,$trimFirst) = @_;
	$sepChar   = setDefault($sepChar," ");
	$trimFirst = setDefault($trimFirst,$TRUE);

	my $splitChr = $sepChar;
	if ($sepChar eq ".") {
		$splitChr = "\\.";
	}
	if ($sepChar eq "\|") {
		$splitChr = "\\|";
	}
	my @retArr = ();
	my @strParts = split($splitChr,$inString);
	foreach my $aPart (@strParts) {
		if ($trimFirst) {
			push(@retArr,length(strip($aPart)));
		} else {
			push(@retArr,length($aPart));
		}
	}
	return @retArr;
}

sub getMaxFieldLengthFromStringArray {
	my($sepChar,$trimFirst,@inStrings) = @_;
	$sepChar   = setDefault($sepChar," ");
	$trimFirst = setDefault($trimFirst,$TRUE);

	my @retVal = ();
	my $firstTime = $TRUE;
	foreach my $aFieldString (@inStrings) {
		my @currFieldLength = getFieldLengthFromString($sepChar,$aFieldString,$trimFirst);
		if ($firstTime) {
			$firstTime = $FALSE;
			@retVal = @currFieldLength;
		}
		my $anzElems = @retVal;
		my @tmpVal = ();
		for (my $i =0; $i < $anzElems; $i++) {
			if ($retVal[$i] > $currFieldLength[$i]) {
				push(@tmpVal,$retVal[$i]);
			} else {
				push(@tmpVal,$currFieldLength[$i]);
			}
		}
		@retVal = @tmpVal;
	}
	return @retVal
}

sub getFieldFromString {
	my($sepChar,$posCountStartsAtZero,$inString,$notFoundStr) = @_;
	$sepChar = setDefault($sepChar," ");
	my $splitChr = $sepChar;
	if ($sepChar eq ".") {
		$splitChr = "\\.";
	}
	if ($sepChar eq "\|") {
		$splitChr = "\\|";
	}

	my @strParts = split($splitChr,$inString);
	# print("inString:${inString}:\n");
	# displayArrayWithLength(@strParts);
  
	return getArrayElement($posCountStartsAtZero,$notFoundStr,@strParts);
}

sub getFieldsFromString {
	my($sepChar,$inString,$trimFields,$preStr,$postStr) = @_;
	$trimFirst = setDefault($trimFirst,$TRUE);
	$sepChar   = setDefault($sepChar," ");
	
	my $splitChr = $sepChar;
	if ($sepChar eq ".") {
		$splitChr = "\\.";
	}
	if ($sepChar eq "\|") {
		$splitChr = "\\|";
	}
	
	my @retList = split($splitChr,$inString);
	if (($preStr ne "") || ($postStr ne "")) {
		my @tmpList = ();
		foreach my $anEntry (@retList) {
			push(@tmpList,"${preStr}${anEntry}${postStr}");
		}
		@retList = @tmpList;
	}
	
	# print("inString:${inString}:\n");
	# displayArrayWithLength(@strParts);
	if ($trimFields) {
		@retList = trimArray(@retList);
	}
	return @retList;
}

sub doTest_padFieldsInFieldStringArray {
	my($myFullName,$debugThisFct) = @_;
	$debugThisFct = setDefault($debugThisFct,$FALSE);

	my @inFieldStringArr = (
		"walti   ; Claudia;M;   Peterliwiese   ; 8855",
		"waltiMax   ; Claudia Collet ;F;Etzelstrasse; 88",
		"max   ; remo;X;Strasse;88558",
	);

	my @expRes_1  = (
		"walti   ;Claudia        ;--M;Peterliwiese___;8855o",
		"waltiMax;Claudia Collet ;--F;Etzelstrasse___;88ooo",
		"max     ;remo           ;--X;Strasse________;88558",
	);

	my @expRes_2  = (
		"walti     ;Claudia          ;M;Peterliwiese;8855 ",
		"waltiMax  ;Claudia Collet   ;F;Etzelstrasse;88   ",
		"max       ;remo             ;X;Strasse     ;88558",
	);

	my @expRes_3  = (
		"walti   ;Claudia       ;M;Peterliwiese;8855 ",
		"waltiMax;Claudia Collet;F;Etzelstrasse;88   ",
		"max     ;remo          ;X;Strasse     ;88558",
	);

	my @fieldLen_1  = (-8,-15,3,-15,-5);
	my @padStr_1    = (" "," ","-","_","o");
	my $sepChar   = ";";

	my @res_1 = padFieldsInFieldStringArray($sepChar,$TRUE,$TRUE,\@inFieldStringArr,\@fieldLen_1,\@padStr_1);
	if (!(areArraysEqual(\@res_1,\@expRes_1,$TRUE,$TRUE))) {
		print("ERROR: ${myFullName} failed (A)\n");
		print("Result  :\n");displayArray(@res_1);
		print("Expected:\n");displayArray(@expRes_1);
	}

	@fieldLen_1  = (2,3,0,0,0);
	@padStr_1    = (" "," "," "," "," ");
	@res_1 = padFieldsInFieldStringArray($sepChar,$TRUE,$FALSE,\@inFieldStringArr,\@fieldLen_1,\@padStr_1);
	if (!(areArraysEqual(\@res_1,\@expRes_2,$TRUE,$TRUE))) {
		print("ERROR: ${myFullName} failed (B)\n");
		print("Result  :\n");displayArray(@res_1);
		print("Expected:\n");displayArray(@expRes_2);
	}

	@fieldLen_1  = (0);
	@padStr_1    = (" ");
	@res_1 = padFieldsInFieldStringArray($sepChar,$TRUE,$FALSE,\@inFieldStringArr,\@fieldLen_1,\@padStr_1);
	if (!(areArraysEqual(\@res_1,\@expRes_3,$TRUE,$TRUE))) {
		print("ERROR: ${myFullName} failed (C)\n");
		print("Result  :\n");displayArray(@res_1);
		print("Expected:\n");displayArray(@expRes_3);
	}
}

sub padFieldsInFieldStringArray {
	my($sepChar,$trimFirst,$effLen,$inFieldStringArrRef,$fieldLenRef,$padStrRef,$removeSepInOutput,$titleSubscribeChar,$fieldFormatStringArrRef,$sepU_Char) = @_;
	$sepChar              = setDefault($sepChar," ");
	$trimFirst            = setDefault($trimFirst,$TRUE);
	$effLen               = setDefault($effLen,$TRUE);
	$removeSepInOutput    = setDefault($removeSepInOutput,$FALSE);

	my @retList = ();
	my @fieldStringArray  = derefAref($inFieldStringArrRef);
	my @fieldLen          = derefAref($fieldLenRef);
	my @padStr            = derefAref($padStrRef);
	my @fieldFormats      = derefAref($fieldFormatStringArrRef);
	## print("padFieldsInFieldStringArray::fieldFormats...\n"); displayArray(@fieldFormats);
	
	my $countOffields = getCountOfFieldsInstring($sepChar,$fieldStringArray[0]);
	while (@fieldLen < $countOffields) {
		push(@fieldLen,$fieldLen[0]);
	}
	while (@padStr < $countOffields) {
		push(@padStr,$padStr[0]);
	}
	## print("fieldStringArray:\n"); displayArray(@fieldStringArray);
	## print("fieldLen:\n");      displayArray(@fieldLen);
	## print("padStr:\n");        displayArray(@padStr);

	if (!($effLen)) {
		my @fieldMaxLength = getMaxFieldLengthFromStringArray($sepChar,$trimFirst,@fieldStringArray);
		## print("fieldMaxLength:\n");      displayArray(@fieldMaxLength);
		my $countFields = @fieldMaxLength;
		for (my $i =0; $i < $countFields; $i++) {
			## print("fieldFormats[${i}]=".$fieldFormats[$i].":\n");
			## print("fieldFormats[${i}]=".getFieldFromString(";",1,$fieldFormats[$i],$notFoundStr).":\n");
			
			if (uc(strip(getFieldFromString(";",1,$fieldFormats[$i],$notFoundStr))) eq "RIGHT") {
				$fieldLen[$i] =  1 * ($fieldLen[$i] + $fieldMaxLength[$i]);
			} else {
				$fieldLen[$i] = -1 * ($fieldLen[$i] + $fieldMaxLength[$i]);
			}
		}
	}
	## print("fieldLen:\n");      displayArray(@fieldLen);
	my $firstLine = $TRUE;
	foreach my $afieldStr (@fieldStringArray) {
		if  (($firstLine) && ($titleSubscribeChar ne "")) {
			push(@retList,unterstreichen(padFieldsIndividualyInString($sepChar,$afieldStr,$trimFirst,\@fieldLen,\@padStr,$removeSepInOutput),$titleSubscribeChar,"NOP",0,$sepU_Char,\@fieldLen));
			$firstLine = $FALSE;
		} else {
			## print("afieldStr:${afieldStr}:\n"); halt();
			push(@retList,padFieldsIndividualyInString($sepChar,$afieldStr,$trimFirst,\@fieldLen,\@padStr,$removeSepInOutput));
			## print("After padFieldsIndividualyInString:".$retList[-1].":\n\n");
		}
	}
	return @retList;
}

sub stripFieldsFromString {
	my($sepChar,$inString) = @_;
	$sepChar = setDefault($sepChar," ");
	my $splitChr = $sepChar;
	if ($sepChar eq ".") {
		$splitChr = "\\.";
	}
	if ($sepChar eq "\|") {
		$splitChr = "\\|";
	}
	
	my $retStr = "";
	my @strParts = split($splitChr,$inString);
	foreach my $aPart (@strParts) {
		if ($retStr eq "") {
			$retStr = strip($aPart);
		} else {
			$retStr = $retStr.$sepChar.strip($aPart);
		}
	}
	return $retStr;
}

sub getLastFieldFromString {
	my($sepChar,$inString,$offsetFromEnd,$doStrip) = @_;
	$sepChar       = setDefault($sepChar," ");
	$offsetFromEnd = setDefault($offsetFromEnd,0);
	$doStrip       = setDefault($doStrip,$TRUE);

	my $splitChr = $sepChar;
	if ($sepChar eq ".") {
		$splitChr = "\\.";
	}
	if ($sepChar eq "\|") {
		$splitChr = "\\|";
	}

	my $retStr   = "";
	my @strParts = split($splitChr,$inString);
	my $countOfElements = @strParts;
	my $retVal = $strParts[$countOfElements-1-$offsetFromEnd];
	if ($doStrip) {
		$retVal = strip($retVal);
	}
	return $retVal;
}

sub doTest_removeFieldFromString {
	my($myFullName,$debugThisFct) = @_;
	$debugThisFct = setDefault($debugThisFct,$FALSE);

	my $sepChar = "_";
	my $aString = "walti_rothlin_8855_wangen";
	my $notFoundStr = $aString;
	if (!(removeFieldFromString($sepChar,0,$aString,$notFoundStr) eq "rothlin_8855_wangen")) {
		print("ERROR: ${myFullName} failed (A)\n");
	}
	if (!(removeFieldFromString($sepChar,1,$aString,$notFoundStr) eq "walti_8855_wangen")) {
		print("ERROR: ${myFullName} failed (B)\n");
	}
	if (!(removeFieldFromString($sepChar,2,$aString,$notFoundStr) eq "walti_rothlin_wangen")) {
		print("ERROR: ${myFullName} failed (C)\n");
	}
	if (!(removeFieldFromString($sepChar,3,$aString,$notFoundStr) eq "walti_rothlin_8855")) {
		print("ERROR: ${myFullName} failed (D)\n");
	}
	if (!(removeFieldFromString($sepChar,4,$aString,$notFoundStr) eq $aString)) {
		print("ERROR: ${myFullName} failed (E)\n");
	}
	if (!(removeFieldFromString($sepChar,5,$aString,$notFoundStr) eq $aString)) {
		print("ERROR: ${myFullName} failed (F)\n");
	}
	if (!(removeFieldFromString($sepChar,-1,$aString,$notFoundStr) eq $aString)) {
		print("ERROR: ${myFullName} failed (G)\n");
	}
}

sub removeFieldFromString {
	my($sepChar,$posCountStartsAtZero,$inString,$notFoundStr) = @_;
	$sepChar = setDefault($sepChar," ");
	my $splitChr = $sepChar;
	my $retStr = "";

	if ($sepChar eq ".") {
		$splitChr = "\\.";
	}
	if ($sepChar eq "\|") {
		$splitChr = "\\|";
	}
	
	my @strParts = split($splitChr,$inString);
	my $countOfElements = @strParts;
	if (($posCountStartsAtZero < 0) ||
		($posCountStartsAtZero >= $countOfElements)) {
			$retStr = $notFoundStr;
	} else {
			@strParts = removeAnEntryFromArray($posCountStartsAtZero,@strParts);
			$retStr = makeStrFromArray($sepChar,@strParts);
	}
	return $retStr;
}

sub doTest_removeFromStringUsingPositions {
	my($myFullName,$debugThisFct) = @_;
	$debugThisFct = setDefault($debugThisFct,$FALSE);

	my $aString = "walti_rothlin_8855_wangen";
	if (!(removeFromStringUsingPositions($aString,1,6) eq "rothlin_8855_wangen")) {
		print("ERROR: ${myFullName} failed (A)\n");
	}

	if (!(removeFromStringUsingPositions($aString,6,13) eq "walti_8855_wangen")) {
		print("ERROR: ${myFullName} failed (B)\n");
	}
  
	if (!(removeFromStringUsingPositions($aString,14,40) eq "walti_rothlin")) {
		print("ERROR: ${myFullName} failed (C)\n");
	}

  
	if (!(removeFromStringUsingPositions($aString,14) eq "walti_rothlin")) {
		print("ERROR: ${myFullName} failed (D)\n");
	}
}

# removeFromStringUsingPositions("walti_rothlin_8855_wangen","6","13");
# --> walti_8855_wangen
sub removeFromStringUsingPositions {
    my($inStr,$startPos,$endPos) = @_;
	$endPos = setDefault($endPos,length($inStr));
	
	my $retStr    = "";
	my $firstPart = "";
	my $endPart   = "";
	
	if ($startPos > $endPos) {
		my $tmpPos = $startPos;
		$startPos = $endPos;
	$endPos   = $tmpPos;
	}
	if ($endPos > length($inStr)) {
		$endPos   = length($inStr);
	}
	# print("\ninStr (".length($inStr)."):${inStr}:\n");
	# print("startPos:${startPos}:\n");
	# print("endPos:${endPos}:\n");
	if ($startPos <	length($inStr)) {
		$firstPart = substr($inStr,0,$startPos - 1);
		# print("firstPart:${firstPart}:\n");
		if ($endPos <=	length($inStr)) {
			$endPart = substr($inStr,$endPos);
			# print("endPart:${endPart}:\n");
			$retStr = "${firstPart}${endPart}";
		} else {
			$retStr = "${firstPart}";
		}
	} else {
	   $retstr = $inStr;
	}
	# print("retStr:${retStr}:\n");
	return $retStr;
}

sub doTest_removeFromString {
	my($myFullName,$debugThisFct) = @_;
	$debugThisFct = setDefault($debugThisFct,$FALSE);

	my $aString = "walti;#rothlin,8855_wangen";
	if (!(removeFromString($aString,"#",",") eq "walti;8855_wangen")) {
		print("ERROR: ${myFullName} failed (A)\n");
	}

	$aString = "walti,#rothlin,8855_wangen";
	if (!(removeFromString($aString,"#",",") eq "walti,8855_wangen")) {
		print("ERROR: ${myFullName} failed (B)\n");
	}

	$aString = "#walti,rothlin,8855_wangen";
	if (!(removeFromString($aString,"#",",") eq "rothlin,8855_wangen")) {
		print("ERROR: ${myFullName} failed (C)\n");
	}

	$aString = "walti,rothlin,#8855_wangen";
	if (!(removeFromString($aString,"#",",") eq "walti,rothlin,")) {
		print("ERROR: ${myFullName} failed (D)\n");
	}
}

# removeFromString("Ein Text mit inline comment # Comment","#",",");
# --> Ein Text mit inline comment
sub removeFromString {
    my($inStr,$startString,$endString) = @_;
	my $retStr = "";

	# print("\ninStr:${inStr}:\n");
	# print("startString:${startString}:\n");
	# print("endString:${endString}:\n");
	my $startPos = index($inStr,$startString) + 1;
	my $endPos   = length($inStr);
	if ($startPos != 0) {
		for (my $i = $startPos; $i <= length($inStr); $i++) {
		   if (substr($inStr,$i,length($endString)) eq $endString) {
				$endPos = $i + length($endString);
				last;
		   }
		}
		# print("startPos:${startPos}:\n");
		# print("endPos:${endPos}:\n");
		$retStr = removeFromString(removeFromStringUsingPositions($inStr,$startPos,$endPos),$startString,$endString);
	} else {
		$retStr = $inStr;
	}
	# print("retStr:${retStr}:\n\n");
	return $retStr;
}

sub doTest_removeLastSepFromString {
  my($myFullName,$debugThisFct) = @_;
  $debugThisFct = setDefault($debugThisFct,$FALSE);

  my $aString = "walti;";
  if (!(removeLastSepFromString($aString,";") eq "walti")) {
      print("ERROR: ${myFullName} failed (A)\n");
  }

  if (!(removeLastSepFromString($aString,"i") eq "walti;")) {
      print("ERROR: ${myFullName} failed (B)\n");
  }

  if (!(removeLastSepFromString($aString,"i;") eq "walt")) {
      print("ERROR: ${myFullName} failed (C)\n");
  }

  $aString = "walti,";
  if (!(removeLastSepFromString($aString,",") eq "walti")) {
      print("ERROR: ${myFullName} failed (D)\n");
  }

}

sub removeLastSepFromString {
	my($inStr,$sepChar) = @_;
	$sepChar = setDefault($sepChar,";");
	my $retStr = "";
	
	# print("\ninStr (".length($inStr)."):${inStr}:\n");
	if (substr($inStr,length($inStr)-length($sepChar)) eq $sepChar) {
		$retStr = substr($inStr,0,length($inStr)-length($sepChar));
	} else {
		$retStr = $inStr;
	}
	# print("retStr:${retStr}:\n\n");
	return $retStr
}

sub doTest_replaceFieldFromString {
  my($myFullName,$debugThisFct) = @_;
  $debugThisFct = setDefault($debugThisFct,$FALSE);

  my $sepChar = "_";
  my $aString = "walti_rothlin_8855_wangen";
  my $notFoundStr = $aString;
  if (!(replaceFieldFromString($sepChar,0,$aString,"XXXX",$notFoundStr) eq "XXXX_rothlin_8855_wangen")) {
      print("ERROR: ${myFullName} failed (A)\n");
  }
  if (!(replaceFieldFromString($sepChar,1,$aString,"XXXX",$notFoundStr) eq "walti_XXXX_8855_wangen")) {
      print("ERROR: ${myFullName} failed (B)\n");
  }
  if (!(replaceFieldFromString($sepChar,2,$aString,"XXXX",$notFoundStr) eq "walti_rothlin_XXXX_wangen")) {
      print("ERROR: ${myFullName} failed (C)\n");
  }
  if (!(replaceFieldFromString($sepChar,3,$aString,"XXXX",$notFoundStr) eq "walti_rothlin_8855_XXXX")) {
      print("ERROR: ${myFullName} failed (D)\n");
  }
  if (!(replaceFieldFromString($sepChar,4,$aString,"XXXX",$notFoundStr) eq $notFoundStr)) {
      print("ERROR: ${myFullName} failed (E)\n");
  }
  if (!(replaceFieldFromString($sepChar,5,$aString,"XXXX",$notFoundStr) eq $notFoundStr)) {
      print("ERROR: ${myFullName} failed (F)\n");
  }
  if (!(replaceFieldFromString($sepChar,-1,$aString,"XXXX",$notFoundStr) eq $notFoundStr)) {
      print("ERROR: ${myFullName} failed (G)\n");
  }
}

sub replaceFieldFromString {
  my($sepChar,$posCountStartsAtZero,$inString,$replaceStr,$notFoundStr) = @_;
  $sepChar = setDefault($sepChar," ");
  my $retStr = "";
  my (@strParts) = split($sepChar,$inString);
  my $countOfElements = @strParts;
  if (($posCountStartsAtZero < 0) ||
      ($posCountStartsAtZero >= $countOfElements)) {
     $retStr = $notFoundStr;
  } else {
     $strParts[$posCountStartsAtZero] = $replaceStr;
     $retStr = makeStrFromArray($sepChar,@strParts);
  }
  return $retStr;
}

sub doTest_addFieldToString {
	my($myFullName,$debugThisFct) = @_;
	$debugThisFct = setDefault($debugThisFct,$FALSE);
	my $testCases = qq {
		Nr|InStr                    |Value |Position|Expected
		01|walti_rothlin_8855_wangen|XXXXyy|       0|XXXXyy_walti_rothlin_8855_wangen
		02|walti_rothlin_8855_wangen|XXXXyy|       1|walti_XXXXyy_rothlin_8855_wangen
		03|walti_rothlin_8855_wangen|XXXXyy|       8|walti_rothlin_8855_wangen_XXXXyy
		04|                         |XXXXyy|       8|XXXXyy
	};
  
	my $sepChar = "_";
  
	for (my $i = 2; $i <= getCountOfLinesFromQQ($testCases); $i++) {
		my $testCaseNr  = getFieldFromQQ($testCases,$i,1);
		my $aString     = getFieldFromQQ($testCases,$i,2);
		my $newVal      = getFieldFromQQ($testCases,$i,3);
		my $position    = getFieldFromQQ($testCases,$i,4);
		my $expectedRes = getFieldFromQQ($testCases,$i,5);
		if ($debugThisFct) {
			print("\n==> ${myFullName}: Test-Case:${i}:${testCaseNr}\n");
			print("       aString     :${aString}:\n");
			print("       newVal      :${newVal}:\n");
			print("       position    :${position}:\n");
			print("       expectedRes :${expectedRes}:\n");
			print("       addFieldToString(${sepChar},${position},${aString},${newVal})=".addFieldToString($sepChar,$position,$aString,$newVal)."\n");
		}
		if (!(addFieldToString($sepChar,$position,$aString,$newVal) eq $expectedRes)) { print("ERROR: Test-Case ${testCaseNr}\n"); print("       addFieldToString(${sepChar},${position},${aString},${newVal})=".addFieldToString($sepChar,$position,$aString,$newVal)."        Expected:${expectedRes}:\n");}
	}

}

sub addFieldToString {
	my($sepChar,$posCountStartsAtZero,$inString,$fieldValue) = @_;
	$sepChar = setDefault($sepChar," ");
	my $retStr = "";
	my @strParts = split($sepChar,$inString);
	my $countOfElements = @strParts;
  
	if ($posCountStartsAtZero > $countOfElements) { $posCountStartsAtZero = $countOfElements; }
	@strParts = addAnEntryToArray($posCountStartsAtZero, $fieldValue, @strParts);
	$retStr = makeStrFromArray($sepChar,@strParts);
  return $retStr;
}


# replaces a variable in a string with a value. The variables must be defined
# as ${xxxx}
sub replaceA_DefinedVariable_InString {
   my($inString,$varName,$aValue) = @_;
   my $outString = $inString;
   my $startOfEnvStr = index($inString,"\${".$varName."}");
   my $endOfEnvStr   = index($inString,$varName."}") + length($varName);
      
   ### print("----> in replaceA_DefinedVariable_InString\n");
   ### print("inString:${inString}:\n");
   ### print("varName:${varName}:\n");
   ### print("aValue:${aValue}:\n");
   ### print("startOfEnvStr:${startOfEnvStr}:\n");
   ### print("endOfEnvStr  :${endOfEnvStr}:\n");
   if (($startOfEnvStr >= 0) && ($endOfEnvStr > $startOfEnvStr)) {

     my $firstPart  = substr($inString,0,$startOfEnvStr);
     my $secondPart = substr($inString,$endOfEnvStr+1);

     ### print("firstPart:${firstPart}:\n");
     ### print("secondPart:${secondPart}:\n");
     ### print("envName:${envName}:    envTranslation:${envTranslation}:\n");
     $outString = "${firstPart}${aValue}${secondPart}";
   }
   ### print("----> end of replaceA_DefinedVariable_InString\n");
   return $outString;
}

# replaces perl variables in a string with their values. The variables must be defined
# as ${xxxx}
sub replaceVariables_InString {
   my($inString) = @_;
   my $outString = $inString;
   my $startOfEnvStr = index($inString,"\${");
   my $endOfEnvStr   = index($inString,"}");

   if (($startOfEnvStr >= 0) && ($endOfEnvStr > $startOfEnvStr)) {
     my $envName = substr($inString,$startOfEnvStr+2,$endOfEnvStr-$startOfEnvStr-2);
     my $envTranslation = $$envName;

     my $firstPart  = substr($inString,0,$startOfEnvStr);
     my $secondPart = substr($inString,$endOfEnvStr+1);

     ### print("firstPart:${firstPart}:\n");
     ### print("secondPart:${secondPart}:\n");
     ### print("envName:${envName}:    envTranslation:${envTranslation}:\n");
     $outString = "${firstPart}${envTranslation}${secondPart}";
     $outString = replaceVariables_InString($outString);
   }
   return $outString;
}


# replaces environment variables in a string with their values. The variables must be defined
# as ${xxxx}
sub replaceENV_InString {
   my($inString) = @_;
   my $outString = $inString;
   my $startOfEnvStr = index($inString,"\${");
   my $endOfEnvStr   = index($inString,"}");

   if (($startOfEnvStr >= 0) && ($endOfEnvStr > $startOfEnvStr)) {
     my $envName = substr($inString,$startOfEnvStr+2,$endOfEnvStr-$startOfEnvStr-2);
     my $envTranslation = $ENV{$envName};

     my $firstPart  = substr($inString,0,$startOfEnvStr);
     my $secondPart = substr($inString,$endOfEnvStr+1);

     ### print("firstPart:${firstPart}:\n");
     ### print("secondPart:${secondPart}:\n");
     ### print("envName:${envName}:    envTranslation:${envTranslation}:\n");
     $outString = "${firstPart}${envTranslation}${secondPart}";
     $outString = replaceENV_InString($outString);
   }
   return $outString;
}

# replaces environment variables as $ENV{CSG_GMM} and perl-variables as ${instance} in a string with their values.
#  --> testString:Dies ist $ENV{CSG_DATA} und eine Perl Variable ${instance}:
#  ==> Replaced:Dies ist /app/lighthouse/data/DZHLHMC1 und eine Perl Variable DZHLHMC1
#  
#  --> testString:Dies ist und eine Perl Variable ${instance}$ENV{CSG_DATA}:
#  ==> Replaced:Dies ist und eine Perl Variable DZHLHMC1/app/lighthouse/data/DZHLHMC1
#  
#  --> testString:${instance} Dies ist und eine Perl Variable $ENV{CSG_DATA}:
#  ==> Replaced:DZHLHMC1 Dies ist und eine Perl Variable /app/lighthouse/data/DZHLHMC1
sub replacePerlVariablesAndENV_InString {
   my($inString) = @_;
   my $outString = $inString;
   my $startOfEnvStr = index($inString,"\$ENV{");   #print("startOfEnvStr:${startOfEnvStr}:\n");
   my $startOfVarStr = index($inString,"\${");      #print("startOfVarStr:${startOfVarStr}:\n");
   my $endOfEnvStr   = index($inString,"}");        #print("endOfEnvStr  :${endOfEnvStr}:\n");
   my $isAnEnvVar    = $TRUE;
   
   my $startOfStr    = 0;
   if ($startOfEnvStr < 0) {
   	   $startOfStr = $startOfVarStr;
   	   $isAnEnvVar = $FALSE;
   } elsif ($startOfVarStr < 0) {
    	  $startOfStr = $startOfEnvStr;
   	   $isAnEnvVar  = $TRUE;
   } else {
       if ($startOfEnvStr < $startOfVarStr) {
       	    $startOfStr = $startOfEnvStr;
       	    $isAnEnvVar = $TRUE;
       } else {
       	    $startOfStr = $startOfVarStr;
       	    $isAnEnvVar = $FALSE;
       }
   }
   #print("startOfStr:${startOfStr}:\n"); if ($isAnEnvVar) { print("It is an ENV var\n"); } else { print("It is a Perl var\n"); }
   #print("\n");
   
   
   if (($startOfStr >= 0) && ($endOfEnvStr > $startOfStr)) {
   	 my $envName = "";
     my $envTranslation = "";
     if ($isAnEnvVar) {
         $envName = substr($inString,$startOfStr+5,$endOfEnvStr-$startOfStr-5);
         $envTranslation = $ENV{$envName};
     } else {
     	   $envName = substr($inString,$startOfStr+2,$endOfEnvStr-$startOfStr-2);
         $envTranslation = $$envName;
     }

     my $firstPart  = substr($inString,0,$startOfStr);
     my $secondPart = substr($inString,$endOfEnvStr+1);

     #print("firstPart:${firstPart}:\n");
     #print("secondPart:${secondPart}:\n");
     #print("envName:${envName}:    envTranslation:${envTranslation}:\n");
     $outString = "${firstPart}${envTranslation}${secondPart}";
     $outString = replacePerlVariablesAndENV_InString($outString);
   }
   return $outString;
}

sub getMenuPoint {
   my($inVal) = @_;
   my $retVal = strip(getFieldFromString(":",0,$inVal,$notFoundStr));
   ### print("retVal:${retVal}:\n");
   return $retVal;
}

sub createAsciiMenu_Old {
  my($endStr,$titleStr,$selectStr,@menuPoints) = @_;
  $endStr        = setDefault($endStr,"Schluss");
  $titleStr      = setDefault($titleStr,"Menu");
  $selectStr     = setDefault($selectStr,"Auswahl");

  my $endLoop = $FALSE;
  do {
    VT52_cls_home();

    my $itemNr = 1;
    print(unterstreichen("$titleStr"));
    foreach my $aMenuItem (@menuPoints) {
      print("${itemNr}:  ${aMenuItem}\n");
      $itemNr++;
    }
    print("\n0:  ${endStr}\n");
    $answer = readln("${selectStr} (0..".($itemNr-1).")",0);
    if (($answer lt $itemNr) && ($answer ge 0)) {
      $endLoop = $TRUE;
    }
  } until($endLoop eq $TRUE);
  return $answer;
}

sub createAsciiMenu {
	my($endStr,$titleStr,$selectStr,@menuPoints) = @_;
	$endStr        = setDefault($endStr,"Schluss");
	$titleStr      = setDefault($titleStr,"Menu");
	$selectStr     = setDefault($selectStr,"Auswahl");

	my @menuSelections = (0);
	my $endLoop = $FALSE;
	do {
		VT52_cls_home();

		my $itemNr = 1;
		print(unterstreichen("$titleStr"));
		foreach my $aMenuItem (@menuPoints) {
			print("${itemNr}:  ${aMenuItem}\n");
			push(@menuSelections,$itemNr);
			$itemNr++;
		}
		print("\n0:  ${endStr}\n");
		$answer = readln("${selectStr} (0..".($itemNr-1).")",0);
		if (foundInArray($answer,@menuSelections)){
			$endLoop = $TRUE;
			## print("END OF LOOP\n");
		}
	} until($endLoop eq $TRUE);
	return $answer;
}

sub createAsciiMenuExtended_TBD {
	my($endStr,$titleStr,$selectStr,$startNr,$endMenuPoint,$padNr,$pointTextSep,@menuPoints) = @_;
	$titleStr      = setDefault($titleStr,"Menu");
	$selectStr     = setDefault($selectStr,"Auswahl");
	$startNr       = setDefault($startNr,1);
	$endMenuPoint  = setDefault($endMenuPoint,"0");
	$padNr         = setDefault($padNr,1);
	$pointTextSep  = setDefault($pointTextSep,": ");

	my @menuSelections = (0);
	my $endLoop = $FALSE;
	do {
		VT52_cls_home();

		my $itemNr = $startNr;
		print(unterstreichen("$titleStr"));
		foreach my $aMenuItem (@menuPoints) {
			print(padString($itemNr,$padNr)."${pointTextSep}${aMenuItem}\n");
			push(@menuSelections,$itemNr);
			$itemNr++;
		}
		if ($endStr ne "") {
			print("\n".padString($endMenuPoint,$padNr)."${pointTextSep}${endStr}\n\n");
			push(@menuSelections,$endMenuPoint);
			$answer = readln("${selectStr} (${startNr}..${itemNr}, ${endMenuPoint})",$endMenuPoint);
		} else {
			print("\n");
			if ($selectStr ne "NO_SELECT") { $answer = readln("${selectStr} (${startNr}..".($itemNr-1).")",$startNr); }
		}
		if (foundInArray($answer,@menuSelections)){
			$endLoop = $TRUE;
			## print("END OF LOOP\n");
		}
	} until($endLoop eq $TRUE);
	### print("answer:${answer}:\n");
	return $answer;
}


sub createAsciiMenuExtended {
	my($endStr,$titleStr,$selectStr,$startNr,$endMenuPoint,$padNr,$pointTextSep,@menuPoints) = @_;
	$titleStr      = setDefault($titleStr,"Menu");
	$selectStr     = setDefault($selectStr,"Auswahl");
	$startNr       = setDefault($startNr,1);
	$endMenuPoint  = setDefault($endMenuPoint,"0");
	$padNr         = setDefault($padNr,1);
	$pointTextSep  = setDefault($pointTextSep,": ");
	return createAsciiMenuMultipleSelection($endStr,$titleStr,$selectStr,$startNr,$endMenuPoint,$padNr,$pointTextSep,$FALSE,@menuPoints);
}

sub createAsciiMenuMultipleSelection {
	my($endStr,$titleStr,$selectStr,$startNr,$endMenuPoint,$padNr,$pointTextSep,$multipleSelection,@menuPoints) = @_;
	return createAsciiMenuMultipleSelectionWithComments($endStr,$titleStr,$selectStr,$startNr,$endMenuPoint,$padNr,$pointTextSep,$multipleSelection,"",@menuPoints);
}

sub createFigureRangeFromTo {
	my($fromFig,$toFig,$sepChr) = @_;
	$sepChr = setDefault($sepChr,";");

	my $retVal = "";
	for (my $i =$fromFig; $i <= $toFig; $i++) {
		if ($retVal ne "") { $retVal = $retVal.";";
		}
		$retVal = $retVal.$i;
	}
	return $retVal
}

sub createFigureRange {
	my($figRange,$sepChr) = @_;
	$sepChr = setDefault($sepChr,";");
	
	$figRange =~ s/\s*-\s*/-/g;
	my ($fromFig, $toFig) = split("-",$figRange);
	return createFigureRangeFromTo($fromFig,$toFig,$sepChr); 
}

sub createAsciiMenuMultipleSelectionWithComments {
	my($endStr,$titleStr,$selectStr,$startNr,$endMenuPoint,$padNr,$pointTextSep,$multipleSelection,$commentStr,@menuPoints) = @_;
	$titleStr           = setDefault($titleStr,"Menu");
	$selectStr          = setDefault($selectStr,"Mehrfach-Auswahl");
	$startNr            = setDefault($startNr,1);
	$endMenuPoint       = setDefault($endMenuPoint,"0");
	$padNr              = setDefault($padNr,1);
	$pointTextSep       = setDefault($pointTextSep,": ");
	$multipleSelection  = setDefault($multipleSelection,$FALSE);

	my $answer = "";
	my $endLoop = $FALSE;
	my @menuSelections = ();
	my $itemNr  = 0;
	my $maxItem = 0;
	do {
		# Menu anzeigen
		do {
			@menuSelections = ();
			if ($endStr ne "") {
				@menuSelections = (0);
			}
			$endLoop = $TRUE;
			$itemNr  = $startNr;
			$maxItem = 0;
			VT52_cls_home();		
			print(unterstreichen("$titleStr"));
			foreach my $aMenuItem (@menuPoints) {
				if (($commentStr ne "") && (stringStartsWith($aMenuItem,$commentStr))) {
					## @menuPoints removeEntriesFromArray($pattern,$caseSensitive,@inArray)
					$aMenuItem =~ s/^$commentStr//g;
					print("${aMenuItem}\n");
				} else {
					print(padString($itemNr,$padNr)."${pointTextSep}${aMenuItem}\n");
					push(@menuSelections,$itemNr);
					$itemNr++;
				}
			}
			$maxItem = $itemNr - 1;

			if ($endStr ne "") {
				print("\n".padString($endMenuPoint,$padNr)."${pointTextSep}${endStr}\n\n");
				push(@menuSelections,$endMenuPoint);
				$answer = readln("${selectStr} [${startNr}..".($itemNr - 1).", ${endMenuPoint}]",$endMenuPoint);
			} else {
				print("\n");
				if ($selectStr ne "NO_SELECT") { $answer = readln("${selectStr} [${startNr}..".($itemNr-1)."]",$startNr); }
			}
			
			if ($answer eq "?") {
				if ($multipleSelection) {
					print("\tMultiple-Selection possible!\n");
					print("\t\te.g.\t1, 5 ; 6 7 8-9 4..6\n");
				} else {
					print("\tOnly single selection possible\n");
				}
				print("\t");halt();
				$endLoop = $FALSE;
			}
		} until($endLoop eq $TRUE);
		
		# Multiple-Selection auflösen
		if ($multipleSelection) {
			# print("answer (0):${answer}:\n"); ## halt();
			$answer =~ s/\.\./-/g;
			$answer =~ s/\s*-\s*/-/g;
			$answer =~ s/ /;/g;
			$answer =~ s/,/;/g;
			# print("answer (0):${answer}:\n");

			while (stringContains($answer,";;")) {
				$answer =~ s/;;/;/g;
			}
			## print("answer (1):${answer}:\n");
			my @listOfAnswers = split(";",$answer);
			## displayArray(@listOfAnswers); print("\n");
					
			# replace 4-8 with 4;5;6;7;8
			# Test cases: 1 - 5 6 -9 10 12-16
			$answer = "";
			foreach my $partOfAnswer (@listOfAnswers) {
				if ($answer ne "") { $answer = $answer.";"; }
				if ($partOfAnswer =~ /\d+-\d+/) {
					my $figRange = createFigureRange($partOfAnswer,";");
					$answer = $answer.$figRange;
				} else {
					$answer = $answer.$partOfAnswer;
				}
			}
			@listOfAnswers  = makeArrayEntriesDistinct($TRUE,split(";",$answer));
			
			@menuSelections = @listOfAnswers;
			## print("answer (7):${answer}:\n"); displayArray(@listOfAnswers); halt();
			## displayArray(@menuSelections);halt();
			if (($endStr ne "") && ($answer eq $endMenuPoint)) {  # ALL has been choosen
				## print("All has been selected !!!\nendMenuPoint:${endMenuPoint}:\n");
				## displayArray(@menuSelections); halt();
				# @listOfAnswers = removeEntriesFromArray("\^${endMenuPoint}\$",$TRUE,@menuSelections);
				@listOfAnswers = (${endMenuPoint});
				## displayArray(@listOfAnswers); halt();
				$answer = makeStrFromArray(";",@listOfAnswers);
				## print("answerxxxxx:${answer}:\n"); halt();
				$endLoop = $TRUE;
			} else {
				$endLoop = $TRUE;
				$answer = "";
				foreach my $anAnswer (@listOfAnswers) {
					if ($answer eq "") {
						$answer = "${anAnswer}";
					} else {
						$answer = "${answer};${anAnswer}";
					}
					if (!(foundInArray($anAnswer,@menuSelections))){
						$endLoop = $FALSE;
					}
				}
			}
		} else {
			if (foundInArray($answer,@menuSelections)){
				$endLoop = $TRUE;
				## print("END OF LOOP\n");
			}
		}
	} until($endLoop eq $TRUE);
	## print("answer:${answer}:\n");
	return $answer;	
}

# %menu = (
#    "1: Convert Playlist" => "convertPlaylist",
#    "2: Export Playlist"  => "exportPlaylistItems",
#    "3: Show UNIX Path"   => "showUNIX_PATH",
# );
sub createAsciiMenuAndPerformActions {
  my($endStr,$titleStr,$selectStr,%menuPointsAndActions) = @_;
  $endStr        = setDefault($endStr,"0: Schluss");
  $titleStr      = setDefault($titleStr,"Menu");
  $selectStr     = setDefault($selectStr,"Auswahl");

  my @menuPoints     = getAllKeysFromHash_AsArray($TRUE,%menuPointsAndActions);
  # print("menuPoints\n"); displayArray(@menuPoints);
  my @menuSelections = processEachElementInArray("getMenuPoint",@menuPoints);
  # print("menuSelections\n"); displayArray(@menuSelections);
  
  my $endMenuSelection = strip(getFieldFromString(":",0,$endStr,$notFoundStr));
  
  do {
    VT52_cls_home();

    my $itemNr = 1;
    print(unterstreichen("$titleStr"));
    foreach my $aMenuItem (@menuPoints) {
      print("${aMenuItem}\n");
    }
    print("\n${endStr}\n");
    $answer = strip(readln("${selectStr}",$endMenuSelection));
    if (foundInArray($answer,@menuSelections)){
        my $functionToCall = $menuPointsAndActions{$menuPoints[getElementIndexInArray($answer,@menuSelections)]};
        my @fctCallList    = split(";",$functionToCall);
        foreach my $aSingleCmd (@fctCallList) {
        	### printf("aSingleCmd:${aSingleCmd}:\n");
          my $retVal = &$aSingleCmd();
          if ($retVal ne "") { print("${retVal}\n"); }
        }
    }
  } until($answer eq $endMenuSelection);
}


############################################################################
# Function for managing a document archive
############################################################################

# const used for DocArchive
# Access-Modes
$DocRead        = "R";
$DocWrite       = "W";
$DocDelete      = "D";
$DocReadWrite   = "RW";
$DocLocking     = "L";
$DocSubscribing = "S";


$DocCommonDocu                = "XXXXXXXXX";
$DocArchiveRootName           = "ROOT";
$DocArchiveLockStatus         = "LOOKSTATUSNORMAL";
$DocArchiveLockErrorStatus    = "LOOKSTATUSERROR";
$DocArchiveFileIsLocked       = "File locked";
$DocArchiveLockedBy           = "Locked by";
$useLayersForFunctionOverview = $FALSE;

# returns a list of documents which a particular user group has access
sub getAvailableDocus {
  my($docuGroupFileName,$sepChar,$privSep,$docGroupFN,$docFN,$docArchiveRoot,$requestedGroup,$accessMode) = @_;
  $accessMode     = setDefault($accessMode,$DocRead);
  my(@documentPattern) = getPrivilegedDocus($docuGroupFileName,$sepChar,$privSep,$docGroupFN,$docFN,$requestedGroup,$accessMode);
  my(@retList) = ();
  my(@tmpList) = ();
  my($aDocPat) = "";
  foreach $aDocPat (@documentPattern) {
     $aDocPat = strip($aDocPat);
     my($fullPat) = $aDocPat;
     if ($docArchiveRoot ne "") {
        $fullPat = "${docArchiveRoot}/${aDocPat}";
     }
     @tmpList = dirListExtended($fullPat);
     @retList = (@retList,@tmpList);
  }
  @retList = makeArrayEntriesDistinct($TRUE,@retList);
  return @retList;
}


sub addDocArchiveHeaderParts() {
return <<__END_OF_DOCHEAD__; 
 <link   rel="stylesheet"      href="/JavaScriptModule/ToolTipp.css">
 <SCRIPT LANGUAGE="JavaScript" SRC="/JavaScriptModule/PopUpWindow.js"></SCRIPT>
 <SCRIPT LANGUAGE="JavaScript" SRC="/JavaScriptModule/siCommon.js"></SCRIPT>
 <SCRIPT LANGUAGE="JavaScript" SRC="/JavaScriptModule/movingLayer_V3.js"></SCRIPT>
__END_OF_DOCHEAD__
}


# main docArchive function to be called after the mainDoor
# Parameter:
#     $tocFormatFunction is the function which is called to format the available documents
#       you need to pass the parameter like \&yourFormatTOC
#       There is a default function called "formatTOCDefault" or "formatTOCDefaultWithLayers"
#       which you can take as a template
#
# The "successHtmlTemplate" looks like the following example
##   Anzahl files uploaded:{countOfUploadedFiles}<BR>
##   Bytes Uploaded: {totalBytesUploaded}<BR>
##         Summery:{uploadSummary}<BR>
##         Destination: {uploadDestinationDir}<BR>
##
##<CENTER><FORM><INPUT TYPE=BUTTON  VALUE="Close" onClick=self.close()></FORM></CENTER>
#
# --> To have a trace and log file please define
# $docArchiveLogFileName = $logFileName;
#
# --> If you want to format the TOC for a particular directory define the following:
# (define colums in doc-control tool to 0)
# 
# $docFormatTOC_Content     = "formatTOC_Content";
#
# sub formatTOC_Content {
#   my($partPathName,$fileName,$aUrl) = @_;
#   my $retStr = "<A ${aUrl}>${fileName}</A>";
#   if ($partPathName eq "FAS133") {
#     $retStr = "<A ${aUrl}>${fileName}....</A>";
#   }
#   return $retStr;
# }
#
# --> If you want to change sorting order for a particular directory define the following:
#     (e.g. sort reverse for a particular directory called FAS133
# $docTOC_Sorter            = "docTOC_Sorter";
#
# sub docTOC_Sorter {
#   my(@inList)  = @_;
#   my(@outList) = ();
#   my(@fasList) = ();
#   foreach my $aDoc (@inList) {
#      if (index($aDoc,"/FAS133/") != -1) {
#         push(@fasList,$aDoc);
#      } else {
#         if (countOfArrayElements(@fasList) != 0) {
#           @fasList = (reverse @fasList);
#            @outList = concatArray(@outList,@fasList);
#            @fasList = ();
#         }
#         push(@outList,$aDoc);
#      }
#   }
#   return @outList;
# }

sub accessDocumentArchive {
 my($docAccessTable,$group,$docAccessTblSep,$successHtmlTemplate,$tocFormatFunction,$patternSep,$fn_Group,$fn_pattern,$docArchiveRoot,$uploadWinWidth,$uploadWinHigh,$uploadFieldSize) = @_;

 $docAccessTblSep   = setDefault($docAccessTblSep,";");
 $patternSep        = setDefault($patternSep,"&");
 $fn_Group          = setDefault($fn_Group,$docAccessDocumentGroupFNam);
 $fn_pattern        = setDefault($fn_pattern,$docAccessDocumentsFNam);
 $uploadWinWidth    = setDefault($uploadWinWidth,"350");
 $uploadWinHigh     = setDefault($uploadWinHigh,"200");
 $uploadFieldSize   = setDefault($uploadFieldSize,"20");

 docSetDefaultValuesFromTOP_LEVEL_COMMENT();
 if ($docControlFile ne "") {
   %docTitleTrans    = getTransTable($docControlFile,$docControlFileSepChar,"",$docControlFileDirName,$docControlFile_Title,"","");
 }

 my($docDefaultFormatFct) = "formatTOCDefault";
 if ($useLayersForFunctionOverview) {
   $docDefaultFormatFct = "formatTOCDefaultWithLayers";
 }

 $tocFormatFunction = setDefault($tocFormatFunction,$docDefaultFormatFct);

 my($documentName)           = getParam("documentName","");
 my($fileName)               = getFileNameOutOfFullName($documentName);
 my($docPath)                = getPathNameOutOfFullName($documentName);   
 my($docArchiveRelativePath) = $docPath;
 $docArchiveRelativePath     =~ s/$docArchiveRoot//; $docArchiveRelativePath =~ s/^\///;
 
 writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}accessDocumentArchive has been called");

 if ($docViewAction  eq "DisplayDoc") {
   my(@documetList)    = getAvailableDocus($docAccessTable,$docAccessTblSep,$patternSep,$fn_Group,$fn_pattern,$docArchiveRoot,$group,$DocRead);
   if (foundInArray($documentName,@documetList)) {
      sendBackFileWithMimeType($documentName);
      writeToDocStatistik("Viewed",$loginUserId,$documentName,"");
      writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Sent back ${documentName}");
   } else {
      print ("Content-type: text/html\n\n");
      print("No access to ${documentName}:<BR>\n");
      writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Access denied to ${documentName}");
   }
   exit;
 }

 if ($docViewAction  eq "") {
   writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Asked for available documents for ${group}");

   my(@documetList)    = getAvailableDocus($docAccessTable,$docAccessTblSep,$patternSep,$fn_Group,$fn_pattern,$docArchiveRoot,$group,$DocRead);
   my(@uploadList)     = getAvailableDocus($docAccessTable,$docAccessTblSep,$patternSep,$fn_Group,$fn_pattern,$docArchiveRoot,$group,$DocWrite);
   my(@deleteList)     = getAvailableDocus($docAccessTable,$docAccessTblSep,$patternSep,$fn_Group,$fn_pattern,$docArchiveRoot,$group,$DocDelete);
   my(@lockingList) = ();
   if (-f $docLockingTable) {
     @lockingList   = getAvailableDocus($docAccessTable,$docAccessTblSep,$patternSep,$fn_Group,$fn_pattern,$docArchiveRoot,$group,$DocLocking);
   }
   my(@subscribeList)  = ();
   if (-f $docSubscribingTable) {
     @subscribeList  = getAvailableDocus($docAccessTable,$docAccessTblSep,$patternSep,$fn_Group,$fn_pattern,$docArchiveRoot,$group,$DocSubscribing);
   }
   addJSshowPage("uploadFormWindow","no","no","no","yes",$uploadWinWidth,$uploadWinHigh,"showUploadForm");
   my(@parameters) = ();

   @documetList = (sort @documetList);

   if ($docTOC_Sorter ne "") {
       @documetList = &$docTOC_Sorter(@documetList);
   }

   foreach $document (@documetList) {
     my($viewLink) = "<A HREF=\"${myCgiFormName}?documentName=".urlEncode($document)."&docViewAction=DisplayDoc&$externalParam\">";
     if ($useLayersForFunctionOverview) {
         $viewLink = "${myCgiFormName}?documentName=".urlEncode($document)."&docViewAction=DisplayDoc&${externalParam}";
     }

     my($fileName) = getFileNameOutOfFullName($document);
     my($uploadLink)        = "";
     my($deleteLink)        = "";
     my($lockingLink)       = "";
     my($unlockingLink)     = "";
     my($subscribeLink)     = "";
     my($unsubscribeLink)   = "";
     my($lockedBy)          = "";
     my($isLocked)          = $FALSE;
     if (-f $docLockingTable) {
       $lockedBy   = getFileLockOwner($document,$TRUE);
       $isLocked   = isFileLocked($document,$loginUserId);
     }
     my($alreadySubscribed) = $FALSE;
     if (-f $docSubscribingTable) {
       $alreadySubscribed = isAlreadySubsribed($document,$loginUserId);
     }

     if (foundInArray($document,@uploadList)) {
        my($uploadURL) = "${myCgiFormName}?documentName=${document}&docViewAction=UploadDocuShowForm&$externalParam";
        if ($useLayersForFunctionOverview) {
           $uploadLink = "${uploadURL}";
        } else {
           $uploadLink = " <A HREF=\"javascript:showUploadForm('${uploadURL}')\">";
        }
        if ($isLocked) { $uploadLink = ""; }
     }
     if (foundInArray($document,@deleteList)) {
        my($urlDocName) = $document;
        $urlDocName =~ s/ /\+/g;
        my($deleteURL) = "${myCgiFormName}?documentName=${urlDocName}&docViewAction=UploadDocuShowDeleteForm&$externalParam";
        if ($useLayersForFunctionOverview) {
           $deleteLink = "${deleteURL}";
        } else {
           $deleteLink = " <A HREF=\"javascript:showUploadForm('${deleteURL}')\">";
        }
        if ($isLocked) { $deleteLink = ""; }
     }
     if (foundInArray($document,@lockingList)) {
        my($urlDocName) = $document;
        $urlDocName =~ s/ /\+/g;
        my($lockingURL) = "${myCgiFormName}?documentName=${urlDocName}&docViewAction=UploadDocuShowLockingForm&$externalParam";
        if ($useLayersForFunctionOverview) {
            $lockingLink = "${lockingURL}";
        } else {
            $lockingLink = " <A HREF=\"javascript:showUploadForm('${lockingURL}')\">";
        }
        if ($isLocked) { $lockingLink = ""; }
     }
     if (foundInArray($document,@subscribeList)) {
        my($urlDocName) = $document;
        $urlDocName =~ s/ /\+/g;
        my($subscribeURL) = "${myCgiFormName}?documentName=${urlDocName}&docViewAction=UploadDocuShowSubscribingForm&$externalParam";
        if ($useLayersForFunctionOverview) {
            $subscribeLink = "${subscribeURL}";
        } else {
            $subscribeLink = " <A HREF=\"javascript:showUploadForm('${subscribeURL}')\">";
        }
     }
     if ($lockedBy eq $loginUserId) {
        $lockingLink = "";
        $lockedBy    = "";
        my($urlDocName) = $document;
        $urlDocName =~ s/ /\+/g;
        my($unlockingURL) = "${myCgiFormName}?documentName=${urlDocName}&docViewAction=UploadDocuShowUnlockingForm&$externalParam";
        if ($useLayersForFunctionOverview) {
            $unlockingLink = "${unlockingURL}";
        } else {
            $unlockingLink = " <A HREF=\"javascript:showUploadForm('${unlockingURL}')\">";
        }
     }
     if ($alreadySubscribed) {
        my($urlDocName) = $document;
        $urlDocName =~ s/ /\+/g;
        $subscribeLink = "";
        my($unsubscribeURL) = "${myCgiFormName}?documentName=${urlDocName}&docViewAction=UploadDocuShowUnsubscribingForm&$externalParam";
        if ($useLayersForFunctionOverview) {
            $unsubscribeLink = "${unsubscribeURL}";
        } else {
            $unsubscribeLink = " <A HREF=\"javascript:showUploadForm('${unsubscribeURL}')\">";
        }
     }
     if (!(foundInArray($document,@uploadList))) {
        $lockedBy = "";
     }
     my $modDate  = getModifyDateAsTimeStamp($document);
     my $fileSize = getFileSizeInByte($document,$TRUE);
     push(@parameters,"${viewLink};${uploadLink};${fileName};${document};${deleteLink};${lockingLink};${subscribeLink};${lockedBy};${unlockingLink};${unsubscribeLink};${modDate};${fileSize}");
   }
   my $commonUploadURL  = "${myCgiFormName}?documentName=${docArchiveRoot}/${DocCommonDocu}&docViewAction=UploadDocuShowForm&$externalParam";
   my $commonUploadLink = " <A HREF=\"javascript:showUploadForm('${commonUploadURL}')\">";
   if ($useLayersForFunctionOverview) {
      $commonUploadLink = $commonUploadURL;
   }
   # print("commonUploadURL :${commonUploadURL}:<BR>\n");
   # print("commonUploadLink:${commonUploadLink}:<BR>\n");
   
   &$tocFormatFunction($group,$commonUploadLink,@parameters);
   print("</BODY></HTML>");

 } elsif ($docViewAction  eq "UploadDocuShowForm") {
     my($countOfFields) = getParam("countOfFields","1");
     print("<!-- fileName:${fileName} -->\n");
     print("<!-- docPath:${docPath} -->\n");
     print("<!-- docArchiveRelativePath:${docArchiveRelativePath} -->\n");
     print("<!-- countOfFields:${countOfFields} -->\n");
     createFileUploadForm($myCgiFormName,"UploaderForm",getLangStr("strSave"),$uploadFieldSize,$docPath,$countOfFields,$fileName,$externalParam,getLangStr("strClose"));
     print("</BODY></HTML>");
     writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Showed Uploadform");

 } elsif ($docViewAction  eq "UploadDocuShowSubscribingForm") {
     my($docPartName)          = $documentName; $docPartName=~ s/$docArchiveRoot//; $docPartName =~ s/^\///;
     my($strReallySubscribe)   = getLangStr("strReallySubscribe");
     my($strYes)               = getLangStr("strYes");
     my($strNo)                = getLangStr("strNo");
     printf("${strReallySubscribe}",$docPartName);
     addJScommon();
     addJScookies();

     print("<SCRIPT>\n");
     print("function initFocus(form) {\n");
     print("  form.recEmail.focus()\n");
     print("}\n");

     print("function checkBeforeSubmit (form,button) {\n");
     print("  if (!check(form)) return;\n");
     print("  form.submit();\n");
     print("  return;\n");
     print("}\n");

     print("function check(form) {\n");
     print(" if (form.recEmail.value.length == 0) {\n");
     printf("   alert ('%s');\n",getLangStr("strInputRequired"));
     print("   form.recEmail.focus();\n");
     print("   return (false);\n");
     print("  }\n");
     print("  setCookie('emailAdr', form.recEmail.value);\n");
     print("  return (true);\n");
     print("}\n");

     print("function readCookies(form) {\n");
     print("  form.recEmail.value = getCookie('emailAdr','');\n");
     print("}\n");

     print("</SCRIPT>\n");

     print("<FORM Name=\"DocViewSubscribeConformationForm\" ACTION=\"${myCgiFormName}\" METHOD=\"POST\">\n");
     print("  <TABLE> \n");
     print("    <TR><TD>Email</TD>        <TD><INPUT TYPE=TEXT  NAME=recEmail  SIZE=${docSubscribingEmailFLen}></TD></TR>\n");
     print("    <TR><TD>As Attachment</TD><TD><SELECT           NAME=\"asAttach\" size=\"1\"><OPTION VALUE=\"Yes\" SELECTED>${strYes}<OPTION VALUE=\"No\">${strNo}</SELECT></TD></TR>\n");
     print("  </TABLE><BR>\n");
     print("  <INPUT TYPE=HIDDEN   NAME=documentName          VALUE=\"${documentName}\">\n");
     print("  <INPUT TYPE=HIDDEN   Name=docViewAction         VALUE=DoSubscribe>\n");
     print("  <INPUT TYPE=\"BUTTON\" VALUE=\"${strYes}\" onClick='checkBeforeSubmit(this.form, this)'>&nbsp;&nbsp;&nbsp;\n");
     print("  <INPUT TYPE=\"BUTTON\" VALUE=\"${strNo}\"  onClick=self.close()>\n");
     printf("%s",produceHiddenField($externalParam,""));
     print("</FORM>\n");
     print("<SCRIPT>initFocus(document.DocViewSubscribeConformationForm);readCookies(document.DocViewSubscribeConformationForm)</SCRIPT>\n");
     print("</BODY></HTML>");
     writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Showed Subscribingform");

  } elsif ($docViewAction  eq "DoSubscribe") {
     my($strHasSubscribed)     = getLangStr("strHasSubscribed");
     my($subEmail)             = getParam("recEmail","");
     my($subAsAttach)          = getParam("asAttach","Yes");
     my($retVal)               = "";
     my($docPartName)   = $documentName; $docPartName=~ s/$docArchiveRoot//; $docPartName =~ s/^\///;
     if (hasWriteAccess($DocSubscribing,$docAccessTable,$docAccessTblSep,$patternSep,$fn_Group,$fn_pattern,$group,$docPartName)) {
            $retVal = insertSubscribtion($documentName,$loginUserId,$subEmail,$subAsAttach);
            if ($retVal eq "") {
                printf("${strHasSubscribed}",$docPartName,$subEmail);
                writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Subscribed ${documentName}");
            }
     } else {
        printf("%s",getLangStr("strNotAuthorized"));
        writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Lock ${documentName} denied");
     }
     print("<FORM>\n");
     if ($retVal ne "") {
        print("${retVal}<BR><BR>");
        writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Subscribed ${documentName} failed");
        printf("  <INPUT TYPE=\"BUTTON\" VALUE=\"%s\" onClick=window.history.back()>\n",getLangStr("strBack"));
     }
     printf("  <INPUT TYPE=\"BUTTON\" VALUE=\"%s\" onClick=self.close()>\n",getLangStr("strClose"));
     print("</FORM>\n");
     print("</BODY></HTML>");

 } elsif ($docViewAction  eq "UploadDocuShowLockingForm") {
     my($docPartName)     = $documentName; $docPartName=~ s/$docArchiveRoot//; $docPartName =~ s/^\///;
     my($strReallyLock) = getLangStr("strReallyLock");
     printf("${strReallyLock}",$docPartName);
     print("<FORM Name=\"DocViewLockConformationForm\" ACTION=\"${myCgiFormName}\" METHOD=\"POST\">\n");
     print("  <INPUT TYPE=HIDDEN   NAME=documentName          VALUE=\"${documentName}\">\n");
     print("  <INPUT TYPE=HIDDEN   Name=docViewAction         VALUE=DoLock>\n");
     printf("  <INPUT TYPE=\"SUBMIT\" VALUE=\"%s\">&nbsp;&nbsp;&nbsp;\n",getLangStr("strYes"));
     printf("  <INPUT TYPE=\"BUTTON\" VALUE=\"%s\" onClick=self.close()>\n",getLangStr("strNo"));
     printf ("%s",produceHiddenField($externalParam,""));
     print("</FORM>\n");
     print("</BODY></HTML>");
     writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Showed Deleteform");

  } elsif ($docViewAction  eq "DoLock") {
     my($strLockHasSet)        = getLangStr("strLockHasSet");
     my($strLockHasAlreadySet) = getLangStr("strLockHasAlreadySet");
     my($docPartName)   = $documentName; $docPartName=~ s/$docArchiveRoot//; $docPartName =~ s/^\///;
     if (hasWriteAccess($DocLocking,$docAccessTable,$docAccessTblSep,$patternSep,$fn_Group,$fn_pattern,$group,$docPartName)) {
        my($lockOwner) = isAlreadyLockSet($documentName);
        if ($lockOwner ne "") {
            printf("${strLockHasAlreadySet}",$docPartName,$lockOwner);
            writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Lock ${documentName}");
        } else {
            setDocLock($documentName,$loginUserId);
            printf("${strLockHasSet}",$docPartName);
            writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Lock ${documentName}");
        }
     } else {
        printf("%s",getLangStr("strNotAuthorized"));
        writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Lock ${documentName} denied");
     }
     print("<FORM>\n");
     printf("  <INPUT TYPE=\"BUTTON\" VALUE=\"%s\" onClick=self.close()>\n",getLangStr("strClose"));
     print("</FORM>\n");
     print("</BODY></HTML>");

 } elsif ($docViewAction  eq "UploadDocuShowUnlockingForm") {
     my($docPartName)     = $documentName; $docPartName=~ s/$docArchiveRoot//; $docPartName =~ s/^\///;
     my($strReallyUnlock) = getLangStr("strReallyUnlock");
     printf("${strReallyUnlock}",$docPartName);
     print("<FORM Name=\"DocViewLockConformationForm\" ACTION=\"${myCgiFormName}\" METHOD=\"POST\">\n");
     print("  <INPUT TYPE=HIDDEN   NAME=documentName          VALUE=\"${documentName}\">\n");
     print("  <INPUT TYPE=HIDDEN   Name=docViewAction         VALUE=DoUnlock>\n");
     printf("  <INPUT TYPE=\"SUBMIT\" VALUE=\"%s\">&nbsp;&nbsp;&nbsp;\n",getLangStr("strYes"));
     printf("  <INPUT TYPE=\"BUTTON\" VALUE=\"%s\" onClick=self.close()>\n",getLangStr("strNo"));
     printf ("%s",produceHiddenField($externalParam,""));
     print("</FORM>\n");
     print("</BODY></HTML>");
     writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Showed Deleteform");

  } elsif ($docViewAction  eq "DoUnlock") {
     my($strHasUnlock)      = getLangStr("strHasUnlock");
     my($strNotLockOwner)   = getLangStr("strNotLockOwner");
     my($docPartName)   = $documentName; $docPartName=~ s/$docArchiveRoot//; $docPartName =~ s/^\///;
     if (hasWriteAccess($DocLocking,$docAccessTable,$docAccessTblSep,$patternSep,$fn_Group,$fn_pattern,$group,$docPartName)) {
        my($lockOwner) = isAlreadyLockSet($documentName);
        if (($lockOwner eq "") || ($lockOwner ne $loginUserId)) {
            printf("${strNotLockOwner}",$docPartName,$lockOwner);
            writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Lock was already released or you are not lock owner ${documentName}");
        } else {
            removeDocLock($documentName);
            printf("${strHasUnlock}",$docPartName);
            writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Lock released ${documentName}");
        }
     } else {
        printf("%s",getLangStr("strNotAuthorized"));
        writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Delete ${documentName} denied");
     }
     print("<FORM>\n");
     printf("  <INPUT TYPE=\"BUTTON\" VALUE=\"%s\" onClick=self.close()>\n",getLangStr("strClose"));
     print("</FORM>\n");
     print("</BODY></HTML>");

 } elsif ($docViewAction  eq "UploadDocuShowUnsubscribingForm") {
     my($docPartName)     = $documentName; $docPartName=~ s/$docArchiveRoot//; $docPartName =~ s/^\///;
     my($strReallyUnsubsribe) = getLangStr("strReallyUnsubsribe");
     printf("${strReallyUnsubsribe}",$docPartName);
     print("<FORM Name=\"DocViewUnsubsribeConformationForm\" ACTION=\"${myCgiFormName}\" METHOD=\"POST\">\n");
     print("  <INPUT TYPE=HIDDEN   NAME=documentName          VALUE=\"${documentName}\">\n");
     print("  <INPUT TYPE=HIDDEN   Name=docViewAction         VALUE=DoUnsubsribing>\n");
     printf("  <INPUT TYPE=\"SUBMIT\" VALUE=\"%s\">&nbsp;&nbsp;&nbsp;\n",getLangStr("strYes"));
     printf("  <INPUT TYPE=\"BUTTON\" VALUE=\"%s\" onClick=self.close()>\n",getLangStr("strNo"));
     printf ("%s",produceHiddenField($externalParam,""));
     print("</FORM>\n");
     print("</BODY></HTML>");
     writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Showed Deleteform");

  } elsif ($docViewAction  eq "DoUnsubsribing") {
     my($strHasUnlock)      = getLangStr("strHasUnlock");
     my($strHasUnsubscribe) = getLangStr("strHasUnsubscribe");
     my($strNotSubcriber)   = getLangStr("strNotSubcriber");

     my($docPartName)   = $documentName; $docPartName=~ s/$docArchiveRoot//; $docPartName =~ s/^\///;
     if (hasWriteAccess($DocSubscribing,$docAccessTable,$docAccessTblSep,$patternSep,$fn_Group,$fn_pattern,$group,$docPartName)) {
        my($alreadySubscribed) = isAlreadySubsribed($documentName,$loginUserId);
        if ($alreadySubscribed) {
            removeSubscription($documentName,$loginUserId);
            printf("${strHasUnsubscribe}",$docPartName);
            writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Canceld subcribtion ${documentName}");
        } else {
            printf("${strNotSubcriber}",$docPartName);
            writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Was not subscribed by the this person ${documentName}");
        }
     } else {
        printf("%s",getLangStr("strNotAuthorized"));
        writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Delete ${documentName} denied");
     }
     print("<FORM>\n");
     printf("  <INPUT TYPE=\"BUTTON\" VALUE=\"%s\" onClick=self.close()>\n",getLangStr("strClose"));
     print("</FORM>\n");
     print("</BODY></HTML>");

 } elsif ($docViewAction  eq "UploadDocuShowDeleteForm") {
     my($docPartName)     = $documentName; $docPartName=~ s/$docArchiveRoot//; $docPartName =~ s/^\///;
     my($strReallyDelete) = getLangStr("strReallyDelete");
     printf("${strReallyDelete}",$docPartName);
     print("<FORM Name=\"DocViewDeletConformationForm\" ACTION=\"${myCgiFormName}\" METHOD=\"POST\">\n");
     print("  <INPUT TYPE=HIDDEN   NAME=documentName          VALUE=\"${documentName}\">\n");
     print("  <INPUT TYPE=HIDDEN   Name=docViewAction         VALUE=DoDelete>\n");
     printf("  <INPUT TYPE=\"SUBMIT\" VALUE=\"%s\">&nbsp;&nbsp;&nbsp;\n",getLangStr("strYes"));
     printf("  <INPUT TYPE=\"BUTTON\" VALUE=\"%s\" onClick=self.close()>\n",getLangStr("strNo"));
     printf ("%s",produceHiddenField($externalParam,""));
     print("</FORM>\n");
     print("</BODY></HTML>");
     writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Showed Deleteform");

  } elsif ($docViewAction  eq "DoDelete") {
     my($strHasDeleted)     = getLangStr("strHasDeleted");
     my($strNotLockOwner)   = getLangStr("strNotLockOwner");
     my($docPartName)   = $documentName; $docPartName=~ s/$docArchiveRoot//; $docPartName =~ s/^\///;
     if (hasWriteAccess($DocDelete,$docAccessTable,$docAccessTblSep,$patternSep,$fn_Group,$fn_pattern,$group,$docPartName)) {
        my($lockOwner) = isAlreadyLockSet($documentName);
        if (($lockOwner eq "") || ($lockOwner eq $loginUserId)) {
            unlink($documentName);
            writeToDocStatistik("Deleted",$loginUserId,$documentName,"");
            printf("${strHasDeleted}",$docPartName);
            writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Deleted ${documentName}");
        } else {
            printf("${strNotLockOwner}",$docPartName,$lockOwner);
            writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Lock was was set. Could not delete! ${documentName}");
        }
     } else {
        printf("%s",getLangStr("strNotAuthorized"));
        writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Delete ${documentName} denied");
     }
     print("<FORM>\n");
     printf("  <INPUT TYPE=\"BUTTON\" VALUE=\"%s\" onClick=self.close()>\n",getLangStr("strClose"));
     print("</FORM>\n");
     print("</BODY></HTML>");

} elsif ($docViewAction eq "Upload") {
     my($docUploadDestination) = getParam("docUploadDestination","");
     print("<!-- docUploadDestination:${docUploadDestination} -->\n");
     my(%FileHandlesAndNames) = getFileHandlesAndNames();
     ## displayHashTableHTML(%FileHandlesAndNames);
     my($FileHandlesAndNamesHashRef) = \%FileHandlesAndNames;
     ## print("docUploadDestination:${docUploadDestination}<BR>\n");
     ## print("maxByte:${maxByte}<BR>\n");
     ## print("successURL:${successURL}<BR>\n");
     
     if (hasWriteAccess($DocWrite,$docAccessTable,$docAccessTblSep,$patternSep,$fn_Group,$fn_pattern,$group,docArchiveGetFullFileNames($docUploadDestination,$docArchiveRoot,%FileHandlesAndNames))) {
        uploadFiles($docUploadDestination,$maxByte,$successHtmlTemplate,$FileHandlesAndNamesHashRef,$loginUserId);
     } else {
        printf("%s",getLangStr("strNotAuthorized"));
        printf("<FORM><INPUT TYPE=BUTTON  VALUE=\"%s\" onClick=self.close()></FORM>\n",getLangStr("strClose"));
        writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Upload denied");
     } 
 }
}


# returns all directories for a particular user and access mode
sub getPrivilegedDirectories {
  my($docuGroupFileName,$sepChar,$privSep,$docGroupFN,$docFN,$requestedGroup,$accessMode,$archiveRoot) = @_;
  $sepChar        = setDefault($sepChar,";");
  $privSep        = setDefault($privSep,"&");
  $docGroupFN     = setDefault($docGroupFN,"DocumentGroup");
  $docFN          = setDefault($docFN,"Documents");
  $accessMode     = setDefault($accessMode,$DocRead);

  my(@privDirs) = getPrivilegedDocus($docuGroupFileName,$sepChar,$privSep,$docGroupFN,$docFN,$requestedGroup,$accessMode);
  my(@retList)  = ();
  my($privDir)  = "";
  foreach $privDir (@privDirs) {
     my($aPath) = getPathNameOutOfFullName($privDir);
     ## if ($aPath eq "") {
     ##    $aPath = $archiveRoot;
     ## } else {
     ##    $aPath = "${archiveRoot}/${aPath}";
     ## }
     push(@retList,$aPath);
  }
  @retList = makeArrayEntriesDestinct($FALSE,@retList);
  return @retList;
}

# returns all the filepattern for a particular user and access mode
sub getPrivilegedDocus {
  my($docuGroupFileName,$sepChar,$privSep,$docGroupFN,$docFN,$requestedGroup,$accessMode) = @_;
  $sepChar        = setDefault($sepChar,";");
  $privSep        = setDefault($privSep,"&");
  $docGroupFN     = setDefault($docGroupFN,"DocumentGroup");
  $docFN          = setDefault($docFN,"Documents");
  $accessMode     = setDefault($accessMode,$DocRead);

  my(@retList)         = ();
  my($aWhereClause)    = "${docGroupFN}=${requestedGroup}";
  
  my(@documentPattern) = getColumnValues($docuGroupFileName,$sepChar,$docFN,$aWhereClause,"","");
  my($countOfDocPat) = 0;
  $countOfDocPat= @documentPattern;
  if ($countOfDocPat != 1) {  # error not a unique docGroup or docGroup not found
      return @retList;
  } else {
      my($docPatStr) = $documentPattern[0];
      $docPatStr =~ s/\<BR\>/\&/g;
      my(@tmpFileList) = split($privSep,$docPatStr);
      my($aFilePat) = "";
      foreach $aFilePat (@tmpFileList) {
         $aFilePat =~ s/ +/ /g;
         my(@parts) = ();
         @parts = split(" ",$aFilePat);
         if ($parts[1] eq "") {
           if ($accessMode eq $DocRead) {
              push(@retList,$parts[0]);
           }                 
         } else {
             my($docPriv) = uc($parts[1]);
             if ((($accessMode eq $DocReadWrite)   && (index($docPriv,$DocReadWrite)   >= 0)) ||
                 (($accessMode eq $DocRead)        && (index($docPriv,$DocRead)        >= 0)) ||
                 (($accessMode eq $DocDelete)      && (index($docPriv,$DocDelete)      >= 0)) ||
                 (($accessMode eq $DocWrite)       && (index($docPriv,$DocWrite)       >= 0)) ||
                 (($accessMode eq $DocLocking)     && (index($docPriv,$DocLocking)     >= 0)) ||
                 (($accessMode eq $DocSubscribing) && (index($docPriv,$DocSubscribing) >= 0))
                 ) {
                    push(@retList,$parts[0]);
             }     
         }
      }
      ### displayArrayHTML(@retList);
      return @retList;
  }
}


# returns all privileged subscriber for a particular document in a list
# each entry looks like:  "$subscEmail;$subscAsAttach;$subscName"
# $docName needs to be the full qualified filename
sub getPrivilegedSubscriber {
  my($docName) = @_;
  my(@retList) = ();
  my($reqFields) = "${docSubscribingFileNameFNam};${docSubscribingOwnerFNam};${docSubscribingEmailFNam};${docSubscribingAsAttachFNam}";
  my(@retValFromSubscFile) = getColumnValues($docSubscribingTable,$docSubscribingTabSep,$reqFields,"","",$FALSE);
  my($aSubscribeEntry) = "";
  foreach $aSubscribeEntry (@retValFromSubscFile) {
      my($subscFilename,$subscOwner,$subscEmail,$subscAsAttach) = split(";",$aSubscribeEntry);
      print("<!-- getPrivilegedSubscriber::subscFilename:${subscFilename}: subscOwner:${subscOwner}: subscEmail:${subscEmail}: subscAsAttach::${subscAsAttach}: -->\n");
      # check if the document matches the pattern in the subscribing file
      if (filenameMatchesPattern($docName,$subscFilename)) {
         print("<!-- getPrivilegedSubscriber::Matches:${docName}:${subscFilename}: myCgiFormName:${myCgiFormName} -->\n");
         # check if the user has privilege to view this document
         $docGroup = getPrivileges($passwordFile,$passwordSepChar,$subscOwner,"",$myCgiFormName,$passwordUserIdFNam,"",$passwordPrivFNam,$privSep,$TRUE,$FALSE,$privTblFileName,$privTblPrivGroupFieldName,$privTblPrivFieldName,$TRUE);
         if ($docGroup ne $LoginFailed) {
            print("<!-- getPrivilegedSubscriber::docGroup:${docGroup}:   subscOwner:${subscOwner}: -->\n");
            my(@documetListForUser) = getAvailableDocus($docAccessTable,$docAccessTblSep,$patternSep,$fn_Group,$fn_pattern,$docArchiveRoot,$docGroup,$DocRead);
            if (foundInArray($docName,@documetListForUser)) {
               print("<!-- getPrivilegedSubscriber:: Send ${docName} to ${subscEmail} as attachment ${subscAsAttach} -->\n");
               my($subscAsAttachmentFlag) = $FALSE;
               if ($subscAsAttach eq "Yes") {
                   $subscAsAttachmentFlag = $TRUE;
               }
               push(@retList,"${subscEmail};${subscAsAttachmentFlag};${subscOwner}");
            }
         }
      }
  }
  return @retList;
}

sub docSetDefaultValuesFromTOP_LEVEL_COMMENT {
 # Set default values from TOP_LEVEL_COMMENT for the selected language
 my($topLevelWhereClause) = sprintf("${docControlFileDirName}=TOP_LEVEL_COMMENT_%s",getLangCode($language));
 my(%topLevelDefinitions) = getSingleRecInHash($docControlFile,$docControlFileSepChar,"",$topLevelWhereClause); 
 if ($topLevelDefinitions{$docControlFile_displLatest} ne "") {
   $docViewerShowLatest     = $topLevelDefinitions{$docControlFile_displLatest};
   if (index($docViewerShowLatest,"N") == 0) {
      $docViewerShowLatest = $FALSE;
   } else {
      $docViewerShowLatest = $TRUE;
   }
 }
 if ($topLevelDefinitions{$docControlFile_notiSubject} ne "") { $docSubscribingSubject   = $topLevelDefinitions{$docControlFile_notiSubject}; }
 if ($topLevelDefinitions{$docControlFile_notiSender}  ne "") { $docSubscribingSenderAdr = $topLevelDefinitions{$docControlFile_notiSender};  }
 if ($topLevelDefinitions{$docControlFile_notiMsg}     ne "") { $docSubscribingMsg       = $topLevelDefinitions{$docControlFile_notiMsg};     }
 if ($topLevelDefinitions{$docControlFile_notiMsg_1a}  ne "") { $docSubscribingMsg_1a    = $topLevelDefinitions{$docControlFile_notiMsg_1a};  }
 if ($topLevelDefinitions{$docControlFile_notiMsg_1b}  ne "") { $docSubscribingMsg_1b    = $topLevelDefinitions{$docControlFile_notiMsg_1b};  }
 if ($topLevelDefinitions{$docControlFile_colspan}     ne "") { $docViewMaxCountOfColums = $topLevelDefinitions{$docControlFile_colspan};  }
}

# checks who has subscribed to $docName and has readAccess to it and emails the document
# TBS $singleSending is always true
# if ($backgroundMailPgm eq "") then mail are sent immediatly 
sub emailDocuments {
  my($docName,$subject,$senderAdr,$msg,$msg_1a,$msg_1b,$singleSending,$ccAdresses,$bccAdresses,$tmpDir) = @_;

  # reading subject,senderAdr,msg, msg_1a,msg_1b from control file
  if (-f $docControlFile) {
     my($pathName) = getPathNameOutOfFullName($docName);
     my($partPathName) = $pathName;    $partPathName=~ s/$docArchiveRoot//; $partPathName =~ s/^\///;
     if ($partPathName eq "") {
         $partPathName = $DocArchiveRootName;
     }
     my($placeHolder) = sprintf("${partPathName}_%s",getLangCode($language));
     my($locWhereClause) = "${docControlFileDirName}=${placeHolder}";
     my($reqFields)      = "${docControlFile_notiSubject};${docControlFile_notiSender};${docControlFile_notiMsg};${docControlFile_notiMsg_1a};${docControlFile_notiMsg_1b}";
     my(@records) = getColumnValues($docControlFile,$docControlFileSepChar,$reqFields,$locWhereClause);
     ($subject,$senderAdr,$msg,$msg_1a,$msg_1b) = split(/;/,$records[0]);
     $msg =~ s/\<BR\>/\n/g;
     $msg_1a =~ s/\<BR\>/\n/g;
     $msg_1b =~ s/\<BR\>/\n/g;
     docSetDefaultValuesFromTOP_LEVEL_COMMENT();
     $docSubscribingMsg =~ s/\<BR\>/\n/g;
     $docSubscribingMsg_1a =~ s/\<BR\>/\n/g;
     $docSubscribingMsg_1b =~ s/\<BR\>/\n/g;
  }
  $subject   = setDefault($subject,$docSubscribingSubject);
  $senderAdr = setDefault($senderAdr,$docSubscribingSenderAdr);
  $msg       = setDefault($msg,$docSubscribingMsg);
  $msg_1a    = setDefault($msg_1a,$docSubscribingMsg_1a);
  $msg_1b    = setDefault($msg_1b,$docSubscribingMsg_1b);

  writeIntoLog($logFileName,"Called emailDocuments(${docName},${subject},${senderAdr},...,...,...,${singleSending},${ccAdresses},${bccAdresses},${tmpDir})");

  $singleSending      = setDefault($singleSending,$TRUE);
  ### print("TBD docName:${docName}:\n");
  my(@subscriberList) = getPrivilegedSubscriber($docName);
  ### displayArray(@subscriberList);
  ### print("TBD End subscriberList\n");
  @subscriberList     = makeArrayEntriesDestinct($TRUE,@subscriberList);

  my($aSubscriber) = "";
  foreach $aSubscriber (@subscriberList) {
      my($subEmail,$asAttachmentFlag,$subscOwner) = split(";",$aSubscriber);
      print("<!-- docName:${docName} subEmail:${subEmail}:${asAttachmentFlag}: -->\n");
      my($mailBodyMsg)   = $msg;
      my($attachedDocus) = $docName;
      if (!($asAttachmentFlag)) {
          $mailBodyMsg    = qq {${msg_1a}
          ${docName}
          ${msg_1b}
          };
          $attachedDocus  = "";
      }
      writeToDocStatistik("Emailed",$subscOwner,$docName,$subEmail);
      sendMailwithAttachments($senderAdr,$subEmail,$subject,$mailBodyMsg,$attachedDocus,$ccAdresses,$bccAdresses,"",$tmpDir,$FALSE);
  }
}

sub writeToDocStatistik {
   my($action,$user,$document,$comment) = @_;
   if ($docStatistikFileName ne "") {
       my($timeStamp) = getTimeStamp();
       my($statEntry) = "${timeStamp}${docStatistikSepChar}${action}${docStatistikSepChar}${user}${docStatistikSepChar}${document}${docStatistikSepChar}${comment}";
       if (-f $docStatistikFileName) {
          my($nextHash) = getNextKey($docStatistikFileName,$docStatistikSepChar,$docStatistikHashFNam);
          open(STATFILE_writeToDocStatistik,">>${docStatistikFileName}");
          print(STATFILE_writeToDocStatistik "${nextHash}${docStatistikSepChar}${statEntry}\n");
          close(STATFILE_writeToDocStatistik);
       } else {
          open(STATFILE_writeToDocStatistik,">${docStatistikFileName}");
          print(STATFILE_writeToDocStatistik "${docStatistikHashFNam}${docStatistikSepChar}${docStatistikTimeStampFNam}${docStatistikSepChar}${docStatistikActionFNam}${docStatistikSepChar}${docStatistikUserFNam}${docStatistikSepChar}${docStatistikDocumentFNam}${docStatistikSepChar}${docStatistikCommentFNam}\n");
          print(STATFILE_writeToDocStatistik "1${docStatistikSepChar}${statEntry}\n");
          close(STATFILE_writeToDocStatistik);
       }
   }
}

sub getFileHandlesAndNames {
  my (%FileHandlesAndNames)= ();
  my($query) = new CGI;
  foreach $key (sort {$a <=> $b} $query->param()) {
    next if ($key =~ /^\s*$/);
    next if ($query->param($key) =~ /^\s*$/);
    next if ($key !~ /^fileToUpload_(\d+)$/);
    $Number = $1;
 
    if ($query->param($key) =~ /([^\/\\]+)$/) {
      $Filename = $1;
      $Filename =~ s/^\.+//;
      $File_Handle = $query->param($key);
      $FileHandlesAndNames{$Filename} = $File_Handle;
    } else {
      $FILENAME_IN_QUESTION = $query->param($key); 
      print <<__END_OF_HTML_CODE__;
       <HTML>
       <HEAD>
       <TITLE>Error: Filename Problem</TITLE>
       </HEAD>
       <BODY BGCOLOR="#FFFFFF">
       <H1>Filename Problem</H1>
       <P>
       You attempted to upload a file that isn't properly formatted.  The file in question
       is <TT><B>$FILENAME_IN_QUESTION</B></TT>  Please rename the file on your computer, and
       attempt to upload it again.  Files may not have forward or backward slashes in their
       names.  Also, they may not be prefixed with one (or more) periods.
       <P>
       </BODY>
       </HTML>
__END_OF_HTML_CODE__
}
}
  #displayHashTable (%FileHandlesAndNames);
  return %FileHandlesAndNames; 
}

sub removeSubscription {
  my($documentName,$loginUserId) = @_;
  my($whereClause) = "${docSubscribingFileNameFNam}=${documentName} AND ${docSubscribingOwnerFNam}=${loginUserId}";
  updateRecord($docSubscribingTable,$docSubscribingTabSep,$whereClause,"DELETE","");
}

sub removeDocLock {
  my($documentName) = @_;
  my($whereClause) = "${docLockingFileNameFNam}=${documentName}";
  updateRecord($docLockingTable,$docLockingTabSep,$whereClause,"DELETE","");
}

# returns "" when no lock has been set otherwise lockowner
sub isAlreadyLockSet {
   my($docName) = @_;
   my($retVal) = getFileLockOwner($docName,$TRUE);
   return $retVal;
}

# returns $TRUE when that user has been subribed to that document
sub isAlreadySubsribed {
   my($docName,$owner) = @_;
   my($whereClause) = "${docSubscribingFileNameFNam}=${docName} AND ${docSubscribingOwnerFNam}=${owner}";
   my(@subsribers)  = getColumnValues($docSubscribingTable,$docSubscribingTabSep,$docSubscribingOwnerFNam,$whereClause);
   my($counts) = "";   $counts = @subsribers;
   if ($counts ne "0") {
      return $TRUE;
   } else {
      return $FALSE;
   }
}

# returns "" if it went o.k.
sub insertSubscribtion {
   my($docName,$loginUserId,$subEmail,$subAsAttach) = @_;
   my($strAlreadySubscribed)   = getLangStr("strAlreadySubscribed");
   my($strMissingEmailAdr)     = getLangStr("strMissingEmailAdr");

   my($retVal) = "";
   $subEmail =~ s/\s//g;
   if ($subEmail eq "") {
      return $strMissingEmailAdr;
   }
   if (isAlreadySubsribed($docName,$loginUserId)) {
      return $strAlreadySubscribed;
   }
   my($nextHash) = getNextKey($docSubscribingTable,$docSubscribingTabSep,$docSubscribingHashFNam);
   my(%newRec)   = ();
   %newRec = (%newRec,($docSubscribingHashFNam,    $nextHash));
   %newRec = (%newRec,($docSubscribingFileNameFNam,$docName));
   %newRec = (%newRec,($docSubscribingOwnerFNam,   $loginUserId));
   %newRec = (%newRec,($docSubscribingEmailFNam,   $subEmail));
   %newRec = (%newRec,($docSubscribingAsAttachFNam,$subAsAttach));
   %newRec = (%newRec,($docSubscribingModAtFNam,   getTimeStamp()));
   %newRec = (%newRec,($docSubscribingModByFNam,   $loginUserId));
   my($newRecord) = generateNewRecord($docSubscribingTable,$docSubscribingTabSep,%newRec);
   insertRecord($docSubscribingTable,$newRecord);
   return $retVal;
}

sub setDocLock {
   my($docName,$loginUserId) = @_;
   my($nextHash) = getNextKey($docLockingTable,$docLockingTabSep,$docLockingHashFNam);
   my(%newRec)   = ();
   %newRec = (%newRec,($docLockingHashFNam,$nextHash));
   %newRec = (%newRec,($docLockingFileNameFNam,$docName));
   %newRec = (%newRec,($docLockingOwnerFNam,$loginUserId));
   %newRec = (%newRec,($docLockingModAtFNam,getTimeStamp()));
   %newRec = (%newRec,($docLockingModByFNam,$loginUserId));
   my($newRecord) = generateNewRecord($docLockingTable,$docLockingTabSep,%newRec);
   insertRecord($docLockingTable,$newRecord);
}

# returns name of lock owner otherwise if it is not locked returns "${DocArchiveLockStatus}:xxxxxx" or
# in an error case "${DocArchiveLockErrorStatus}:xxxxxx"
sub getFileLockOwner {
  my($fullFileName,$ownerOnly) = @_;
  $ownerOnly  = setDefault($ownerOnly,$FALSE);
  my($retVal) = "";
  
  if (($docLockingTable ne "") && (-f $docLockingTable)) {
     my($whereClause) = "${docLockingFileNameFNam}=${fullFileName}";
     my(@locks) = getColumnValues($docLockingTable,$docLockingTabSep,$docLockingOwnerFNam,$whereClause);
     my($counts) = "";   $counts = @locks;
     if ($counts == 0) { 
         if (!($ownerOnly)) {
           $retVal = "${DocArchiveLockStatus}:No lock set for ${fullFileName}";
         }
     } elsif ($counts == 1) {
         my($lockOwner) = $locks[0];
         $retVal = $lockOwner;
     } else {
        if (!($ownerOnly)) {
           $retVal = "${DocArchiveLockErrorStatus}:Multiple locks";
        }
     }
  }
  return $retVal;
}

sub isFileLocked {
  my($fullFileName,$uploadUser) = @_;
  my($retValStr) = getFileLockOwner($fullFileName);
  my($retVal)    = $TRUE;
  if ($retValStr eq $uploadUser) {
     $retVal = $FALSE;
  } elsif ($retValStr =~ /${DocArchiveLockErrorStatus}/) {
     print("Multiple locks for ${fullFileName}.<BR>Please contact webmaster<BR>\n");
     $retVal = $TRUE;
  } elsif ($retValStr =~ /${DocArchiveLockStatus}/) {
     print("<!-- $retVal -->\n");
     $retVal = $FALSE;
  } else {
     print("<!-- ${fullFileName} currently locked by ${retValStr} -->\n");
     $retVal = $TRUE;
  }
  return $retVal;
}

# Uploads files
# the function adds the following items to %transTab:
#                {countOfUploadedFiles}
#                {totalBytesUploaded}
#                {uploadSummary}
#                {uploadDestinationDir}
# which can be used as placeholders in the $successTemplateFile
sub uploadFiles {
  my ($destinationDir,$uploadLimit,$successTemplateFile,$refFileHandlesAndNamesHash,$uploadUser,$checkLooking) = @_;
  my (%FileHandlesAndNames) = derefHref( $refFileHandlesAndNamesHash);
  my($strUpLoadTitle)       = getLangStr("strUpLoadTitle");
  my($strUpLoadDestination) = getLangStr("strUpLoadDestination");
  my($strClose)             = getLangStr("strClose");
  $checkLooking             = setDefault($checkLooking,$TRUE);

  ## print("destinationDir:${destinationDir}:<BR>");
  ## print("uploadLimit:${uploadLimit}:<BR>");
  ## print("successTemplateFile:${successTemplateFile}:<BR>");
  
  ## displayHashTable (%FileHandlesAndNames);

  if ( (!(-e $destinationDir)) ||
       (!(-W $destinationDir)) ||
       (!(-d $destinationDir)) ) {
    print "Bad directory\n";  
    return 0;
  } else { 

  foreach $Filename (keys %FileHandlesAndNames) {
    my($fullFileName) = "${destinationDir}/${Filename}";
    $File_Handle = $FileHandlesAndNames{$Filename};
    
    if ($checkLooking) {
      if (isFileLocked($fullFileName,$uploadUser)) {
         $Confirmation{$File_Handle} = $DocArchiveFileIsLocked;
         next;
      }
    }
 

    if (!open(OUTFILE_uploadFiles, ">${destinationDir}/${Filename}")) {
            print("<H1>Error</H1><BR>\n");
            print( "Could not write File<BR>:<B>${destinationDir}/${Filename}</B>:<BR><BR><BR><BR>\n");
            print("<FORM>\n");
            printf("  <INPUT TYPE=\"BUTTON\" VALUE=\"%s\" onClick=self.close()>\n",getLangStr("strClose"));
            print("</FORM>\n");
            return 0; 
    }
    undef $BytesRead;
    undef $Buffer;
  
    while ($Bytes = read($File_Handle,$Buffer,1024)) {
       $BytesRead += $Bytes;
       print OUTFILE_uploadFiles $Buffer;
    }
    writeToDocStatistik("Uploaded",$loginUserId,"${destinationDir}/${Filename}","");
    writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Uploaded ${destinationDir}\/${Filename}");

    push(@Files_Written, "$destinationDir\/$Filename");
    $TOTAL_BYTES += $BytesRead;
    $Confirmation{$File_Handle} = $BytesRead;

    close($File_Handle);
    close(OUTFILE_uploadFiles);

    my $newMode = "06";
    $newMode    = "${newMode}66";
	$newMode    = "664";
	my $aCmdTmp = "chmod 644 ${destinationDir}/${Filename} 2>&1";
	print("<!-- UnixCmd: ${aCmdTmp}  ");
	my $retMsg = `${aCmdTmp}`;
	print("retMsg: ${retMsg}-->\n");
    ## chmod ($newMode, "$destinationDir\/$Filename");
    
    # send to subscribers
    if ($docSubscribingTable ne "") {
        my($docName) = "${destinationDir}/${Filename}";
        print("<!-- emailDocuments (${docName}/${language}) to Subscribers -->\n");
        if ($docSubscribingBackgroundMailPgm ne "") {
           my($unixCmd) = "${docSubscribingBackgroundMailPgm} \"${docName}\" \"${language}\" 2>&1 >/dev/null";
           print("<!-- Submitting mailfile job :${unixCmd}:-->\n");
           submitUnixJob("",$unixCmd,"");
        } else {
           emailDocuments($docName);
        }
    }
  }

  $FILES_UPLOADED = scalar(keys(%Confirmation));
  if ($TOTAL_BYTES > $uploadLimit && $uploadLimit > 0) {
                foreach $File (@Files_Written) {
                        unlink $File;
                }
 
                print $header;
                print <<__END_OF_HTML_CODE__; 
                <HTML>
                <HEAD>
                        <TITLE>Error: Limit Reached</TITLE>
                </HEAD>
                <BODY BGCOLOR="#FFFFFF">
                <H1>Limit Reached</H1>
                <P>
                You have reached your upload limit.  You attempted to upload <B>$FILES_UPLOADED</B> files, totalling
                <B>$TOTAL_BYTES</B>.  This exceeds the maximum limit of <B>$uploadLimit</B> bytes, set by the system
                administrator.  <B>None</B> of your files were successfully saved.  Please try again.
                <P>
                <HR SIZE=1>
                <CENTER><A HREF="http://www.terminalp.com/scripts/">Jeff's Scripts</A></CENTER>
                </BODY>
                </HTML> 
__END_OF_HTML_CODE__
  return 0;
 }

   # generate transtab
   my($key) = "";
   my($summary) = "<TABLE border=1 cellpadding=5 cellspacing=0>\n";
   foreach $key (keys (%Confirmation)) {
     my($msgText) = $Confirmation{$key};
     if ($msgText ne $DocArchiveFileIsLocked) {
        $msgText = "${msgText} bytes";
     } else {
        $msgText = "<font color=\"#ff0000\">${msgText}</font>";
     }
     $summary = "${summary}<TR><TD>${msgText}</TD><TD>${key}</TD></TR>\n";
   }
   if ($FILES_UPLOADED ne "1") {
     $summary = "${summary}<TR><TD>${TOTAL_BYTES} bytes Total</TD><TD>Total Files: ${FILES_UPLOADED}</TD></TR>\n";
   }
   $summary = "${summary}</TABLE>\n";
   
   %transTab = (%transTab,(
                "{countOfUploadedFiles}" => $FILES_UPLOADED,
                "{totalBytesUploaded}"   => $TOTAL_BYTES,
                "{uploadSummary}"        => $summary,
                "{uploadDestinationDir}" => $destinationDir));   
   
   if ($successTemplateFile !~ /^\s*$/) {
      my(@lines) = replacePlaceholdersInFile($successTemplateFile,%transTab);   
      displayLines($FALSE,@lines);
      ### print $query->redirect($successTemplateFile);
      return 1; 
   } else {
      printf("<H2>${strUpLoadTitle}</H2> ${strUpLoadDestination}: <B>%s</B>\n",$transTab{"{uploadDestinationDir}"});
      printf("%s\n",$transTab{"{uploadSummary}"});
      print("<FORM><INPUT TYPE=BUTTON  VALUE=\"${strClose}\" onClick=self.close()></FORM>\n");
      return 1; 
  }
  }
}

sub createFileUploadForm {
   my($myCgiName,$myFormName,$sendBtnText,$fieldLength,$destinationDir,$fieldCount,$fieldLbl,$externalParameter,$closeBtnLbl,$actionName,$action) = @_;
   $myFormName   = setDefault($myFormName,  "UploaderForm");
   my($lblDefault) = "Upload Files";
   if ($fieldCount eq "1") { $lblDefault = "Upload File"; } 
   $sendBtnText  = setDefault($sendBtnText, $lblDefault);
   $fieldLength  = setDefault($fieldLength, "35");
   $fieldCount   = setDefault($fieldCount,"1");
   $fieldLbl     = setDefault($fieldLbl,"File");
   $actionName   = setDefault($actionName,"docViewAction");
   $action       = setDefault($action,"Upload");

   print("<FORM Name=\"${myFormName}\" ENCTYPE=\"multipart/form-data\" ACTION=\"${myCgiName}\" METHOD=\"POST\">\n");
   print("<TABLE BORDER=0>\n");
   
   my($aFileLabel) = "";
   my($lblCount)   = 1;
   for ($lblCount = 1; $lblCount <= $fieldCount; $lblCount++) {
     my($countStr) = sprintf("%2d",$lblCount);  $countStr =~ s/ /0/g;
     print("<TR><TD>");
     if ($fieldCount eq "1") {
         print("${fieldLbl} ");
     } else {
         print("${fieldLbl} ${countStr}");
     }
     print("</TD>\n");
     print("    <TD><INPUT TYPE=\"FILE\"   NAME=\"fileToUpload_${countStr}\" SIZE=\"${fieldLength}\"></TD>\n");
     print("</TR>\n");
   }
   print("<TR><TD COLSPAN=2>&nbsp;<BR></TD></TR>\n");
   print("<TR><TD COLSPAN=2><CENTER><INPUT TYPE=\"SUBMIT\" VALUE=\"${sendBtnText}\">&nbsp;&nbsp;&nbsp;\n");
   if ($closeBtnLbl ne "") {
       print("    &nbsp;&nbsp;&nbsp;<INPUT TYPE=\"BUTTON\" VALUE=\"${closeBtnLbl}\" onClick=self.close()>\n");
   }
   print("    </TD></TR>\n");
   print("</TABLE>\n");
   print("<INPUT TYPE=HIDDEN Name=docUploadDestination VALUE=\"${destinationDir}\">\n\n");
   print("<INPUT TYPE=HIDDEN Name=${actionName}        VALUE=\"${action}\">\n");
   printf("%s",produceHiddenField($externalParam,""));
   print("</FORM>\n");
}

sub getCommonUploadLink {
   my($linkPattern,$destinationDir,$fileName,$countOfFields) = @_;
   $fileName         = setDefault($fileName,"Document");
   $countOfFields    = setDefault($countOfFields,"1");
   my($newName)      = $fileName;
   if ($destinationDir ne "") {
      $newName      = "${destinationDir}/${fileName}";
   }
   $newName = "${newName}&countOfFields=${countOfFields}";
   my($specificLink) = $linkPattern;
   $specificLink =~ s/$DocCommonDocu/$newName/;
   return $specificLink;
}


sub addJS_goThere() {
print <<__END_OF_HTML_CODE__; 
<SCRIPT LANGUAGE="JavaScript">
// function to handle Upload select
function goThere() {
  if (document.Links.Link_select.options[document.Links.Link_select.selectedIndex].value != "none") {
     aNewUrl = document.Links.Link_select.options[document.Links.Link_select.selectedIndex].value;
     showUploadForm(aNewUrl);
  }
}
</SCRIPT>
__END_OF_HTML_CODE__
}

sub addJS_goThere_1() {
print <<__END_OF_HTML_CODE__; 
<SCRIPT LANGUAGE="JavaScript">
// function to handle Other application select
function goThere_1() {
  if (document.Links_1.Link_select_1.options[document.Links_1.Link_select_1.selectedIndex].value != "none") {
     aNewUrl = document.Links_1.Link_select_1.options[document.Links_1.Link_select_1.selectedIndex].value;
     document.location = aNewUrl;
  }
}
</SCRIPT>
__END_OF_HTML_CODE__
}


sub formatTOCDefault {
   my($group,$commonUploadLink,@parameters) = @_;
   my($oneParam)   = "";
   print("<TABLE border=0 cellspacing=3 cellpadding=3>\n");
   my($strUpload)         = getLangStr("strUpload");
   my($strDelete)         = getLangStr("strDelete");
   my($strSubscribe)      = getLangStr("strSubscribe");
   my($strLock)           = getLangStr("strLock");
   my($strUnsubscribe)    = getLangStr("strUnsubscribe");
   my($strUnlock)         = getLangStr("strUnlock");
   my($strLocks)          = getLangStr("strLocks");
   my($strSubscribtions)  = getLangStr("strSubscribtions");
   my($strManageMy)       = getLangStr("strManageMy");
   my($strOtherFct)       = getLangStr("strOtherFct");
   my($strLastModDoc)     = getLangStr("strLastModDoc");

   my($isAllowedToSubscribe) = $FALSE;
   my($isAllowedToLock)      = $FALSE;

   my($latestModified)     = "00000101000000";
   my($lastModDocument)    = "";
   my($lastModLink)        = "";

   foreach $oneParam (@parameters) {
       print("<TR><TD>\n");
       my($viewLink,$uploadLink,$fileName,$fullFileName,$deleteLink,$lockingLink,$subscribeLink,$lockedBy,$unlockingLink,$unsubscribeLink,$modDate,$fileSize) = split(";",$oneParam);
       my($pathName) = getPathNameOutOfFullName($fullFileName);
       my($partPathName) = $pathName;    $partPathName=~ s/$docArchiveRoot//; $partPathName =~ s/^\///;
       if ($partPathName eq "") {
          $partPathName = $DocArchiveRootName;
       }

       if ($modDate > $latestModified) {
         $latestModified =  $modDate;
         $lastModDocument = $fileName;
         $lastModLink = "${viewLink}${fileName}</A>";
       }
       my($fileStatus) = formatTimeStamp($modDate,"",$FALSE,$FALSE,$language);
       print("${viewLink}${fileName}</A></TD>\n");
       print("<TD><font size=-1>${fileStatus}</font></TD>\n");
       print("<TD><font size=-1>${fileSize}</font></TD>\n");
       if ($docControlFile ne "") {
          $partPathName = getLangStrFromHash_LangCode($partPathName,%docTitleTrans);
       }
       print("<TD><font size=-1>${partPathName}</font></TD>\n");
       if ($uploadLink ne "") {
           print("<TD>${uploadLink}<FONT SIZE=-2>${strUpload}</FONT></A></TD>\n");
       }
       if ($deleteLink ne "") {
           print("<TD>${deleteLink}<FONT SIZE=-2> ${strDelete}</FONT></A></TD>\n");
       }
       if ($lockingLink ne "") {
           print("<TD>${lockingLink}<FONT SIZE=-2> ${strLock}</FONT></A></TD>\n");
           $isAllowedToLock = $TRUE;
       }
       if ($unlockingLink ne "") {
           print("<TD>${unlockingLink}<FONT SIZE=-2> ${strUnlock}</FONT></A></TD>\n");
           $isAllowedToLock = $TRUE;
       }
       if ($lockedBy ne "") {
           my($lablStr) = $DocArchiveLockedBy;
           if ($lablStr ne "") {
              $lablStr = "${lablStr}: ";
           }
           print("<TD colspan=2><FONT SIZE=-2>${lablStr}${lockedBy}</FONT></TD>\n");
       }
       if ($subscribeLink ne "") {
           print("<TD>${subscribeLink}<FONT SIZE=-2> ${strSubscribe}</FONT></A></TD>\n");
           $isAllowedToSubscribe = $TRUE;
       }
       if ($unsubscribeLink ne "") {
           print("<TD>${unsubscribeLink}<FONT SIZE=-2> ${strUnsubscribe}</FONT></A></TD>\n");
           $isAllowedToSubscribe = $TRUE;
       }
       print("</TR>\n");
  }
  print("</TABLE>\n");
  if ($lastModDocument ne "") {
    print ("<BR><BR><Font Size=-2>${strLastModDoc} ${lastModLink} ".formatTimeStamp($latestModified,"",$FALSE,$FALSE,$language)."</font><BR>\n");
  }
  displayDocManagerFunctions($group,$isAllowedToSubscribe,$isAllowedToLock,$commonUploadLink,$docUploadCountOfFields);
}


sub formatTOC_Title {
   my($displStr,$partPathName,$colSpan,$bgColor,$language) = @_;
   my($retStr) = "<TD colspan=${colSpan} ${bgColor}><B>$displStr</B></TD>";
   if ($docTitleFormatFct ne "") {
      $retStr = &$docTitleFormatFct($displStr,$partPathName,$colSpan,$bgColor,$language);
   }
   return $retStr
}

sub print_PreText {
   my($partPathName,$colSpan,$language) = @_;
   if ($docPreTextFct ne "") {
      &$docPreTextFct($partPathName,$colSpan,$language);
   }
}

sub print_PostText {
   my($partPathName,$colSpan,$language) = @_;
   if ($docPostTextFct ne "") {
      &$docPostTextFct($partPathName,$colSpan,$language);
   }
}

sub formatTOCDefaultWithLayers {
   my($group,$commonUploadLink,@parameters) = @_;
   my $oneParam   = "";
   print("<TABLE border=0 cellspacing=3 cellpadding=3>\n");
   my $strUpload         = getLangStr("strUpload");
   my $strDelete         = getLangStr("strDelete");
   my $strSubscribe      = getLangStr("strSubscribe");
   my $strLock           = getLangStr("strLock");
   my $strUnsubscribe    = getLangStr("strUnsubscribe");
   my $strUnlock         = getLangStr("strUnlock");
   my $strLocks          = getLangStr("strLocks");
   my $strSubscribtions  = getLangStr("strSubscribtions");
   my $strManageMy       = getLangStr("strManageMy");
   my $strClose          = getLangStr("strClose");
   my $strView           = getLangStr("strView");
   my $strLastModDoc     = getLangStr("strLastModDoc");


   my $strAction         = getLangStr("strAction");
   my $popUpTitleStr     = "${strAction}";

   my $isAllowedToSubscribe = $FALSE;
   my $isAllowedToLock      = $FALSE;
      
   my $oldDirName         = "";
   my $countOfColums      = 0;
   my $first_1            = $TRUE;
   my $latestModified     = "00000101000000";
   my $lastModDocument    = "";
   my $lastModLink        = "";
   my $lastPath           = "";

   my $relLatestModified  = "00000101000000";
   my $relLastModDocument = "";
   my $relLastModLink     = "";
   my $relLastPath        = "";

   my $titleBGColor       = $docViewerTitleBG;
   if ($titleBGColor ne "") {
      $titleBGColor = "bgcolor=${titleBGColor}";
   }
   my $oneFound = $FALSE;
   $docViewMaxCountOfColumsLocal = "";

   my(%docViewMaxCountOfColumsLocalValues) = ();
   my(%docViewPreTextes)   = ();
   my(%docViewPostTextes)  = ();
   my(%docViewDisplLatest) = ();
   if ($docControlFile ne "") {
     %docViewMaxCountOfColumsLocalValues = getTransTable($docControlFile,$docControlFileSepChar,"",$docControlFileDirName,$docControlFile_colspan,"","");
     %docViewPostTextes                  = getTransTable($docControlFile,$docControlFileSepChar,"",$docControlFileDirName,$docControlFile_postMsg,"","");
     %docViewPreTextes                   = getTransTable($docControlFile,$docControlFileSepChar,"",$docControlFileDirName,$docControlFile_preMsg,"","");
     %docViewDisplLatest                 = getTransTable($docControlFile,$docControlFileSepChar,"",$docControlFileDirName,$docControlFile_displLatest,"","");
   }
   
   printf("%s",getLangStrFromHash_LangCode_NoDefaults("TOP_LEVEL_COMMENT",%docViewPreTextes));
   foreach $oneParam (@parameters) {
       $oneFound = $TRUE;
       my($viewLink,$uploadLink,$fileName,$fullFileName,$deleteLink,$lockingLink,$subscribeLink,$lockedBy,$unlockingLink,$unsubscribeLink,$modDate,$fileSize) = split(";",$oneParam);
       my($pathName) = getPathNameOutOfFullName($fullFileName);
       my($partPathName) = $pathName;    $partPathName=~ s/$docArchiveRoot//; $partPathName =~ s/^\///;
       if ($partPathName eq "") {
          $partPathName = $DocArchiveRootName;
       }
       my($popUpTitleStr_1) = "${popUpTitleStr}: (${fileName})";
       $popUpTitleStr_1     =~ s/ /&nbsp;/g;
       if ($oldDirName ne $partPathName) {
           if ($first_1) {
              $first_1 = $FALSE;
           } else {
              print("</TD></TR></TABLE>\n");
              printf("<TR><TD colspan=${docViewMaxCountOfColums}>%s</TD></TR>\n",getLangStrFromHash_LangCode_NoDefaults($oldDirName,%docViewPostTextes));
              print_PostText($oldDirName,$docViewMaxCountOfColums,$language);
              if (($relLastModDocument ne "") && (getLangStrFromHash_LangCode_NoDefaults($oldDirName,%docViewDisplLatest) eq "YES")) {
                my($dirName) = $relLastPath;
                if ($docControlFile ne "") {
                  $dirName = getLangStrFromHash_LangCode($dirName,%docTitleTrans);
                }
                print("<TR><TD colspan=${docViewMaxCountOfColums}><BR><Font Size=-2>${strLastModDoc} ${relLastModLink} ".formatTimeStamp($relLatestModified,"",$FALSE,$FALSE,$language)."</font></TD></TR>\n");
              }
              print("<TR><TD colspan=${docViewMaxCountOfColums}>&nbsp;<BR>&nbsp;</TD></TR>\n");
           }
           $oldDirName = $partPathName;
           my($displStr) = $partPathName;
           if ($docControlFile ne "") {
               $displStr = getLangStrFromHash_LangCode($partPathName,%docTitleTrans);
           }
           $docViewMaxCountOfColumsLocal = getLangStrFromHash_LangCode_NoDefaults($partPathName,%docViewMaxCountOfColumsLocalValues);
           printf("<TR>%s</TR>\n",formatTOC_Title($displStr,$partPathName,$docViewMaxCountOfColums,$titleBGColor,$language));
           print_PreText($partPathName,$docViewMaxCountOfColums,$language);
           printf("<TR><TD colspan=${docViewMaxCountOfColums}>%s</TD></TR>\n",getLangStrFromHash_LangCode_NoDefaults($partPathName,%docViewPreTextes));
           print("<TR><TD colspan=${docViewMaxCountOfColums}>\n");
           print("<TABLE border=0 cellspacing=3 cellpadding=3>\n");
           $countOfColums       = 0;
           $relLatestModified   = "00000101000000";
           $relLastModDocument  = "";
           $relLastModLink      = "";
           $relLastPath         = "";
           print("<TR>\n");
       }
       
       if ($modDate > $latestModified) {
         $latestModified =  $modDate;
         $lastModDocument = "${partPathName}/${fileName}";
         $lastPath = $partPathName;
       }
       if ($modDate > $relLatestModified) {
         $relLatestModified =  $modDate;
         $relLastModDocument = "${partPathName}/${fileName}";
         $relLastPath = $partPathName;
       }



       my($fileStatus) = sprintf("${fileName}:  %s (${fileSize})", formatTimeStamp($modDate,"",$FALSE,$FALSE,$language));
       if ($lockedBy ne "") {
           my($formatStr) = getLangStr("strNotLockOwner");
           $formatStr  = removeHtmlTags($formatStr);
           $fileStatus = sprintf($formatStr,$fileName,$lockedBy);
       }

       if (($deleteLink      eq "") &&
           ($lockingLink     eq "") &&
           ($subscribeLink   eq "") &&
           ($unlockingLink   eq "") &&
           ($unsubscribeLink eq "")) {
          my $aUrl = "HREF=\"${viewLink}\" ";
          my $aLink = createDocuLink($partPathName,$fileName,$aUrl,repNullStr($fileStatus));

          if ($lastModDocument eq "${partPathName}/${fileName}") {
             $lastModLink = "<A ${aUrl}>${fileName}</A>";
             $lastPath = $partPathName;
          }
          if ($relLastModDocument eq "${partPathName}/${fileName}") {
             $relLastModLink = "<A ${aUrl}>${fileName}</A>";
             $relLastPath = $partPathName;
          }
          if ($docViewMaxCountOfColumsLocal eq "0") { 
             print ("${aLink}\n");
          } else {
             print ("<TD>${aLink}</TD>\n");
          }
          $countOfColums++;
       } else {
		  my $lockStrFull = $lockedBy;
		  if ($lockStrFull ne "") { $lockStrFull =  getLangStr("strIsLocked").": ${lockedBy}"; }
          my $aUrl  = "HREF=\"javascript:docPopUpPrepareAndDisplay('${viewLink}','${uploadLink}','${deleteLink}','${subscribeLink}','${unsubscribeLink}','${lockingLink}','${unlockingLink}','${lockStrFull}','${popUpTitleStr_1}','${strView}','${strUpload}','${strDelete}','${strSubscribe}','${strUnsubscribe}','${strLock}','${strUnlock}','${strClose}','". repNullStr($fileStatus)."')\" class=\"tooltip\"";
		  my $aLink = createDocuLink($partPathName,$fileName,$aUrl,repNullStr($fileStatus));
          if (($subscribeLink ne "") || ($unsubscribeLink ne "")) {
           $isAllowedToSubscribe = $TRUE;
          }
          if (($lockingLink ne "") || ($unlockingLink ne "")) {
           $isAllowedToLock = $TRUE;
          }
          if ($lastModDocument eq "${partPathName}/${fileName}") {
             $lastModLink = "<A ${aUrl}>${fileName}</A>";
             $lastPath = $partPathName;
          }
          if ($relLastModDocument eq "${partPathName}/${fileName}") {
             $relLastModLink = "<A ${aUrl}>${fileName}</A>";
             $relLastPath = $partPathName;
          }
          if ($docViewMaxCountOfColumsLocal eq "0") { 
             print("<B>${aLink}</B>\n");
          } else {
             print("<TD><B>${aLink}</B></TD>\n");
          }
          $countOfColums++;
       }
       if ($docViewMaxCountOfColumsLocal eq "") {
          $docViewMaxCountOfColumsLocal = $docViewMaxCountOfColums;
       }
       if ($countOfColums >= $docViewMaxCountOfColumsLocal) {
          $countOfColums = 0;
          ## if ($docViewMaxCountOfColumsLocal != 0) {
             print("</TR>\n");
          ## }
       }
  }
  if ($oneFound) {
    print("</TD></TR></TABLE>\n");
    print("<TR><TD colspan=${docViewMaxCountOfColums}>".getLangStrFromHash_LangCode_NoDefaults($oldDirName,%docViewPostTextes)."</TD></TR>\n");
    print_PostText($oldDirName,$docViewMaxCountOfColums,$language);
    if (($relLastModDocument ne "") && (getLangStrFromHash_LangCode_NoDefaults($oldDirName,%docViewDisplLatest) eq "YES")) {
       my($dirName) = $relLastPath;
       if ($docControlFile ne "") {
           $dirName = getLangStrFromHash_LangCode($dirName,%docTitleTrans);
       }
       print("<TR><TD colspan=${docViewMaxCountOfColums}><BR><Font Size=-2>${strLastModDoc} ${relLastModLink} ".formatTimeStamp($relLatestModified,"",$FALSE,$FALSE,$language)."</font></TD></TR>\n");
    }
  }
  print("</TABLE>\n");
  if (($lastModDocument ne "") && ($docViewerShowLatest)) {
    my($dirName) = $lastPath;
    if ($docControlFile ne "") {
       $dirName = getLangStrFromHash_LangCode($dirName,%docTitleTrans);
    }
    print("<hr align=\"CENTER\" width=\"50%\" noshade><Font Size=-2>${strLastModDoc} ${lastModLink} ".formatTimeStamp($latestModified,"",$FALSE,$FALSE,$language)." in ${dirName}</font><BR>\n");
  }
  print(getLangStrFromHash_LangCode_NoDefaults("TOP_LEVEL_COMMENT",%docViewPostTextes));
  displayDocManagerFunctions($group,$isAllowedToSubscribe,$isAllowedToLock,$commonUploadLink,$docUploadCountOfFields);
}

sub createDocuLink {
  my($partPathName,$fileName,$aUrl,$statusMsg) = @_;
  if ($statusMsg ne "") { $statusMsg = "<span><font size=-2>${statusMsg}</font></span>"; }
  my $retStr = "<A ${aUrl}>${fileName}${statusMsg}</A>";
  if ($docFormatTOC_Content ne "") {
    $retStr = &$docFormatTOC_Content($partPathName,$fileName,$aUrl);
  }
  return $retStr;
}

sub displayDocManagerFunctions {
  my($group,$isAllowedToSubscribe,$isAllowedToLock,$commonUploadLink,$countOfUploadFields) = @_;
  my($first)  = $TRUE;
  my($hrDone) = $FALSE;
  my($strUpload)         = getLangStr("strUpload");
  my($strLocks)          = getLangStr("strLocks");
  my($strSubscribtions)  = getLangStr("strSubscribtions");
  my($strManageMy)       = getLangStr("strManageMy");
  $countOfUploadFields   = setDefault($countOfUploadFields,2);



  my(@privDir) = getPrivilegedDirectories($docAccessTable,$docTabSep,"",$docAccessDocumentGroupFNam,$docAccessDocumentsFNam,$group,$DocWrite,$docArchiveRoot);
  my($privUploadDir) = "";

  foreach $privUploadDir (@privDir) {
     if ($first) {
        $first = $FALSE;
        $hrDone = $TRUE;
        addJS_goThere();
        print("<hr align=\"CENTER\" width=\"100%\" noshade>\n<TABLE cellpadding=3 cellspacing=3><TR><TD><CENTER>${strUpload}...<BR>");
        print("<form name=\"Links\">\n");
        print("<SELECT NAME=\"Link_select\" onchange=\"goThere()\">\n");
        print("<OPTION value=\"none\">${strUpload}...\n");
     }
     my($displStr) = $privUploadDir;
     if ($displStr eq "") { $displStr = $DocArchiveRootName; }
     if ($docControlFile ne "") {
        $displStr = getLangStrFromHash_LangCode($displStr,%docTitleTrans);
     }
     print("  <OPTION value=\"".getCommonUploadLink($commonUploadLink,$privUploadDir,"File",$countOfUploadFields)."\">${displStr}\n");
     ### print("</A>\n");
  }
  if (!($first)) {
    print("</SELECT></form>\n");
    print("</TD>\n");
  }

  $first = $TRUE;
  if ($isAllowedToSubscribe) {
     if ($first) {
        if (!($hrDone)) { $hrDone = $TRUE; print("<HR>\n<TABLE cellpadding=3 cellspacing=3><TR>"); }
        print("<TD><CENTER>${strManageMy}...<BR>\n");
        $first = $FALSE;
     }
     print("<A HREF=\"docSubscribingTool.pl?${externalParam}\">${strSubscribtions}</A>\n");
  }
  if ($isAllowedToLock) {
     if ($first) {
        if (!($hrDone)) { $hrDone = $TRUE; print("<HR>\n<TABLE cellpadding=3 cellspacing=3><TR>"); }
        print("<TD><CENTER>{strManageMy}...<BR>\n");
        $first = $FALSE;
     }
     print("<A HREF=\"docLockingTool.pl?${externalParam}\">${strLocks}</A>\n");
  }
  if (!($first)) {
      print("</TD>\n");
  }
  displayOtherDocFunctions($hrDone);
  print("</TR></TABLE>\n");
}

sub displayOtherDocFunctions {
  my($hrDone,$action)  = @_;
  my($doEndTable) = (!($hrDone));
  if (($action eq "ForCopy") ||
      ($action eq "ForModify") ||
      ($action eq "ForInsert") ||
      ($action eq "ForDelete") ||
      ($action eq "ShowDetail")) {
      return "";
  }


  my($externalParam) = "loginUserId=${loginUserId}&loginPassword=${loginPassword}&loginAction=Login&language=".getParam("language",$DefaultLang);

  my($strOtherFct)          = getLangStr("strOtherFct");
  my($aPrivPassword)        = mainDoorGetPrivstr($passwordFile,$passwordSepChar,$applDocPasswordTool,   $passwordUserIdFNam,$passwordPasswordFNam,$passwordPrivFNam,$TRUE,$useServerLogin,$TRUE,"","","",$silent);
  my($aPrivAccess)          = mainDoorGetPrivstr($passwordFile,$passwordSepChar,$applDocAccessTool,     $passwordUserIdFNam,$passwordPasswordFNam,$passwordPrivFNam,$TRUE,$useServerLogin,$FALSE,"","","",$silent);
  my($aPrivStatistik)       = mainDoorGetPrivstr($passwordFile,$passwordSepChar,$applDocStatistikTool,  $passwordUserIdFNam,$passwordPasswordFNam,$passwordPrivFNam,$TRUE,$useServerLogin,$FALSE,"","","",$silent);
  my($aPrivControl)         = mainDoorGetPrivstr($passwordFile,$passwordSepChar,$applDocControlTool,    $passwordUserIdFNam,$passwordPasswordFNam,$passwordPrivFNam,$TRUE,$useServerLogin,$FALSE,"","","",$silent);
  my($aPrivLockingTool)     = mainDoorGetPrivstr($passwordFile,$passwordSepChar,$applDocLockingTool,    $passwordUserIdFNam,$passwordPasswordFNam,$passwordPrivFNam,$TRUE,$useServerLogin,$TRUE,"","","",$silent);
  my($aPrivSubscribingTool) = mainDoorGetPrivstr($passwordFile,$passwordSepChar,$applDocSubscribingTool,$passwordUserIdFNam,$passwordPasswordFNam,$passwordPrivFNam,$TRUE,$useServerLogin,$TRUE,"","","",$silent);
  my($aPrivDocManager)      = mainDoorGetPrivstr($passwordFile,$passwordSepChar,$applDocManagerTool,    $passwordUserIdFNam,$passwordPasswordFNam,$passwordPrivFNam,$TRUE,$useServerLogin,$TRUE,"","","",$silent);

  if ($myCgiFormName eq $applDocPasswordTool)    { $aPrivPassword        = ""; }
  if ($myCgiFormName eq $applDocAccessTool)      { $aPrivAccess          = ""; }
  if ($myCgiFormName eq $applDocStatistikTool)   { $aPrivStatistik       = ""; }
  if ($myCgiFormName eq $applDocControlTool)     { $aPrivControl         = ""; }
  if ($myCgiFormName eq $applDocLockingTool)     { $aPrivLockingTool     = ""; }
  if ($myCgiFormName eq $applDocSubscribingTool) { $aPrivSubscribingTool = ""; }
  if ($myCgiFormName eq $applDocManagerTool)     {
      $aPrivDocManager      = "";
      $aPrivLockingTool     = "";
      $aPrivSubscribingTool = "";
  }


  if (($aPrivPassword        ne "")   ||
      ($aPrivAccess          ne "")   ||
      ($aPrivStatistik       ne "")   ||
      ($aPrivControl         ne "")   ||
      ($aPrivDocManager      ne "")   ||
      ($aPrivLockingTool     ne "")   ||
      ($aPrivSubscribingTool ne "")) {
        addJS_goThere_1();
        if (!($hrDone)) { $hrDone = $TRUE; print("<HR>\n<TABLE cellpadding=3 cellspacing=3><TR>"); }
        print("<TD><CENTER>${strOtherFct}...<BR>");
        print("<form name=\"Links_1\">\n");
        print("<SELECT NAME=\"Link_select_1\" onchange=\"goThere_1()\">\n");
        print("<OPTION value=\"none\">${strOtherFct}...\n");
        if ($aPrivPassword ne "") {
           my($displStr) = "Password-Tool";
           if ($docControlFile ne "") {
             $displStr = getLangStrFromHash_LangCode($displStr,%docTitleTrans);
           }
           my($newURL) = "${applDocPasswordTool}?${externalParam}";
           print("  <OPTION value=\"$newURL\">${displStr}\n");
        }
        if ($aPrivAccess ne "") {
           my($displStr) = "Doc-Access";
           if ($docControlFile ne "") {
             $displStr = getLangStrFromHash_LangCode($displStr,%docTitleTrans);
           }
           my($newURL) = "${applDocAccessTool}?${externalParam}";
           print("  <OPTION value=\"$newURL\">${displStr}\n");
        }
        if ($aPrivStatistik ne "") {
           my($displStr) = "Statistik-Tool";
           if ($docControlFile ne "") {
             $displStr = getLangStrFromHash_LangCode($displStr,%docTitleTrans);
           }
           my($newURL) = "${applDocStatistikTool}?${externalParam}";
           print("  <OPTION value=\"$newURL\">${displStr}\n");
        }
        if ($aPrivControl ne "") {
           my($displStr) = "Control-Tool";
           if ($docCOntrolFile ne "") {
             $displStr = getLangStrFromHash_LangCode($displStr,%docTitleTrans);
           }
           my($newURL) = "${applDocControlTool}?${externalParam}";
           print("  <OPTION value=\"$newURL\">${displStr}\n");
        }
        if ($aPrivDocManager ne "") {
           my($displStr) = "Doc-Manager";
           if ($docControlFile ne "") {
             $displStr = getLangStrFromHash_LangCode($displStr,%docTitleTrans);
           }
           my($newURL) = "${applDocManagerTool}?${externalParam}";
           print("  <OPTION value=\"$newURL\">${displStr}\n");
        }
        if ($aPrivLockingTool ne "") {
           my($displStr) = "Locking-Tool";
           if ($docControlFile ne "") {
             $displStr = getLangStrFromHash_LangCode($displStr,%docTitleTrans);
           }
           my($newURL) = "${applDocLockingTool}?${externalParam}";
           print("  <OPTION value=\"$newURL\">${displStr}\n");
        }
        if ($aPrivSubscribingTool ne "") {
           my($displStr) = "Subscribing-Tool";
           if ($docControlFile ne "") {
             $displStr = getLangStrFromHash_LangCode($displStr,%docTitleTrans);
           }
           my($newURL) = "${applDocSubscribingTool}?${externalParam}";
           print("  <OPTION value=\"$newURL\">${displStr}\n");
        }
        print("</SELECT></form></TD>\n");
        if ($doEndTable) { print("</TR></TABLE>\n"); }
  }
}

sub docArchiveGetFullFileNames {
   my($path,$docArchiveRoot,%fileHandlesAndNames) = @_;
   my(@fKeys)   = ();
   my(@retList) = ();
   $path =~ s/$docArchiveRoot//; $path =~ s/^\///;

   @fKeys = keys %fileHandlesAndNames;
   my($aKey) = "";
   foreach $aKey (@fKeys) {
      if ($path eq "") {
         push(@retList,$aKey);
      } else {
         push(@retList,"${path}/${aKey}");
      }
   }
   return @retList;
}

# returns $TRUE if the filename matches the pattern
#   possible pattern:
#     Path/*
#     Path/test01.*
#     Path/*.doc
#     Path/test*.doc
sub filenameMatchesPattern {
  my($filename,$pattern) = @_;
  return areStringMatching($filename,$pattern,$TRUE);
}


# returns $TRUE if all @fileNames have write access
sub hasWriteAccess {
  my($reqMode,$docAccessTable,$docAccessTblSep,$patternSep,$fn_Group,$fn_pattern,$group,@fileNames) = @_;
  my(@allowedDocPattern) = getPrivilegedDocus($docAccessTable,$docAccessTblSep,$patternSep,$fn_Group,$fn_pattern,$group,$reqMode);
  ## displayArrayHTML(@allowedDocPattern);

  my($retVal) = $FALSE;
  my($fullFNamePat) = "";
  foreach $fullFNamePat (@allowedDocPattern) {
    my($fNamePat)     = getFileNameOutOfFullName($fullFNamePat);
    my($fNamePatPath) = getPathNameOutOfFullName($fullFNamePat);

    my($fall)     = 0;
    my(@patParts) = ();
  
    if ($fNamePat eq "*") {                                        # *
      $fNamePat =~ s/\*//g;
      $fall = 4; 
    } elsif (index($fNamePat,"*") == (length($fNamePat)-1)) {      # test01.*
      $fNamePat =~ s/\*//g;    
      $fall = 2; 
    } elsif (index($fNamePat,"*") == 0) {                          # *.doc
      $fNamePat =~ s/\*//g;    
      $fall = 1; 
    } elsif (index($fNamePat,"*") != -1) {                         # test*.doc
      $fNamePat =~ s/\*/;;;;/g;
      @patParts = split(";;;;",$fNamePat);   
      $fall = 3; 
    } 
    ## print ("FileName Muster:${fNamePat}:\n",);

    my($fullFName) = "";
    foreach $fullFName (@fileNames) {
     my($fName)     = getFileNameOutOfFullName($fullFName);
     my($fNamePath) = getPathNameOutOfFullName($fullFName);

     if  (
          (
           (($fall == 0) && ($fName eq $fNamePat))   ||
           (($fall == 1) && ($fName =~ /${fNamePat}$/)) ||
           (($fall == 2) && ($fName =~ /^${fNamePat}/)) ||
           (($fall == 3) && ($fName =~ /^$patParts[0]/) && ($fName =~ /$patParts[1]$/)) ||
           (($fall == 4))
          ) && ($fNamePath eq $fNamePatPath)
         ) {
            print("<!-- ${fNamePath} ${fName} -> ${fNamePatPath} ${fNamePat} o.k. -->\n");
            $retVal = $TRUE;
     } else {
            print("<!-- ${fNamePath} ${fName} -> ${fNamePatPath} ${fNamePat} not allowed -->\n");
     }
    }
  }
  return $retVal;
}
############################################################################
# Function for Time and Date
############################################################################

sub doTest_isValidTimeStampYYYYMMDDHHMMSS {
  my($myFullName,$debugThisFct) = @_;
  $debugThisFct = setDefault($debugThisFct,$FALSE);

  if (!(isValidTimeStampYYYYMMDDHHMMSS("20020228123859"))) { 
     print("ERROR: ${myFullName} (A): 20020228123859 is valid\n"); 
  }
  if (isValidTimeStampYYYYMMDDHHMMSS("20020228123861")) { 
     print("ERROR: ${myFullName} (B): 20020228123861 is not valid\n");
  }
  if (isValidTimeStampYYYYMMDDHHMMSS("20020229123800")) { 
     print("ERROR: ${myFullName} (C): 20020229123800 is not valid\n"); 
  }
  if (isValidTimeStampYYYYMMDDHHMMSS("20021328123859")) { 
     print("ERROR: ${myFullName} (D): 20021328123859 is not valid\n"); 
  }
  if (isValidTimeStampYYYYMMDDHHMMSS("20020228126259")) { 
     print("ERROR: ${myFullName} (E): 20020228126259 is not valid\n"); 
  }
  if (isValidTimeStampYYYYMMDDHHMMSS("20020228243861")) { 
     print("ERROR: ${myFullName} (F): 20020228243861 is not valid\n"); 
  }
}

sub isValidTimeStampYYYYMMDDHHMMSS {
  my($timeStampStr) = @_;
  $timeStampStr =~ s/\D//g;
  if (length($timeStampStr) != 14) {
      return $FALSE;
  } else {
      my $year      = substr($timeStampStr,0,4);
      my $month     = substr($timeStampStr,4,2);
      my $day       = substr($timeStampStr,6,2);
      my $dateStr   = "${year}${month}${day}";
      my $hh        = substr($timeStampStr,8,2);
      my $min       = substr($timeStampStr,10,2);
      my $sec       = substr($timeStampStr,12,2);
      
      my $newDateStr = getYYYYMMDD_DaysSince1582(daysSince1582_YMD_str($dateStr));
      if ($newDateStr ne $dateStr) { return $FALSE; }
      if ($hh  > 23) { return $FALSE; }
      if ($min > 59) { return $FALSE; }
      if ($sec > 59) { return $FALSE; }
      return $TRUE;
  }
}


sub getActMonat {
  my($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
  return $monatNamesD{$mon};
}

sub getActYear {
  my($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
  $year += 1900;
  return $year;
}

sub getModDate {
  my($aTime) = @_;
  my($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($aTime);
  $mon += 1;
  my($modDate) = sprintf("%4s%2s%2s",(1900+$year),$mon,$mday);
  $modDate =~ s/ /0/g;
  return $modDate;
}

sub getModDateUSA {
  my($aTime) = @_;
  my($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($aTime);
  $mon += 1;
  my($modDate) = sprintf("%2s/%2s/%4s",$mon,$mday,(1900+$year));
  $modDate =~ s/ /0/g;
  return $modDate;
}

sub getModDateEU {
  my($aTime) = @_;
  my($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($aTime);
  $mon += 1;
  my($modDate) = sprintf("%2s.%2s.%4s",$mday,$mon,(1900+$year));
  $modDate =~ s/ /0/g;
  return $modDate;
}

sub getModTime {
  my($aTime) = @_;
  my($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($aTime);
  my($modTime) = sprintf("%2s%2s%2s",$hour,$min,$sec);
  $modTime =~ s/ /0/g;
  return $modTime;
}

sub getModTimeUSA_EU {
  my($aTime) = @_;
  my($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($aTime);
  my($modTime) = sprintf("%2s:%2s:%2s",$hour,$min,$sec);
  $modTime =~ s/ /0/g;
  return $modTime;
}

# returns YYYYMMDDHHMMSS from the actual time
sub getTimeStamp {
  my($nowTime) = time;
  return getModDate($nowTime).getModTime($nowTime);
}

sub getGMT_TimeStamp {
  my($nowTime) = time;
  my($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = gmtime($nowTime);
  $mon += 1;
  my $modDate = sprintf("%4s%2s%2s%2s%2s%2s",(1900+$year),$mon,$mday,$hour,$min,$sec);
  $modDate =~ s/ /0/g;
  return $modDate;
}


sub getDateTimeStamp {
  my($nowTime)   = time;
  my($dateStr)   = getModDate($nowTime);
  my($year)      = substr($dateStr,0,4);
  my($month)     = substr($dateStr,4,2);
  my($day)       = substr($dateStr,6,2);
  my($monthName) = getValueFromHash($month,"",$TRUE,%monatNamesAbrevToNrE);
  my($retStr)    = "${day}-${monthName}-${year}";
  return $retStr;
}

sub getWeekDayByName {
  my($aTime) = @_;
  my($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($aTime);
  return  $wochentagNamesE{$wday};
}

sub getWochentagByName {
  my($aTime) = @_;
  my($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($aTime);
  return  $wochentagNamesD{$wday};
}

sub isWeekend {
  my($yyyymmdd_Str) = @_;
  my($dayNr)  = ((daysSince1582_YMD_str($yyyymmdd_Str) - 2) % 7);
  if (($dayNr == 0) || ($dayNr == 6)) {
     return $TRUE;
  } else {
     return $FALSE;
  }
}

sub getWeekdayName {
  my($yyyymmdd_Str,$language) = @_;
  $language = setDefault($language,$DefaultLang);

  my($retVal) = "";
  my($dayNr)  = ((daysSince1582_YMD_str($yyyymmdd_Str) - 2) % 7);

  if ($language eq $LangEnglish) {
     $retVal = $wochentagNamesE{$dayNr};
  } elsif ($language eq $LangGerman) {
     $retVal = $wochentagNamesD{$dayNr};
  } elsif ($language eq $LangFrench) {
     $retVal = $wochentagNamesF{$dayNr};
  } elsif ($language eq $LangItalian) {
     $retVal = $wochentagNamesI{$dayNr};
  } else {
     $retVal = "Unknown Language (2):${language}";
  }
  return $retVal;
}

sub getMonthByName {
  my($aTime) = @_;
  my($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($aTime);
  return  $monatNamesE{$mon};
}

sub getMonatByName {
  my($aTime) = @_;
  my($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($aTime);
  return  $monatNamesD{$mon};
}


sub getMonthAbrevName {
  my($aTimeStr,$language) = @_;
  my($retVal)  = "";
  my($monthNr) = substr($aTimeStr,4,2);
  $monthNr -= 1;
  if ($language eq $LangEnglish) {
     $retVal = $monatNamesAbrevE{$monthNr};
  } elsif ($language eq $LangGerman) {
     $retVal = $monatNamesAbrevD{$monthNr};
  } elsif ($language eq $LangFrench) {
     $retVal = $monatNamesAbrevFE{$monthNr};
  } elsif ($language eq $Langitalian) {
     $retVal = $monatNamesAbrevI{$monthNr};
  } else {
     $retVal = "Unknown Language (1):${language}";
  }
  return $retVal;
}

sub getMonthNrByMonthName {
	my($monthName,$doPadding) = @_;
	$doPadding = setDefault($doPadding,$TRUE);
	
	my $retVal = 0;
	$monthName = uc(substr($monthName,0,3));
	if (exists($monatNamesAbrevToNrAll{$monthName})) {
		$retVal = $monatNamesAbrevToNrAll{$monthName};
	}
	
	if ($doPadding) {
		$retVal = paddenNull($retVal,2,"0");
	}
	return $retVal;
}

sub getMonthName {
  my($aTimeStr,$language) = @_;
  my($retVal)  = "";
  my($monthNr) = substr($aTimeStr,4,2);
  $monthNr -= 1;
  if ($language eq $LangEnglish) {
     $retVal = $monatNamesE{$monthNr};
  } elsif ($language eq $LangGerman) {
     $retVal = $monatNamesD{$monthNr};
  } elsif ($language eq $LangFrench) {
     $retVal = $monatNamesF{$monthNr};
  } elsif ($language eq $Langitalian) {
     $retVal = $monatNamesI{$monthNr};
  } else {
     $retVal = "Unknown Language (1):${language}";
  }
  return $retVal;
}

sub doTest_paddingDate {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   if (!(paddingDate("2/3/1999") eq "02/03/1999")) {
       print("ERROR: ${myFullName} failed (A)\n");
   }
   if (!(paddingDate("2/3/99") eq "02/03/99")) {
       print("ERROR: ${myFullName} failed (B)\n");
   }
   if (!(paddingDate("2.3.1999") eq "02.03.1999")) {
       print("ERROR: ${myFullName} failed (C)\n");
   }
}

# padding a date string with 0
# eg   2/3/1999  => 02/03/1999
# eg   4.5.1999  => 04.05.1999
sub paddingDate {
  my($inStr)  = @_;
  my($retStr) = $inStr;
  my($delChr) = "/";
  if (index($retStr,".") > 0) {
    $delChr = ".";
  }
  $retStr =~ s/\//;/g;
  $retStr =~ s/\./;/g;
  my(@parts) = split(";",$retStr);
  $retStr = sprintf("%2d${delChr}%2d${delChr}%d",$parts[0],$parts[1],$parts[2]);  
  $retStr =~ s/ /0/g;
  return $retStr;
}

sub changeDateFormat {
	my($dateStr,$inFormat,$outFormat,$firstResDel,$secResDel) = @_;
	$inFormat  = setDefault($inFormat, "MM/DD/YY");
	$outFormat = setDefault($outFormat,"YYYYMMDD");
 
	my $month = "";
	my $day   = "";
	my $year  = "";
	my $retStr = $dateStr;
	$retStr =~ s/\D//g;
	if ($inFormat eq "MM/DD/YY") {
		$month = substr($retStr,0,2);
		$day   = substr($retStr,2,2);
		$year  = substr($retStr,4);
		if (length($year) < 4) {
			$year = "20${year}";
		}
	} elsif ($inFormat eq "YYYY/MM/DD") {
		$year   = substr($retStr,0,4);
		$month  = substr($retStr,4,2);
		$day    = substr($retStr,6,2);
	} elsif ($inFormat eq "YY/MM/DD") {
		$year   = "20".substr($retStr,0,2);	# print("year :${year}:\n");
		$month  = substr($retStr,2,2);		# print("month:${month}:\n");
		$day    = substr($retStr,4,2);		# print("day  :${ day}:\n");
	} 
 
	if ($outFormat eq "YYYYMMDD") {
		$retStr = "${year}${firstResDel}${month}${secResDel}${day}";
	} elsif ($outFormat eq "YYMMDD") {
		$retStr = substr($year,2,2)."${firstResDel}${month}${secResDel}${day}";
	}
	return $retStr;
}


# inputformat is yyyymmdd or yyyymmddhhmmss and output format is depending on
#     $format  == EUR      ==>  "dd.mm.yyyy hh:mm:ss" or "dd.mmyyyy"
#     $format  otherwise   ==>  "mm/dd/yyyy hh:mm:ss" or "mm/dd/yyyy"
sub formatTimeStamp {
  my($timeStamp, $format, $withWeekday, $useMonthByName, $language)  = @_;
  my $retVal = "";
  if (($language eq "") && ($format eq "")) {
     $language = $LangEnglish;
     $format   = "USA";
  } elsif (($language eq "") && ($format ne "")) {
     if ($format  eq "USA") {
         $language = $LangEnglish;
     } else {
         $language = $LangGerman;
     }
  } elsif (($language ne "") && ($format eq "")) {
     if ($language eq $LangEnglish) {
         $format   = "USA";
     } else {
         $format   = "EUR";
     }
  }
  if ($withWeekday    eq "") { $withWeekday    = $FALSE; }
  if ($useMonthByName eq "") { $useMonthByName = $FALSE; }

  if (length($timeStamp) >= 8) {
     my $year   = substr($timeStamp,0,4);
     my $month  = substr($timeStamp,4,2);
     my $day    = substr($timeStamp,6,2);
     my $dayName    = "";
     my $monthName  = "";
     if ($withWeekday) {
        $dayName = getWeekdayName($timeStamp,$language);
     }
     if ($useMonthByName) {
        $monthName = getMonthName($timeStamp,$language);
     }

     if ($useMonthByName) {
         if ($format eq "EUR") {
             $retVal = "${day}.${monthName} ${year}";
         } else {
             $retVal = "${monthName} ${day} ${year}";
         }
     } else {
         if ($format eq "EUR") {
              $retVal = "${day}.${month}.${year}";
         } else {
              $retVal = "${month}/${day}/${year}";
         }
     }
     if ($withWeekday) {
         $retVal = "${dayName}, ${retVal}";
     }

  }
  if (length($timeStamp) > 8) {
    my $hou  = substr($timeStamp,8,2);
    my $min  = substr($timeStamp,10,2);
    my $sec  = substr($timeStamp,12,2);
    $retVal = "${retVal} ${hou}:${min}:${sec}";
  }
  return $retVal;
}

sub doTest_formatYYYYMMDD {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my($yyyymmddStr) = "20011115";

   if (!(formatYYYYMMDD($yyyymmddStr,"DD-MMM-YY", $language) eq "15-NOV-01")) {
       print("ERROR: ${myFullName} failed (A)\n");
   }
   if (!(formatYYYYMMDD($yyyymmddStr,"DD-Mmm-YY", $language) eq "15-Nov-01")) {
       print("ERROR: ${myFullName} failed (B)\n");
   }
   if (!(formatYYYYMMDD($yyyymmddStr,"DD-MMM-YYYY", $language) eq "15-NOV-2001")) {
       print("ERROR: ${myFullName} failed (C)\n");
   }
   if (!(formatYYYYMMDD($yyyymmddStr,"DD-Mmm-YYYY", $language) eq "15-Nov-2001")) {
       print("ERROR: ${myFullName} failed (D)\n");
   }
   if (!(formatYYYYMMDD($yyyymmddStr,"DD-Month-YY", $language) eq "15-November-01")) {
       print("ERROR: ${myFullName} failed (E)\n");
   }
   if (!(formatYYYYMMDD($yyyymmddStr,"DD-MONTH-YY", $language) eq "15-NOVEMBER-01")) {
       print("ERROR: ${myFullName} failed (F)\n");
   }
   if (!(formatYYYYMMDD($yyyymmddStr,"DD-Month-YYYY", $language) eq "15-November-2001")) {
       print("ERROR: ${myFullName} failed (G)\n");
   }
   if (!(formatYYYYMMDD($yyyymmddStr,"DD-MONTH-YYYY", $language) eq "15-NOVEMBER-2001")) {
       print("ERROR: ${myFullName} failed (H)\n");
   }
   if (!(formatYYYYMMDD($yyyymmddStr,"DD-MM-YYYY", $language) eq "15-11-2001")) {
       print("ERROR: ${myFullName} failed (I)\n");
   }
   if (!(formatYYYYMMDD("2233","DD-MONTH-YYYY", $language) eq "2233")) {
       print("ERROR: ${myFullName} failed (J)\n");
   }
   if (!(formatYYYYMMDD("2233555555555","DD-MONTH-YYYY", $language) eq "2233555555555")) {
       print("ERROR: ${myFullName} failed (K)\n");
   }
   if (!(formatYYYYMMDD($yyyymmddStr,"YYYY-MM-DD", $language) eq "2001-11-15")) {
       print("ERROR: ${myFullName} failed (L)\n");
   }
}


sub formatYYYYMMDD {
     my($YYYYMMDD_date, $format, $language, $dayMonthSep, $monthYearSep) = @_;
     $language     = setDefault($language,$DefaultLang);
     $dayMonthSep  = setDefault($dayMonthSep,"-");
     $monthYearSep = setDefault($monthYearSep,"-");

     if (length($YYYYMMDD_date) != 8) { return $YYYYMMDD_date; }

     my $retVal = "";
     my $year   = substr($YYYYMMDD_date,0,4);
     my $month  = substr($YYYYMMDD_date,4,2);
     my $day    = substr($YYYYMMDD_date,6,2);
    
     my $monthFullStr   = getMonthName($YYYYMMDD_date,$language);
     my $monthAbrevStr  = getMonthAbrevName($YYYYMMDD_date,$language);

     ### printf("year:${year}:  month:${month}:  day:${day}:  monthFullStr:${monthFullStr}:  monthAbrevStr:${monthAbrevStr}:\n");
 
     if      ($format eq "DD-MMM-YY")     { $retVal = "${day}${dayMonthSep}".uc($monthAbrevStr)."${monthYearSep}".substr($year,2,2);
     } elsif ($format eq "DD-Mmm-YY")     { $retVal = "${day}${dayMonthSep}${monthAbrevStr}${monthYearSep}".substr($year,2,2);
     } elsif ($format eq "DD-MMM-YYYY")   { $retVal = "${day}${dayMonthSep}".uc($monthAbrevStr)."${monthYearSep}${year}";
     } elsif ($format eq "DD-Mmm-YYYY")   { $retVal = "${day}${dayMonthSep}${monthAbrevStr}${monthYearSep}${year}";
     } elsif ($format eq "DD-Month-YY")   { $retVal = "${day}${dayMonthSep}${monthFullStr}${monthYearSep}".substr($year,2,2);
     } elsif ($format eq "DD-MONTH-YY")   { $retVal = "${day}${dayMonthSep}".uc($monthFullStr)."${monthYearSep}".substr($year,2,2);
     } elsif ($format eq "DD-Month-YYYY") { $retVal = "${day}${dayMonthSep}${monthFullStr}${monthYearSep}${year}";
     } elsif ($format eq "DD-MONTH-YYYY") { $retVal = "${day}${dayMonthSep}".uc($monthFullStr)."${monthYearSep}${year}";
     } elsif ($format eq "DD-MM-YYYY")    { $retVal = "${day}${dayMonthSep}${month}${monthYearSep}${year}";
		 
     } elsif ($format eq "YY-MMM-DD")     { $retVal = substr($year,2,2)."${monthYearSep}".uc($monthAbrevStr)."${dayMonthSep}${day}";
     } elsif ($format eq "YY-Mmm-DD")     { $retVal = substr($year,2,2)."${monthYearSep}${monthAbrevStr}${dayMonthSep}${day}";
     } elsif ($format eq "YYYY-MMM-DD")   { $retVal = "${year}${monthYearSep}".uc($monthAbrevStr)."${dayMonthSep}${day}";
     } elsif ($format eq "YYYY-Mmm-DD")   { $retVal = "${year}${monthYearSep}${monthAbrevStr}${dayMonthSep}${day}";
     } elsif ($format eq "YY-Month-DD")   { $retVal = substr($year,2,2)."${monthYearSep}${monthFullStr}${dayMonthSep}${day}";
     } elsif ($format eq "YY-MOUNTH-DD")  { $retVal = substr($year,2,2)."${monthYearSep}".uc($monthFullStr)."${dayMonthSep}${day}";
     } elsif ($format eq "YYYY-Month-DD") { $retVal = "${year}${monthYearSep}${monthFullStr}${dayMonthSep}${day}";
     } elsif ($format eq "YYYY-MONTH-DD") { $retVal = "${year}${monthYearSep}".uc($monthFullStr)."${dayMonthSep}${day}";
     } elsif ($format eq "YYYY-MM-DD")    { $retVal = "${year}${monthYearSep}${month}${dayMonthSep}${day}";
     } else  { $retVal = $YYYYMMDD_date;
     }
     return $retVal;
}

sub doTest_formatToYYYYMMDD {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   if (!(formatToYYYYMMDD("15-NOV-07","DD-MMM-YY", $language) eq "20071115")) {
       print("ERROR: ${myFullName} failed (A)\n");
   }
   if (!(formatToYYYYMMDD("3-Jul-2007","DD-Mmm-YYYY", $language) eq "20070703")) {
       print("ERROR: ${myFullName} failed (B)\n");
   }
   if (!(formatToYYYYMMDD("03-12-2007","DD-MM-YYYY", $language) eq "20071203")) {
       print("ERROR: ${myFullName} failed (C)\n");
   }
   if (!(formatToYYYYMMDD("02-01-07","DD-MM-YY", $language) eq "20070102")) {
       print("ERROR: ${myFullName} failed (D)\n");
   }
   if (!(formatToYYYYMMDD("02-December-07","DD-Month-YY", $language) eq "20071202")) {
       print("ERROR: ${myFullName} failed (E)\n");
   }
   if (!(formatToYYYYMMDD("02-DEZEMBER-07","DD-MONTH-YY", $language) eq "20071202")) {
       print("ERROR: ${myFullName} failed (F)\n");
   }
   if (!(formatToYYYYMMDD("02-DEZEMBER-2007","DD-Month-YYYY", $language) eq "20071202")) {
       print("ERROR: ${myFullName} failed (G)\n");
   }
}



sub formatToYYYYMMDD {
     my($aDate, $inputFormat) = @_;
     $language     = setDefault($language,$DefaultLang);
     
     my $year   = "";
     my $month  = "";
     my $day    = "";
 
     ## print("--> formatToYYYYMMDD....:${aDate}:\n");
     if (($inputFormat eq "DD-MM-YY")   || ($inputFormat eq "DD-MMM-YY")   || ($inputFormat eq "DD-Mmm-YY")   || ($inputFormat eq "DD-Month-YY")   || ($inputFormat eq "DD-MONTH-YY") ||
         ($inputFormat eq "DD-MM-YYYY") || ($inputFormat eq "DD-MMM-YYYY") || ($inputFormat eq "DD-Mmm-YYYY") || ($inputFormat eq "DD-Month-YYYY") || ($inputFormat eq "DD-MONTH-YYYY")) {
         my @parts = split("-",$aDate);
         
         
         $day    = $parts[0];
         if (length($day) == 1) { $day = "0${day}"; }
         
         $month  = $parts[1];
         ## print("Orginal Month is ${month}\n");
         if (!(($month >= 1) && ($month <= 12))) {
         	  $month = substr(uc($month),0,3);
         	  if (exists($monatNamesAbrevToNrAll{$month})) {
         	  	 $month = $monatNamesAbrevToNrAll{$month};
         	  }
            ## print("Month is ${month}\n");
         }
         
         $year   = $parts[2];
         if ($year < 99) { $year = "20${year}"; }
     } else {
         $retVal = $aDate;
     }
     ## print("formatToYYYYMMDD....:${year}:${month}:${day}:\n");
     return "${year}${month}${day}";
}

sub formatTime {
  my($HHMMSS) = @_;
  my $retStr = substr($HHMMSS,0,2).":".substr($HHMMSS,2,2).":".substr($HHMMSS,4,2);

  return $retStr;
}

sub isLeapYear {
    my($year)  = @_;
    my($isOne) = $FALSE;
    if (($year % 400) == 0) {
       $isOne = $TRUE;
    } elsif ((($year % 4) == 0) && (($year % 100) != 0)) {
       $isOne = $TRUE;
    }
    return $isOne;
}

sub daysSince1582_DMY_str {
  my($ddmmyyyy) = @_;
  return daysSince1582_DMY(substr($ddmmyyyy,0,2),substr($ddmmyyyy,2,2),substr($ddmmyyyy,4,4));
}

sub daysSince1582_YMD_str {
  my($yyyymmdd) = @_;
  return daysSince1582_DMY(substr($yyyymmdd,6,2),substr($yyyymmdd,4,2),substr($yyyymmdd,0,4));
}

sub setDaysInMonths {
  my($year) = @_;
  delete $dayInMonth{"1"};
  if (isLeapYear($year)) {
    %dayInMonth = (%dayInMonth,("1" => "29"));
  } else {
    %dayInMonth = (%dayInMonth,("1" => "28"));
  }
}

sub daysSince1582_DMY {
   my($day,$month,$year) = @_;
   ## print("${day} ${month} ${year}\n");

   my($help)          = 1582;
   my($daysSince1582) = 0;

   setDaysInMonths($year);

   while ($help < $year) {
     if (isLeapYear($help)) {
       $daysSince1582 += 366;
     } else {
       $daysSince1582 += 365;
     }
     $help++;
   } # end while

   $help = 0;
   while ($help < ($month - 1)) {
     $daysSince1582 += $dayInMonth{$help};
     $help++;
   }
   $daysSince1582 += ($day - 1);
   return $daysSince1582;
}


# returns a string in yyyymmdd format for given days from 1582
sub getYYYYMMDD_DaysSince1582 {
  my($at_1582) = @_;
  my($at_year) = 0;
  my($exit)    = $FALSE;

  ## Year
  my($year) = 1582;
  while (!$exit) {
     if (isLeapYear($year)) {
        $at_year = 366;
     } else {
        $at_year = 365;
     }
     if ($at_1582 >= $at_year) {
        $at_1582 -= $at_year;
        $year++;
     } else {
        $exit = 1;
     }
  } # end of while (year)
  ## Month
  setDaysInMonths($year);
  my($month) = 0;
  while ($at_1582 >= $dayInMonth{$month}) {
    $at_1582 -= $dayInMonth{$month};
    $month++;
  }
  $month++;
  ## Day
  my($day) = $at_1582 + 1;
  my($retVal) = sprintf("%4s%2s%2s",$year,$month,$day);
  $retVal =~ s/ /0/g;
  return $retVal;
}


sub dayDifference_str2 {
  my($yyyymmdd1,$yyyymmdd2) = @_;
  ## print("dayDifference_str2:${yyyymmdd1} - ${yyyymmdd2}\n");
  return dayDifference(substr($yyyymmdd1,6,2),substr($yyyymmdd1,4,2),substr($yyyymmdd1,0,4),
                       substr($yyyymmdd2,6,2),substr($yyyymmdd2,4,2),substr($yyyymmdd2,0,4));
}

sub dayDifference_str1 {
  my($ddmmyyyy1,$ddmmyyyy2) = @_;
  ## print("dayDifference_str1:${ddmmyyyy1} - ${ddmmyyyy2}\n");
  return dayDifference(substr($ddmmyyyy1,0,2),substr($ddmmyyyy1,2,2),substr($ddmmyyyy1,4,4),
                       substr($ddmmyyyy2,0,2),substr($ddmmyyyy2,2,2),substr($ddmmyyyy2,4,4));
}

sub dayDifference {
  my($day1,$month1,$year1,$day2,$month2,$year2) = @_;
  ## print("dayDifference:${day1}.${month1}.${year1} - ${day2}.${month2}.${year2}\n");
  my($days1) = daysSince1582_DMY($day1,$month1,$year1);
  my($days2) = daysSince1582_DMY($day2,$month2,$year2);
  return $days1 - $days2;
}

$Format_HH_MM_SS = "1";

sub formatSec {
  my($sec, $format) = @_;
  my($retStr) = $sec;
  if ($format eq $Format_HH_MM_SS) {
      my($hours) = "";
      if ($retStr > 3600) {
         $hours = int $retStr / 3600;
         $retStr = $retStr - ($hours * 3600);
      }
      my($minutes) = "";
      my($sec) = "";
      if ($retStr > 60) {
         $minutes = int $retStr / 60;
      }
      $sec = $retStr - ($minutes * 60);
      $retStr = sprintf("%2d:%2d:%2d",$hours,$minutes,$sec);
      $retStr =~ s/ /0/g;             
  }
  return $retStr;
}

sub secDiff_hhmmss {
   my($hhmmss1,$hhmmss2,$format) = @_;
   my($retStr) = "";
   $hhmmss1 =~ s/\D//g;
   $hhmmss2 =~ s/\D//g;
   if (!(($hhmmss1 eq "") || ($hhmmss2 eq ""))) {
     my($sec1) = substr($hhmmss1,0,2)*60*60 + substr($hhmmss1,2,2)*60 + substr($hhmmss1,4,2);
     my($sec2) = substr($hhmmss2,0,2)*60*60 + substr($hhmmss2,2,2)*60 + substr($hhmmss2,4,2);
     $retStr = $sec1 - $sec2;
     $retStr = formatSec($retStr, $format);
   }
   return $retStr;
}

sub doTest_secDiff_YYYYMMDDhhmmss {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my $timeNow    = "20011228110040";
   my $lastUpdate = "20011227105647";
   if (!(secDiff_YYYYMMDDhhmmss($timeNow,$lastUpdate) == 86633)) {
       print("ERROR: ${myFullName} failed (A): ".secDiff_YYYYMMDDhhmmss($timeNow,$lastUpdate)."\n");
   } 
}

sub addSec_YYYYMMDDhhmmss {
   my($YYYYMMDDhhmmss,$secToAdd) = @_;
   my $retStr = "";
   $YYYYMMDDhhmmss =~ s/\D//g;
   $secToAdd       =~ s/\s//g;

   if (!(($YYYYMMDDhhmmss eq "") || ($secToAdd eq ""))) {
    my $hhmmss1 = substr($YYYYMMDDhhmmss,8,8);
    my $date1   = substr($YYYYMMDDhhmmss,0,8);
    my $sec1    = substr($hhmmss1,0,2)*60*60 + substr($hhmmss1,2,2)*60 + substr($hhmmss1,4,2);
    $retStr = $sec1 + $secToAdd;
	while ($retStr >= 86400) { # more than a day
	   $date1 = getYYYYMMDD_DaysSince1582(daysSince1582_YMD_str($date1) + 1);
	   $retStr = $retStr - 86400;
	}
    $retStr = $date1.formatSec($retStr, $Format_HH_MM_SS);
	$retStr =~ s/://g;
   }               
   return $retStr;
}

sub doTest_addSec_YYYYMMDDhhmmss {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);
   
   my $startTime    = "20120301125930";
   my $expectedTime = "20120301125940";
   my $secToAdd     = 10;
   if (!(addSec_YYYYMMDDhhmmss($startTime,$secToAdd) eq $expectedTime)) {
       print("ERROR: ${myFullName} failed (A): addSec_YYYYMMDDhhmmss(${startTime},${secToAdd})=".addSec_YYYYMMDDhhmmss($startTime,$secToAdd)." Should be ${expectedTime}\n");
   }
   $secToAdd     = 50;
   $expectedTime = "20120301130020";
   if (!(addSec_YYYYMMDDhhmmss($startTime,$secToAdd) eq $expectedTime)) {
       print("ERROR: ${myFullName} failed (B): addSec_YYYYMMDDhhmmss(${startTime},${secToAdd})=".addSec_YYYYMMDDhhmmss($startTime,$secToAdd)." Should be ${expectedTime}\n");
   }
   $secToAdd     = -50;
   $expectedTime = "20120301125840";
   if (!(addSec_YYYYMMDDhhmmss($startTime,$secToAdd) eq $expectedTime)) {
       print("ERROR: ${myFullName} failed (C): addSec_YYYYMMDDhhmmss(${startTime},${secToAdd})=".addSec_YYYYMMDDhhmmss($startTime,$secToAdd)." Should be ${expectedTime}\n");
   }
   $secToAdd     = 1;
   $startTime    = "20120301235959";
   $expectedTime = "20120302000000";
   if (!(addSec_YYYYMMDDhhmmss($startTime,$secToAdd) eq $expectedTime)) {
       print("ERROR: ${myFullName} failed (D): addSec_YYYYMMDDhhmmss(${startTime},${secToAdd})=".addSec_YYYYMMDDhhmmss($startTime,$secToAdd)." Should be ${expectedTime}\n");
   }
   $secToAdd     = 2;
   $startTime    = "20120301235959";
   $expectedTime = "20120302000001";
   if (!(addSec_YYYYMMDDhhmmss($startTime,$secToAdd) eq $expectedTime)) {
       print("ERROR: ${myFullName} failed (E): addSec_YYYYMMDDhhmmss(${startTime},${secToAdd})=".addSec_YYYYMMDDhhmmss($startTime,$secToAdd)." Should be ${expectedTime}\n");
   }
   $secToAdd     = 2 + 86400;
   $startTime    = "20120301235959";
   $expectedTime = "20120303000001";  
   if (!(addSec_YYYYMMDDhhmmss($startTime,$secToAdd) eq $expectedTime)) {
       print("ERROR: ${myFullName} failed (F): addSec_YYYYMMDDhhmmss(${startTime},${secToAdd})=".addSec_YYYYMMDDhhmmss($startTime,$secToAdd)." Should be ${expectedTime}\n");
   }
   
}

sub secDiff_YYYYMMDDhhmmss {
   my($YYYYMMDDhhmmss1,$YYYYMMDDhhmmss2,$format) = @_;
   my($retStr) = "";
   $YYYYMMDDhhmmss1 =~ s/\D//g;
   $YYYYMMDDhhmmss2 =~ s/\D//g;

   if (!(($YYYYMMDDhhmmss1 eq "") || ($YYYYMMDDhhmmss1 eq ""))) {

     my($hhmmss1) = substr($YYYYMMDDhhmmss1,8,8);
     my($hhmmss2) = substr($YYYYMMDDhhmmss2,8,8);
   
     my($date1) = substr($YYYYMMDDhhmmss1,0,8);
     my($date2) = substr($YYYYMMDDhhmmss2,0,8);
   
     my($dayDiff) = dayDifference_str2($date1,$date2);
   
     ## print("${date1} - ${date2} = ${dayDiff}\n");
   
     my($sec1) = substr($hhmmss1,0,2)*60*60 + substr($hhmmss1,2,2)*60 + substr($hhmmss1,4,2) + ($dayDiff * 24 * 3600);
     my($sec2) = substr($hhmmss2,0,2)*60*60 + substr($hhmmss2,2,2)*60 + substr($hhmmss2,4,2);
     $retStr = $sec1 - $sec2;

     $retStr = formatSec($retStr, $format);
   }         
         
   return $retStr;
}

sub doTest_getPreviousNextSunday {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my $aDate         = "20030911";
   my $nextSunday    = "20030914";
   my $lastSunday    = "20030907";

   if (!(getPreviousSunday($aDate) eq $lastSunday)) {
       print("ERROR: ${myFullName} failed (A): Previous Sunday of ${aDate} is ".getPreviousSunday($aDate)." Should be ${lastSunday}\n");
   }
   if (!(getNextSunday($aDate) eq $nextSunday)) {
       print("ERROR: ${myFullName} failed (A): Next Sunday of ${aDate} is ".getNextSunday($aDate)." Should be ${nextSunday}\n");
   } 
}

sub getPreviousSunday {
   my($dateYYYYMMDD) = @_;
   if (length($dateYYYYMMDD) > 8) {
     $dateYYYYMMDD = substr($dateYYYYMMDD,0,8);
   }
   my $weekDayNr  = ((daysSince1582_YMD_str($dateYYYYMMDD) - 2) % 7);
   my $sundayDate = daysAddToYYYYMMDD($dateYYYYMMDD,-${weekDayNr});
   return $sundayDate;
}

sub getNextSunday {
   my($dateYYYYMMDD) = @_;
   if (length($dateYYYYMMDD) > 8) {
     $dateYYYYMMDD = substr($dateYYYYMMDD,0,8);
   }
   my $weekDayNr  = ((daysSince1582_YMD_str($dateYYYYMMDD) - 2) % 7);
   my $sundayDate = daysAddToYYYYMMDD($dateYYYYMMDD,-${weekDayNr}+7);
   return $sundayDate;
}
sub getLastDayOfMonth_ddmmyyyy {
  my($ddmmyyyyStr) = @_;
  return getLastDayOfMonth(1,substr($ddmmyyyyStr,2,2),substr($ddmmyyyyStr,4,4));
}

sub getLastDayOfMonth_mmyyyy {
  my($mmyyyyStr) = @_;
  return getLastDayOfMonth(1,substr($mmyyyyStr,0,2),substr($mmyyyyStr,2,4));
}

# also accepts YYYYMM
sub getLastDayOfMonth_yyyymmdd {
	my($yyyymmddStr) = @_;
	return getLastDayOfMonth(1,substr($yyyymmddStr,4,2),substr($yyyymmddStr,0,4));
}

# dont use that one!!1 Instead use getLastDayOfMonth_1
sub getLastDayOfMonth {
	my($day,$month,$year) = @_;
	setDaysInMonths($year);
	my $lastDayinMonth = $dayInMonth{$month - 1};
	my $retVal         = sprintf("%s%2d%s",$year,$month,$lastDayinMonth); $retVal =~ s/ /0/g;
	return $retVal;
}

sub getLastDayOfMonth_1 {
	my($month,$year) = @_;
	setDaysInMonths($year);
	my $lastDayinMonth  = $dayInMonth{$month - 1};
	my $retVal          = sprintf("%s%2d%s",$year,$month,$lastDayinMonth); $retVal =~ s/ /0/g;
	return $retVal;
}

sub isLastDayOfMonth_yyyymmdd {
  my($yyyymmddStr) = @_;
  my($year)  = substr($yyyymmddStr,0,4);
  my($month) = substr($yyyymmddStr,4,2);
  my($day)   = substr($yyyymmddStr,6,2);
  setDaysInMonths($year);
  my($lastDayinMonth) = $dayInMonth{$month - 1};
  if ($day eq  $lastDayinMonth) {
     return $TRUE;
  } else {
     return $FALSE;
  }
}

sub isFirstDayOfMonth_yyyymmdd {
  my($yyyymmddStr) = @_;
  my($day)   = substr($yyyymmddStr,6,2);
  if ($day eq  "01") {
     return $TRUE;
  } else {
     return $FALSE;
  }
}

sub isLastDayOfYear_yyyymmdd {
  my($yyyymmddStr) = @_;
  my($year)  = substr($yyyymmddStr,0,4);
  my($month) = substr($yyyymmddStr,4,2);
  my($day)   = substr($yyyymmddStr,6,2);
  if (($day   eq  "31") &&
      ($month eq "12")) {
     return $TRUE;
  } else {
     return $FALSE;
  }
}

sub isFirstDayOfYear_yyyymmdd {
  my($yyyymmddStr) = @_;
  my($day)   = substr($yyyymmddStr,6,2);
  if (($day   eq  "01") &&
      ($month eq "01")) {
     return $TRUE;
  } else {
     return $FALSE;
  }
}

# working day related function using a calendar
# ---------------------------------------------
## sub isNotWorkingDayFct {
##   my($yyyymmddStr) = @_;
##   if (($yyyymmddStr eq "20010228") ||
##       ($yyyymmddStr eq "20010227") ||
##       ($yyyymmddStr eq "20010226")) {
##       return $TRUE;
##   } else {
##       return $FALSE;
##   }
## }
##
## $retVal = getLastWorkingDayInMonth("2001","02","isNotWorkingDayFct");

sub isNotHolidayFctToCheckArray {
    my($yyyymmddStr) = @_;
    return foundInArray($yyyymmddStr,@holidayCalendarGlobalVarHidden);
}

sub getLastWorkingDayInMonth {
  my($year,$month,$checkCalendarFctName) = @_;
  my $retVal = "";
  setDaysInMonths($year);
  my $lastDayInMonth = $dayInMonth{$month - 1};
  my $tryAgain = $TRUE;
  while ($tryAgain) {
      $retVal = sprintf("%s%2d%s",$year,$month,$lastDayInMonth); $retVal =~ s/ /0/g;
      if (isWeekend($retVal)) {
          $lastDayInMonth--;
      } elsif ($checkCalendarFctName ne "") {
          my $isNotWorkingDay = &$checkCalendarFctName($retVal);
          if ($isNotWorkingDay) {
             $lastDayInMonth--;
          } else {
             $tryAgain = $FALSE;
          }
      } else {
          $tryAgain = $FALSE;
      }
  }
  return $retVal;
}

sub getLastWorkingDayInYear {
  my($year,$checkCalendarFctName) = @_;
  return getLastWorkingDayInMonth($year,"12",$checkCalendarFctName);
}

sub getFirstWorkingDayInMonth {
  my($year,$month,$checkCalendarFctName) = @_;
  my $retVal = "";
  setDaysInMonths($year);
  my $firstDayInMonth = 1;
  my $tryAgain = $TRUE;
  while ($tryAgain) {
      $retVal = sprintf("%s%2d%2d",$year,$month,$firstDayInMonth); $retVal =~ s/ /0/g;
      if (isWeekend($retVal)) {
          $firstDayInMonth++;
      } elsif ($checkCalendarFctName ne "") {
          my $isNotWorkingDay = &$checkCalendarFctName($retVal);
          if ($isNotWorkingDay) {
             $firstDayInMonth++;
          } else {
             $tryAgain = $FALSE;
          }
      } else {
          $tryAgain = $FALSE;
      }
  }
  return $retVal;
}

sub getFirstWorkingDayInYear {
  my($year,$checkCalendarFctName) = @_;
  return getFirstWorkingDayInMonth($year,"01",$checkCalendarFctName);
}

sub getLastWorkingDay {
  my($yyyymmddStr,$checkCalendarFctName) = @_;
  my $retVal = daysAddToYYYYMMDD($yyyymmddStr,-1);
  while (!(isWorkingDay($retVal,$checkCalendarFctName))) {
    $retVal = daysAddToYYYYMMDD($retVal,-1);
  }
  return $retVal;
}

# wrapper for getLastWorkingDay
sub getPreviousWorkingDay {
  my($yyyymmddStr,$checkCalendarFctName) = @_;
  getLastWorkingDay($yyyymmddStr,$checkCalendarFctName);
}

sub getNextWorkingDay {
  my($yyyymmddStr,$checkCalendarFctName) = @_;
  my $retVal = daysAddToYYYYMMDD($yyyymmddStr,1);
  while (!(isWorkingDay($retVal,$checkCalendarFctName))) {
    $retVal = daysAddToYYYYMMDD($retVal,1);
  }
  return $retVal;
}

sub addSomeWorkingDays {
   my($yyyymmddStr,$checkCalendarFctName,$workingDaysToAdd) = @_;
   for (my $i=1; $i <= $workingDaysToAdd; $i++) {
        $yyyymmddStr = getNextWorkingDay($yyyymmddStr,$checkCalendarFctName);
   }
   return $yyyymmddStr;
}

sub subSomeWorkingDays {
   my($yyyymmddStr,$checkCalendarFctName,$workingDaysToAdd) = @_;
   for (my $i=1; $i <= $workingDaysToAdd; $i++) {
        $yyyymmddStr = getPreviousWorkingDay($yyyymmddStr,$checkCalendarFctName);
   }
   return $yyyymmddStr;
}

sub doTest_addSomeWorkingDaysPassHolidayArray {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my(@holArr) = (
     "20011126",
     "20011127",
     "20011128",
   );
   if (!(addSomeWorkingDaysPassHolidayArray("20011121","3",@holArr) eq "20011129")) {
       print("ERROR: ${myFullName} failed (A):".addSomeWorkingDaysPassHolidayArray("20011121","3",@holArr)."\n");
   }
}

sub addSomeWorkingDaysPassHolidayArray {
   my($yyyymmddStr,$workingDaysToAdd,@holidayArr) = @_;
   @holidayCalendarGlobalVarHidden = @holidayArr;
   return addSomeWorkingDays($yyyymmddStr,"isNotHolidayFctToCheckArray",$workingDaysToAdd);
}

sub doTest_isLastWorkingDayOfMonth {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);
   if (!(isLastWorkingDayOfMonth("20030131"))) {
       print("ERROR: ${myFullName} failed (A)\n");
   }
   if (isLastWorkingDayOfMonth("20030130")) {
       print("ERROR: ${myFullName} failed (B)\n");
   }
}

sub isLastWorkingDayOfMonth {
  my($yyyymmddStr,$checkCalendarFctName) = @_;
  my $year  = substr($yyyymmddStr,0,4);
  my $month = substr($yyyymmddStr,4,2);
  my $day   = substr($yyyymmddStr,6,2);
  my $lastWorkingDay = getLastWorkingDayInMonth($year,$month,$checkCalendarFctName);
  my $lastDayInMonth = substr($lastWorkingDay,6,2);
  if ($day eq $lastDayInMonth) {
     return $TRUE;
  } else {
     return $FALSE;
  }
}

sub isFirstWorkingDayOfMonth {
  my($yyyymmddStr,$checkCalendarFctName) = @_;
  my $year  = substr($yyyymmddStr,0,4);
  my $month = substr($yyyymmddStr,4,2);
  my $day   = substr($yyyymmddStr,6,2);
  my $firstWorkingDay = getFirstWorkingDayInMonth($year,$month,$checkCalendarFctName);
  my $firstDayInMonth = substr($firstWorkingDay,6,2);
  if ($day eq  $firstDayInMonth) {
     return $TRUE;
  } else {
     return $FALSE;
  }
}

sub isLastWorkingDayOfYear {
  my($yyyymmddStr,$checkCalendarFctName) = @_;
  my $year  = substr($yyyymmddStr,0,4);
  my $day   = substr($yyyymmddStr,6,2);
  my $lastWorkingDay = getLastWorkingDayInYear($year,$checkCalendarFctName);
  my $lastDayInYear = substr($lastWorkingDay,6,2);
  if ($day eq  $lastDayInYear) {
     return $TRUE;
  } else {
     return $FALSE;
  }
}

sub isFirstWorkingDayOfYear {
  my($yyyymmddStr,$checkCalendarFctName) = @_;
  my $year  = substr($yyyymmddStr,0,4);
  my $day   = substr($yyyymmddStr,6,2);
  my $firstWorkingDay = getFirstWorkingDayInYear($year,$checkCalendarFctName);
  my $firstDayInYear = substr($firstWorkingDay,6,2);
  if ($day eq  $firstDayInYear) {
     return $TRUE;
  } else {
     return $FALSE;
  }
}

sub isWorkingDay {
  my($yyyymmddStr,$checkCalendarFctName) = @_;
  if (isWeekend($yyyymmddStr)) {
      return $FALSE;
  } elsif ($checkCalendarFctName ne "") {
      my $isNotWorkingDay = &$checkCalendarFctName($yyyymmddStr);
      if ($isNotWorkingDay) {
          return $FALSE;
      } else {
          $tryAgain = $TRUE;
      }
  } else {
      $tryAgain = $TRUE;
  }
}

sub doTest_isDateBetween {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   if (!(isDateBetween("2003-01-31 12:00:00","2003-01-31 12:30:00","2003-01-31 11:00:00",$debugThisFct))) {
       print("ERROR: ${myFullName} failed (A)\n");
   }
   if (!(isDateBetween("2003-01-31 12:00:00","2003-01-31 11:00:00","2003-01-31 12:30:00",$debugThisFct))) {
       print("ERROR: ${myFullName} failed (B)\n");
   }

   if (isDateBetween("2003-01-31 12:00:00","2003-01-31 13:00:00","2003-01-31 13:30:00",$debugThisFct)) {
       print("ERROR: ${myFullName} failed (A-1)\n");
   }

}

sub isDateBetween {
   my($dateToTest,$date_1,$date_2,$debugThisFct) = @_;
   my $nowtime = getTimeStamp();
   $dateToTest         = setDefault($dateToTest,$nowtime);
   $date_1             = setDefault($date_1    ,$nowtime);
   $date_2             = setDefault($date_2    ,$nowtime);
   $debugThisFct       = setDefault($debugThisFct,$FALSE);
   $dateToTest =~ s/\D//g;
   $date_1     =~ s/\D//g;
   $date_2     =~ s/\D//g;

   if ($debugThisFct) {
      print("dateToTest:${dateToTest}\n");
      print("date_1:${date_1}\n");
      print("date_2:${date_2}\n\n");
   }

   if ($date_2 < $date_1) {
      my $tmpDate = $date_2;
      $date_2 = $date_1;
      $date_1 = $tmpDate;
   }
   
   if (($dateToTest >= $date_1) && ($dateToTest <= $date_2)) { 
      return $TRUE;
   } else {
      return $FALSE;
   }
}

sub doTest_isDateBetweenUseCalendar {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my(%holidayCal) = (
       "2003-12-01 12:00:00" => "2003-12-01 13:00:00",
       "2004-12-01 12:00:00" => "2004-12-01 13:00:00",
       "2005-12-01 12:00:00" => "2005-12-01 13:00:00",
   );

   my(%holidayCalEmpty) = (
   );

   if (!(isDateBetweenUseCalendar("2003-12-01 12:30:00",\%holidayCal,$debugThisFct))) {
       print("ERROR: ${myFullName} failed (A)\n");
   }

   if (isDateBetweenUseCalendar("2003-01-31 12:00:00",\%holidayCal,$debugThisFct)) {
       print("ERROR: ${myFullName} failed (A-1)\n");
   }
   if (isDateBetweenUseCalendar("2003-12-01 12:30:00",\%holidayCalEmpty,$debugThisFct)) {
       print("ERROR: ${myFullName} failed (A-2)\n");
   }

}

sub isDateBetweenUseCalendar {
   my($dateToTest,$refToCal,$debugThisFct) = @_;
   my $nowtime = getTimeStamp();
   $dateToTest = setDefault($dateToTest,$nowtime);
   
   my $retVal = $FALSE;

   my(@keys) = keys %$refToCal;

   my $countOfKeys = @keys;
   if ($countOfKeys == 0) {
     return $FALSE;
   }

   foreach $aKey (@keys) {
      if ($debugThisFct) {
         print("aKey:${aKey}  value:".$refToCal->{$aKey}."\n");
      }
      if (isDateBetween($dateToTest,$aKey,$refToCal->{$aKey},$debugThisFct)) {
        $retVal = $TRUE;
        last;
      }
   }
   return $retVal;
}

sub getAllSpecialHolidays {
   my($yearStr,$language,$includeGeburis,$includeFixedHolidays,$includeEsternHolidays) = @_;
   $includeGeburis         = setDefault($includeGeburis,$FALSE);
   $includeFixedHolidays   = setDefault($includeFixedHolidays,$TRUE);
   $includeEsternHolidays  = setDefault($includeEsternHolidays,$TRUE);

   my(%retList)           = ();
   my(%fixedHolidays)     = %holidays_fixed_G;
   my(%floatingHolidays)  = %holidays_floating_G;
   my(%geburis)           = %geburis_G;

   my(@keys) = ();
   my($aKey) = "";
   # add all fixed holidays
   if ($includeFixedHolidays) {
     @keys = keys %fixedHolidays;
     foreach $aKey (@keys) {
        my($holStr) = $fixedHolidays{$aKey};
        %retList = (%retList,("${yearStr}${aKey}",$holStr));
     }
   }

   # add all floating holidays
   if ($includeEsternHolidays) {
     my($eastern)  = getEastern($yearStr);
     @keys = keys %floatingHolidays;
     foreach $aKey (@keys) {
        my($holStr)  = $floatingHolidays{$aKey};
        my($dateStr) = daysAddToYYYYMMDD($eastern,$aKey);
        %retList = (%retList,($dateStr,$holStr));
     }
   }

   # add Geburis
   if ($includeGeburis) {
     @keys = keys %geburis;
     foreach $aKey (@keys) {
       $aKey =~ s/\D//g;
       my $holStr  = $geburis{$aKey};
       my $newKey  = "${yearStr}${aKey}";
       if (exists($retList{$newKey})) {
          $retList{$newKey} = $retList{$newKey}." ; ${holStr}";
       } else {
          %retList = (%retList,($newKey,"; ${holStr}"));
       }
     }
   }
   return %retList   
}

sub getCalendarInYYYYMMDD {
   my($startDate,$endDate) = @_;
   my(@calendar)   = ();
   my $countOfDays = dayDifference_str2($endDate,$startDate) + 1;

   foreach (my $i=0; $i < $countOfDays; $i++) {
      my $newDate = daysAddToYYYYMMDD($startDate,$i);
      push(@calendar,$newDate);
   }
   return @calendar;
}


   my($yearStr,$language,$format,$withWeekday,$useMonthByName,$delim,$includeGeburis,$includeFixedHolidays,$includeEsternHolidays) = @_;
   $format          = setDefault($format,          "EUR");
   $withWeekday     = setDefault($withWeekday,     $TRUE);
   $useMonthByName  = setDefault($useMonthByName,  $TRUE);
   $delim           = setDefault($delim,           ";");
   $includeGeburis  = setDefault($includeGeburis,$FALSE);
   $includeFixedHolidays   = setDefault($includeFixedHolidays,$TRUE);
   $includeEsternHolidays  = setDefault($includeEsternHolidays,$TRUE);


sub getCalendar_Formated {
   my($startDate,$endDate,$language,$format,$withWeekday,$useMonthByName,$delim,$includeGeburis,$includeFixedHolidays,$includeEsternHolidays,$showOnlySpecialDays) = @_;
   $format          = setDefault($format,          "EUR");
   $withWeekday     = setDefault($withWeekday,     $TRUE);
   $useMonthByName  = setDefault($useMonthByName,  $TRUE);
   $delim           = setDefault($delim,           ";");
   $includeGeburis  = setDefault($includeGeburis,$FALSE);
   $includeFixedHolidays   = setDefault($includeFixedHolidays,$TRUE);
   $includeEsternHolidays  = setDefault($includeEsternHolidays,$TRUE);
   $showOnlySpecialDays    = setDefault($showOnlySpecialDays,$FALSE);

   my(%retList) = ();

   my $countOfDays = dayDifference_str2($endDate,$startDate) + 1;

   foreach (my $i=0; $i < $countOfDays; $i++) {
      my $newDate = daysAddToYYYYMMDD($startDate,$i);
      my $specHolidayStr = isSpecialHoliday($newDate,$language,$includeGeburis,$includeFixedHolidays,$includeEsternHolidays);
      if (!(($specHolidayStr eq "") && ($showOnlySpecialDays))) {
         my $formatedDateStr = formatTimeStamp($newDate, $format, $withWeekday, $useMonthByName, $language);
         my $newVal = "${formatedDateStr}${delim}${specHolidayStr}";
         %retList = (%retList,($newDate,$newVal));
      }
   }
   return %retList;
}

sub getCalendar_asString {
   my($startDate,$endDate,$language,$format,$withWeekday,$useMonthByName,$includeGeburis,$includeFixedHolidays,$includeEsternHolidays) = @_;
   $format          = setDefault($format,          "EUR");
   $withWeekday     = setDefault($withWeekday,     $TRUE);
   $useMonthByName  = setDefault($useMonthByName,  $TRUE);
   $delim           = setDefault($delim,           ";");
   $includeGeburis  = setDefault($includeGeburis,$FALSE);
   $includeFixedHolidays   = setDefault($includeFixedHolidays,$TRUE);
   $includeEsternHolidays  = setDefault($includeEsternHolidays,$TRUE);

   my $retString = "";

   my $countOfDays = dayDifference_str2($endDate,$startDate) + 1;
  
   foreach (my $i=0; $i < $countOfDays; $i++) {
      my $newDate = daysAddToYYYYMMDD("${yearStr}0101",$i);
      my $specHolidayStr = isSpecialHoliday($newDate,$language,$includeGeburis);
      my $formatedDateStr = formatTimeStamp($newDate, $format, $withWeekday, $useMonthByName, $language);
      if ($withWeekday) {
         my(@dateParts) = split(",",$formatedDateStr);
         $retString = sprintf("${retString}%-20s %-12s %s\n",$dateParts[1],$dateParts[0],$specHolidayStr);
      } else {
         $retString = sprintf("${retString}%-${fieldLength}s %s\n",$parts[0],$specHolidayStr);
      }
   }
   return $retString;
}

sub parseFormatedCalenderEntry {
   my($calenderEntry) = @_;
   my(@parts) = split(";",$calenderEntry);

   my(@parts_1) = split(",",$parts[0]);
   my(@retVal) = (
       $parts_1[0],
       $parts_1[1],
   );
   my $countOfParts = @parts;
   foreach (my $i=1; $i<$countOfParts; $i++) {
     push(@retVal,$parts[$i]);  
   }
   return trimArray(@retVal);
}

sub getAllSpecialHolidays_Formated {
   my($yearStr,$language,$format,$withWeekday,$useMonthByName,$delim,$includeGeburis,$includeFixedHolidays,$includeEsternHolidays) = @_;
   $format          = setDefault($format,          "EUR");
   $withWeekday     = setDefault($withWeekday,     $TRUE);
   $useMonthByName  = setDefault($useMonthByName,  $TRUE);
   $delim           = setDefault($delim,           ";");
   $includeGeburis  = setDefault($includeGeburis,$FALSE);
   $includeFixedHolidays   = setDefault($includeFixedHolidays,$TRUE);
   $includeEsternHolidays  = setDefault($includeEsternHolidays,$TRUE);


   my(%retList) = ();
   my(%unformatedList) = getAllSpecialHolidays($yearStr,$language,$includeGeburis,$includeFixedHolidays,$includeEsternHolidays);
   my(@allKey) = keys %unformatedList;
   my $aKey    = "";
   my $count   = "1";
   foreach $aKey (sort @allKey) {
      my $formatedDateStr  = formatTimeStamp($aKey, $format, $withWeekday, $useMonthByName, $language);
      my $newVal  = sprintf("%s${delim}%s",$formatedDateStr,$unformatedList{$aKey});
      
      my $countStr  = sprintf("%3d",$count);
      $count++;
      %retList = (%retList,($countStr,$newVal));
   }  
   return %retList   
}

sub showMenu_dateCalculation {
   my $answer = "";
   do {
    VT52_cls_home();
    print(unterstreichen("Calculation with dates","="));
    print("    1: Calendar with special holidays\n");

    print("\n");
    printf("%5d: Quit\n\n",0);
    $answer = readln("Select: ",0);
    print("\n");
    if ($answer eq "1") {
       my $reqYear     = readln("Year",substr(getTimeStamp(),0,4));
       my $incHolidays = setBooleanFromYesNoStr(readln("Including Holidays","Y"));
       my $incGeburi   = setBooleanFromYesNoStr(readln("Including Geburtstage","Y"));
       print(getAllSpecialHolidays_asString($reqYear,$fieldLength,$language,$format,$withWeekday,$useMonthByName,$incGeburi,$incHolidays,$incHolidays));
       halt();
    }

   } until ($answer eq "0");
}


sub getCalendarEntriesInTimeInterval {
   my($startDate,$endDate,$delimStr,$outDateFormat,%aCalendar) = @_;
   my $todayDateStr  = substr(getTimeStamp(),0,8);
   ## print("todayDateStr:${todayDateStr}:\n");


   $daysInAdvance = setDefault($daysInAdvance,0);
   $startDate     = setDefault($startDate,$todayDateStr);
   $endDate       = setDefault($endDate,daysAddToYYYYMMDD($startDate+2));
   if ($startDate > $endDate) { 
     my $tmpDate = $startDate;
     $startDate  = $endDate;
     $endDate    = $tmpDate;
   }
   my $dateInCalendarInclYear = $TRUE;
   ####!#### print("startDate:${startDate}:  endDate:${endDate}:\n");  

   $delimStr      = setDefault($delimStr,";");
   $outDateFormat = setDefault($outDateFormat,"DD-Mmm-YY");
   my(@calendarKey) = keys %aCalendar;
   my $countOfCalEntries = @calendarKey;
   if ($countOfCalEntries == 0) {
      %aCalendar = %geburis_G;
      $dateInCalendarInclYear = $FALSE;
   } else {
      if (length($calendarKey[0]) < 8) {
        $dateInCalendarInclYear = $FALSE;
      }
   }

   my(@datesInQuestion) = ();
   my $tmpDate = $startDate;
   do {
       push(@datesInQuestion,$tmpDate);
       $tmpDate = daysAddToYYYYMMDD($tmpDate+1);
   } until ($tmpDate > $endDate);
   ####!#### displayArray(@datesInQuestion); 
   my $retStr = "";
   foreach my $aDateWithYear (@datesInQuestion) {
     my $aCalendarKey = $aDateWithYear;
     if (!($dateInCalendarInclYear)) {
        $aCalendarKey = substr($aCalendarKey,4,4);
     }
     $aCalendarVal = $aCalendar{$aCalendarKey};
     if ($aCalendarVal ne "") {
        my $formatedDateStr = $aDateWithYear;
        $formatedDateStr = formatYYYYMMDD($aDateWithYear,$outDateFormat,$language,"","");
        $retStr = "${retStr}${delimStr}${formatedDateStr} ${aCalendarVal}";
     }
   }

   return substr($retStr,1);
}

sub getAllSpecialHolidays_asString {
   my($yearStr,$fieldLength,$language,$format,$withWeekday,$useMonthByName,$includeGeburis,$includeFixedHolidays,$includeEsternHolidays) = @_;
   $fieldLength = setDefault($fieldLength,30);
   $withWeekday = setDefault($withWeekday,$TRUE);

   my $retStr   = "";
   my(%retList) = getAllSpecialHolidays_Formated($yearStr,$language,$format,$withWeekday,$useMonthByName,";",$includeGeburis,$includeFixedHolidays,$includeEsternHolidays);
   my(@allKey) = keys %retList;

   foreach my $aKey (sort @allKey) {
     my $aVal = $retList{$aKey};


     my $dateDayStr        = strip(getFieldFromString(";",0,$aVal));
     my $holNameAndGeburis = strip(removeFieldFromString(";",0,$aVal));

     my $holidayName = strip(getFieldFromString(";",0,$holNameAndGeburis));
     my $geburis     = strip(removeFieldFromString(";",0,$holNameAndGeburis));

     if ($geburis eq "") {
        $holNameAndGeburis = "${holidayName}";
     } else {
        $holNameAndGeburis = "${holidayName} ==> ${geburis}";
     }

     if ($withWeekday) {
        my(@dateParts) = split(",",$dateDayStr);
        $retStr = sprintf("${retStr}%-20s %-12s %s\n",$dateParts[1],$dateParts[0],$holNameAndGeburis);
     } else {
        $retStr = sprintf("${retStr}%-${fieldLength}s %s\n",$dateDayStr,$holNameAndGeburis);
     }
   }
   return $retStr;
}

sub isSpecialHoliday {
   my($dateStr,$language,$includeGeburis,$includeFixedHolidays,$includeEsternHolidays) = @_;
   $includeGeburis         = setDefault($includeGeburis,$FALSE);
   $includeFixedHolidays   = setDefault($includeFixedHolidays,$TRUE);
   $includeEsternHolidays  = setDefault($includeEsternHolidays,$TRUE);

### printf("dateStr:${dateStr}:   includeGeburis:${includeGeburis}: includeFixedHolidays:${includeFixedHolidays}: includeEsternHolidays:${includeEsternHolidays}:\n");

   my($retStr) = "";
   my(%fixedHolidays)     = %holidays_fixed_G;
   my(%floatingHolidays)  = %holidays_floating_G;
   my(%geburis)           = %geburis_G;

   my($yyyy)    = substr($dateStr,0,4);
   my($mmddStr) = substr($dateStr,4,4);
   if (exists($fixedHolidays{$mmddStr})) {
       if ($includeFixedHolidays) {
          $retStr = $fixedHolidays{$mmddStr};
       }
   } else {
       my($eastern)  = getEastern($yyyy);
       my($dayDiffs) = dayDifference_str2($dateStr,$eastern);
       if (exists($floatingHolidays{$dayDiffs})) {
          if ($includeEsternHolidays) {
             $retStr = $floatingHolidays{$dayDiffs};
          }
       }
   }

   # add Geburis
   if ($includeGeburis) {
     if (exists($geburis{$mmddStr})) {
         if ($retStr eq "") {
            $retStr = sprintf(";%s",$geburis{$mmddStr});
         } else {
            $retStr = sprintf("${retStr};%s",$geburis{$mmddStr});
         }
     }
   }

   return $retStr;
}

# returns the date for eastern YYYYMMDD for a given year.
sub getEastern {
  my($year) = @_;
  my($retStr)     = "";
  my($day)        = 0;
  my($month)      = 4;
  my($yearMod19)  = int($year % 19 + 1);
  my($yearDiv100) = int(($year / 100) + 1);
  my($sunCorr)    = int((3*($yearDiv100 / 4)) - 12);
  my($moonCorr)   = int((((8*$yearDiv100) + 5) / 25) - 5);
  my($sunday)     = int($year + ($year / 4) - $sunCorr - 10);
  my($epakte)     = int(((11 * $yearMod19) + 20 + $moonCorr - $sunCorr) % 30);
  my($fullMoon)   = 0;

  ## print("yearMod19:${yearMod19}: yearDiv100:${yearDiv100}: sunCorr:${sunCorr}: moonCorr:${moonCorr}: sunday:${sunday}: epakte:${epakte}:\n");
  if ($epakte < 0) {
	 $epakte = $epakte + 30;
  }
  if (($epakte == 25) && ($yearMod19 > 11) || ($epakte == 24)) {
	 $epakte = $epakte + 1;
  }
  $fullMoon = 44 - $epakte;
  if ($fullMoon < 21) {
     $fullMoon = $fullMoon + 30;
  }
  $day   = $fullMoon + 7 - ($sunday + $fullMoon) % 7;
  if ($day > 31) {
	 $day = $day - 31;
  } else {
	 $month = 3;
  }
  $retStr = sprintf("%4d%2d%2d",$year,$month,$day);
  $retStr =~ s/ /0/g;
  return $retStr;
}

sub daysAddToYYYYMMDD {
  my($YYYYMMDDstr,$deltaDays) = @_;
  my($days1) = daysSince1582_DMY(substr($YYYYMMDDstr,6,2),substr($YYYYMMDDstr,4,2),substr($YYYYMMDDstr,0,4));
  my($days2) = $days1 + $deltaDays;
  return getYYYYMMDD_DaysSince1582($days2);
}


sub daysAddToDate {
  my($day,$month,$year,$deltaDays) = @_;
  ## print("daysAddToDate:${day}.${month}.${year} + ${deltaDays}\n");
  my($days1) = daysSince1582_DMY($day,$month,$year);
  my($days2) = $days1 + $deltaDays;
  return getYYYYMMDD_DaysSince1582($days2);
}

sub yyyymmddTOddmAbrevyyyy {
   my($yyyymmdd,$delim,$language) = @_;
   my($month)  = substr($yyyymmdd,4,2);  ## $month =~ s/^0//;
   my($monthAbrev) = $monatNamesAbrevE{$month - 1};
   my($retVal) = substr($yyyymmdd,6,2)."${delim}${monthAbrev}${delim}".substr($yyyymmdd,0,4); $retVal =~ s/ /0/g;
   return $retVal;
}

sub yyyymmddTOddmAbrevyy {
   my($yyyymmdd,$delim,$language) = @_;
   $delim  = setDefault($delim,"-");
   my($month)  = substr($yyyymmdd,4,2);  ## $month =~ s/^0//;
   my($monthAbrev) = $monatNamesAbrevE{$month - 1};
   my($retVal) = substr($yyyymmdd,6,2)."${delim}${monthAbrev}${delim}".substr($yyyymmdd,2,2); $retVal =~ s/ /0/g;
   return $retVal;
}


sub yyyymmddTOddmmyyyy {
   my($yyyymmdd) = @_;
   return substr($yyyymmdd,6,2).substr($yyyymmdd,4,2).substr($yyyymmdd,0,4);
}

sub ddmmyyyyTOyyyymmdd {
   my($ddmmyyyy) = @_;
   return substr($ddmmyyyy,4,4).substr($ddmmyyyy,2,2).substr($ddmmyyyy,0,2);
}

sub ddmonyyTOyyyymmdd {
  my ($indate, $YearsIntheFuture) = @_;
  if ($indate eq "") {
    return "";
  }
  if ($YearsIntheFuture eq "") {
    $YearsIntheFuture = 80;
  }
  my ($day, $month, $year) = split("-",$indate);
  if ($year > $YearsIntheFuture) {
     $year = "19${year}";
  } else {
     $year = "20${year}";
  }
  $month = $month_number{$month};
  return "${year}${month}${day}";
}

sub ddmonyyyyTOyyyymmdd {
  my ($indate) = @_;
  my ($day, $month, $year) = split("-",$indate);
  $month = $month_number{$month};
  return "${year}${month}${day}";
}

sub getEnglishMonthAbrev {
  my($MM) = @_;
  my(%tab) = swapHash(%monatNamesAbrevToNrE);
  $MM = sprintf("%2s",$MM); $MM =~ s/ /0/g; 
  return $tab{$MM};
}

# parses Date-String in different formats and returns a yyyymmdd String or $ErrorString in a case
# the conversion failed
sub readDate {
   my($dateStr,$language)  = @_;
   my($retValue)  = "";
   my($errorMsg)  = "";
   my(@dateParts) = ();
   ### print("DateStr (1):${dateStr}:\n");
   $language = setDefault($language,$DefaultLang);
   $dateStr =~ s/\//\./g;
   $dateStr =~ s/ /\./g;
   $dateStr =~ s/\.\./\./g;
   ### print("DateStr (2):${dateStr}:\n");
   my(@datePartsTemp) = split(/\./,$dateStr);
   my($datePart)  = "";
   foreach $datePart (@datePartsTemp) {
         if ($datePart ne "") {
            if ($datePart =~ /\d/) {
                if (length($datePart) == 1) {
                   $datePart = "0${datePart}";
                }
            } else {
                my(%mNames1) = swapHash(%monatNamesE);
                my(%mNames2) = swapHash(%monatNamesD);
                my(%mNames3) = swapHash(%monatNamesF);
                my(%mNames4) = swapHash(%monatNamesI);
                my(@keyMNames2) = ();
                my($keyMName2)  = "";
                @keyMNames2     = keys %mNames2;
                foreach $keyMName2 (@keyMNames2) {
                    if (!(exists($mNames1{$keyMName2}))) {
                         %mNames1 = (%mNames1,($keyMName2,$mNames2{$keyMName2}));
                    }
                }
                                
                my(@keyMNames3) = ();
                my($keyMName3)  = "";
                @keyMNames3     = keys %mNames3;
                foreach $keyMName3 (@keyMNames3) {
                    if (!(exists($mNames1{$keyMName3}))) {
                         %mNames1 = (%mNames1,($keyMName3,$mNames3{$keyMName3}));
                    }
                }
                                
                my(@keyMNames4) = ();
                my($keyMName4)  = "";
                @keyMNames4     = keys %mNames4;
                foreach $keyMName4 (@keyMNames4) {
                    if (!(exists($mNames1{$keyMName4}))) {
                         %mNames1 = (%mNames1,($keyMName4,$mNames4{$keyMName4}));
                    }
                }


                %mNames1 = (%mNames1,("Maerz","2"));
                ## displayHashTable(%mNames1);

                @keyMNames2     = keys %mNames1;
                $errorMsg       = "${datePart} not a valid name for a month";
                my($mTrans)     = "";
                foreach $keyMName2 (@keyMNames2) {
                      ## print("Komparing:${keyMName2}:${datePart}:\n");
                      my($name1) = $keyMName2; $name1 =~ tr/A-Z/a-z/;
                      my($name2) = $datePart;  $name2 =~ tr/A-Z/a-z/;
                      if (index($name1,$name2) >= 0) {
                           ## print("Matching:${keyMName2}:${datePart}:\n");
                           $mTrans = $mNames1{$keyMName2};
                           $mTrans++;
                           $errorMsg = "";
                      }
                }
                $datePart = $mTrans;
                if (length($datePart) == 1) {
                      $datePart = "0${datePart}";
                }
            }
            ## print("Push:${datePart}:\n");
            push(@dateParts,$datePart);
         }
   }
   my($countOfFields) = 0;
   $countOfFields     = @dateParts;
   if ($countOfFields != 3) {
      $errorMsg = "Unrecognized date!";
   }
   if ($errorMsg eq "") {
     ## displayArray(@dateParts);
     if (($dateParts[0] > "12") && ($dateParts[1] > "12")) {
      $retValue = "${ErrorString}:Not a valid date (month and day > 12)";
     } elsif (($dateParts[0] > "12") && ($dateParts[1] <= "12")) {
      $retValue = sprintf("%s%s%s",$dateParts[2],$dateParts[1],$dateParts[0]);
     } elsif (($dateParts[0] <= "12") && ($dateParts[1] > "12")) {
      $retValue = sprintf("%s%s%s",$dateParts[2],$dateParts[0],$dateParts[1]);
     } elsif (($dateParts[0] <= "12") && ($dateParts[1] <= "12")) {
      if ($language eq $LangEnglish) {
          $retValue = sprintf("%s%s%s",$dateParts[2],$dateParts[0],$dateParts[1]);
      } elsif (($language eq $LangGerman) || ($language eq $LangFrench)){
          $retValue = sprintf("%s%s%s",$dateParts[2],$dateParts[1],$dateParts[0]);
      } else {
          $retValue = "";
          $errorMsg = "${language} is not a valid language";
      }
     } else {
        $retValue = "";
        $errorMsg = "Unexpected Error (1)";
     }
   }
   if ($errorMsg eq "") {
     ## printf("RetVal:${retValue}:\n");
     my($days)    = daysSince1582_YMD_str($retValue);
     my($verDate) = getYYYYMMDD_DaysSince1582($days);
     if ($retValue ne $verDate) {
      $retValue = "";
      $errorMsg = "Not a valid date (verification failed) (${retValue} ne ${verDate})";
     }
   }

   if ($errorMsg ne "") {
    $retValue =  "${ErrorString}:${errorMsg}";
   }
   return $retValue;
}


############################################################################
# Function for manipulating files and directories
############################################################################
$timeEpochStart = "19700101000000";

sub getFilePermission {
	my($fullFilename) = @_;
	my $perm = (stat($fullFilename)) [2];
	# print("perm:${perm}:<BR>\n");
	return substr(dec2Octal($perm),2,4);
}

sub getFileOwner {
	my($fullFilename) = @_;
	my $perm = (stat($fullFilename)) [4];
	return $perm;
}

sub getFileGroup {
	my($fullFilename) = @_;
	my $perm = (stat($fullFilename)) [5];
	return $perm;
}

sub getFileLastAccess {
	my($fullFilename) = @_;
	my $perm = (stat($fullFilename)) [8];
	return addSec_YYYYMMDDhhmmss($timeEpochStart,$perm);
}

sub getFileLastModify {
	my($fullFilename) = @_;
	my $perm = (stat($fullFilename)) [9];
	return addSec_YYYYMMDDhhmmss($timeEpochStart,$perm);
}

sub getFileSize {
	my($fullFilename) = @_;
	my $perm = (stat($fullFilename)) [7];
	return $perm;
}

sub doTest_readWriteLhCookie {
	my($myFullName,$debugThisFct) = @_;
	$debugThisFct = setDefault($debugThisFct,$FALSE);

	if ($debugThisFct) {
		$cookieValue = qq {
			DB_Name:     LHCFG_DB
			DB_User:     lhcfg
			DB_Password: winter#cfget123
			TestItem:    "Hallo Walti"
		};
		$cookieValue   = trimQQ_String($cookieValue);
		my $cookieName = "ConfigDBDetails";
		print("1) Cookie writen to: ".writeLhCookie($cookieName,$cookieValue,"",20)."\n\n");
		print("1) Cookie value from ${cookieName} :".readLhCookie($cookieName)."\n\n");
		# sleep 10;
		# print("1) Cookie value from ${cookieName} :".readLhCookie($cookieName)."\n\n");
		# sleep 20;
		# print("1) Cookie value from ${cookieName} :".readLhCookie($cookieName)."\n\n");
		print("1) Cookie value from ${cookieName} :".readLhCookie($cookieName,"","","","",$FALSE)."\n\n\n\n");
	}

	my $testCases = qq {
		Nr|TestString         |Key     
		01|12345 7865Ax       |    
		02|12345 7865Ax       |ert    
		03|WaltiRothlin.,_=%ç*|1234
		04|WaltiRothlin.,_=%ç*|abc    
		05|+"*ç%&/()=?`^.,_ä$ü|abc    
	};
	my $cookieName_1  = "TestLhCookie";
	my $noKeyFound    = "NoKeyFound";

	for (my $i = 2; $i <= getCountOfLinesFromQQ($testCases); $i++) {
		my $testCaseNr  = getFieldFromQQ($testCases,$i,1);
		my $testString  = getFieldFromQQ($testCases,$i,2);
		my $cryptKey    = getFieldFromQQ($testCases,$i,3,"",$FALSE,$noKeyFound);  if ($cryptKey eq $noKeyFound) { $cryptKey = ""; }

		my $cookieFullName = writeLhCookie($cookieName_1,$testString,$cryptKey);
		if ($debugThisFct) {
			print("\n==> ${myFullName}: Test-Case:${i}:${testCaseNr}\n");
			print("       testString      :${testString}:\n");
			print("       cryptKey        :${cryptKey}:\n");
			print("       cookieFullName  :${cookieFullName}:\n");
			print("       readLhCookie(${cookieName_1},${cryptKey})=\"".readLhCookie($cookieName_1,$cryptKey)."\"\n");
		}
		if (!(readLhCookie($cookieName_1,$cryptKey) eq $testString)) { print("ERROR: Test-Case ${testCaseNr}\n"); print("       readLhCookie(${cookieName_1},${cryptKey})=".readLhCookie($cookieName_1,$cryptKey)."        Expected:${$testString}:\n");}
	}
}

sub listLhCookies {
	my($path, $extension, $withExpiry) = @_;
	
	$path       = setDefault($path,      setDefault($ENV{"CSG_COOKY_PATH"},"/tmp"));
	$extension  = setDefault($extension, ".lhc");
	$withExpiry = setDefault($withExpiry, $TRUE);

	my @retList  = ();
	my @fileList = dirList($path, $extension);
	if ($withExpiry) {
		foreach my $aCookie (@fileList) {
			my $expiryDate = getCookieExpiryTime($aCookie,"GE_LONG");
			push(@retList,padString($expiryDate,-35)."; ${aCookie}");
		}
	} else {
		@retList = @fileList;
	}
	return @retList;
}

sub getLhCookieFullName {
	my($name, $path) = @_;
	$path = setDefault($path, setDefault($ENV{"CSG_COOKY_PATH"},"/tmp"));

	my $fullCookieName = "";
	if (isFileExists($name)) {
		$fullCookieName = $name;
	} else {
		$fullCookieName = "${path}/${name}";
		if (!(isFileExists($fullCookieName))) {
			$fullCookieName = "${path}/${name}.lhc";
		}
	}
	return $fullCookieName;
}

sub removeLhCookie {
	my($name, $path) = @_;
	$path = setDefault($path, setDefault($ENV{"CSG_COOKY_PATH"},"/tmp"));

	my $fullCookieName = getLhCookieFullName($name, $path);
	if (isFileExists($fullCookieName)) {
		unlink($fullCookieName);
	}
}

sub selectLhCookie {
	my($filter, $filterPrompt, $menuTitle, $verbal) = @_;
	$filterPrompt        = setDefault($filterPrompt,     "Regular-expression filter for cookies");
	$menuTitle           = setDefault($menuTitle,        "List of LH cookies");
	$verbal              = setDefault($verbal,           $FALSE);
	if ($filter eq "") { $filter    = readln($filterPrompt,".+"); }

	my @tmpArray  = listLhCookies("", "", $FALSE);
	my $releaseName  = $tmpArray[createAsciiMenuExtended("",$menuTitle,"  Select",1,"N",5,"",@tmpArray)-1];
	return $releaseName;
}

sub getCookieExpiryTime {
	my($name, $format, $path) = @_;
	$path = setDefault($path, "/tmp");

	my $fullCookieName = getLhCookieFullName($name, $path);

	my @tmpList    = ();
	my $expiryTime = "";
	# print("fullCookieName:${fullCookieName}:\n");

	if (isFileExists($fullCookieName)) {
		($expiryTime, @tmpList) = readFile($fullCookieName);
	}

	if ($format eq "GE_LONG") {
		$expiryTime = formatTimeStamp($expiryTime, "ENG", $TRUE, $FALSE, $LangEnglish);
	}
	return $expiryTime;
}

sub alterCookieExpiryTime {
	my($name, $path, $newTimeStamp) = @_;
	$newTimeStamp = setDefault($newTimeStamp, addSec_YYYYMMDDhhmmss(getTimeStamp(),-20));
	$path         = setDefault($path, "/tmp");

	my $fullCookieName = getLhCookieFullName($name, $path);

	my @tmpList    = ();
	my $expiryTime = "";
	print("fullCookieName:${fullCookieName}:\n");

	if (isFileExists($fullCookieName)) {
		($expiryTime, @tmpList) = readFile($fullCookieName);
	}

	## print("a)\n");displayArray(@tmpList);
	@tmpList = ($newTimeStamp,@tmpList);
	## print("b)\n");displayArray(@tmpList);

	writeArrayToFile($fullCookieName,$FALSE,@tmpList);
	return $newTimeStamp;
}


sub writeLhCookie {
	my($name, $value, $cryptKey, $expiryTimeInSec, $path) = @_;
	$expiryTimeInSec = setDefault($expiryTimeInSec,  3600);
	$path            = setDefault($path,             setDefault($ENV{"CSG_COOKY_PATH"},"/tmp"));

	mkUnixDir($path,"/");
	my $expiryTime = addSec_YYYYMMDDhhmmss (getTimeStamp(),$expiryTimeInSec);   
   
	$name = strip($name);

	my $fullCookieName = getLhCookieFullName($name, $path);
	if (isFileExists($fullCookieName)) {
		unlink($fullCookieName);
	}
	if ($cryptKey ne "") {
		$value = encryptString($value, $cryptKey); # verschluesseln
	}
	writeStringToFile($fullCookieName,$FALSE,"${expiryTime}\n${value}",$FALSE);
	return $fullCookieName;
}

sub readLhCookie {
	my($name, $cryptKey, $path, $notFoundStr, $expiredStr, $doCheckExpiry) = @_;
	$path            = setDefault($path,           setDefault($ENV{"CSG_COOKY_PATH"},"/tmp"));
	$notFoundStr     = setDefault($notFoundStr,    "ERROR:Not found lhCookie! (name:${name})");
	$expiredStr      = setDefault($expiredStr,     "ERROR:Cookie expired! (name:${name})");
	$doCheckExpiry   = setDefault($doCheckExpiry,  $TRUE);

	$name = strip($name);

	my @retVal        = ();
	my $expiryTime    = "";
	my $fullCookieName =  getLhCookieFullName($name, $path);
	if (isFileExists($fullCookieName)) {
		($expiryTime, @retVal) = readFile($fullCookieName);
		if ($cryptKey ne "") {
			@retVal = decryptString($retVal[0],$cryptKey); # entschluesselt
		}
		if ($doCheckExpiry) {
			my $currTime = getTimeStamp();
			if ($expiryTime lt $currTime) {
				@retVal  = ($expiredStr);
			}
		}
	} else {
		@retVal = ($notFoundStr." (${fullCookieName})");
	}
	return makeStrFromArray("\n",@retVal);
}

# returns a list of files found in a directory
#  namePattern can be regular expression e.g. "^access_log_1999Jul"
sub dirList {
  my($dirName, $namePattern) = @_;
  my(@fileNameList) = ();
  #### print("In dirList:${dirName}:${namePattern}\n");
  opendir(ADIR_dirList,$dirName)   || showError("Error (dirList): Can't open directory:${dirName}: $!");
  #### print("FileName Muster:${namePattern}:\n");
  foreach $fileName (sort readdir(ADIR_dirList)) {
     if ($namePattern eq "") {
        push(@fileNameList,$fileName);
     } elsif ($fileName =~ /$namePattern/) {
        push(@fileNameList,$fileName);
     }
  }
  return @fileNameList
} # end of dirList

sub dirListRecursive {
   my($startdir,$isDOS) = @_;
   $isDOS        = setDefault($isDOS,$TRUE);
   $dirSep = "/";
   if ($isDOS) {
   	  $dirSep = "\\";
   }
   my @retList = ();
   opendir(ADIR,$startdir);
   foreach $fileName (sort readdir(ADIR)) {
   	    if (($fileName eq ".") ||($fileName eq "..")) { next; }
   	    push(@retList,$startdir.$dirSep.$fileName);
   	    if (ifDirectory($startdir.$dirSep.$fileName)) {
   	    	 @retList = concatArray(@retList,dirListRecursive($startdir.$dirSep.$fileName));
   	    }
   }   
   return @retList;
}

sub isFileExists {
   my($aFileName) = @_;
   $aFileName = strip($aFileName);
   if (length($aFileName) == 0) {
      return $FALSE;
   } 
   if (-e $aFileName) {
      return $TRUE;
   } else {
      return $FALSE;
   }
}

sub isFileEmpty {
	my($aFileName) = @_;
	if (isFileExists($aFileName)) {
		my $fileContent = readFileIntoStr($aFileName);
		if ($fileContent eq "") {
			return $TRUE;
		} else {
			return $FALSE;
		}
	} else {
		return $TRUE;
	}
}

sub isFileExistsAndNotGrowing {
   my($aFileName,$waitMsg,$logFileName,$verbal) = @_;
     $retVal = isFileExists($aFileName);
     if ($retVal) {
     	# check if file size is changing
     	while (($totalsize_new = getFileSizeInByte($aFileName,$false,0)) > $totalsize) {
           $totalsize = $totalsize_new;
           if ($waitMsg ne "") {
           	addToLogFile("${waitMsg} (${totalsize})",$logFileName,$verbal);
           }
           sleep 10;
        }
        last;
     }
}

# return a list of files which are existing
sub whichFilesExist {
   my($path,$extension,$returnFullPath,@fileList) = @_;
   $returnFullPath = setDefault($returnFullPath,$FALSE);

   if (($path ne "") && (index($path,"/") != (length($path)-1))) {
      $path = "${path}/";
   }
   if (($extension ne "") && (index($extension,".") != 0)) {
      $extension = ".${extension}";
   }

   my @retList = ();
   for my $aFileName (@fileList) {
       ## print("File to check:${path}${aFileName}${extension}:\n");
       if (isFileExists("${path}${aFileName}${extension}")) {
          if ($returnFullPath) {
             push(@retList,"${path}${aFileName}${extension}");
          } else {
             push(@retList,$aFileName);
          }
       }
   }
   return @retList;
}

sub getFirstExistingFile {
    my (@fileList) = @_;
    my $retFilename = "";
    foreach my $aFilename (@fileList) {
       if (isFileExists($aFilename)) {
          $retFilename = $aFilename;
          last;
       }
    }
    return $retFilename;
}

sub getExistingFiles {
    my (@fileList) = @_;
    my @retFilenames = ();
    foreach my $aFilename (@fileList) {
       if (isFileExists($aFilename)) {
          push(@retFilenames,$aFilename);
       }
    }
    return @retFilename;
}


# Same as waitForFileToExists just with a callback within each wait cycle
sub waitForFileToExistsWithCallback {
   my($aFileName,$pollingTime,$pollingPeriods,$waitMsg,$checkIfFilesizeIsChanging,$callbackFct,$logFileName,$verbal) = @_;	
   $pollingTime               = setDefault($pollingTime,    "30");
   $pollingPeriods            = setDefault($pollingPeriods, "0");
   $checkIfFilesizeIsChanging = setDefault($checkIfFilesizeIsChanging, $FALSE);
   $waitMsg                   = setDefault($waitMsg,        "--> waiting for ${aFileName}");
   $retVal                    = $FALSE;

   if ($aFileName eq "") {
   	  if ($callbackFct ne "") { &$callbackFct("File for waiting not specified!"); }
      return $TRUE;
   }

   $alreadyWaited = 0;
   $doPolling     = $TRUE;
   while ($doPolling) {
     $alreadyWaited++;
     $retVal = isFileExists($aFileName);
     if ($retVal) {
     	# check if file size is changing
     	if ($checkIfFilesizeIsChanging) {
     	    while (($totalsize_new = getFileSizeInByte($aFileName,$false,0)) > $totalsize) {
                $totalsize = $totalsize_new;
                addToLogFile("${waitMsg} (${totalsize})",$logFileName,$verbal);
                sleep 10;
            }
        }
        last;
     }
     if (($pollingPeriods != 0) && ($alreadyWaited > $pollingPeriods)){
     	  if ($callbackFct ne "") { &$callbackFct("Reached timeout of waiting for ${aFileName}"); }
        last;
     }
     addToLogFile("${waitMsg}",$logFileName,$verbal);
     if ($callbackFct ne "") { &$callbackFct("${alreadyWaited}: Waiting for ${aFileName}"); }
     sleep($pollingTime);
   }
   if ($retVal) {
   	   if ($callbackFct ne "") {&$callbackFct("${aFileName} found"); } 
   } else {
   	   if ($callbackFct ne "") {&$callbackFct("${aFileName} not found"); } 
   }
   return $retVal	
}

# That function returns $TRUE when the file exists. If the file is not existing it will poll
# every $pollingTime seconds for $pollingPeriods times. If the file still does not exist after 
# waiting $pollingTime * $pollingPeriods seconds the function returns $FALSE.
# If $pollingPeriods == 0 than it polls for ever.
sub waitForFileToExists {
   my($aFileName,$pollingTime,$pollingPeriods,$waitMsg,$checkIfFilesizeIsChanging,$logFileName,$verbal) = @_;
   $pollingTime               = setDefault($pollingTime,    "30");
   $pollingPeriods            = setDefault($pollingPeriods, "0");
   $checkIfFilesizeIsChanging = setDefault($checkIfFilesizeIsChanging, $FALSE);
   $waitMsg                   = setDefault($waitMsg,        "--> waiting for ${aFileName}");
   $retVal                    = $FALSE;

   if ($aFileName eq "") {
      return $TRUE;
   }

   $alreadyWaited = 0;
   $doPolling     = $TRUE;
   while ($doPolling) {
     $alreadyWaited++;
     $retVal = isFileExists($aFileName);
     if ($retVal) {
     	# check if file size is changing
     	if ($checkIfFilesizeIsChanging) {
     	    while (($totalsize_new = getFileSizeInByte($aFileName,$false,0)) > $totalsize) {
                $totalsize = $totalsize_new;
                addToLogFile("${waitMsg} (${totalsize})",$logFileName,$verbal);
                sleep 10;
            }
        }
        last;
     }
     if (($pollingPeriods != 0) && ($alreadyWaited > $pollingPeriods)){
        last;
     }
     addToLogFile("${waitMsg}",$logFileName,$verbal);
     sleep($pollingTime);
   }
   return $retVal
}

# That function returns $TRUE when the file not exists. If the file is existing it will poll
# every $pollingTime seconds for $pollingPeriods times. If the file still does exist after 
# waiting $pollingTime * $pollingPeriods seconds the function returns $FALSE.
# If $pollingPeriods == 0 than it polls for ever.
sub waitForFileToNotExists {
   my($aFileName,$pollingTime,$pollingPeriods,$waitMsg,$logFileName,$verbal) = @_;
   $pollingTime    = setDefault($pollingTime,    "30");
   $pollingPeriods = setDefault($pollingPeriods, "0");
   $waitMsg        = setDefault($waitMsg,        "--> ${aFileName} is still existing");
   $retVal         = $FALSE;

   if ($aFileName eq "") {
      return $TRUE;
   }

   $alreadyWaited = 0;
   $doPolling     = $TRUE;
   while ($doPolling) {
     $alreadyWaited++;
     $retVal = (!(isFileExists($aFileName)));
     if ($retVal) {
        last;
     }
     if (($pollingPeriods != 0) && ($alreadyWaited > $pollingPeriods)){
        last;
     }
     addToLogFile("${waitMsg}",$logFileName,$verbal);
     sleep($pollingTime);
   }
   return $retVal
}


sub setNotDirHidden {
   ### print("Is No Dir!!!!!!<BR>\n");
   $isDirXXXXXhidden     = $FALSE;
}


sub ifDirectory {
   my($aFileName) = @_;
   ### print("Test if Dir:${aFileName}<BR>\n");
   $isDirXXXXXhidden     = $TRUE;
   opendir(ADIR,$aFileName) || setNotDirHidden();
   return $isDirXXXXXhidden;
}



# returns a list of files matched to the pattern specified. The pattern can include
# a * (wildcard) and path information
# e.g.   dirListExtended("../DocumentArchive/Users/weeklyReport*.doc"); 
sub dirListExtended {
  my($fullFileNamePattern) = @_;
  my($fNamePat)     = getFileNameOutOfFullName($fullFileNamePattern);
  my($passedPath)   = getPathNameOutOfFullName($fullFileNamePattern);
  my(@fileNameList) = ();


  if ($passedPath ne "") { $passedPath = "${passedPath}/"; }
  ## print("fullFileNamePattern:${fullFileNamePattern}:  --> path:${path}:  fNamePat:${fNamePat}<BR>\n");
  
  if ($passedPath eq "") {
     $path = ".";
  } else {
     $path = $passedPath;
  }
  ## print("In dirList:${path}:${fNamePat}:\n");
  if (!(opendir(ADIR,$path))) {
     print("<!-- Error: Could not open directory:${path} -->\n"); 
     return @fileNameList;
  }
  
  foreach $fileName (sort readdir(ADIR)) {
     if (($fileName ne ".") && ($fileName ne "..")) {
       if (areStringMatching($fileName,$fNamePat,$TRUE)) {
           my($fullDirName) = $fileName;
           if ($path ne "") {
              $fullDirName = "${path}/${fileName}";
           }
           if (!(ifDirectory($fullDirName))) {
               ## print("push fall:${fall}:  :${fileName}:<BR>\n");
               push(@fileNameList,"${passedPath}${fileName}");
           } else {
               ## print("is a directory:${fileName}:<BR>\n");
           }
       }
     }
  }
  return @fileNameList;
}

sub concatPathAndFilename {
   my($path,$fileName) = @_;
   my $fullName = "";
   if ($path eq "") {
       $fullName = $fileName;
   } else {
       if ($path =~ /\/$/) {
          $fullName = "${path}${fileName}";
       } else {
          $fullName = "${path}/${fileName}";
       }
   } 
   return $fullName;
}

# returns the filename without any path information 
# e.g.   "../DocumentArchive/Users/weeklyReport*.doc"  --> weeklyReport*.doc
#        "..\DocumentArchive\Users\weeklyReport*.doc"  --> weeklyReport*.doc
sub getFileNameOutOfFullName {
   my($fullFileNamePattern) = @_;
   my($filename) = "";
   my($tmpName)  = $fullFileNamePattern;
   $tmpName =~ s/\//;;;/g;
   $tmpName =~ s/\\/;;;/g;
   my(@parts)   = split(";;;",$tmpName);
   my($anz)     = 0; $anz = @parts;
   ## displayArrayHTML(@parts);
   $filename = $parts[$anz-1];
   return $filename;
}

# returns just the path information 
# e.g.   "../DocumentArchive/Users/weeklyReport*.doc"  --> ../DocumentArchive/Users
#        "..\DocumentArchive\Users\weeklyReport*.doc"  --> ..\DocumentArchive\Users
sub getPathNameOutOfFullName {
   my($fullFileNamePattern) = @_;
   my($path) = "";
   my($tmpName) = $fullFileNamePattern;
   $tmpName =~ s/\//;;;/g;
   $tmpName =~ s/\\/;;;/g;
   my(@parts)   = split(";;;",$tmpName);
   my($anz)     = 0; $anz = @parts;
   ### displayArrayHTML(@parts);
   if ($anz > 1) {
      my($fName) = $parts[$anz-1];
      $path = substr($fullFileNamePattern,0,index($fullFileNamePattern,$fName)-1);
   } else {
      $path = "";
   }
   return $path;
}

# $inName without path
sub getFilenameWithoutExtension {
	my($inName) = @_;
	my $retVal  = "";
	my $tmpName = $inName;
	$tmpName =~ s/\./;;;/g;
	my @parts   = split(";;;",$tmpName);
	my $anz     = "0"; $anz = @parts;

	my $i = 0;
	foreach ($i=0; $i<$anz-1; $i++) {
		if ($retVal eq "") {
			$retVal =  $parts[$i];
		} else {
			$retVal =  sprintf("${retVal}.%s",$parts[$i]);
		}
	}
	if (index($inName,".") < 0) {
		$retVal = $inName;
	}
	return $retVal;
}

sub getFileNameExtension {
	my($inName) = @_;
	my $retVal  = "";
	my $tmpName = $inName;
	$tmpName =~ s/\./;;;/g;
	my @parts   = split(";;;",$tmpName);
	my $anz     = "0"; $anz = @parts;

	$retVal =  $parts[$anz-1];
	if (index($inName,".") < 0) {
		$retVal = "";
	}
	return $retVal;
}

sub setNewFilenameExtension {
    my($fileName,$newExtension) = @_;
    return getFilenameWithoutExtension($fileName).".${newExtension}";
}

# puts a string in a full filename
#
#   e.g. addStringToFilename("/delme/aExample.html","AAAA",$prePos)

#        $prePos = $TRUE     --> /delme/AAAAaExample.html
#        $prePos = $FALSE    --> /delme/aExample.htmlAAAA
#        $prePos = ""        --> /delme/aExampleAAAA.html
sub addStringToFilename {
    my($fileName,$aString,$prePos) = @_;
    my($path)       = getPathNameOutOfFullName($fileName);
    my($fName)      = getFileNameOutOfFullName($fileName);
    my($fNameNoExt) = getFilenameWithoutExtension($fName);
    my($extension)  = getFileNameExtension($fName);
    if ($prePos eq $TRUE) {
        $fNameNoExt = "${aString}${fNameNoExt}";
    } elsif ($prePos eq $FALSE) {
        $extension = "${extension}${aString}";
    } else {
        $fNameNoExt = "${fNameNoExt}${aString}";
    }
    my($retVal) = $fNameNoExt;
    if ($extension ne "") {
       $retVal = "${retVal}.${extension}";
    }
    if ($path ne "") {
       $retVal = "${path}/${retVal}";
    }
    return $retVal;

}

sub doTest_putTimeStampInFileName {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   my($tabName) = "Data/address.flt";
   my($tabNameWithVersion) = putTimeStampInFileName($tabName);
   ### printf("${tabName} --> ${tabNameWithVersion}<BR>\n");

   $tabNameWithVersion = putTimeStampInFileName($tabName,$TRUE);
   ### printf("${tabName} --> ${tabNameWithVersion}<BR>\n");

   $tabNameWithVersion = putTimeStampInFileName($tabName,$FALSE);
   ### printf("${tabName} --> ${tabNameWithVersion}<BR>\n");

}

# puts a timestamp in a full filename
#
#   e.g. /delme/aExample.html
#        $prePos = $TRUE     --> /delme/20001130170550_aExample.html
#        $prePos = $FALSE    --> /delme/aExample.html_20001130170550
#        $prePos = ""        --> /delme/aExample_20001130170550.html
sub putTimeStampInFileName {
    my($fileName,$prePos,$timeStampParam) = @_;
    my($path)       = getPathNameOutOfFullName($fileName);
    my($fName)      = getFileNameOutOfFullName($fileName);
    my($fNameNoExt) = getFilenameWithoutExtension($fName);
    my($extension)  = getFileNameExtension($fName);
    my($tStamp)     = $timeStampParam;
    if ($tStamp eq "") {
       $tStamp = getTimeStamp();
    }
    if ($prePos eq $TRUE) {
        $fNameNoExt = "${tStamp}_${fNameNoExt}";
    } elsif ($prePos eq $FALSE) {
        $extension = "${extension}_${tStamp}";
    } else {
        $fNameNoExt = "${fNameNoExt}_${tStamp}";
    }
    my($retVal) = $fNameNoExt;
    if ($extension ne "") {
       $retVal = "${retVal}.${extension}";
    }
    if ($path ne "") {
       $retVal = "${path}/${retVal}";
    }
    return $retVal;

}

sub getModifyDateAsTimeStamp {
    my($fileName) = @_;
    my $writetime = (stat($fileName))[9];
    my ($retVal) = getModDate($writetime).getModTime($writetime);
    ### print("writetime:${writetime}: --> :${retVal}:<BR>\n");
    return $retVal;
}

sub getLastReadDateAsTimeStamp {
    my($fileName) = @_;
    my $readtime = (stat($fileName))[8];
    my ($retVal) = getModDate($readtime).getModTime($readtime);
    ### print("readtime:${readtime}: --> :${retVal}:<BR>\n");
    return $retVal;
}

sub getFileSizeInByte {
    my($fileName,$inKBytes,$stellenZahl) = @_;
    my $sizeInBytes = (stat($fileName))[7];
    if ($inKBytes) {
      if ($stellenZahl eq "") {
         $stellenZahl = 3;
      }
      $sizeInBytes = $sizeInBytes/1024;
      $sizeInBytes = substr($sizeInBytes,0,index($sizeInBytes,".") + 1 + $stellenZahl);
      $sizeInBytes = "${sizeInBytes} kB";
    }
    return $sizeInBytes;
}

sub getRecordCountFromFltFile {
   my($fileName)   = @_;
   my @records = readFltTable($fileName);
   my $count = @records;
   return $count - 1;
}

# readFltTable
# ------------
# History:
# 01/13/99    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# reads in a file an returns a list with all the aktiv lines
# removes all empty and comment (starting with #) lines
sub readFltTable {
   my($fileName)   = @_;
   my(@retList)    = ();

   ## print ("Open File ${fileName}\n");
   open(TABFILE_readFltTable,$fileName) || showError("ERROR (readFltTable): Can't open file:${fileName}: $!");
   while (defined($line = <TABFILE_readFltTable>)) {
      chomp($line);
      #skip comment and blank lines
      if (($line =~ /^#/) || ($line =~ /^\s+$/) || (length($line) == 0)) {
         ## print("Skip:${line}:\n",);
      } else {
         push(@retList,$line);
      }
   } # end of while
   close(TABFILE_readFltTable);
   return @retList;
}

# checks if the header in the inFileName hcontains all tblFields. If not, the missing fields are 
# added at the end to header of the outFileName.
# If outfileName eq "" the inFileName will be modified.
sub upgradeFltFileDefinition {
   my($inFileName,$outFileName,@tblFields) = @_;

   my $retString      = "";

   my(@inFileLines)   = readFltTable($inFileName);
   my $oldHeader      = $inFileLines[0];
   my $countOfRecords = @inFileLines;
   my $sepCharDouble  = getSepCharFromHeader($oldHeader,$TRUE);
   my $sepChar        = getSepCharFromHeader($oldHeader,$FALSE);
   my(@headerParts)   = split($sepCharDouble,$oldHeader);

   my(@newFields) = getExclutionOfArrays(\@tblFields,\@headerParts);
   my $countOfNewFields = @newFields;
   if ($countOfNewFields > 0) {
      $retString = makeQuotedStrFromArray(",","",@newFields);
      my $removeOutFile = $FALSE;
      if ($outFileName eq "") {
         $outFileName = putTimeStampInFileName($inFileName,"",getTimeStamp());
         $removeOutFile = $TRUE;
      }

      my $newHeader = $oldHeader;
      open(FLTFILE_upgradeFltFileDefinition,">${outFileName}") || showError("ERROR (upgradeFltFileDefinition): Can't open outfile:${outFileName}: $!");
      foreach my $aNewField (@newFields) {
         if ($newHeader eq "") {
             $newHeader = $aNewField;
         } else {
             $newHeader = "${newHeader}${sepChar}${aNewField}"; 
         }
      }
      print(FLTFILE_upgradeFltFileDefinition "${newHeader}\n",);
      foreach (my $i=1; $i<$countOfRecords; $i++) {
         my $aRecord = $inFileLines[$i];
         print(FLTFILE_upgradeFltFileDefinition "${aRecord}\n",);
      }
      close(FLTFILE_upgradeFltFileDefinition);
      if ($removeOutFile) {
        unlink($inFileName);
        rename($outFileName,$inFileName);
      }
   }
   return $retString;
}

# copyFltFileWithHeaderTranslation
# --------------------------------
# History:
# 09/25/00    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# copies $infile to $outfile and translates the uppercase headers to case sensitiv column
# titles specified in @outputFields
sub copyFltFileWithHeaderTranslation {
   my($infile,$outfile,$reopenOutputFile,@outputFields)   = @_;
   $reopenOutputFile = setDefault($reopenOutputFile,$FALSE);
   my(@inFileLines) = readFltTable($infile);
   my $countOfLines = @inFileLines;
   
   my %transTabUpperCase = ();
   my $aTransTabEntrie   = "";
   foreach $aTransTabEntrie (@outputFields) {
      %transTabUpperCase = (%transTabUpperCase,(uc($aTransTabEntrie),$aTransTabEntrie));
   }
   
   my $oldHeader     = $inFileLines[0];
   my $sepCharDouble = getSepCharFromHeader($oldHeader,$TRUE);
   my $sepChar       = getSepCharFromHeader($oldHeader,$FALSE);
   my(@headerParts)  = split($sepCharDouble,$oldHeader);

   my $newHeader     = "";
   my $aHeaderPart   = "";
   foreach $aHeaderPart (@headerParts) {
        if (exists($transTabUpperCase{$aHeaderPart})) {
            $newHeader = sprintf("${newHeader}${sepChar}%s",$transTabUpperCase{$aHeaderPart});
        } else {
            $newHeader = "${newHeader}${sepChar}${aHeaderPart}";
        }
   }
   if ($sepChar eq ";") {
      $newHeader =~ s/^;//;
   } else {
      $newHeader =~ s/^\|//;
   }

   if ($reopenOutputFile) {
       open(TABFILE_copyFltFileWithHeaderTranslation,">>${outfile}") || showError("ERROR (copyFltFileWithHeaderTranslation): Can't open file:${fileName}: $!");

       my $oldHeader = getTableHeader($outfile);
       if ($newHeader ne $oldHeader) {
           print("ERROR (copyFltFileWithHeaderTranslation): Headers not equal\n");
           print("  ERROR:${newHeader} -->${infile}\n");
           print("  ERROR:${oldHeader} -->${outfile}\n");
       }
   } else {
       open(TABFILE_copyFltFileWithHeaderTranslation,">${outfile}") || showError("ERROR (copyFltFileWithHeaderTranslation): Can't open file:${fileName}: $!");
       print(TABFILE_copyFltFileWithHeaderTranslation "${newHeader}\n");
   }
   for (my $i=1; $i < $countOfLines; $i++) {
      printf (TABFILE_copyFltFileWithHeaderTranslation "%s\n",$inFileLines[$i]);
   }
   close(TABFILE_copyFltFileWithHeaderTranslation);
   return $countOfLines-1;
}

# creates and OR chain like
#
# e.g.
#   $fieldName = "Hash"
#   @keyValues = (0001,
#                 0005,
#                 1000)
#
#   ---> Hash eq "0001" OR Hash eq "0005" OR Hash eq "1000"
#
sub makeOR_ConditionOutOfIn {
   my($fieldName,@keyValues) = @_;
   my($retStr)     = "";
   my $count       = @keyValues;

   foreach my $aKeyValue (@keyValues) {
         if ($retStr eq "") {
            $retStr = "${fieldName} eq ${aKeyValue}";
         } else {
            $retStr = "${retStr} OR ${fieldName} eq ${aKeyValue}";
         }
   }
   return $retStr;
} 

# creates and AND chain like
#
# e.g.
#   $fieldName = "Hash"
#   @keyValues = (0001,
#                 0005,
#                 1000)
#
#   ---> Hash ne "0001" AND Hash ne "0005" AND Hash ne "1000"
#
sub makeAND_ConditionOutOfNotIn {
   my($fieldName,@keyValues) = @_;
   my($retStr)     = "";
   my $count       = @keyValues;

   foreach my $aKeyValue (@keyValues) {
         if ($retStr eq "") {
            $retStr = "${fieldName} ne ${aKeyValue}";
         } else {
            $retStr = "${retStr} AND ${fieldName} ne ${aKeyValue}";
         }
   }
   return $retStr;
} 

# $fieldsToCompare contains the fields (separated by ;) which should be compared. Default is header from $file_1
sub compareFltFilesAndProduceReport_1 {
   my($file_1,$keyFieldName_1,$file_2,$keyFieldName_2,$reportFileName,$compareCommonRecord,$fieldsToExclude,$fieldsToCompare)   = @_;
   $keyFieldName_2       = setDefault($keyFieldName_2,$keyFieldName_1);
   $fieldsToCompare      = setDefault(getTableHeader($file_1),$fieldsToCompare);
   $compareCommonRecord  = setDefault($compareCommonRecord,$TRUE);

   $fieldsToCompare =~ s/\|/;/g;
   $fieldsToExclude =~ s/\|/;/g;

   my(@fieldsToComp) = split(";",$fieldsToCompare);   
   my(@fieldsToExc)  = split(";",$fieldsToExclude);

   $fieldsToCompare = makeStrFromArray(";",getExclutionOfArrays(\@fieldsToComp,\@fieldsToExc));

   my @retList_1 = ();
   my @retList_2 = ();

   if ($reportFileName ne "") {
       openLogFile($reportFileName,"",$TRUE,$FALSE);
   }
   my $startTimeStamp = getTimeStamp();

   addToLogFile("Started at ".formatTimeStamp($startTimeStamp,"USA", $FALSE, $FALSE,$LangEnglish),$reportFileName,$TRUE,"",$FALSE);
   addToLogFile("Missing keys in ".getFileNameOutOfFullName($file_2)." (Total Records:".getRecordCountFromFltFile($file_2).")",$reportFileName,$TRUE,"",$FALSE);
   @retList_1 = compareFltFilesReturnMissingKeysInFile2($file_1,$keyFieldName_1,$file_2,$keyFieldName_2,$TRUE);
   addToLogFile(makeStrFromArray("\n",@retList_1),$reportFileName,$TRUE,"",$FALSE);

   addToLogFile("\n\nMissing keys in ".getFileNameOutOfFullName($file_1)." (Total Records:".getRecordCountFromFltFile($file_1).")",$reportFileName,$TRUE,"",$FALSE);

   @retList_2 = compareFltFilesReturnMissingKeysInFile2($file_2,$keyFieldName_2,$file_1,$keyFieldName_1,$TRUE);
   addToLogFile(makeStrFromArray("\n",@retList_2),$reportFileName,$TRUE,"",$FALSE);

   if ($compareCommonRecord) {
     addToLogFile("\n\nChecking for differences in common records (takes time).....",$reportFileName,$TRUE,"",$FALSE);

     my $whereClause_1 = makeAND_ConditionOutOfNotIn($keyFieldName_1,@retList_1);
     my @records_1     = getColumnValues($file_1,getSepCharFromTable($file_1,$TRUE),$fieldsToCompare,$whereClause_1,$keyFieldName_1);
     my $comRecCount_1 = @records_1;
     addToLogFile("... ${comRecCount_1} records selected from ".getFileNameOutOfFullName($file_1)."",$reportFileName,$TRUE,"",$FALSE);

     my $whereClause_2 = makeAND_ConditionOutOfNotIn($keyFieldName_2,@retList_2);
     my @records_2     = getColumnValues($file_2,getSepCharFromTable($file_2,$TRUE),$fieldsToCompare,$whereClause_2,$keyFieldName_1);
     my $comRecCount_2 = @records_2;
     addToLogFile("... ${comRecCount_2} records selected from ".getFileNameOutOfFullName($file_2)."",$reportFileName,$TRUE,"",$FALSE);

     if ($comRecCount_1 != $comRecCount_2) {
       addToLogFile("ERROR: Record counts are not maching!!!!!! (${comRecCount_1} != ${comRecCount_2})",$reportFileName,$TRUE,"",$FALSE);
     } else {
        my $diffsFoundCount = 0;
        addToLogFile("\n\nDifferences in common records (${comRecCount_1})",$reportFileName,$TRUE,"",$FALSE);
        my $diffsFound = $FALSE;
        for (my $i=0; $i <= $comRecCount_1; $i++) {
          ### addToLogFile(sprintf("%20s     %20s\n",substr($records_1[$i],0,20),substr($records_2[$i],0,20)),$reportFileName,$TRUE,"",$FALSE);
          if ($records_1[$i] ne $records_2[$i]) {
             my $str_1 = $records_1[$i];
             my $str_2 = $records_2[$i];
             my $markerStr = createMarker(getPosWhereStringsStartToBeDifferent($str_1,$str_2),"-");
             if (!($diffsFound)) {
                $diffsFound = $TRUE;
                my $headerLine_1 = getTableHeader($file_1);
                my $headerLine_2 = getTableHeader($file_2);
                addToLogFile($headerLine_1,$reportFileName,$TRUE,"",$FALSE);
                if ($headerLine_1 ne $headerLine_2) {
                  addToLogFile($headerLine_2,$reportFileName,$TRUE,"",$FALSE);
                }
             }
             addToLogFile("${str_1}\n${str_2}\n${markerStr}\n",$reportFileName,$TRUE,"",$FALSE);
             $diffsFoundCount++;
          }
        }
        addToLogFile("\n\n${diffsFoundCount} differences found in common records (${comRecCount_1})",$reportFileName,$TRUE,"",$FALSE);
     }
   }
   my $endTimeStamp = getTimeStamp();
   addToLogFile("Ended at ".formatTimeStamp($endTimeStamp,"USA", $FALSE, $FALSE,$LangEnglish),$reportFileName,$TRUE,"",$FALSE);
   addToLogFile("Running time:".secDiff_YYYYMMDDhhmmss($endTimeStamp,$startTimeStamp,$Format_HH_MM_SS),$reportFileName,$TRUE,"",$FALSE);

   if ($reportFileName ne "") {
       closeLogFile($reportFileName,$FALSE);
   }
}

sub compareFltFilesAndProduceReport {
   my($file_1,$keyFieldName_1,$file_2,$keyFieldName_2,$reportFileName,$fieldsToExclude,$fieldsToCompare)   = @_;
   $keyFieldName_2  = setDefault($keyFieldName_2,$keyFieldName_1);
   $fieldsToCompare = setDefault(getTableHeader($file_1),$fieldsToCompare);

   compareFltFilesAndProduceReport_1($file_1,$keyFieldName_1,$file_2,$keyFieldName_2,$reportFileName,$TRUE,$fieldsToExclude,$fieldsToCompare);
}

sub compareFltFilesReturnMissingKeysInFile2 {
   my($file_1,$keyFieldName_1,$file_2,$keyFieldName_2,$returnJustKeys)   = @_;
   $returnJustKeys = setDefault($returnJustKeys,$TRUE);

   my @missingKeys = ();
   if (!(isFieldNamePartOfHeader($file_1,$keyFieldName_1))) {
      print("ERROR:${keyFieldName_1}: not found in header of ${file_1}\n");
      return @missingKeys;
   }
   if (!(isFieldNamePartOfHeader($file_2,$keyFieldName_2))) {
      print("ERROR:${keyFieldName_2}: not found in header of ${file_2}\n");
      return @missingKeys;
   }
   my @keysInFile_1 = getColumnValues($file_1,getSepCharFromTable($file_1,$TRUE),$keyFieldName_1,"","",$TRUE);
   my @keysInFile_2 = getColumnValues($file_2,getSepCharFromTable($file_2,$TRUE),$keyFieldName_2,"","",$TRUE);
   @missingKeys = getExclutionOfArrays(\@keysInFile_1,\@keysInFile_2);
   if ($returnJustKeys) {
       return @missingKeys;
   } else {
       my $countOfMissingsLines = @missingKeys;
       if ($countOfMissingsLines == 0) {
           return @missingKeys;
       }
       my $whereClause = $whereClause = "${keyFieldName_1} in (".makeStrFromArray(",",@missingKeys).")";
       return getRowsInFltFile($file_1,getSepCharFromTable($file_1,$TRUE),$whereClause,$FALSE);
   }
}

sub compareFltFilesReturnCommonKeys {
   my($file_1,$keyFieldName_1,$file_2,$keyFieldName_2)   = @_;
   my @keysInFile_1 = getColumnValues($file_1,getSepCharFromTable($file_1,$TRUE),$keyFieldName_1,"","",$TRUE);
   my @keysInFile_2 = getColumnValues($file_2,getSepCharFromTable($file_2,$TRUE),$keyFieldName_2,"","",$TRUE);

   return getIntersectionOfArrays(\@keysInFile_1,\@keysInFile_2);
}


sub appendFltFiles {
   my($fileName,$fileToAppend)   = @_;
   my(@linesToAppend) = readFltTable($fileToAppend);

   my(@linesInFile)   = ();
   if (isFileExists($fileName)) { 
      @linesInFile = readFltTable($fileName);
   }
   my $countOfLines     = @linesToAppend;
   my $countOfInLines   = @linesInFile;

   my($startIndex) = 1;
   if ($countOfInLines == 0) {
      $startIndex = 0;
   }
   open(TABFILE_appendFltFiles,">>${fileName}") || showError("ERROR (appendFltFiles): Can't open file:${fileName}: $!");
   for (my $i=$startIndex; $i < $countOfLines; $i++) {
      printf (TABFILE_appendFltFiles "%s\n",$linesToAppend[$i]);
   }
   close(TABFILE_appendFltFiles);
   return $countOfLines-1;
}

# replacePlaceholdersInFile
# -------------------------
# History:
# 02/03/99    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# reads a file an replaces all placeholder defined in the transList and returns
# a list with all the lines.
# The Placeholder can also be a full fuction call
# 
# e.g.
# %transList = (
#    "{normalerPlaceholder}"                      => "NORMAL",
# );
# 
# $fileContent = "Dies ist ein {normalerPlaceholder} Placeholder and that is the result ({CallUserFctHidden:sayHalloWalti(1,\"Walterli\",\"Me,Too\")}) of a function call";
sub replacePlaceholdersInFile {
   my($fileName,%transList)   = @_;
   my(@retList)               = ();

   ## displayHashTable(%transList);
   ## print("Open File ${fileName}\n");
   open(TABFILE_replacePlaceholdersInFile,$fileName) || showError("ERROR (replacePlaceholdersInFile): Can't open file:${fileName}: $!");
   while (defined($line = <TABFILE_replacePlaceholdersInFile>)) {
      chomp($line);
      $line = replacePlaceholdersStr($line,%transList);
      push(@retList,$line);
   } # end of while
   close(TABFILE_replacePlaceholdersInFile);
   return @retList;
}


# appendLine
# ----------
# History:
# 02/05/99    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# appends a new line to a file
sub appendLine {
   my($fileName,$newLine)   = @_;
   my($outFileName) = ">>${fileName}";
   open(TABFILE_appendLine,$outFileName) || showError("ERROR (appendLine): Can't open file:${outFileName}: $!");
   print(TABFILE_appendLine "${newLine}\n");
   close(TABFILE_appendLine);
}

# putLineOnTop
# ------------
# History:
# 09/03/99    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# puts a new line as the first line to a file
sub putLineOnTop {
   my($fileName,$newLine)   = @_;
   my(@newLines) = (${newLine});
   putLinesOnTop($fileName,@newLines);
}

sub putLinesOnTop {
	my($fileName,@newLines)   = @_;
	my @oldLines = readFile($fileName);
	my $outFileName = ">${fileName}";
	open(TABFILE_putLineOnTop,$outFileName) || showError("ERROR (putLineOnTop): Can't open file:${outFileName}: $!");
	foreach my $aNewLine (@newLines) {
		print(TABFILE_putLineOnTop "${aNewLine}\n");
	}

	foreach my $oldLine (@oldLines) {
		print(TABFILE_putLineOnTop "${oldLine}\n");
	}
	close(TABFILE_putLineOnTop);
}


# getDescriptionLines
# -------------------
# History:
# 01/13/99    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# returns all comment lines, sub and @_ out of a perl-script
sub getDescriptionLines {
	my($fileName)   = @_;
	my @retList     = ();

	## print("Open File ${fileName}\n");
	open(TABFILE_getDescriptionLines,$fileName) || showError("ERROR (getDescriptionLines): Can't open file:${fileName}: $!");
	while (defined($line = <TABFILE_getDescriptionLines>)) {
		chomp($line);
		#skip comment and blank lines
		if (($line =~ /^#/) || ($line =~ /^\s*sub /) || ($line =~ /\@_;\s*/) || ($line =~ /^\s*return/)) {
			push(@retList,$line);
		}
	} # end of while
	close(TABFILE_getDescriptionLines);
	return @retList;
}

# get description of a sub
sub getFctDescriptionFromFileList {
	my($fctName,$showModName,@fileNameList)   = @_;
	my @retList = ();
	my @tmpList = ();
	my $countOfFiles = @fileNameList;
	if ($countOfFiles eq "0") {
		getPerlLibFullNameList();
	}
	foreach my $aFilename (@fileNameList) {
		@tmpList = getFctDescription($fctName,$showModName,$aFilename);
		@retList = concatArray(@retList,@tmpList);
	}
	return @retList;
}

sub getSubCode {
	my($fctName,$exactMatch)   = @_;
	$exactMatch    = setDefault($exactMatch,$TRUE);
	
	my @retLines     = ();
	my @fileLines    = ();
	my $subfound     = $FALSE;
	my $subFileName  = "";
	my $subLineNr    = -1;
	my $countOfLines = 0;

	foreach my $aSubFileName (getPerlLibFullNameList()) {
		# print("aSubFileName:${aSubFileName}:\n");
		@fileLines = readFile($aSubFileName);
		$countOfLines = @fileLines;
		# print("First:".$fileLines[0]."\n");
		# print("Last :".$fileLines[$countOfLines - 1]."\n");
		for (my $i=0; $i < $countOfLines; $i++) {
			if ($fileLines[$i] =~ /^\s*sub\s*$fctName/) {
				$fileLines[$i] =~ s/\s+/ /g;
				$fileLines[$i] = strip($fileLines[$i]);
				## print("1: fileLines:".$fileLines[$i]."\n");
				if ($exactMatch) {
					if ($fileLines[$i] eq "sub ${fctName} {") {
						$subLineNr = $i;
						$subfound  = $TRUE;
						$subFileName = $aSubFileName;
						last;
					}
				} else {
					$subLineNr = $i;
					$subfound  = $TRUE;
					$subFileName = $aSubFileName;
					last;
				}
			}
		}
		if ($subfound) {
			last;
		}
	}
	# print("subFileName:${subFileName}:     subLineNr:${subLineNr}:\n");
	my $startOfSub = $subLineNr;
	while ($fileLines[$startOfSub - 1] =~ /^\s*#/) {
		$startOfSub = $startOfSub - 1;
		if ($startOfSub == 0) { last; }
	}
	my $endOfSub   = $subLineNr;
	# print("Line:".$fileLines[$endOfSub + 1]."\n");
	while (!($fileLines[$endOfSub + 1] =~ /^\s*sub\s*/)) {
		$endOfSub = $endOfSub + 1;
		if ($endOfSub >= $countOfLines) { last; }
	}
	if ($endOfSub < $countOfLines) {
		while (!($fileLines[$endOfSub - 1] =~ /^\}/)) {
			$endOfSub = $endOfSub - 1;
		}
	}
	# print("startOfSub:${startOfSub}:     endOfSub:${endOfSub}:\n");
	return ($subFileName,$startOfSub,$endOfSub,getSubsetFromArray($startOfSub,$endOfSub,@fileLines));
}

sub getSubSignatur {
	my($fctName)   = @_;
	my @retLines = ();

	my ($sourceFN, $startLine, $endLine, @descLinesAll) = getSubCode($fctName);

	foreach my $aLine (@descLinesAll) {
		if ($aLine =~ /^#/) {
			push(@retLines,$aLine);
		}

		if ($aLine =~ /^\s*sub\s*$fctName/) {
			push(@retLines,$aLine);
		}

		if ($aLine =~ /setDefault/) {
			push(@retLines,$aLine);
		}

		if ($aLine =~ /= \@_/) {
			push(@retLines,$aLine);
		}

		if ($aLine =~ /= return /) {
			push(@retLines,$aLine);
		}
	}

	return @retLines;

}

sub getFctDescription {
	my($fctName,$showModName,$perlSourceFile) = @_;
	my @descLinesAll = getDescriptionLines($perlSourceFile);
	my @descLines    = ();

	my $doCopy = $TRUE;
	my $found  = $FALSE;
	foreach my $line (@descLinesAll) {
		if ($line =~ /^#/) {
			$doCopy = $TRUE;
			if ($found) {
				last;
			}
		}
		if ($line =~ /^\s*sub /) {
			if (index($line,$fctName) == -1) {
				$doCopy = $FALSE;
				if (!($found)) {
					@descLines = ();
				}
			} else {
				$found = $TRUE;
				$doCopy = $TRUE;
			}
		} 
		if ($doCopy) {
			push(@descLines,$line);
		}
	}
	return @descLines;
}

sub getSubNameFromFileList {
	my($showParamList,$showModName,@fileNameList)   = @_;
	my @retList = ();
	my @tmpList = ();
	foreach my $aFilename (@fileNameList) {
		@tmpList = getSubNames($aFilename,$showParamList,$showModName,$FALSE);
		# print("\n\n");displayArray(@tmpList);print("\n\n");
		@retList = concatArray(@retList,@tmpList);
	}
	return @retList;
}

# returns all comment sub names
sub getSubNames  {
	my($fileName,$showParamList,$showModName,$withDoTest)   = @_;
	$showParamList      = setDefault($showParamList,$FALSE);
	$showModName        = setDefault($showModName,$FALSE);
	$withoutDoTest      = setDefault($withDoTest,$TRUE);

	my $modName    = "";
	if ($showModName) {
		$modName = getFileNameOutOfFullName($fileName);
		$modName =~ s/\.pm//g;
	}
	my @retList    = ();
	my $line       = "";
	my @subParts   = ();
	## print("Open File ${fileName}\n");
	open(TABFILE_getSubNames,$fileName) || showError("ERROR (getSubNames): Can't open file:${fileName}: $!");
	my $keptLine = "";
	while (defined($line = <TABFILE_getSubNames>)) {
		chomp($line);
		if ($showParamList) {
			if (($line =~ /^\s*my\s*\(/) && ($line =~ /\@_;\s*/)) {
				my $paramList = $line;
				$paramList =~ s/\s*my\s*//g;
				$paramList =~ s/\s*=\s*\@_;\s*//g;
				if ($showModName) {
					push(@retList,"${modName}::${keptLine}${paramList}");
				} else {
					push(@retList,"${keptLine}${paramList}");
				}
				$keptLine = "";
			} else {
				if ($keptLine ne "") {
					if ($showModName) {
						push(@retList,"${modName}::${keptLine}");
					} else {
						push(@retList,"${keptLine}");
					}
					$keptLine = "";
				}
			}
		}


		if ($line =~ /^\s*sub /) {
			# print("line:${line}:\n");
			if (($withoutDoTest) && (stringContains($line,"sub doTest_"))) {
				# print("Skipped!!!!!!!\n");
				next;
			}
			$line = strip($line);
			$line =~ s/\s+/ /g;
			@subParts = split(" ",$line);
			$keptLine = $subParts[1];
			if ($showParamList) {
				next;
			} else {
				if ($showModName) {
					push(@retList,"${modName}::${keptLine}");
				} else {
					push(@retList,"${keptLine}");
				}
				$keptLine = "";
			}
		}
	} # end of while
	if ($keptLine ne "") {
		if ($showModName) {
			push(@retList,"${modName}::${keptLine}");
		} else {
			push(@retList,"${keptLine}");
		}
		$keptLine = "";
	}
	close(TABFILE_getSubNames);
	return @retList;
}

sub replaceTabsInFile {
  my($inFileName,$outFileName,$tabWidth,$inWholeLine)   = @_;
  $inWholeLine = setDefault($inWholeLine,$TRUE);
  my($iLine) = "";
  my($oLine) = "";
  open(INF_replaceTabsInFile,"${inFileName}") || showError("ERROR (replaceTabsInFile): Can't open infile:${inFileName}: $!");
  open(OUTF_replaceTabsInFile,">${outFileName}") || showError("ERROR (replaceTabsInFile): Can't open outfile:${outFileName}: $!");
  while (defined($iLine = <INF_replaceTabsInFile>)) {
    chomp($iLine);
    $oLine = replaceTab($iLine,$tabWidth," ",$inWholeLine);
    print(OUTF_replaceTabsInFile "${oLine}\n");
  } # end of while
  close(OUTF_replaceTabsInFile);
  close(INF_replaceTabsInFile);
}

sub textFileCopy {
   my($sourceFileName,$destFileName) = @_;
   if ($sourceFileName ne $destFileName) {
      my($iLine) = "";
      open(INF_textFileCopy,"${sourceFileName}") || showError("ERROR (textFileCopy): Can't open infile:${sourceFileName}: $!");
      open(OUTF_textFileCopy,">${destFileName}") || showError("ERROR (textFileCopy): Can't open outfile:${destFileName}: $!");
      while (defined($iLine = <INF_textFileCopy>)) {
        chomp($iLine);
        print(OUTF_textFileCopy "${iLine}\n");
      } # end of while
      close(OUTF_textFileCopy);
      close(INF_textFileCopy);
   }
}

sub swapFilenames {
  my($fileNameA,$fileNameB) = @_;
  my $tmpFileName = setNewFilenameExtension($fileNameA,"tmp");
  rename($fileNameA,$tmpFileName);
  rename($fileNameB,$fileNameA);
  rename($tmpFileName,$fileNameB);
  unlink($tmpFileName);
}

# getNextLSNr
# -----------
# History:
# 03/17/99    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# reads a number from a file, increments it and stores the new value again in the file
sub getNextLSNr {
  my($inFileName)  = @_;
  my($nr)          = getLSNr($inFileName);
  $nr++;
  setLSNr($inFileName,$nr);
  return $nr;
}

sub setLSNr {
   my($inFileName,$newVal)  = @_;
   $newVal     = setDefault($newVal,"0");
   $inFileName = ">${inFileName}";
   open(LSNR_setLSNr,$inFileName) || showError("Error (setLSNr):Can't open outfile:$inFileName}: $!");
   print(LSNR_setLSNr "${newVal}\n");
   close(LSNR_setLSNr);
}

sub getLSNr {
   my($inFileName)  = @_;
   my $line = "0";
   if (isFileExists($inFileName)) { 
      open(LSNR_getLSNr,$inFileName) || showError("Error (getLSNr):Can't open outfile:${inFileName}: $!");
      while (defined ($line = <LSNR_getLSNr>)) {
         chomp($line);
         last;
      } # end of while
      close(LSNR_getLSNr);
   } else {
      setLSNr($inFileName,$line);
   }
   return $line;
}


# displays an counter 
# @images = (
#   "/images/0.gif",
#   "/images/1.gif",
#   "/images/2.gif",
#   "/images/3.gif",
#   "/images/4.gif",
#   "/images/5.gif",
#   "/images/6.gif",
#   "/images/7.gif",
#   "/images/8.gif",
#   "/images/9.gif",
# );
# 
# print(displayCounter("Data/rothlinCount_11.txt",5,"","100",@images));
# 
# if @images = (); then display ASCII str
sub displayCounter {
    my($counterFile,$length,$padChr,$startVal,@images) = @_;
    $padChr   = setDefault($padChr,"0");
    $startVal = setDefault($startVal,"0");
    my($nextNr) = $startVal;
    my($retStr) = "";
    if (-f $counterFile) {
        $nextNr = getNextLSNr($counterFile);
    } else {
        setLSNr($counterFile,$startVal);
    }
    my($nrStr) = paddenNull($nextNr,$length,$padChr);
    my(@strParts) = split("",$nrStr);
    my($aPart) = "";
    foreach $aPart (@strParts) {
        if ($images[$aPart] eq "") {
             $retStr = "${retStr}${aPart}";
        } else {
             $retStr = sprintf("${retStr}<IMG SRC=\"%s\" border=0>",$images[$aPart]);
        }
    }
    return $retStr;
}

# creates an outputfile which contains all $outputFields and the $extremField 
sub createFileWithExtrems {
   my($infileName,$outfileName,$sepChar,$whereClause,$selectFields,$additionalOutputFields,$hashName,$extremField,$takeMaximum) = @_;
   my(@selectedRecords) =  getColumnValues($infileName,$sepChar,"${selectFields};${additionalOutputFields};${extremField}",$whereClause,"",$FALSE);
   #### displayArrayHTML(@selectedRecords);
   my(%extrems) = ();
   my(%resHash) = ();
   my($aSelectedRec) = "";
   my(@selParts)   = split($sepChar,$selectFields);
   my $countFields = @selParts;
   foreach $aSelectedRec (@selectedRecords) {
      my(@recParts)  = split($sepChar,$aSelectedRec);
      my $maxCountFields = @recParts;
      my($key)       = $recParts[0];
      my($i)        = 1;
      foreach ($i=1; $i < $countFields ; $i++) {
          $key = sprintf("%s;%s",$key,$recParts[$i]);
      }
      my($extremVal) = $recParts[$maxCountFields-1];
      if (exists($extrems{$key})) {
          if ((($extrems{$key} < $extremVal) && ($takeMaximum)) ||
              (($extrems{$key} > $extremVal) && (!($takeMaximum)))) {
             # extremer extrem (replace old extrem)
             $extrems{$key} = $extremVal;
             $resHash{$key} = $aSelectedRec;
          }
      } else {
          # new extrem (nothing to replace)
          %extrems = (%extrems,($key,$extremVal));
          %resHash = (%resHash,($key,$aSelectedRec));
      }
   }
   #### displayHashTable(%resHash);
   open(NEWFILE_createFileWithExtrems,">${outfileName}") || showError("Error (createFileWithExtrems):Can't open outfile:${outfileName}: $!");
   my($reqFieldNames) = "${selectFields};${additionalOutputFields};${extremField}";
   $reqFieldNames =~ s/;/$sepChar/g;
   print(NEWFILE_createFileWithExtrems "${hashName}${sepChar}${reqFieldNames}\n");   
   my(@keyList) = keys %resHash;
   my($aKey)    = "";
   my($count)   = 1;
   foreach $aKey (@keyList) {
      printf(NEWFILE_createFileWithExtrems "${count}${sepChar}%s\n",$resHash{$aKey});
      $count++;
   }
   close(NEWFILE_createFileWithExtrems);
}

# creates an outputfile which has a new field in it which summarizes (counts) the entries
sub createSummarizedFile {
   my($infileName,$outfileName,$sepChar,$whereClause,$fieldsToSummarize,$hashName,$sumName) = @_;
   my(@selectedRecords) =  getColumnValues($infileName,$sepChar,$fieldsToSummarize,$whereClause,"",$FALSE);
   my(%resultHash) = countApperanceOfNames($TRUE,"","",@selectedRecords);
   ### displayHashTable(%resultHash);
   open(NEWFILE_createSummarizedFile,">${outfileName}") || showError("Error (createSummarizedFile):Can't open outfile:${outfileName}: $!");
   $fieldsToSummarize =~ s/;/$sepChar/g;
   print(NEWFILE_createSummarizedFile "${hashName}${sepChar}${sumName}${sepChar}${fieldsToSummarize}\n");   
   my(@keyList) = keys %resultHash;
   my($aKey)    = "";
   my($count)   = 1;
   my($max)     = -1;
   foreach $aKey (@keyList) {
      my($val) = $resultHash{$aKey};
      print(NEWFILE_createSummarizedFile "${count}${sepChar}${val}${sepChar}${aKey}\n");
      if ($val > $max) {
         $max = $val;
      }
      $count++;
   }
   close(NEWFILE_createSummarizedFile);
   return $max;
}

sub getSummarizedValue {
   my($infileName,$sepChar,$whereClause,$fieldToSummarize) = @_;
   my(@selectedRecords) =  getColumnValues($infileName,$sepChar,$fieldToSummarize,$whereClause,"",$FALSE);
   my($sumVal) = 0;
   my($aVal)   = "";
   foreach $aVal (@selectedRecords) {
      $sumVal = $sumVal + $aVal;
   }
   return $sumVal;
}

sub getAverageValue {
   my($infileName,$sepChar,$whereClause,$fieldToSummarize) = @_;
   my(@selectedRecords) =  getColumnValues($infileName,$sepChar,$fieldToSummarize,$whereClause,"",$FALSE);
   my($countOfEntries)  =  0; $countOfEntries = @selectedRecords;
   my($sumVal) = 0;
   my($aVal)   = "";
   foreach $aVal (@selectedRecords) {
      $sumVal = $sumVal + $aVal;
   }
   if ($countOfEntries ne "0") {
       return $sumVal / $countOfEntries;
   } else {
       return "";
   }
}


# ($modAt,$modBy) = getLastModByAtFromFltFile("bugList.flt","\\|","ModAt","ModBy");
sub getLastModByAtFromFltFile {
   my($fileName,$sepChar,$ModAtFNa,$ModByFNa) = @_;
   my $modAt = "";
   my $modBy = "";

   my(@selectedRecords) = getColumnValues($fileName,$sepChar,"${ModAtFNa};${ModByFNa}","","!${ModAtFNa}",$FALSE);
   ### print("<!-- TESTOUTPUT from getLastModByAtFromFltFile\n");
   ### displayArrayHTML(@selectedRecords);
   ### print("-->");

   my($countOfEntries)  =  0; $countOfEntries = @selectedRecords;
   if ($countOfEntries >= 1) {
       my(@parts) = split($sepChar,$selectedRecords[0]);
       $modAt = $parts[0];
       $modBy = $parts[1];
   }
   return ($modAt,$modBy);
}

$newsTickerTypeEnum_LED      = "LED";
$newsTickerTypeEnum_Vertikal = "Vertikal";

sub getLatestPublishedRecord {
   my($infileName,$sepChar,$publishDateFNa,$appletTypeFNa,$appletType) = @_;
   $appletType   = setDefault($appletType,$newsTickerTypeEnum_Vertikal);
   my $timeStamp   = getTimeStamp();
   my $whereClause = "${publishDateFNa}<${timeStamp} AND ${appletTypeFNa} eq ${appletType}";
   if ($appletTypeFNa eq "") {
     $whereClause = "${publishDateFNa}<${timeStamp}";
   }
   ## print("whereClause:${whereClause}:\n");
   my(@selectedRecords) = getAllMatchesFromFltFileAsHashes($infileName,$sepChar,$whereClause,$publishDateFNa);
   my($countOfEntries)  =  0; $countOfEntries = @selectedRecords;
   ## my($aRecord)         = "";
   ## foreach $aRecord (@selectedRecords) {
   ##   printf("NewsText:%s:\n",$aRecord->{NewsText});
   ##   printf("PublishDate:%s:\n\n",$aRecord->{PublishDate});
   ## }
   ## print("countOfEntries:${countOfEntries}:\n");
   my %retHash = ();
   if ($countOfEntries >= 1) {
       my $hashRef = $selectedRecords[$countOfEntries - 1];
       ## printf("....PublishDate:%s:\n\n",$hashRef->{PublishDate});
       %retHash = %$hashRef;
   }
   return %retHash;
}

sub selectFromFltToOtherFlt {
   my($inFileName,$outFileName,$sepChar,$whereClause,$sortedBy,$distinct,@columns)   = @_;

   if ($sepChar eq "") {
      $sepChar = getSepCharFromHeader(getTableHeader($inFileName),$TRUE);
   }

   my(%transHash) = ();
   my $countOfColumns = @columns;
   if ($countOfColumns eq "0") { 
      %transHash = produceTransHashFromHeader($inFileName,$sepChar);
   } else {
      %transHash = produceTransHashFromColumsArray(@columns);
   }
   if ($sepChar ne ";") {
     $sepChar = "\\|";
   }
   ## print("inFileName:${inFileName}: outFileName:${outFileName}: sepChar:${sepChar}: whereClause:${whereClause}: sortedBy:${sortedBy}: distinct:${distinct}:<BR>\n");
   transformFile($inFileName,$outFileName,$sepChar,$whereClause,$sortedBy,$distinct,%transHash);
}

sub produceTransHashFromColumsArray {
    my(@columns) = @_;
    my($aHeaderPart)  = "";
    my(%transHashRet) = ();
    my($count)        = 1;
    foreach $aHeaderPart (@columns) {
       my($countStr) = sprintf("%3s",$count); $countStr =~ s/ /0/g; 
       %transHashRet = (%transHashRet,("${countStr}:${aHeaderPart}",$aHeaderPart));
       $count++;
    }
    return %transHashRet;
}

sub produceTransHashFromHeader {
    my($inFileName,$sepChar) = @_;
    my $headerLine = getTableHeader($inFileName);
    my(@headParts)  = split($sepChar,$headerLine);
    my($aHeaderPart) = "";
    my(%transHashRet) = ();
    my($count)        = 1;
    foreach $aHeaderPart (@headParts) {
       my($countStr) = sprintf("%3s",$count); $countStr =~ s/ /0/g; 
       %transHashRet = (%transHashRet,("${countStr}:${aHeaderPart}",$aHeaderPart));
       $count++;
    }
    return %transHashRet;
}


# sortFltFile
# -----------
# History:
# 04/16/01    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# Sorts a flat file and produces another flt file. If you don't specify $outFileName the infile will
# be over written.
#
# e.g.
## %fieldTypes = (
##     "PLZ"  => "Numeric",
## );
## 
## @outPutFields = (
##     "Ort",
##     "Name",
## );
## 
## 
## $sortedBy="!Name|PLZ";
## $where="Name eq Collet OR Name eq Rothlin";
## 
## sortFltFile($fileName,$outFileName,$where,$sortedBy,\%fieldTypes,\@outPutFields);
## 
## sortFltFile($fileName,"","",$sortedBy);
## 
sub sortFltFile {
  my($inFileName,$outFileName,$whereClause,$sortedBy,$refFieldTypes,$refOutputFields) = @_;
  %myFieldType = %$refFieldTypes;

  my $fltHeader        = getTableHeader($inFileName);
  my $sepChar          = getSepCharFromHeader($fltHeader,$TRUE);
  $sortFltFile_sepCharToWrite   = getSepCharFromHeader($fltHeader,$FALSE);
 
  @sortFltFile_outputFields         = @$refOutputFields;
  $sortFltFile_OutputFieldsDefined  = $FALSE;
  my $countOF_sortFltFile_outputFields = @sortFltFile_outputFields;
  if ($countOF_sortFltFile_outputFields > 0) {
      $sortFltFile_OutputFieldsDefined  = $TRUE;
  }

  my $removeOutFile = $FALSE;
  if ($outFileName eq "") {
     $outFileName = putTimeStampInFileName($inFileName,"","XXXXXX");
     $removeOutFile = $TRUE;
  }

  open(FLTFILE_sortFltFile,">${outFileName}") || showError("ERROR (sortFltFile): Can't open outfile:${outFileName}: $!");
  if ($sortFltFile_OutputFieldsDefined) {
     my $headLine = "";
     my $first = $TRUE;

     foreach $aField (@sortFltFile_outputFields) {
       if ($first) {
          $first = $FALSE;
          $headLine = $aField; 
       } else {
          $headLine = "${headLine}${sortFltFile_sepCharToWrite}${aField}"; 
       }
     }
     print(FLTFILE_sortFltFile "${headLine}\n",);
  } else {
     print(FLTFILE_sortFltFile "${fltHeader}\n");
  }
  selectRowsInFltFile($inFileName,$sepChar,$whereClause,$sortedBy,\&sortFltFile_Callback_Hidden);
  close(FLTFILE_sortFltFile);
  
  if ($removeOutFile) {
     unlink($inFileName);
     rename($outFileName,$inFileName);
  }
}

sub sortFltFile_Callback_Hidden {
  my($header,$line,$sepChar,$refLocNameToIndex,$refUserParam)   = @_;
  if ($sortFltFile_OutputFieldsDefined) {
     my(%locNameToIndex) = %$refLocNameToIndex;
     my(@parts) = split($sepChar,$line);
     my $outLine = "";
     my $first = $TRUE;

     foreach $aField (@sortFltFile_outputFields) {
       if ($first) {
          $first = $FALSE;
          $outLine = $parts[$locNameToIndex{$aField}]; 
       } else {
          $outLine = "${outLine}${sortFltFile_sepCharToWrite}".$parts[$locNameToIndex{$aField}]; 
       }
     }
     print(FLTFILE_sortFltFile "${outLine}\n",);
  } else {
     print(FLTFILE_sortFltFile "${line}\n");
  }
}



# transformFile
# -------------
# History:
# 03/17/99    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# Transforms a flat file into a new flat file. To select the records you want from the input file
# you can use the whereClause, distinct and sortedBy argument.
# !!!! distinct is not implemented yet !!!!
# The transHash has the following structure:
#   (The numbers are used to have the output fields in the right order)
# %transHash = (
#     "001:outFieldName1"   =>  "inFieldName1",
#     "002:outFiledName2"   =>  "userDefined:myFct",
#     "004:outFiledName4"   =>  "inFieldName2",
#     "003:outFiledName3"   =>  "userDefined:genHash",
#       );
#
# There are function which produce a %transTab
#     produceTransHashFromHeader
#     produceTransHashFromColumsArray
#
# sub myFct {
#   my(%aRecord) = @_;
#   my($retVal)  = "";
#   $retVal = sprintf("%s (%s)",$aRecord{"UserId"},$aRecord{"Password"});
#   return $retVal;
# }
#
# sub genHash {
#   my(%aRecord) = @_;
#   BEGIN {
#      my($aHash)  = 0;
#   }
#   return $aHash++;
# }
sub transformFile {
   my($inFileName,$outFileName,$sepChar,$whereClause,$sortedBy,$distinct,%transHash)   = @_;
   %transHashHidden = %transHash;

   my(@orgHeaderComments) = getTableHeaderComments($inFileName);

   if ($sepChar eq "") {
      $sepChar = getSepCharFromHeader(getTableHeader($inFileName),$TRUE);
   }

   if ($sepChar ne ";") {
       $sepCharHidden   = "|";
   } else {
       $sepCharHidden   = $sepChar;
   } 

   my $removeOutFile = $FALSE;
   if ($outFileName eq "") {
     $outFileName = putTimeStampInFileName($inFileName);
     $removeOutFile = $TRUE;
   }

   open(NEWFILE_transformFile,">${outFileName}") || showError("Error (transformFile):Can't open outfile:${outFileName}: $!");
   my(@outFieldNames) = keys %transHash;
   my($outFieldName)  = "";
   my($first)         = $TRUE;
   foreach $outFieldName (sort @outFieldNames) {
     my(@parts) = split(":",$outFieldName);
     if ($first) {
        $first = $FALSE;
        print(NEWFILE_transformFile $parts[1]);
     } else {
        print(NEWFILE_transformFile "${sepCharHidden}".$parts[1]);
     }
   }
   print(NEWFILE_transformFile "\n");
   selectHashInFltFile($inFileName,$sepChar,$whereClause,$sortedBy,$distinct,\&cbTransformFileHidden,"","","");
   close(NEWFILE_transformFile);

   putLinesOnTop($outFileName,@orgHeaderComments);
   if ($removeOutFile) {
     unlink($inFileName);
     rename($outFileName,$inFileName);
   }
}


sub cbTransformFileHidden {
   my($recCount, $refRecord, $refUserParam) = @_;
   my(%aRecord) = derefHref($refRecord);
   my(@outFieldNames) = keys %transHashHidden;
   my($outFieldName)  = "";
   my($first)         = $TRUE;
   foreach $outFieldName (sort @outFieldNames) {
     my(@parts) = split(":",$outFieldName);
     my($inFieldName) = $transHashHidden{$outFieldName};
     my(@inFieldNameParts) = split(":",$inFieldName);
     my($outField)  = "";
     if ($inFieldNameParts[0] eq "userDefined") {
         my($usrDefFunct) = $inFieldNameParts[1];
         my($aValStr) = &$usrDefFunct(%aRecord);
         $outField = $aValStr;
     } else {
         ### printf ("Record:%s:  FieldName:%s:   FieldValue:%s:\n",$recCount,$parts[1],$aRecord{$inFieldName});
         $outField = $aRecord{$inFieldName};
     }
     if ($first) {
         $first = $FALSE;
         print(NEWFILE_transformFile "${outField}"); 
     } else {
         print(NEWFILE_transformFile "${sepCharHidden}${outField}");
     }
   }
   print(NEWFILE_transformFile "\n");
}


# postProcessFltFile
# ------------------
# History:
# 04/25/00    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
#
# @outFields = ("Hash","NameVorname","PLZ");
#
# sub myPostProcessor {
#    # or accessing the global variables
#    print("${globalVarPrefix}Name:$REC1_Name\n");
#    if ($REC1_PLZ eq "8855") {
#       return $FALSE;   # do not write to output file!!!
#    } else {
#       return $TRUE;
#    }
# }
#
# $countOfRecordsWritten = postProcessFltFile("delmeInfile.txt","delmeOutfile.txt",\&myPostProcessor,\@outFields,"\\|","\\|",$FALSE,"REC1_");
sub postProcessFltFile {
  my ($inputFileName,$outputFile,$postProcessorFctName,$outputFieldsRef,$inputDelimiter,$outputDelimiter,$reopenOutputFile,$globalVarPrefix) = @_;
  $inputDelimiter   = setDefault($inputDelimiter,"\\|");
  $outputDelimiter  = setDefault($outputDelimiter,"\\|");
  $globalVarPrefix  = setDefault($globalVarPrefix,"REC1_");
  $reopenOutputFile = setDefault($reopenOutputFile,$FALSE);
  my($outDelim)     = $outputDelimiter;   if ($outDelim ne ";") {$outDelim = "|"; }

  my($header,$refToAll,$sepChar,$locNameToIndexRef) = getAllMatchesFromFltFile($inputFileName,$inputDelimiter,"","","","");
  my(@records)           = derefAref($refToAll);
  my(@outputFields)      = @$outputFieldsRef;

  my($outputFilehandler) = openFltFile($outputFile,$outDelim,$reopenOutputFile,@outputFields);

  my($singleRecord) = "";
  my($count)        = 0;
  foreach $singleRecord (@records) {
       my(@parts)    = split($inputDelimiter,$singleRecord);

       my($recordHasBeenWritten) = postProcessOneRecord(\@parts,$locNameToIndexRef,\@outputFields,$globalVarPrefix,$postProcessorFctName,$outputFilehandler,$outDelim);
       if ($recordHasBeenWritten) {
          $count++;
       }
  }
  close($outputFilehandler);
  return $count;
}

# sendPasswordForUserID($tabName,"Walter_Rothlin",$passwordUserIdFNam,$passwordPasswordFNam,$emailColumnName,$emailText,$fromAddr,$ccAddrs,$bccAddrs);
sub sendPasswordForUserID {
  my($tabName,$userId,$userIdFN,$passwordFN,$emailFN,$emailSubject,$emailText,$fromAddr,$ccAddrs,$bccAddrs) = @_;
  $emailText      = setDefault($emailText,sprintf(getLangStr("forgottenPwdMsg"),"...")."\n\n${passwordFN}:{${passwordFN}}");
  $emailSubject   = setDefault($emailSubject,getLangStr("emailNotifySubject"));
  $fromAddr       = setDefault($fromAddr,$emailNotifyFromAdr);

  my @records = getAllMatchesFromFltFileAsHashes($tabName,"","${userIdFN} eq ${userId}");
  my %aRecord  = ();
  my $password = "";
  my $emailAdr = "";

  ## foreach my $recRef (@records) {
  ##  printf("eMailAdr:%s<BR>\n",$recRef->{$emailFN});
  ##  printf("Password:%s<BR>\n",$recRef->{$passwordFN});
  ## }

  
  my $recCount = @records;
  ##  printf("recCount:${recCount}:<BR>\n");

  if ($recCount eq "1") {
     my $aRecordRef = $records[0];
     %aRecord  = %$aRecordRef;
     $password = $aRecord{$passwordFN};
     $emailAdr = $aRecord{$emailFN};

     %aRecord = updateHashKeys(\%aRecord);
     ## displayHashTableHTML(%aRecord);
     ## printf("E-mail:%s:<BR>\n",$emailAdr);
     ## printf("Password:%s:<BR>\n",$password);

     if ($emailAdr eq "") {
        return sprintf(getLangStr("strNoEmailDefined"),$userId);
     } else {
        # printf("msg (before):${emailText}:<BR>\n");
        $emailText = replacePlaceholdersStr($emailText,%aRecord);
        # printf("msg:${emailText}:<BR>\n");
        sendMailwithAttachments($fromAddr,$emailAdr,$emailSubject,$emailText,"",$ccAddrs,$bccAddrs,"","",$FALSE);
        return sprintf(getLangStr("strEmailSentTo"),$emailAdr);
     }
  } else {
     return getLangStr("strUserId")." ".getLangStr("strUnknown")." (${userId} --> ${recCount})";
  }
}

#ELB
#
# This routine removes dups in one pass through the list.
#
# It does case sensitive compares, which is consistent
# with the previous version of this routine.
#
# If eliminateEmptyLines is false, only the first blank
# line is salvaged, which is consistent with the behavior
# of the previous version.
#
sub makeArrayEntriesDistinct_faster{
 my($eliminateEmptyLines, @InList) = @_;

 my %ar_keys = ();
 my @ar_out = ();

 foreach $val (@InList) {
  if (!(($eliminateEmptyLines) && ($val eq ""))) {
   if (! exists $ar_keys{$val}) {
    push @ar_out, $val;
    $ar_keys{$val} = 1;
   }
  }
 }
 return @ar_out;
}

sub openFltFile {
    my($outputFile,$outDelim,$reopenOutputFile,@columnTitles) = @_;
    $outDelim = setDefault($outDelim,"\\|");  if ($outDelim ne ";") {$outDelim = "|"; }

    if ($reopenOutputFile) {
       open(OUTPUT_openFltFile, ">>${outputFile}") || die "Error (openFltFile) postProcessFltFile: Can't open $outputFile: $!\n";
    } else {
       open(OUTPUT_openFltFile, ">${outputFile}") || die "postProcessFltFile: Can't open $outputFile: $!\n";
       printf(OUTPUT_openFltFile "%s\n",makeQuotedStrFromArray($outDelim,"",@columnTitles));
    }
    return OUTPUT_openFltFile;
}

sub postProcessOneRecord {
    my($partsRef,$locNameToIndexRef,$outputFieldsRef,$globalVarPrefix,$postProcessorFctName,$outputFilehandler,$outDelim) = @_;
    $outDelim = setDefault($outDelim,"\\|");  if ($outDelim ne ";") {$outDelim = "|"; }

    my(@inputFields)       = (); @inputFields = keys %$locNameToIndexRef;

    #ELB
    my(@inputOutputFields) = makeArrayEntriesDistinct_faster($TRUE,concatArray(@inputFields,@$outputFieldsRef));

    my($aVarName) = "";
    foreach $aVarName (@inputOutputFields) {
         $aVarName = uc($aVarName);
         my($globalVarName)  = "${globalVarPrefix}${aVarName}";
         if (exists($locNameToIndexRef->{$aVarName})) {
             $$globalVarName     = @$partsRef[$locNameToIndexRef->{$aVarName}];
         } else {
             $$globalVarName     = "";
         }
       }

       my($writeToOutput) = &$postProcessorFctName($globalVarPrefix);
       if ($writeToOutput) {
           writeGlobalsToFile_fh($outputFilehandler,$outDelim,$globalVarPrefix,$TRUE,@$outputFieldsRef);
    }
    return $writeToOutput;
}

# returns a list of diff lines and writes
# the filename at the beginning of each line.
# It compaires line be line
sub compFiles {
  my($fNamePath_1,$fName_1,$fNamePath_2,$fName_2) = @_;
  my($fullFileName_1) = "${fNamePath_1}/${fName_1}";
  my($fullFileName_2) = "${fNamePath_2}/${fName_2}";

  my($strLabel_1) = "${fullFileName_1}: ";
  my($strLabel_2) = "${fullFileName_2}: ";
  my($padLen)     = maxStrLength($strLabel_1,$strLabel_2);
  $strLabel_1     = paddenNull($strLabel_1,-$padLen," ");
  $strLabel_2     = paddenNull($strLabel_2,-$padLen," ");

  my(@file_1)     = readFile($fullFileName_1);
  my(@file_2)     = readFile($fullFileName_2);
  my(@retList)    = ();

  my($countLine)  = 0;
  my($aLine_1)    = "";
  my($aLine_2)    = "";

  foreach $aLine_1 (@file_1) {
     $aLine_2 = $file_2[$countLine];
     if ($aLine_1 ne $aLine_2) {
        push(@retList,"${strLabel_1}${aLine_1}");
        push(@retList,"${strLabel_2}${aLine_2}");
        push(@retList,"");
     }
     $countLine++;
  }
  return @retList;
}

sub areFilesEqual {
	my($filename1,$filename2,$orderIsRelevant) = @_;
	my @lines1 = ();
	my @lines2 = ();
	if (isFileExists($filename1)) {
		@lines1 = readFile($filename1);
		if (isFileExists($filename2)) {
			@lines2 = readFile($filename2);
			return areArraysEqual(\@lines1,\@lines2,$orderIsRelevant);
		} else {
			return $FALSE;
		}
	} else {
		return $FALSE;
	}
}

sub readFileIntoStr {
   my($filename,$fromLine,$toLine,$trace)   = @_;
   $fromLine = setDefault($fromLine,1);
   $toLine   = setDefault($toLine  ,-1);
   $trace    = setDefault($trace   ,$FALSE);

   my $retStr      = "";
   my $aLine       = "";
   my $lineCount   = 1;
   open(FILE_readFileIntoStr,$filename) || showError("Error (readFile): Can't open file:${filename}: $!");
   while (defined ($aLine = <FILE_readFileIntoStr>)) {

     if (($lineCount >= $fromLine) &&
         (($lineCount <= $toLine) || ($toLine == -1))) {
       $retStr = "${retStr}${aLine}";
       if ($trace) {
          print("${aLine}\n");
       }
     }
     $lineCount++;
   }
   close(FILE_readFileIntoStr);
   return $retStr;
}

# reads a file and returns the lines in an array.
#     $fromLine defines the first line returned (counting at 1) Default:  1
#     $toLine   defines the last line returned                  Default: -1 (to the end)
sub readFile {
	my($filename,$fromLine,$toLine,$trace)   = @_;
	$fromLine = setDefault($fromLine,1);
	$toLine   = setDefault($toLine  ,-1);
	$trace    = setDefault($trace   ,$FALSE);

	my @retList    = ();
	my $aLine      = "";
	my $lineCount  = 1;
	open(FILE_readFile,$filename) || showError("Error (readFile): Can't open file:${filename}: $!");
	while (defined ($aLine = <FILE_readFile>)) {
		chomp($aLine);
		if (($lineCount >= $fromLine) &&
			(($lineCount <= $toLine) || ($toLine == -1))) {
			push(@retList,$aLine);
			if ($trace) {
				print("${aLine}\n");
			}
		}
		$lineCount++;
	}
	close(FILE_readFile);
	return @retList;
}

# returns a list of lines and resolves the includes
# Default include pattern is: <include:filename>
# Don't pass $recLevel. It is used internaly for recursion
# The function doesn't read any other character on the same line as the include command
sub readFileWithIncludes {
   my($infile,$includePattern,$recLevel,$withComments,$includePath)  = @_;
   $includePattern = setDefault($includePattern,"<include:*>");
   $recLevel       = setDefault($recLevel,0);
   $withComments   = setDefault($withComments,$TRUE);
   $recLevel++;
   my @patterns   = split('\*',$includePattern);
   my $startMark  = $patterns[0];
   my $endeMark   = $patterns[1];
   my @retList    = ();
   my $aLine      = "";
   my $fh         = "FILE_${recLevel}";
   open($fh,$infile) || showError("Can't open (readFileWithIncludes) infile:${infile}: $!");
   while (defined ($aLine = <$fh>)) {
     chomp($aLine);
     if ($aLine =~ $startMark) {
        my $fNameStart = index($aLine,$startMark)+length($startMark);
        my $filename   = substr($aLine,$fNameStart);
        my $fNameEnd   = index($filename,$endeMark);
        $filename      = "${includePath}".substr($filename,0,$fNameEnd);
        my @linesFromInclude = readFileWithIncludes($filename,$includePattern,$recLevel,$withComments,$includePath);
        @retList = concatArray(@retList,@linesFromInclude);
     } else {
     	if ($withComments) {
     	    push(@retList,$aLine);	
     	} else {
  	    if (($aLine =~ /^#/) || ($aLine =~ /^\s+$/) || (length($aLine) == 0)) {
                ### print("Skip:${aLine}:\n",);
            } else {
                push(@retList,$aLine);
            }
        }
     }
   }
   close($fh);
   return @retList;
}

# See readFile but replaces placeholder specified in %transTab
# The Placeholder can also be a full fuction call
# 
# e.g.
# %transList = (
#    "{normalerPlaceholder}"                      => "NORMAL",
# );
# 
# $fileContent = "Dies ist ein {normalerPlaceholder} Placeholder and that is the result ({CallUserFctHidden:sayHalloWalti(1,\"Walterli\",\"Me,Too\")}) of a function call";
sub readFileAndTranslate {
   my($filename,$fromLine,$toLine,$trace,%transTab)   = @_;
   $fromLine = setDefault($fromLine,1);
   $toLine   = setDefault($toLine  ,-1);
   $trace    = setDefault($trace   ,$FALSE);

   my(@orgLines)   = readFile($filename,$fromLine,$toLine,$trace);
   my(@retList)    = ();
   my($aLine)      = "";
   foreach $aLine (@orgLines) {
      my($newLine) = replacePlaceholdersStr($aLine,%transTab);
      push(@retList,$newLine);
   }
   return @retList;
}


# reads a file and returns the lines between $startMarker and $endMarker
#     $withMarkers returns the startMarker and endMarker line to  Default: $FALSE
#     $markerIsPartOfLine   Default: $FALSE
#            if TRUE  -> marker needs to be substr of line
#               FALSE -> marker has to be equal to the whole line
sub readFileBetweenMarkers {
	my($filename,$startMarker,$endMarker,$withMarkers,$markerIsPartOfLine,$trace,$debug)   = @_;
	$withMarkers        = setDefault($withMarkers,       $FALSE);
	$markerIsPartOfLine = setDefault($markerIsPartOfLine,$FALSE);
	$trace              = setDefault($trace,             $FALSE);
	$debug              = setDefault($debug,             $FALSE);
	
	my @retList    = ();
	my $aLine      = "";

	if ($debug) {
		print("filename          :${filename}:\n");
		print("startMarker       :${startMarker}:\n");
		print("endMarker         :${endMarker}:\n");
		print("withMarkers       :${withMarkers}:\n");
		print("markerIsPartOfLine:${markerIsPartOfLine}:\n");
		print("trace             :${trace}:\n");
	}

	my $betweenMarker  = $FALSE;
	my $finito         = $FALSE;
	open(FILE_readFileBetweenMarkers,$filename) || showError("Error (readFileBetweenMarkers): Can't open file:${filename}: $!");
	while (defined ($aLine = <FILE_readFileBetweenMarkers>)) {
		chomp($aLine);
		### if ($trace) { print("------>:${aLine}:\n"); }
		if (!($finito)) {
			if ((($aLine eq $startMarker) && (!($markerIsPartOfLine))) ||
				(($aLine =~ $startMarker) &&   ($markerIsPartOfLine))) {
					$betweenMarker = $TRUE;
					if ($withMarkers) {
						push(@retList,$aLine);
						if ($trace) {
							print("${aLine}\n");
						}
					}
			} elsif ((($aLine eq $endMarker) && (!($markerIsPartOfLine))) ||
					(($aLine =~ $endMarker) &&   ($markerIsPartOfLine))) {
					$betweenMarker = $FALSE;
					if ($withMarkers) {
						push(@retList,$aLine);
						if ($trace) {
							print("${aLine}\n");
						}
					}
					$finito = $TRUE
			} elsif ($betweenMarker) {
				push(@retList,$aLine);
				if ($trace) {
					print("${aLine}\n");
				}
			}
		}
	}
	close(FILE_readFileBetweenMarkers);
	return @retList;
}

# See readFileBetweenMarkers but replaces placeholder specified in %transTab
# The Placeholder can also be a full fuction call
# 
# e.g.
# %transList = (
#    "{normalerPlaceholder}"                      => "NORMAL",
# );
# 
# $fileContent = "Dies ist ein {normalerPlaceholder} Placeholder and that is the result ({CallUserFctHidden:sayHalloWalti(1,\"Walterli\",\"Me,Too\")}) of a function call";
sub readFileBetweenMarkersAndTranslate {
   my($filename,$startMarker,$endMarker,$withMarkers,$markerIsPartOfLine,$trace,%transTab)   = @_;
   $withMarkers        = setDefault($withMarkers,       $FALSE);
   $markerIsPartOfLine = setDefault($markerIsPartOfLine,$FALSE);
   $trace              = setDefault($trace,             $FALSE);

   my(@orgLines)   = readFileBetweenMarkers($filename,$startMarker,$endMarker,$withMarkers,$markerIsPartOfLine,$FALSE);
   my(@retList)    = ();
   my($aLine)      = "";
   foreach $aLine (@orgLines) {
      my($newLine) = replacePlaceholdersStr($aLine,%transTab);
      push(@retList,$newLine);
      if ($trace) {
        print("${newLine}\n");
      }
   }
   return @retList;
}

# reads a file and returns the lines between "Start_${marker}" and "End_${marker}".
# These string can be part of the line
sub readFilePart {
   my($filename,$marker,$withMarkers,$markerIsPartOfLine,$trace)   = @_;
   $withMarkers            = setDefault($withMarkers,       $FALSE);
   $markerIsPartOfLine     = setDefault($markerIsPartOfLine,$TRUE);
   $trace                  = setDefault($trace,             $FALSE);
   my($startMarker)        = "Start_${marker}";
   my($endMarker)          = "End_${marker}";
   my(@retList)      = readFileBetweenMarkers($filename,$startMarker,$endMarker,$withMarkers,$markerIsPartOfLine,$trace);
   return @retList;
}

# See readFilePart but replaces placeholder specified in %transTab
# The Placeholder can also be a full fuction call
# 
# e.g.
# %transList = (
#    "{normalerPlaceholder}"                      => "NORMAL",
# );
# 
# $fileContent = "Dies ist ein {normalerPlaceholder} Placeholder and that is the result ({CallUserFctHidden:sayHalloWalti(1,\"Walterli\",\"Me,Too\")}) of a function call";
sub readFilePartAndTranslate {
   my($filename,$marker,$withMarkers,$markerIsPartOfLine,$trace,%transTab)   = @_;
   $withMarkers            = setDefault($withMarkers,       $FALSE);
   $markerIsPartOfLine     = setDefault($markerIsPartOfLine,$TRUE);
   $trace                  = setDefault($trace,             $FALSE);

   my(@orgLines)   = readFilePart($filename,$marker,$withMarkers,$markerIsPartOfLine,$FALSE);
   my(@retList)    = ();
   my($aLine)      = "";
   foreach $aLine (@orgLines) {
      my($newLine) = replacePlaceholdersStr($aLine,%transTab);
      push(@retList,$newLine);
      if ($trace) {
        print("${newLine}\n");
      }
   }
   return @retList;
}

# posible $conditions writes to archive everything where:
#  eq: $fieldToTest  = $value
#  ne: $fieldToTest != $value
#  gt: $fieldToTest  > $value
#  ge: $fieldToTest >= $value
#  lt: $fieldToTest  < $value
#  le: $fieldToTest <= $value
sub archiveDate {
  my($infileName,$sepChar,$outfileName,$fieldToTest,$value,$condition) = @_;

  my($infileNameTmp)    = "${infileName}_TMP";
  my(@headers)          = ();
  my($fieldIndexToTest) = -1;
  open(INFILE_archiveDate,      "${infileName}")   || showError("Error (archiveDate): Can't open infile:${infileName}: $!");
  open(ARCHIVE_archiveDate,   ">${outfileName}")   || showError("Error (archiveDate): Can't open outfile:${outfileName}: $!");
  open(NEWCURRENT_archiveDate,">${infileNameTmp}") || showError("Error (archiveDate): Can't open infileNameTmp:${infileNameTmp}: $!");
  my($first) = $TRUE;
  while (defined($aLine = <INFILE_archiveDate>)) {
    chomp($aLine);
    #just copy comment and blank lines
    if (($aLine =~ /^#/) || ($aLine =~ /^\s+$/) || (length($aLine) == 0)) {
         print(ARCHIVE_archiveDate    "${aLine}\n");
         print(NEWCURRENT_archiveDate "${aLine}\n");
    } else {
         if ($first) {  # Copy Header-Line
             print(ARCHIVE_archiveDate    "${aLine}\n");
             print(NEWCURRENT_archiveDate "${aLine}\n");
             @headers = split(/$sepChar/,$aLine);
             my($aHeader) = "";
             my($i) = 0;
             foreach $aHeader (@headers) {
                if ($aHeader eq $fieldToTest) {
                   $fieldIndexToTest = $i;
                }
                $i++;
             }
             if ($fieldIndexToTest eq "-1") {
                print("<!-- Error: In archiveDate: No field with name :${fieldToTest}: -->\n");
             }
             #### print("fieldIndexToTest:${fieldIndexToTest}:<BR>\n");
             $first = $FALSE;
         } else {
             my(@lineParts) = split(/$sepChar/,$aLine);
             if ($condition eq "le") {
                  if ($lineParts[$fieldIndexToTest] le $value) {
                     print(ARCHIVE_archiveDate    "${aLine}\n");
                  } else {
                     print(NEWCURRENT_archiveDate "${aLine}\n");
                  }  
             }
             if ($condition eq "lt") {
                  if ($lineParts[$fieldIndexToTest] lt $value) {
                     print(ARCHIVE_archiveDate    "${aLine}\n");
                  } else {
                     print(NEWCURRENT_archiveDate "${aLine}\n");
                  }  
             }
             if ($condition eq "eq") {
                  if ($lineParts[$fieldIndexToTest] eq $value) {
                     print(ARCHIVE_archiveDate    "${aLine}\n");
                  } else {
                     print(NEWCURRENT_archiveDate "${aLine}\n");
                  }  
             }            
             if ($condition eq "ne") {
                  if ($lineParts[$fieldIndexToTest] ne $value) {
                     print(ARCHIVE_archiveDate    "${aLine}\n");
                  } else {
                     print(NEWCURRENT_archiveDate "${aLine}\n");
                  }  
             }            
             if ($condition eq "gt") {
                  if ($lineParts[$fieldIndexToTest] gt $value) {
                     print(ARCHIVE_archiveDate    "${aLine}\n");
                  } else {
                     print(NEWCURRENT_archiveDate "${aLine}\n");
                  }  
             }            
             if ($condition eq "ge") {
                  if ($lineParts[$fieldIndexToTest] ge $value) {
                     print(ARCHIVE_archiveDate    "${aLine}\n");
                  } else {
                     print(NEWCURRENT_archiveDate "${aLine}\n");
                  }  
             }            
         }
    }
  }
  close(NEWCURRENT_archiveDate);
  close(ARCHIVE_archiveDate);
  close(INFILE_archiveDate);
  unlink($infileName);
  rename($infileNameTmp,$infileName);
  unlink($infileNameTmp);
}

# encrypt / decrypt a file using $key
#
# cryptPath can be defined if the crypt command is not in the PATH
sub cryptUNIXFile {
   my($inName,$outName,$key,$removeSourceFile) = @_;
   my($tmpFileName)   = "${inName}_XXXXcryptedXXXX";
   $outName           = setDefault($outName,$tmpFileName);
   $key               = setDefault($key,"007WalterRothlin");
   $removeSourceFile  = setDefault($removeSourceFile,$FALSE);
   $key               = reverseStr($key);
   ### print("key:${key}:\n");
   ## my $cmd  = "crypt \"$key\" <${inName} >${outName}";
   my $cmd  = "${cryptPath}crypt \"$key\" <${inName} >${outName}";

   my $msg = `$cmd`;
   if ($outName eq $tmpFileName) {
     rename($outName,$inName);
     unlink $tmpFileName
   }
   if ($removeSourceFile) {
     unlink $inName;
   }
}

# converts an txt (TAB separated file) to a flt (| or ; separated file)
# default sepChar is ;
# if no $outfileName is specified the infileName with the extension "flt" is taken
sub convertTXT_to_FLT {
  my($infileName, $sepChar, $outfileName, $trimFields, $stripDoubleQuotes) = @_;
  $sepChar           = setDefault($sepChar,";");
  $outfileName       = setDefault($outfileName,setNewFilenameExtension($infileName,"flt"));
  $trimFields        = setDefault($trimFields,$FALSE);
  $stripDoubleQuotes = setDefault($stripDoubleQuotes,$FALSE);
  my($iLine)   = "";

  ### print("sepChar:${sepChar}:\n");
  ### print("infileName:${infileName}:\n");
  ### print("outfileName:${outfileName}:\n");
  open(INF_convertTXT_to_FLT,"${infileName}")    || showError("ERROR (convertTXT_to_FLT): Can't open infile:${infileName}: $!");
  open(OUTF_convertTXT_to_FLT,">${outfileName}") || showError("ERROR (convertTXT_to_FLT): Can't open outfile:${outfileName}: $!");
  while (defined($iLine = <INF_convertTXT_to_FLT>)) {
    chomp($iLine);
    if (($iLine =~ /^#/) || ($iLine =~ /^\s+$/) || (length($iLine) == 0)) {
         ## print("Skip:${iLine}:\n",);
    } else {
         if (($trimFields) || ($stripDoubleQuotes)) {
           my(@fields) = split("\t",$iLine);
           if ($trimFields) {
             @fields = trimArray(@fields);
           }
           if ($stripDoubleQuotes) {
             my (@stripped) = ();
             foreach my $element (@fields) {
               $element =~ s/\"//g;
               @stripped = (@stripped, $element);
             }
             @fields = @stripped;
           }
           $iLine = makeStrFromArray("\t",@fields);
         }
         $iLine =~ s/\t/$sepChar/g;
    }
    print(OUTF_convertTXT_to_FLT "${iLine}\n");
  } # end of while
  close(OUTF_convertTXT_to_FLT);
  close(INF_convertTXT_to_FLT);
}

sub replaceDelimiterByTAB {
  my($infileName,$outfileName,$sepChar) = @_;
  my($iLine)   = "";

  open(INF_replaceDelimiterByTAB,"${infileName}") || showError("ERROR (replaceDelimiterByTAB): Can't open infile:${infileName}: $!");
  open(OUTF_replaceDelimiterByTAB,">${outfileName}") || showError("ERROR (replaceDelimiterByTAB): Can't open outfile:${outfileName}: $!");
  while (defined($iLine = <INF_replaceDelimiterByTAB>)) {
    chomp($iLine);
    if ($sepChar eq ";") {
       $iLine =~ s/$sepChar/\t/g;
    } else {
       $iLine =~ s/\|/\t/g;
    }
    print(OUTF_replaceDelimiterByTAB "${iLine}\n");
  } # end of while
  close(OUTF_replaceDelimiterByTAB);
  close(INF_replaceDelimiterByTAB);
}

# converts an flt (| or ; separated file) to txt (TAB separated file) to 
# default sepChar is ;
# if no $outfileName is specified the infileName with the extension "txt" is taken
sub convertFLT_to_TXT {
  my($infileName, $sepChar, $outfileName) = @_;
  $sepChar     = setDefault($sepChar,";");
  $outfileName = setDefault($outfileName,setNewFilenameExtension($infileName,"txt"));
  replaceDelimiterByTAB($infileName,$outfileName,$sepChar);
}

# converts an flt (| or ; separated file) to txt (TAB separated file) 
# default sepChar is |
# if no $outfileName is specified the infileName with the extension "xls" is taken
sub convertFLT_to_XLS {
  my($infileName,$outfileName,$sepChar) = @_;
  $sepChar     = setDefault($sepChar,getSepCharFromTable($infileName,$TRUE));
  $outfileName = setDefault($outfileName,setNewFilenameExtension($infileName,"xls"));
  replaceDelimiterByTAB($infileName,$outfileName,$sepChar);
}

# replaces \n with \n\r
sub convertFromUNIX_ASCII_to_DOS_ASCII {
   my($infileName,$outfileName) = @_;
   open(IN_convertFromUNIX_ASCII_to_DOS_ASCII,$infileName) || showError("Error (convertFromUNIX_ASCII_to_DOS_ASCII): Can't open infile:${infileName}: $!");
   open(OUT_convertFromUNIX_ASCII_to_DOS_ASCII,">$outfileName") || showError("Error (convertFromUNIX_ASCII_to_DOS_ASCII): Can't open oufile:${outfileName}: $!");
   while (defined ($aLine = <IN_convertFromUNIX_ASCII_to_DOS_ASCII>)) {
     chomp($aLine);
     print(OUT_convertFromUNIX_ASCII_to_DOS_ASCII "${aLine}\r\n");
   }
   close(OUT_convertFromUNIX_ASCII_to_DOS_ASCII);
   close(IN_convertFromUNIX_ASCII_to_DOS_ASCII);
}


# replaces \n\r with \n
sub dos2unix {
	my($aFileName) = @_;
	my @lines     = removeCRFromArrayEntries(chompArrayEntries(readArrayFromFile($aFileName)));	
	writeArrayToFileType($aFileName,$FALSE,"",@lines);
}

# replaces \n\r with \n
sub convertFromDOS_ASCII_to_UNIX_ASCII {
   my($infileName,$outfileName) = @_;
   open(IN_convertFromDOS_ASCII_to_UNIX_ASCII,$infileName) || showError("Error (convertFromDOS_ASCII_to_UNIX_ASCII): Can't open infile:${infileName}: $!");
   open(OUT_convertFromDOS_ASCII_to_UNIX_ASCII,$outfileName) || showError("Error (convertFromDOS_ASCII_to_UNIX_ASCII): Can't open oufile:${outfileName}: $!");
   while (defined ($aLine = <IN_convertFromDOS_ASCII_to_UNIX_ASCII>)) {
     chomp($aLine);
     print(OUT_convertFromDOS_ASCII_to_UNIX_ASCII "${aLine}\n");
   }
   close(OUT_convertFromDOS_ASCII_to_UNIX_ASCII);
   close(IN_convertFromDOS_ASCII_to_UNIX_ASCII);
}


# produces out of a comma separated file an flt file using $delimChar
sub convertCSV_to_FLT {
   my($infileName,$outfileName,$delimChar) = @_;
   if ($delimChar ne ";") {
     $delimChar = "\|";
   }

   open(IN_convertCSV_to_FLT,$infileName) || showError("Error (convertCSV_to_FLT): Can't open infile:${infileName}: $!");
   open(OUT_convertCSV_to_FLT,">$outfileName") || showError("Error (convertCSV_to_FLT): Can't open oufile:$outfileName}: $!");
   while (defined ($aLine = <IN_convertCSV_to_FLT>)) {
     chomp($aLine);
     my(@lineParts) = parse_csv($aLine);
     my($newLine) = "";
     my($aPart)   = "";
     my($first)   = $TRUE;
     foreach $aPart (@lineParts) {
        if ($first) {
          $newLine = $aPart;
          $first = $FALSE;
        } else {
          $newLine = "${newLine}${delimChar}${aPart}";
        }
     }
     print(OUT_convertCSV_to_FLT "${newLine}\n");
   }
   close(OUT_convertCSV_to_FLT);
   close(IN_convertCSV_to_FLT);
}

sub removeSpecialCharFromHeaderLineNoNewFile {
   my($infileName,$sepChar) = @_;
   my $tmpOutName = putTimeStampInFileName($infileName);
   removeSpecialCharFromHeaderLine($infileName,$tmpOutName,$sepChar);
   unlink($infileName);
   rename($tmpOutName,$infileName);
   ## unlink($tmpOutName);
}

sub removeSpecialCharFromHeaderLine {
   my($infileName,$outfileName,$sepChar) = @_;
   my($sep) = $sepChar;
   if ($sepChar ne ";") {
     $sep = "|";
     $sepChar = "\\|";
   }
   open(IN_removeSpecialCharFromHeaderLine,$infileName) || showError("Error (removeSpecialCharFromHeaderLine): Can't open infile:${infileName}: $!");
   open(OUT_removeSpecialCharFromHeaderLine,">$outfileName") || showError("Error (removeSpecialCharFromHeaderLine): Can't open oufile:${outfileName}: $!");
   my($headerFound) = $FALSE;
   while (defined ($aLine = <IN_removeSpecialCharFromHeaderLine>)) {
     chomp($aLine);
     my($newLine) =  $aLine;
     if (($newLine =~ /^#/) || ($newLine =~ /^\s+$/) || (length($newLine) == 0)) {
         print(OUT_removeSpecialCharFromHeaderLine "${newLine}\n");
     } else {
         if ($headerFound) { 
            print(OUT_removeSpecialCharFromHeaderLine "${newLine}\n");
         } else {
            my(@headerParts) = split($sepChar,$newLine);
            my($aHeader) = "";
            my($first)   = $TRUE;
            foreach $aHeader (@headerParts) {
                $aHeader =~ s/\W//g;
                if ($first) {
                   $newLine = $aHeader;
                   $first   = $FALSE;
                } else {
                   $newLine = "${newLine}${sep}${aHeader}";
                }
            }
            $headerFound = $TRUE;
            print(OUT_removeSpecialCharFromHeaderLine "${newLine}\n");
         }
     }
   }
   close(OUT_removeSpecialCharFromHeaderLine);
   close(IN_removeSpecialCharFromHeaderLine);
}

# returns the count of lines in that file
sub countLinesInFile {
   my($filename)   = @_;
   my(@lineList)   = ();
   my($retValue)   = "";

   @lineList = readFile($filename);
   $retValue = @lineList;
   return  $retValue;
}

# like the unix more command
sub more {
   my($filename,$pageSize,$doLineCount)   = @_;
   $pageSize    = setDefault($pageSize,23);
   $doLineCount = setDefault($doLineCount,$TRUE);
   my($lineCount)     = 1;
   my($totLineCount)  = 1;
   open(FILE_more,$filename) || showError("Error (more): Can't open file:${filename}: $!");
   while (defined ($aLine = <FILE_more>)) {
     chomp($aLine);
     if ($lineCount > $pageSize) {
        $lineCount = 1;
        halt();
     }
     if ($doLineCount) {
        print("${totLineCount}:${aLine}\n");
     } else {
        print("${aLine}\n");
     }
     $lineCount++;
     $totLineCount++;
   }
   close(FILE_more);
}

# used to stream back a pdf file
sub sendBackPdfFile {
   my($filename)   = @_;
   pdfMimeType();
   open(FILE_sendBackPdfFile,$filename) || showError("Error (sendBackPdfFile): Can't open infile:${filename}: $!");
   while (defined ($aLine = <FILE_sendBackPdfFile>)) {
          print("${aLine}");
   }
   close(FILE_sendBackPdfFile);
}

sub sendBackPdfFileContent {
   my($pdfFileContent)   = @_;
   pdfMimeType();
   print("${pdfFileContent}");
}

sub sendBackFileWithMimeType {
   my($filename)   = @_;
   $fileExtension  = getFileNameExtension($filename);
   my $sepChar = getSepCharFromTable($filename,$FALSE);
   mimeTypeUsingFileExtension($fileExtension,$filename);
   open(FILE_sendBackFileWithMimeType,$filename) || showError("Error (sendBackFileWithMimeType): Can't open infile:${filename}: $!");
   while (defined ($aLine = <FILE_sendBackFileWithMimeType>)) {
     if ($fileExtension eq "flt") {
        if ($sepChar eq ";") {
           $aLine =~ s/;/\t/g;
        } else {
           $aLine =~ s/\|/\t/g;
        }
     }
     print("${aLine}");
   }
   close(FILE_sendBackFileWithMimeType);
}

sub sendBackFileContentWithMimeType {
   my($anyFileContent,$fileExtension)   = @_;
   mimeTypeUsingFileExtension($fileExtension);
   print("${anyFileContent}");
}



# Function to process Word prn files and produce a well formated Post-Script file
# -------------------------------------------------------------------------------
# Modifies a Word prn file (PostScript) to a post-Script where the placeholders are as string together.
# It does not make any changes in the format nor the context, just reformate the Post-Script file that
# the placeholders can be searched or greped.
#
# The placeholder ist everything between >xxxxxx> (Default) or {xxxxxxx}
#
sub convertWordPrnToPsFile {
    my($inFileName,$outFileName,$silent,$convertWordPrnToPsFile_startChar,$convertWordPrnToPsFile_endChar) = @_;
    $silent = setDefault($silent,$TRUE);
    $convertWordPrnToPsFile_startChar = setDefault($convertWordPrnToPsFile_startChar,">");
    $convertWordPrnToPsFile_endChar   = setDefault($convertWordPrnToPsFile_endChar,">");


    my $outFileName_1   = "${outFileName}_tmp";
    my $adobeMarkFound  = 0;
    my $firstPos        = "";
    my $secPos          = "";
    my $skip            = 0;
    my $inPlaceholder   = 0;
    my $startState      = 0;
	   
    if (!($silent)) { print("Converter: ${inFileName} --> ${outFileName}\n"); }
    open(OUTFILE,">${outFileName_1}") || die("ERROR: Can't open outfile: $outFileName_1 : $!");
    open(INFILE,$inFileName) || die("ERROR: Can't open infile: $inFileName : $!");
    while (defined($line = <INFILE>)) {
	   if (!($line =~ /\(.\)/)) {
	       if ($adobeMarkFound) {
		      print(OUTFILE "${line}");
           } else {
		      if ($line =~ /^..PS-Adobe/) {
	             print(OUTFILE "${line}");
	             $adobeMarkFound = 1;
			  }
		   }
		   next;
       }
       chomp($line);
       @lineParts=split(/ /,$line);
       foreach $linePart (@lineParts) {
           if ($skip > 0) {
              $skip -= 1;
              next;
           } # end of skip 

           if ($startState == 1) {
              $secPos = $linePart;
              $startState = 0;
              next;
           }
                   
           if (isPlaceHolderStartOrEndIn_wordHidden($linePart,$convertWordPrnToPsFile_startChar,$convertWordPrnToPsFile_endChar)) {
              $inPlaceholder = ! $inPlaceholder;
              if ($inPlaceholder) {
                print(OUTFILE "(${convertWordPrnToPsFile_startChar}");
                @startParts=split(/\)/,$linePart);
                $firstPos = $startParts[1];
                $startState=1;
                next;
             } else {
                print(OUTFILE "${convertWordPrnToPsFile_endChar})${firstPos} ${secPos} MS\n");
                $firstPos = "";
                $secPos = "";
                $skip += 2;
                next;
             } 
           }
                   
           if ($inPlaceholder) {
               picupBracketValues_wordHidden($linePart);
           } else {
               print(OUTFILE "${linePart} ");
           } # end if
        } # end of loop lineparts
        if (!($inPlaceholder)) {
           print(OUTFILE "\n");
        }
    } # end of input file
    close(INFILE);
	if (!($adobeMarkFound)) {
	  if (!($silent)) { print("No PS-Adobe mark found at the beginning of PostScript file ${inFileName}\n"); }
	}
    close(OUTFILE);


    # make more line breaks otherwise SCCS or some editors got a problem
    open(OUTFILE,">${outFileName}") || die("ERROR: Can't open outfile: $outFileName : $!");
    open(INFILE,$outFileName_1) || die("ERROR: Can't open infile: $outFileName_1 : $!");
    while (defined($line = <INFILE>)) {
       chomp($line);
       $line =~ s/ MS \(/ MS\n\(/g;
       print(OUTFILE "${line}\n");
    }
    close(INFILE);
    close(OUTFILE);
    unlink($outFileName_1);

} # end of convertWordPrnToPsFile

# Picks-Up the printed char between the postscript code. (Y)786 --> Y
sub picupBracketValues_wordHidden {
    my($aString)=@_;
    if ($aString =~ /\(.\)/) {
        @parts_1=split(/\(|\)/,$aString);
        ## printf ("----> %s\n",$parts_1[1]);
        print(OUTFILE $parts_1[1]);
    } 
} # end of picupBracket

# returns true string includes a (>) string
sub isPlaceHolderStartOrEndIn_wordHidden {
     my($aString,$convertWordPrnToPsFile_startChar,$convertWordPrnToPsFile_endChar)=@_;
     return (($aString =~ /($convertWordPrnToPsFile_startChar)/) || ($aString =~ /($convertWordPrnToPsFile_endChar)/));
} # end of isPlaceHolderStartOrEndIn



############################################################################
# Function for specific applications and user groups
############################################################################
sub showMenu_HabaEinsatzplan {
   print("This function creates the calendar grid (2 files) for Haba-Einsatzplan\n");
   my $startDate = readln("Start-Date (Montag) (YYYYMMDD)","20040105");
   my $endDate   = readln("End-Date   (YYYYMMDD)","20040710");
   my $fileName1 = readln("Anlass    Filename","habaDienst_anlass.flt");
   my $fileName2 = readln("Zuteilung Filename","habaDienst_zuteilung.flt");
   produceAnlassHabaFiles($startDate,$endDate,$fileName1,$fileName2);
   halt();
}

sub produceAnlassHabaFiles {
   my($startDate1_YYYYMMDD,$endDate_YYYYMMDD,$outFilename1,$outFilename2,$startDate2_YYYYMMDD,$sorterStart,$sorterInc,$hashStart,$hashInc) = @_;
   $startDate2_YYYYMMDD       = setDefault($startDate2_YYYYMMDD,daysAddToYYYYMMDD($startDate1_YYYYMMDD,6));
   $sorterStart               = setDefault($sorterStart,2000);
   $sorterInc                 = setDefault($sorterInc,100);
   $hashStart                 = setDefault($hashStart,10);
   $hashInc                   = setDefault($hashInc,1);
   $outFilename1              = setDefault($outFilename1,"habaDienst_anlass.flt");
   $outFilename2              = setDefault($outFilename2,"habaDienst_zuteilung.flt");



   open(TABFILE_produceAnlassHabaFiles,">${outFilename1}") || showError("ERROR (produceAnlassHabaFiles): Can't open file:${outFilename1}: $!");
   open(TABFILE_produceZuteilungHabaFiles,">${outFilename2}") || showError("ERROR (produceAnlassHabaFiles): Can't open file:${outFilename2}: $!");

   print(TABFILE_produceAnlassHabaFiles"Hash\|Beschreibung\|Sorter\|ModBy\|ModAt\n");
   print(TABFILE_produceZuteilungHabaFiles"Coordinates\|Zuteilung\|ModBy\|ModAt\n");
   my $yCoord = 1;
   while ($startDate1_YYYYMMDD < $endDate_YYYYMMDD) {

       print(TABFILE_produceAnlassHabaFiles "${hashStart}\|<CENTER><BR><font size=-1>".formatTimeStamp($startDate1_YYYYMMDD,"EUR",$FALSE,$FALSE)." - ".formatTimeStamp($startDate2_YYYYMMDD,"EUR",$FALSE,$FALSE)."\|${sorterStart}\|Walter_Rothlin\|\|\n"); 


       # generate zuteilung entry
       my $dienstDate = daysAddToYYYYMMDD($startDate1_YYYYMMDD,1);
       my $dienstDateFormated = formatTimeStamp($dienstDate,"EUR",$FALSE,$FALSE);
       print(TABFILE_produceZuteilungHabaFiles "${yCoord}__1\|OFF:HTML:\<TD bgcolor=yellow\>${dienstDateFormated}\</TD\>\|Walter_Rothlin\|\n"); 
       print("${dienstDateFormated}\n");

       $dienstDate = daysAddToYYYYMMDD($startDate1_YYYYMMDD,4);
       $dienstDateFormated = formatTimeStamp($dienstDate,"EUR",$FALSE,$FALSE);
       print(TABFILE_produceZuteilungHabaFiles "${yCoord}__4\|OFF:HTML:\<TD bgcolor=yellow\>${dienstDateFormated}\</TD\>\|Walter_Rothlin\|\n"); 
       print("${dienstDateFormated}\n");



       $startDate1_YYYYMMDD = daysAddToYYYYMMDD($startDate1_YYYYMMDD,7);
       $startDate2_YYYYMMDD = daysAddToYYYYMMDD($startDate2_YYYYMMDD,7);
       $hashStart   = $hashStart   + $hashInc;
       $sorterStart = $sorterStart + $sorterInc;
       $yCoord++;
   }

   close(TABFILE_produceZuteilungHabaFiles);
   close(TABFILE_produceAnlassHabaFiles);

   print("--> ${outFilename1} written\n");
   print("--> ${outFilename2} written\n");   	
}

############################################################################
# Function to call a function (with parameters) dynamic (variable contains the call)
############################################################################
# e.g.
# $aFctName = "sayHalloWalti(1,\"Walterli\",\"Me,Too\")";
# callFunction($aFctName);
# callFunction("sayHalloClaudia");
# 
# 
# 
# sub sayHalloWalti {
#    my($aNum,$name,$comment) = @_;
#    print("Hallo ${name} ${aNum} ${comment}\n");
# }
# 
# sub sayHalloClaudia {
#    print("Hallo Claudia\n");
# }
#
sub callFunction {
	my($fctCallString) = @_;
	my $fctName = refCallGetFunctionName($fctCallString);
	my $parameterString = refCallGetParameterStringFromCall($fctCallString);
	### print(" fctCallString:${fctCallString}:\n fctName:${fctName}:\n parameterString:${parameterString}:\n");
	my(@parameter) = parse_csv($parameterString);
	### displayArray(@parameter);
	if (defined &$fctName) {
		return &$fctName(@parameter);
	} else {
		return "##(!!## WARNING: Function (${fctName}) not found! ##!!)##";
	}
}

sub execPerlFct {
	my($fctNameToCall, @param) = @_;
	$CallUserFct  = "Fct";

	if (stringStartsWith($fctNameToCall,"=",$TRUE)) {
		return eval(substr($fctNameToCall,1));
	} elsif (stringStartsWith($fctNameToCall,"{${CallUserFct}:",$TRUE)) {
		# print("fctNameToCall:${fctNameToCall}:\n");
		return replaceFctCallHidden($fctNameToCall,0);
	} else {
		return &$fctNameToCall(@param);
	}
}


sub refCallGetFunctionName {
   my($fctCallString) = @_;
   if (index($fctCallString,"(") == -1) {
       return $fctCallString;
   } else {
       return substr($fctCallString,0,index($fctCallString,"("));
   }
}

sub refCallGetParameterStringFromCall {
   my($fctCallString) = @_;
   if (index($fctCallString,"(") == -1) {
       return "";
   } else {
       return substr($fctCallString,index($fctCallString,"(")+1,length($fctCallString)-index($fctCallString,"(")-2);
   }
}

sub isPlaceholderFunctionCall {
   my($placeholder) = @_;

   
}



############################################################################
# Function for handling cgi
############################################################################
# reads a parameter and returns its value unless the parameter has not been
# defined in the form it return a default value
sub getParam {
    my($fieldName,$defaultValue) = @_;
    my($paramVal) = param($fieldName);
    my($retValue) = "";
    if (defined ($paramVal)) {
       $retValue = $paramVal;
    } else {
       $retValue = $defaultValue;
    }
    return $retValue;
} # end of getParam

# reads a parameter and returns its value unless the parameter has not been
# defined in the form it return a default value. If there are any separator
# character in the input field they will replaced by the $repChar
sub getParamRem {
    my($fieldName,$defaultValue,$sepChr,$repChr) = @_;
    $newVal = getParam($fieldName,$defaultValue);
    ### print("getParamRem (1):${sepChr}:${repChr}::${newVal}:<BR>\n");
    if ($sepChr eq ";") {
      $newVal =~ s/\;/$repChr/g;
    } else {
      $newVal =~ s/\|/$repChr/g;
    }
    ### print("getParamRem:${newVal}:<BR>\n");
    return $newVal;
} # end of getParamRem

sub getParameterNames {
  my($pattern) = @_;
  my($query) = new CGI;
  my(@names) = $query->param;
  if ($pattern ne "") {
    my @tmpNames = ();
    foreach $aParamName (@names) {
      if (index($aParamName,$pattern) != -1) {
        push(@tmpNames,$aParamName);
      }
    }
    @names = @tmpNames;
  }
  return @names;
}

sub isItProbablyAnMS_Browser {
   my($userAgent) = $ENV{"HTTP_USER_AGENT"};
   return ($userAgent =~ /MSIE/);
   HTTP_USER_AGENT
}

# echo's back all received data (parameters) as an HTML page back to the client
sub echo {
  print("<html><head><title>CGI-Feedback</title></head>\n");
  print("<body><h1>CGI-Feedback</h1>\n");
  if ($ENV{"REQUEST_METHOD"} eq "GET") {
    print("Daten wurden via <B>QUERY_STRING (GET)</b> uebertragen<br>\n");
    printf("<STRONG>Query-String:</STRONG> %s<br>\n",    $ENV{"QUERY_STRING"});
  } else {
    print("Daten wurden via <B>Standart-Input (POST)</b> uebertragen<br>\n");
  }
  if (isItProbablyAnMS_Browser()) {
     print("You probably use an Microsoft Browser\n");
  } else {
     print("You use another Browser than a Microsoft\n");
  }
  print("<HR><H3>Request spezifische Informationen</H3>");
  displayHashTableHTML(%ENV);
  print("<HR><H3>Parameters passed</H3>\n");
  my(@names) = getParameterNames();
  my($aName) = "";
  my(%paramsPairs) = ();
  foreach $aName (@names) {
     my($aValue) = param($aName);
     %paramsPairs = (%paramsPairs,($aName,$aValue));
  }
  displayHashTableHTML(%paramsPairs);
  print("<HR>\n");
  print("</body></html>\n");
}


# Decode a cgi string (Replaces %xx with the real character  TBS TBS
sub cgiDecodeStr {
   my($inStr)   = @_;
   my($retStr)  = $inStr;
   %DecodeToAscii = swapHash(%AsciiToDecode);
   $retStr = replacePlaceholdersStr($inStr,);
   return $retStr;
}

# Encode a cgi string (Replaces real character with the %xx  TBS TBS
sub cgiEncodeStr {
   my($inStr)   = @_;
   my($retStr)  = $inStr;
   $retStr = replacePlaceholdersStr($inStr,%AsciiToDecode);
   return $retStr;
}

sub cgiEncode {
   my($inChr)   = @_;
   my($retChr)  = $inChr;
   if ($inChr eq "=") {
      $retChr = "%3D";
   }
   return $retChr;
}

sub urlEncode {
	my($string) = @_;	
	my($result) = "";
	$result = CGI::escape($string);
	$result =~ s/\./\%2E/g;
	return $result;
}

# pass a cgi str (name=value&name=value...) and returns for each pair
# a input hidden field
sub produceHiddenField {
   my($paramStr,$padStr)   = @_;
   my($retStr)  = "";
   my($aNameValPair) = "";
   my(@nameValPairs) = split(/\&/,$paramStr);
   foreach $aNameValPair (@nameValPairs) {
      my(@nameValPairPatrs) = split(/\=/,$aNameValPair);
      my($aHiddenField) = sprintf ("%s<INPUT TYPE=HIDDEN NAME=\"%s\"  VALUE=\"%s\">\n",$padStr,$nameValPairPatrs[0],$nameValPairPatrs[1]);
      $retStr = "${retStr}${aHiddenField}";
   } # end foreach namValPair
   return $retStr;
}

sub makeFormLink {
   my($padStr,$labelStr,$imgName,$cgiToCall,$paramStr)   = @_;
   print("${padStr}<FORM METHOD=POST ACTION=${cgiToCall}>\n");
   print(produceHiddenField($paramStr,"${padStr}  "));
   if ($imgName eq "") {
      print("${padStr}   <INPUT TYPE=SUBMIT NAME=submitted VALUE=\"${labelStr}\">\n");
   } else {
      print("${padStr}   <BR><INPUT TYPE=IMAGE SRC=\"${imgName}\" ALT=\"${labelStr}\" name=\"submitButton\" border=0>\n");
   }
   print("${padStr}</FORM>");
}

sub addUrlParam {
  my($aUrl,$newParam) = @_;
  my($newUrl)     = $aUrl;
  if ($newParam ne "") {
    if (index($newUrl,"?") >= 0) {
       $newUrl = "${newUrl}&${newParam}";
    } else {
       $newUrl = "${newUrl}?${newParam}";
    }
  }
  return $newUrl;
}

sub addCgiParameterInUrl {
  my($aUrl,$newParam) = @_;
  my($newUrl)     = $aUrl;
  if ($newParam ne "") {
    if (index($aUrl,"?") >= 0) {
       $aUrl =~ s/\?/;;;/g;
       my(@parts) = split(";;;",$aUrl);
       $newUrl = sprintf("%s?%s&%s",$parts[0],$newParam,$parts[1]);
    } elsif (index($aUrl,"('") >= 0) {
       $aUrl =~ s/\(\'/;;;/g;
       my(@parts) = split(";;;",$aUrl);
       $newUrl = sprintf("%s('%s&%s",$parts[0],$newParam,$parts[1]);
    } else {
       $newUrl = "${newUrl}?${newParam}";
    }
  }
  return $newUrl;
}
############################################################################
# Function for handling html
############################################################################
sub htmlMimeType {
  print ("Content-type: text/html\n\n"); # don't touch this line!!!
}

sub pdfMimeType {
  print ("Content-type: application/pdf\n\n"); # don't touch this line!!!
}

sub vcfMimeType {
  print ("Content-type: text/x-vcard;charset=ISO-8859-1\n\n"); # don't touch this line!!!
}

sub mimeTypeUsingFileExtension {
  my($fileExtension,$fullFilenameWithPath)   = @_;
  $fileExtension = lc($fileExtension);
  if ($fullFilenameWithPath ne "") {
      my $fileName = getFileNameOutOfFullName($fullFilenameWithPath);
      print ("Content-disposition: attachment; filename=${fileName}\n");
  }

  if (($fileExtension eq "doc") || ($fileExtension eq "docx")){
      print ("Content-type: application/msword\n\n");
  } elsif ($fileExtension eq "rtf") {
      print ("Content-type: application/msword\n\n");
  } elsif ($fileExtension eq "vcf") {
      vcfMimeType();
  } elsif (($fileExtension eq "xls") || ($fileExtension eq "xlsm")){
      print ("Content-type: application/vnd.ms-excel\n\n");
  } elsif ($fileExtension eq "flt") {
      print ("Content-type: application/vnd.ms-excel\n\n");
  } elsif ($fileExtension eq "pdf") {
      print ("Content-type: application/pdf\n\n");
  } elsif ($fileExtension eq "ppt") {
      print ("Content-type: application/vnd.ms-powerpoi\n\n");
  } elsif ($fileExtension eq "gif") {
      print ("Content-type: image/gif\n\n");
  } elsif ($fileExtension eq "jpg") {
      print ("Content-type: image/jpeg\n\n");
  } elsif (($fileExtension eq "html") || ($fileExtension eq "htm")) {
      print ("Content-type: text/html\n\n");
  } elsif (($fileExtension eq "txt") || ($fileExtension eq "bas") || ($fileExtension eq "java")) {
      print ("Content-type: text/html\n\n<PRE>");
  } elsif ($fileExtension eq "zip") {
      if ($fullFilenameWithPath eq "")  {
         print ("Content-disposition: attachment; filename=download.zip\n");
      }
      print ("Content-type: application/zip\n\n");
  } else {
      print ("Content-type: text/html\n\n Unknown Mime-Type <B>${fileExtension}</B><BR><BR>\n"); 
  }
}
 

sub htmlHeaderNoMimeType {
  my($title,$subTitle,$addHeadParts) = @_;
  print("<HTML>\n");
  print("<HEAD>\n");
  print(" <TITLE>${title}</TITLE>\n");
  print(" <!-- Uses ".getLibDescription()."-->\n");
  if ($addHeadParts ne "") { print($addHeadParts); }
  print("</HEAD>\n");
  if (length($subTitle) > 0) {
    print("<BODY>\n");
    print("<H1>${subTitle}</H1>");
  }
}

sub htmlHeader {
  my($title,$subTitle,$addHeadParts) = @_;
  htmlMimeType();
  htmlHeaderNoMimeType($title,$subTitle,$addHeadParts);
}

sub htmlTail {
  print("</BODY>\n");
  print("</HTML>\n");
}


# removes all html tags in a string
sub removeHtmlTags {
    my($inStr)  = @_;
    my($retStr) = "";
    my($part)   = "";

    $inStr =~ s/\>/\>\>;/g;
    my(@parts) = split("\>;",$inStr);
    foreach $part (@parts) {
       $part =~ s/\<.+\>//g;
       $retStr = "${retStr}${part}";
    }
    return $retStr;
}

# replaces in a string all spaces with html-spaces
sub repNullStr {
    my($inVal)  = @_;
    if ($inVal eq "") {
      $inVal = " ";
    }
    $inVal =~ s/ /\&nbsp\;/g;
    return $inVal;
} # end of repNullStr

# replaces an empty str with a html-space
sub htmlNullStr {
    my($inVal) = @_;
    if (length($inVal) == 0) {
      return "&nbsp;";
    } else {
      return $inVal;
    }
}

# replaces Carrige returns into HTML line breaks
sub replaceCR_BR {
    my($inVal) = @_;
    $inVal =~ s/\n/\<BR\>/g;
    return $inVal;
}

sub replaceBR_CR {
    my($inVal) = @_;
    $inVal =~ s/\<BR\>/\n/g;
    return $inVal;
}


# inserts HTML line breaks and replaces all spaces with html-spaces
sub printHTML_Line {
    my($inVal) = @_;
    $inVal =~ s/ /\&nbsp\;/g;
    print("${inVal}<BR>\n");
}

sub displaySelectorWidget {
  my($size,$widgetName,$selectedStr,@aList) = @_;

  my($aField)   = "";
  if (length($size)        == 0) {$size        = "1"; }
  if (length($widgetName)  == 0) {$widgetName  = ""; }
  if (length($selectedStr) == 0) {$selectedStr = ""; }

  print("<SELECT NAME=\"${widgetName}\" size=\"${size}\">\n");
  foreach $aField (@aList) {
     if ($selectedStr eq $aField) {
         print("   <OPTION VALUE=\"${aField}\" SELECTED>${aField}\n");
     } else {
         print("   <OPTION VALUE=\"${aField}\">${aField}\n");
     }
  }
  print("</SELECT>\n");
}

sub getSelectorWidget {
  my($size,$widgetName,$selectedStr,@aList) = @_;
  my($retVal) = "";

  my($aField)   = "";
  if (length($size)        == 0) {$size        = "1"; }
  if (length($widgetName)  == 0) {$widgetName  = ""; }
  if (length($selectedStr) == 0) {$selectedStr = ""; }

  $retVal = "<SELECT NAME=\"${widgetName}\" size=\"${size}\">\n";
  foreach $aField (@aList) {
     if ($selectedStr eq $aField) {
         $retVal = "${retVal}   <OPTION VALUE=\"${aField}\" SELECTED>${aField}\n";
     } else {
         $retVal = "${retVal}   <OPTION VALUE=\"${aField}\">${aField}\n";
     }
  }
  $retVal = "${retVal}</SELECT>\n";
  return $retVal;
}

# returns a string for a selector box
# e.g.  @aList = ("001;Walter","002;"Claudia")
#   $selectedStr can be $FIRST 001 or Claudia
sub getSelectorWidgetForValueTextPair {
  my($sepChar,$size,$widgetName,$selectedStr,$autofire,@aList) = @_;
  my($retVal)   = "";
  my($first)    = $TRUE;

  if (length($size)        == 0) {$size        = "1"; }
  if (length($widgetName)  == 0) {$widgetName  = ""; }
  if (length($selectedStr) == 0) {$selectedStr = ""; }

  if ($autofire) {
      $retVal = "<SELECT NAME=\"${widgetName}\" size=\"${size}\" onChange='this.form.submit()'>\n";
  } else {
      $retVal = "<SELECT NAME=\"${widgetName}\" size=\"${size}\">\n";
  }

  foreach my $aField (@aList) {
     my @entryParts = split($sepChar,$aField);
     my $value       = $entryParts[0];
     my $text        = $entryParts[1];

     if ($text eq "") { $text = $value; }

     if ((($selectedStr eq $text)  || ($selectedStr eq $value)) ||
         (($selectedStr eq $FIRST) && (!$first))
        ){
         $retVal = "${retVal}   <OPTION VALUE=\"${value}\" SELECTED>${text}\n";
         $first  = $FALSE;
     } else {
         $retVal = "${retVal}   <OPTION VALUE=\"${value}\">${text}\n";
     }
  }
  $retVal = "${retVal}</SELECT>\n";
  return $retVal;
}



############################################################################
# JavaScript functions often used
############################################################################
sub addJScommon {
print <<javaScript;
<script language="JavaScript">
<!-- Hide Script from older Browsers.
function closeMe() {
   self.close();
}

function showStatus(msg) {
    window.status=msg;
}
// End the hiding here. -->
</SCRIPT>
javaScript
}

sub addJSshowPage {
  my($windowName,$toolbar,$status,$scrollbars,$resizable,$width,$height,$JSfuncName) = @_;
  $toolbar    = setDefault($toolbar,   "no");
  $status     = setDefault($status,    "no");
  $scrollbars = setDefault($scrollbars,"no");
  $resizable  = setDefault($resizable, "no");

  $windowName = setDefault($windowName,"aNewWindow");
  $width      = setDefault($width,     "250");
  $height     = setDefault($height,    "200");
  $JSfuncName = setDefault($JSfuncName,"showPage");

print <<javaScript;
<script language="JavaScript">
<!-- Hide Script from older Browsers.
function ${JSfuncName}(nameURL) {
   aNewWindow=window.open(nameURL,"${windowName}","toolbar=${toolbar},status=${status},scrollbars=${scrollbars},resizable=${resizable},width=${width},height=${height}");
   aNewWindow.focus();
}
// End the hiding here. -->
</SCRIPT>
javaScript
}

sub addJScookies {
print <<javaScript;
<script language="JavaScript">
<!-- Hide Script from older Browsers.
// Function for using cookies
// --------------------------
function setCookie(name, value) {
    var today = new Date();
    var expire = new Date();
    expire.setTime(today.getTime() + 1000*60*60*24*365);  // Cookie lebt 1 Jahr
    document.cookie = name + "=" + escape(value) + ";expires=" + expire.toGMTString();
}


function getCookie(name,defaultValue) {
    var search = name + "=";
    if (document.cookie.length > 0) {
        offset = document.cookie.indexOf(search);
        if (offset != -1) {
            offset += search.length
            end = document.cookie.indexOf(";", offset);
            if (end == -1)
                end = document.cookie.length;
            return  unescape(document.cookie.substring(offset, end));
        } else {
            return defaultValue;
        }
    } else {
        return defaultValue;
    }
}
// End the hiding here. -->
</SCRIPT>
javaScript
}

sub addJScheckBeforeSubmit {
  my($testFunctionName,$jsFunctionName) = @_;
  $jsFunctionName   = setDefault($jsFunctionName,   "checkBeforeSubmit");
  $testFunctionName = setDefault($testFunctionName, "check");


print <<javaScript;
<script language="JavaScript">
<!-- Hide Script from older Browsers.
function ${jsFunctionName} (form,button) {
   if (!${testFunctionName}(form)) return;
   form.submit();
   return;
}
// End the hiding here. -->
</SCRIPT>
javaScript
}

############################################################################
# Function for DOS Systems only
############################################################################
sub copyFileDos {
  my($sourceFile,$destDir) = @_;
  my $dosCmd = "copy \"${sourceFile}\" \"${destDir}\"  2>&1";
  my $retMsg = `${dosCmd}`;
  if (index($retMsg,"file(s) copied.") == -1) {
     print("ERROR:${retMsg}\n");
  }
}


############################################################################
# Function for UNIX SOLARIS Packages
############################################################################
sub replacePakageInfoSepFct {
  my($inVal) = @_;
  return substituteStr($inVal,":  ","-->",$TRUE);
}

sub readPackageInfo {
  my($packagename) = @_;
  my $unixCmd =  "pkginfo -l ${packagename} 2>&1";
  my @packageInfoLines = `${unixCmd}`;
  
  @packageInfoLines = processEachElementInArray("replacePakageInfoSepFct",trimRemoveEmptiesAndCommentsInArray(chompArrayEntries(@packageInfoLines)));
  ### print("Package Info for:${packagename}\n"); displayArray(@returnedLines);
  return convertArrayMappingTblToHashMappingTbl(":  ",@packageInfoLines);
}

sub listPakageInfo {
	 my($preStringHead,$postStringHead,$preString,$postString,$sepChar,$fieldsToShow,@packageList) = @_;
	 $fieldsToShow   = setDefault($fieldsToShow,"PKGINST;VERSION");
	 $sepChar        = setDefault($sepChar,"\|");
	 if ($preStringHead ne "") { $preStringHead = $preStringHead.$sepChar; }
	 if ($preString     ne "") { $preString     = $preString.$sepChar; }
	 
	 my $returnStr = "";
	 
	 my @fieldsToShow = split(";",$fieldsToShow);
   $returnStr = $preStringHead;
   foreach my $aFieldName (@fieldsToShow) {
	    $returnStr = $returnStr . $aFieldName.$sepChar;
	 }
	 $returnStr = $returnStr . "${postStringHead}\n";
	 
	 foreach my $aPackageName (@packageList) {
	 	  my %packageInfoRec = readPackageInfo($aPackageName);
	 	  $returnStr = $returnStr . $preString;
	 	  foreach my $aFieldName (@fieldsToShow) {
	 	  	$returnStr = $returnStr . $packageInfoRec{$aFieldName}.$sepChar;
	 	  }
	 	  $returnStr = $returnStr . "${postString}\n";
	 }
	 $returnStr = $returnStr . "\n";
	 return $returnStr;
}


############################################################################
# Function for UNIX Systems only
############################################################################
sub callUnixCmd {
  my($command) = @_;
  my($msg)     = "";
  if (isDebug()) {
     system($command);
  } else {
     $msg = `$command`;
  }
  return $msg;
}

sub showDiskUsedOnUnix {
    my($directory,$recursive) = @_;
    my %resHash = ();
    %resHash = diskUsedOnUnix($directory,$recursive);
    displayHashTable(%resHash);
}

# returns disk space used in kByte for all sub dirs in $directory
sub diskUsedOnUnix {
    my($directory,$recursive) = @_;
    $recursive= setDefault($recursive,  $FALSE);
    ### print("directory:${directory}:\n");
    my(%retHash)   = ();

    if ($recursive) {
        my($cmd_2) = "du -k | sort -nr";
        if ($directory ne "") {
          $cmd_2 = "cd ${directory} ; ${cmd_2}";
        }
        my($retMsg_2_Total) = callUnixCmd($cmd_2);
        my(@dirList) = split("\n",$retMsg_2_Total);
        ### displayArray(@retMsg);
        my($aDirEntry) = "";
        foreach $aDirEntry (@dirList) {
          $aDirEntry =~ s/\s/;/;
          my(@parts) = split(";",$aDirEntry);
          ### printf("--->  :%s:%s:\n",$parts[1],$parts[0]);
          if ($parts[1] ne "") {
             %retHash = (%retHash,($parts[1],$parts[0]));
          }
        }
    } else {
       ### print("directory:${directory}:\n");
       my(@dirList)     = `ls -l ${directory} 2>&1 | grep '^d' 2>&1`;
       ### displayArrayHTML(@dirList);

       my($aDirEntry) = "";
       foreach $aDirEntry (@dirList) {
         my($dName) = extractFileNameFromDirEntry($aDirEntry);
         ### print("Check dir :${dName}:${aDirEntry}:\n");
         my($cmd_2) = "du -k ${dName} | tail -1 | sort -nr";
         if ($directory ne "") {
          $cmd_2 = "cd ${directory} ; ${cmd_2}";
         }
         my($retMsg_2) = callUnixCmd($cmd_2);
         chomp($retMsg_2);
         $retMsg_2 =~ s/\s/;/;
         my(@parts) = split(";",$retMsg_2);
         ### printf("%s:%s:\n",$parts[1],$parts[0]);
         if ($parts[1] ne "") {
             %retHash = (%retHash,($parts[1],$parts[0]));
         }
       }
    }
    return %retHash;
}

sub getMyUnixUserId {
   my $uid  =`id  2>&1` ;  chop $uid;
   $uid = substr($uid,index($uid,"(")+1);
   $uid = substr($uid,0,index($uid,")"));
   return $uid;
}

sub getCurrentDir {
   my $currDir =  `pwd  2>&1` ;  chop $currDir;
   $currDir = strip($currDir);
   return $currDir;
}

sub getMyUnixPid {
   my($pid) =  `echo $$  2>&1` ;  chop $pid;
   return $pid;
}

sub getMyUnixHostname {
   my $unameStr = `uname -a  2>&1` ;  chop $unameStr;
   my(@parts)    = split(" ",$unameStr);
   return $parts[1];
}

sub perlnslookup {
	my $unixCmd = "${nslookupCmdLinux} xxx 2>&1";
	print("unixCmd:${unixCmd}:\n");
	my @retMsg = `$unixCmd` ;
	displayArray(@retMsg);
	print("done\n");
	
	
	$unixCmd = "${nslookupCmdSOLARIS} xxx 2>&1";
	print("unixCmd:${unixCmd}:\n");
	my @retMsg = `$unixCmd` ;
	displayArray(@retMsg);
	print("done\n");
}

sub set_nslookupPath {
	$nslookupCmd = `which nslookup 2>&1` ; chop $nslookupCmd;
	my $strContained = "";
	if (!(stringEndsWith($nslookupCmd,"nslookup"))) {
		$nslookupCmd = $nslookupCmdSOLARIS;
	}
}

sub set_uuencodePath {
	$uuencodeCmd = `which uuencode 2>&1` ; chop $uuencodeCmd;
	my $strContained = "";
	if (!(stringEndsWith($uuencodeCmd,"uuencode"))) {
		$uuencodeCmd = $uuencodeCmdSOLARIS;
	}
}

sub getMyUnixDomainname {
	my $domainName = `domainname  2>&1` ;  chop $domainName;
	$domainName = removeFieldFromString(".",0,$domainName,"");

	if ($domainName eq "") {
		my $hostname = getMyUnixHostname();
		## set_nslookupPath();
		my $fullname = ` ${nslookupCmd} ${hostname} | grep Name | awk '{print $2}'  2>&1` ;  chop $fullname;
		$domainName = removeFieldFromString(".",0,$fullname);
	}
	return $domainName
}

sub getMyUnixFullHostname {
   return getMyUnixHostname().".".getMyUnixDomainname();
}

sub getFullHostnameFromAlias {
	my($alias) = @_;
	## set_nslookupPath();
	my $fullname = ` ${nslookupCmd} ${alias} | grep Name | awk '{print \$2}'  2>&1` ;  chop $fullname; chomp($fullname);
	return strip($fullname);
}

sub getFullHostnameFromIP {
	  my($ipAdr) = @_;
	  return getFullHostnameFromAlias($ipAdr);
}

sub  getIpFromHostname {
	my($hostname) = @_;
	## set_nslookupPath();
	my @retVal = chompArrayEntries(` ${nslookupCmd} ${hostname} | grep Address | awk '{print \$2}'  2>&1`);
	return strip($retVal[1]);
}

sub  getIpFromAlias {
	  my($aliasName) = @_;
	  return getIpFromHostname($aliasName);
}

sub isCurrentHost {
	my($hostAlias) = @_;
	## print("Hostname (from LINUX): ".getMyUnixFullHostname()."<BR/>\n");
	## print("Hostname (from alias): ".getFullHostnameFromAlias($hostAlias)."<BR/>\n");
	return (getMyUnixFullHostname() eq getFullHostnameFromAlias($hostAlias));
}

sub whichIsCurrentHostAlias {
	my(@aliasList) = @_;
	foreach my $aEntry (@aliasList) {
		if (isCurrentHost($aEntry)) {
			return $aEntry;
			last;
		}
	}
	return "";
}

sub doTest_nslookupFunctions {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);
   if (getIpFromHostname("zus90a-1841.tszrh.csfb.com") ne getIpFromAlias("cent.tszrh.csfb.com")) {
   	  print("ERROR: ${myFullName} failed (A1)\n");
   }
#   if (getFullHostnameFromAlias("cent.tszrh.csfb.com") ne getFullHostnameFromIP("xxx.xx.xxx.xx")) {
#   	  print("ERROR: ${myFullName} failed (B)\n");
#   }   
}


sub purgeUnixDir {
	my($directory, $retention, $silent, $withDir) = @_;
	$directory = setDefault($directory,".");
	$retention = setDefault($retention,2);
	$silent    = setDefault($silent,  $FALSE);
	$withDir   = setDefault($withDir, $FALSE);
  
	my $retStr = "";

	if (!($silent)) {
		print("\npurgeUnixDir: Cleanup ${directory}:  retention:${retention}:  withDir:${withDir}:\n");
	}
	my $purgeCmd = "find ${directory} -type d -mtime +${retention} -exec rm -rf {} \\;";
	if (!($silent)) {
		print("     purgeCmd:${purgeCmd}:\n");
	}
	$retStr = callUnixCmd($purgeCmd);
	$purgeCmd = "find ${directory} -type f -mtime +${retention} -exec rm -f {} \\;";
	if (!($silent)) {
		print("     purgeCmd:${purgeCmd}:\n");
	}
	$retStr = $retStr . "\n". callUnixCmd($purgeCmd);
	
	return $retStr;
}


sub cleanupUnixDir {
  my($directory, $retention, $size, $command, $silent) = @_;
  $command   = setDefault($command,  "ls -al \$FILENAME");
  $silent    = setDefault($silent,  $FALSE);
  $directory = setDefault($directory,".");
  $retention = setDefault($retention,2);
  if ($size ne "") { $size = "-size ${size}"; }
  
  my $purgeCmd = "find ${directory} -type f -mtime +${retention} ${size} -print | while read FILENAME; do ${command}; done 2>&1";
  if (!($silent)) { print("Exec ${purgeCmd}\n") };
  return callUnixCmd($purgeCmd);
}

sub isUNIX_DirEntryA_Directory {
	my($dirEntry) = @_;
	# print("dirEntry:".substr($dirEntry,0,1).":\n");
	if (substr($dirEntry,0,1) eq "d") {
	    return $TRUE;	
	} else {
		  return $FALSE;	
	}
}

sub isUNIX_DirEntryA_Link {
	my($dirEntry) = @_;
	# print("isUNIX_DirEntryA_Link     :dirEntry:".substr($dirEntry,0,1).":\n");
	if (substr($dirEntry,0,1) eq "l") {
	    return $TRUE;	
	} else {
		return $FALSE;	
	}
}

sub isUNIX_DirEntryA_File {
	my($dirEntry) = @_;
	my $unixCmd = "ls -l ${dirEntry} | grep -v \"^total\"";
	
	my @dirEntries = chompArrayEntries(`$unixCmd`);
	my $countEntries = @dirEntries;
	if ($countEntries != 1) {
		return $FALSE;	
    }

	if (substr($dirEntries[0],0,1) eq "-") {
	    # still it could be a dir containing just one file or a file
		#
		# e.g. /tmp/dcl contains one file (template_xxxxx2_temp_InLink.dcl)
		# kallo:DZHLHFC1> ls /tmp/dcl
        # template_xxxxx2_temp_InLink.dcl
		#
		# kallo:DZHLHFC1> ls /tmp/dcl/template_xxxxx2_temp_InLink.dcl
        # /tmp/dcl/template_xxxxx2_temp_InLink.dcl
		#
		$unixCmd = "ls ${dirEntry} | grep -v \"^total\"";
		@dirEntries = chompArrayEntries(`$unixCmd`);
	    if ($dirEntries[0] eq $dirEntry) {
			return $TRUE;
		} else {
			return $FALSE;
		}
	} else {
		return $FALSE;	
	}
}

sub getLinkDestFromUnixDirEntry {
	my($aDirEntry,$supressWarnings) = @_;
	$supressWarnings    = setDefault($supressWarnings,  $FALSE);
	if (isUNIX_DirEntryA_Link($aDirEntry)) {
		my ($firstPart,$destination) = split(" ->",$aDirEntry);
		# print("getLinkDestFromUnixDirEntry:   firstPart:${firstPart}:\n");
		# print("getLinkDestFromUnixDirEntry:   destination:${destination}:\n");
		return strip($destination);
	} else {
		if (!($supressWarnings)) {
			print("WARNING: ${aDirEntry}:NOT A LINK!\n");
		}
		return ""
	}
}
sub getFilenameFromUNIX_DirEntry {
	my($inVal) = @_;
	my $retVal = $inVal;
	$retVal =~ s/\s+/;/g;
	my @fields = split(";",$retVal);
	my $countOfFields = @fields;
	$retVal = $fields[$countOfFields - 1];
	return $retVal;	
}

sub doTest_getFileLastModFromUNIX_DirEntry {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);
	my $testCases = qq {
		Nr|Dir-Entry    |Expected
		01|-rwxrwxrwx 1 lhadm lhgrp   7122 Sep  1 14:43 ./11.1.0.4/scripts/TEST_CASES.txt   |20150901144300
		02|-rwxrwxrwx 1 lhadm lhgrp   7122 Jan  5 14:59 ./11.1.0.4/scripts/TEST_CASES.txt   |20160105145900
		03|-rw-r--r-- 1 raroc raroc 22 2008-05-13 21:19 web_orig_20070509                   |20080513211900
	};
	my $todayTestDate = "20160130";

	for (my $i = 2; $i <= getCountOfLinesFromQQ($testCases); $i++) {
		my $testCaseNr  = getFieldFromQQ($testCases,$i,1);
		my $dirEntry    = getFieldFromQQ($testCases,$i,2);
		my $expectedRes = getFieldFromQQ($testCases,$i,3);

		if ($debugThisFct) {
			print("\n==> ${myFullName}: Test-Case:${i}:${testCaseNr}\n");
			print("       todayTestDate :${todayTestDate}:\n");
			print("       dirEntry      :${dirEntry}:\n");
			print("       expectedRes   :${expectedRes}:\n");
			print("       getFileLastModFromUNIX_DirEntry(${dirEntry},${todayTestDate})=".getFileLastModFromUNIX_DirEntry($dirEntry,$todayTestDate,$debugThisFct)."\n");
		}
		if (!(getFileLastModFromUNIX_DirEntry($dirEntry,$todayTestDate) eq $expectedRes)) { print("ERROR: Test-Case ${testCaseNr}\n"); print("       getFileLastModFromUNIX_DirEntry(${dirEntry},${todayTestDate})=".getFileLastModFromUNIX_DirEntry($dirEntry,$todayTestDate)."        Expected:${expectedRes}:\n");}
	}
}


sub getFileLastModFromUNIX_DirEntry {
	my($inVal,$currentDate,$doDebug) = @_;
	my $currentDate  = setDefault($currentDate,substr(getTimeStamp(),0,8));
	my $doDebug      = setDefault($doDebug,$FALSE);
	
	my $currentMonthDay = substr($currentDate,4,4);
	my $currentYear     = substr($currentDate,0,4);
		
	my $retVal = $inVal;
	$retVal =~ s/\s+/;/g;
	my @fields = split(";",$retVal);
	my $countOfFields = @fields;
	# print("getFileLastModFromUNIX_DirEntry count:${countOfFields}:\n"); displayArray(@fields);
	
	if ($countOfFields == 9) {
		# -rwxrwxrwx 1 lhadm lhgrp   7122 Sep  1 14:43 ./11.1.0.4/scripts/TEST_CASES.txt
		my $theMonth = getMonthNrByMonthName($fields[5]);
		my $theDay   = paddenNull($fields[6],2,"0");
		my $theTime  = $fields[7] . "00"; $theTime =~ s/\D+//g;
		
		my $monthDay = $theMonth . $theDay;
		if ($doDebug) {
			print("currentDate     :${currentDate}:\n");
			print("currentMonthDay :${currentMonthDay}:\n");
			print("monthDay        :${monthDay}:\n");
			print("currentYear     :${currentYear}:\n");
		}
		
		if ($currentMonthDay < $monthDay) {
			$currentYear = $currentYear - 1;
		}
		$retVal = $currentYear . $theMonth . $theDay .  $theTime;
	} elsif ($countOfFields == 8) {
		# -rw-r--r-- 1 raroc raroc 22 2008-05-13 21:19 web_orig_20070509
		my $theTime  = $fields[6] . "00"; $theTime =~ s/\D+//g;
		my $theDate  = $fields[5];        $theDate =~ s/\D+//g;
		$retVal = $theDate . $theTime;
	} 
	return $retVal;	
}

# reutrns a list of filenames, recursivly walked trougth the directory tree (also following links)
sub getFilesInDirTree {
	my($baseDir,$fullPath,$excludePatterns,$includePatterns,$followLinks) = @_;
	$baseDir = strip(replacePerlVariablesAndENV_InString($baseDir));
	if ($followLinks) {
	  # print("Follow links....\n");
	}
	# print("\n\n------> getFilesInDirTree(".$baseDir.")\n");
	$fullPath    = setDefault($fullPath,$TRUE);
	$followLinks = setDefault($followLinks,$TRUE);

		# Example for pattern match
		# my $path = "/app/ft/code/DZHLHFC1/rap";
		# my $name = "^if";

		# opendir (DIR_TO_SEARCH, $path)  or  die "Failed to open directory $path : $!";
		# my @dirs_found = grep { /$name/ } (sort readdir DIR_TO_SEARCH);
		# closedir (DIR_TO_SEARCH);

		# for my $dir (@dirs_found) {
			# print $dir , "\n";
		# }

	my @includePatternList = trimArray(split(",",$includePatterns));
	my @excludePatternList = trimArray(split(",",$excludePatterns));
	## displayArray(@includePatternList);
	my @retList = ();
	if (isDirectoryExisting_UNIX($baseDir)) {  
		# print("Checking directory :${baseDir}:\n");
		my @dirList = getDirList_UNIX($baseDir);
		# print("Result of getDirList_UNIX :${baseDir}:\n");
		# displayArray(@dirList);
		# halt();
		foreach my $aDirEntry (@dirList) {
			my $dirEntryName = getFilenameFromUNIX_DirEntry($aDirEntry);

			my $isA_File = $FALSE;
			# walk trought tree
			if (isUNIX_DirEntryA_Directory($aDirEntry)) {
				# print("aDirEntry:${aDirEntry}:   Is a Directory\n");
				my @subDirListe = getFilesInDirTree(${baseDir}."/".$dirEntryName,$fullPath,$excludePatterns,$includePatterns,$followLinks);
				@retList = concatArray(@retList,@subDirListe);
			} elsif (isUNIX_DirEntryA_Link($aDirEntry)) {
				if ($followLinks) {
					# print("aDirEntry:${aDirEntry}:   Is a Link\n");
					$linkDest = getLinkDestFromUnixDirEntry($aDirEntry);
					# print("linkDest:${linkDest}:\n");
					if (isUNIX_DirEntryA_File($linkDest)) {
						# print("linkDest:${linkDest}: is a file------------------------------------------------------------\n");
						$isA_File = $TRUE;
					} else {
						# print("linkDest:${linkDest}: is a directory\n");
						my @subDirListe = getFilesInDirTree($linkDest,$fullPath,$excludePatterns,$includePatterns,$followLinks);
						@retList = concatArray(@retList,@subDirListe);
					}
				}
			} else {
				$isA_File = $TRUE;
			} 
			if ($isA_File eq $TRUE) {
				# filter
				# print("File found:${aDirEntry}:\n");
				if ($excludePatterns ne "") {
					if (isOnePatternMatchesString($aDirEntry,@excludePatternList)) {
						next;
					}
				}
				if ($includePatterns ne "") {
					if (!(isOnePatternMatchesString($aDirEntry,@includePatternList))) {
						next;
					}
				}

				if ($fullPath) {
					if (substr($dirEntryName,0,1) eq "/") {
						push(@retList,$dirEntryName);
					} else {
						push(@retList,"${baseDir}/".$dirEntryName);
					}
				} else {
					push(@retList,$dirEntryName);
				}
			}
		}
	} else {
		print("ERROR: ${baseDir} not an existing directory (maybe a file)!");
	}
	return @retList;
}

sub getDirList_UNIX {
	my($dirPath,$supressWarnings) = @_;
	$supressWarnings    = setDefault($supressWarnings,  $FALSE);
	my @dirList = ();
	if (isDirectoryExisting_UNIX($dirPath)) {
		if ($supressWarnings) {
			@dirList = chompArrayEntries(`ls -l ${dirPath} 2>&1 | grep -v "^total" 2>&1`);
		} else {
			@dirList = chompArrayEntries(`ls -l ${dirPath} | grep -v "^total"`);
		}
	} else {
		push(@dirList,"${dirPath} is not existing");
	}
	return @dirList;
}

sub isDirectoryExisting_UNIX {
	my($dirPath) = @_;
	# print("isDirectoryExisting_UNIX::dirPath:${dirPath}:\n");
	$retVal = `cd $dirPath 2>&1`;
	# print("isDirectoryExisting_UNIX::retVal:${retVal}:\n");
	if ($retVal eq "") {
		return $TRUE;
	} else {
		 return $FALSE;
	}
}

sub listFilesDirectoriesInSelect {
	my($workingDir,$filter,$selectName,$listFiles) = @_;
	$retMsg = `ls -al $workingDir 2>&1`;
	my @fileList  = split("\n",$retMsg);
	my $aEntry = "";
	print("<SELECT NAME=$selectName SIZE=6>\n");
	foreach $aEntry (@fileList) {
		if ($listFiles) {
			if ($aEntry =~ /^\-/) {
				my $dName = extractFileNameFromDirEntry($aEntry);
				if ($dName ne ".") {
					print("<OPTION VALUE=${dName}>${dName}\n");
				}
			}
		} else {
			if ($aEntry =~ /^d/) {
				my $dName = extractFileNameFromDirEntry($aEntry);
				if (($dName ne ".") && ($dName ne "..")) {
					print("<OPTION VALUE=${dName}>${dName}\n");
				}
			}
		}
	}
	print("</SELECT>\n");
}


# creates a whole sub directory tree. $rootDir is the starting point
sub mkUnixDir {
	my($dir,$rootDir) = @_;
	my $cdDir = $rootDir;
	my $msg   = `cd ${rootDir} 2>&1`;
	if ($msg ne "") {
		return "Root (${rootDir}) dir doesn't exist!";
	}
	$dir =~ s/\\/;/g;
	$dir =~ s/\//;/g;
	# print("\n\n\n");
	# print("dir          :${dir}:\n");
	
	my @dirs = split(";",$dir);
	my $anzDir = 0; $anzDir = @dirs;
	# print("anzDir:${anzDir}:\n");	
	foreach (my $i=0; $i<$anzDir; $i++) {
		my $aDir = $dirs[$i];
		# print("aDir:${aDir}:\n");
		# my $unixCmd = "cd ${cdDir}/${aDir} 2>&1";
		# my $msg  = `$unixCmd`;
		# print("unixCmd:${unixCmd}:    msg:${msg}:\n");
		# if ($msg ne "") {
			# print("cd:${cdDir}: newDir:${aDir}:\n");
			$msg  = `cd $cdDir 2>&1 && mkdir $aDir 2>&1`;
		# }
		if ($cdDir eq "/") {
			$cdDir = "/${aDir}";
		} else {
			$cdDir = "${cdDir}/${aDir}";
		}
	}
	# print("\n\n\n");
}

sub UNIX_Which {
	my($filename,$defaultPath) = @_;
	if ($defaultPath ne "") {
		if (!($defaultPath =~ /\/$/)) {
			$defaultPath = "${defaultPath}/";
		}
	}
	my $retVal = fctChomp(`which ${filename}  2>&1`);
	if (index($retVal,"no ${filename}") != -1) {
		$retVal = "${defaultPath}${filename}";
	}
	return $retVal;
}

sub getPerlLibFullNameList {
	return (
		getPerlLibFullName("littlePerlLib.pm"),
		getPerlLibFullName("csfbPerlLib.pm"),
		getPerlLibFullName("tradeiqPerlLib.pm"),
	);
}

sub getPerlLibFullName {
	my($libName) = @_;
	$libName = setDefault($libName,"littlePerlLib.pm");

	if (getFileNameExtension($libName) eq "") {
		$libName = $libName.".pm";
	}
	my $perl5LibPath = $ENV{PERL5LIB};
	my $retVal = "";
	
	# print("perl5LibPath:${perl5LibPath}:\n");
	my @paths = split(":",$perl5LibPath);
	foreach my $aPath (@paths) {
		# print("    aPath:${aPath}:\n");
		if (isFileExists("${aPath}/${libName}")) {
			$retVal = "${aPath}/${libName}";
		}
	}
	return $retVal;
}

# returns a list of diff lines using Unix diff and writes
# the filename at the beginning of each line
sub compUnixFiles {
	my($fNamePath_1,$fName_1,$fNamePath_2,$fName_2) = @_;
	my $fullFileName_1 = "${fNamePath_1}/${fName_1}";
	my $fullFileName_2 = "${fNamePath_2}/${fName_2}";
	$msg = `diff $fullFileName_1 $fullFileName_2`;
	my @msgLines   = split("\n",$msg);
	my $aLine      = "";
	my $strLabel_1 = "${fullFileName_1}: ";
	my $strLabel_2 = "${fullFileName_2}: ";
	my @retList    = ();

	my $padLen     = maxStrLength($strLabel_1,$strLabel_2);
	$strLabel_1    = paddenNull($strLabel_1,-$padLen," ");
	$strLabel_2    = paddenNull($strLabel_2,-$padLen," ");

	foreach $aLine (@msgLines) {
		if (($aLine =~ /^\</) || ($aLine =~ /^\>/)) {
			$aLine =~ s/^\</$strLabel_1/g;
			$aLine =~ s/^\>/$strLabel_2/g;
			push(@retList,$aLine);
		}
	}
	return @retList;
}

sub extractFileNameFromDirEntry {
	my($dirEntry) = @_;
	my $retValue = "";
	my @dirEntryParts = split(" ",$dirEntry);
	my $anzParts = 0;  $anzParts = @dirEntryParts;
	$retValue = $dirEntryParts[$anzParts-1];
	return $retValue;
}

sub cleanupFilePath {
	my($dirPath)   = @_;
	my $retValue  = $dirPath;
	my @pathParts = split("/",$dirPath);
	my $anzParts  = 0;  $anzParts = @pathParts;
	if ($anzParts >= 2) {
		$retValue = "";
		my $i = 0;
		my $tmpPart   = "";
		my $firstTime = $TRUE;
		foreach($i=1; $i<$anzParts; $i++) {
			if (($pathParts[$i-1] ne "..") && ($pathParts[$i] eq "..")) {
				$i++;
			} else {
				if ($firstTime) {
					$retValue = $pathParts[$i-1];
					$firstTime = $FALSE;
				} else {
					$retValue = sprintf("%s/%s",$retValue,$pathParts[$i-1]);
				}
				if  ($i >= $anzParts-1) {
					if ($firstTime) {
						$retValue = $pathParts[$i];
						$firstTime = $FALSE;
					} else {
						$retValue = sprintf("%s/%s",$retValue,$pathParts[$i]);
					}
				}
			}
		}
	}
	## print("cleanupFilePath:${retValue}<BR>\n");
	return $retValue;
}

sub isUNIX_CommandExist {
	my($commandName) = @_;
	my $retMsg = `which ${commandName} 2>&1`;
	chomp($retMsg);
	my $pos = index($retMsg,$commandName);
	my $pot = length($retMsg) - length($commandName);
	if ( $pos == $pot ) {
		return $TRUE;
	} else {
		return $FALSE;
	}
}

sub getVersionDetailsFromFile {
	my($fullFilename) = @_;
	my %retVal = (
		"version"       => "",
		"location"      => "",
		"checkInTime"   => "",
		"checkedInUser" => "",
	);
    
	if ((index($fullFilename,".so.") > -1) ||
		(index($fullFilename,".so")  > -1) ||
		(index($fullFilename,".jar") > -1) ||
		(index($fullFilename,".tar") > -1)) {
			$retVal{"version"}  = "bin-file"; 
			return %retVal;  	
	}
    
	my $sccsID = `grep " \@(#)" $fullFilename | grep -v SccsId  2>&1` ;  chop $sccsID; chomp($sccsID);
	if ($sccsID ne "") {
		my $filename = getFileNameOutOfFullName($fullFilename);
		$sccsID = substr($sccsID,index($sccsID,$filename));
		$sccsID =~ s/\s+/;/g;
		my @parts = split(";",$sccsID);
		$retVal{"version"}       = $parts[1];
		$retVal{"location"}      = $parts[4];
		my $timeStamp = $parts[3];  $timeStamp =~ s/\D//g;
        
		$retVal{"checkInTime"}   = changeDateFormat($parts[2])."${timeStamp}";
		$retVal{"checkedInUser"} = "";   	
	} else {
		my @linesWithHeader = `grep "Header:" $fullFilename  2>&1`;
		my $cvsID = "";
		foreach my $aLine (@linesWithHeader) {
			if ((substr($aLine,length($aLine-1),1) eq "\$") &&
				(substr($aLine,index($aLine,"Header:")-1,1) eq "\$")) {
					$cvsID = substr($aLine,index($aLine,"Header:")+length("Header:"));
					$cvsID =~ s/\s+/;/g;
					my @parts = split(";",$cvsID);
					$retVal{"version"}       = $parts[2];
					$retVal{"location"}      = $parts[1];
					my $timeStamp = $parts[4];  $timeStamp =~ s/\D//g;
					$retVal{"checkInTime"}   = changeDateFormat($parts[3],"YYYY/MM/DD")."${timeStamp}";
					$retVal{"checkedInUser"} = $parts[5];   	
					last;
			}
		}
	}
	return %retVal;
}

sub testCompress {
	my($logFileName,$verbal) = @_;

	my $testFile_1 = "/app/lighthouse/data/AZHLHMC1/gmm/tradeIQ_GmmExtractorEod/20060922_ZH_TIQ_GMM_LOANS_DEPOSITS.flt";
	my $testFile_2 = "/app/lighthouse/data/AZHLHMC1/gmm/tradeIQ_GmmExtractorEod/20060922_ZH_TIQ_GMM_FUTURES_HOLDING.flt";
   
	my $retFile_1 = compressBigFile($testFile_1,"1000000",$logFileName,$verbal); print("retFile_1:${retFile_1}:\n");
	my $retFile_2 = compressBigFile($testFile_2,"",$logFileName,$verbal); print("retFile_2:${retFile_2}:\n");
   
	halt();
   
	my $retFile_3 = uncompressFile($retFile_1,$logFileName,$verbal); print("retFile_3:${retFile_3}:\n");
	my $retFile_4 = uncompressFile($retFile_2,$logFileName,$verbal); print("retFile_4:${retFile_4}:\n");
}


# compresses a file (using gzip) over a certain file size
# sizeLimitInByte = "0" ==> it will always compress
# sizeLimitInByte = ""  ==> it will never compress
# returns filename of file (in a case it was not compressed it will be remain the filename otherwise it will append a ".gz" to the filename)
sub compressBigFile {
	my($filename,$sizeLimitInByte,$logFileName,$verbal) = @_;
	# $sizeLimitInByte = setDefault($sizeLimitInByte,1000000);

	if ($sizeLimitInByte eq "") {
		return $filename;
	}

	my $fileSize = getFileSizeInByte($filename);
	## print("fileSize:${fileSize}:   sizeLimitInByte:${sizeLimitInByte}:\n");

	if ($fileSize >= $sizeLimitInByte) {
		my $newFilename = "${filename}.gz";
		if (isFileExists($newFilename)) {
			unlink($newFilename);
		}
		my $timestamp1 = getTimeStamp();
		`gzip ${filename}`;
		my $timestamp2 = getTimeStamp();
		my $newFileSize = getFileSizeInByte($newFilename);
		my $timeUsedForCompression = secDiff_YYYYMMDDhhmmss($timestamp2,$timestamp1);
		addToLogFile("Compression from ${fileSize} --> ${newFileSize} Bytes  ===> Down to ".realFormat(100*$newFileSize/$fileSize,2)."% Time used for compression: ${timeUsedForCompression}s",$logFileName,$verbal);
		return $newFilename;
	} else {
		return $filename;
	}
}

# decompresses a file if it ends with ".gz" otherwise is does nothing
# returns filename of decompressed file (in a case it was not compressed it will be return the original filename)
sub uncompressFile {
	my($filename,$logFileName,$verbal) = @_;

	my $startPos = index($filename,".gz");
	my $posi     = length($filename) - 3;

	if ($startPos >= 0) {
		if ($startPos eq $posi) {
			my $fileSize = getFileSizeInByte($filename);
			my $newFilename = substr($filename,0,$posi);
			if (isFileExists($newFilename)) {
				unlink($newFilename);
			}
			my $timestamp1 = getTimeStamp();
			`gzip -d ${filename}`;
			my $timestamp2 = getTimeStamp();
			my $newFileSize = getFileSizeInByte($newFilename);
			my $timeUsedForCompression = secDiff_YYYYMMDDhhmmss($timestamp2,$timestamp1);
			addToLogFile("De-Compression from ${fileSize} --> ${newFileSize} Bytes.  Time used for decompression: ${timeUsedForCompression}s",$logFileName,$verbal);
			return $newFilename
		} else {
			# not a .gz file
			return $filename;
		}
	} else {
		# not a .gz file
		return $filename;
	}
}

sub createTarFile {
   my($sourceDir,$tarfileName,$logFileName,$verbal,@files) = @_;
   my $fileList = makeStrFromArray(" ",@files);

   my $unixCmd =  "cd ${sourceDir} && rm -f ${tarfileName}.gz && tar -cvf  ${tarfileName} ${fileList} &&  gzip ${tarfileName} 2>&1";
   addToLogFile("--> tar files using ${unixCmd}",$logFileName,$verbal);

   my @fileListTared     = `${unixCmd}`;
   my $retString = makeStrFromArray(" ",@fileListTared);
   addToLogFile("--> tared files ${retString}",$logFileName,$verbal);
}

sub moveFileUnix {
  my($sourceFile,$destDir,$logFileName,$verbal) = @_;
  my $unixCmd = "mv -f ${sourceFile} ${destDir}  2>&1";
  my $retMsg = `${unixCmd}`;
  if ($retMsg ne "") {
     addToLogFile("ERROR:${retMsg}",$logFileName,$verbal);
  } else {
     if ($verbal) {
     	addToLogFile("mv ${sourceFile} ${destDir}",$logFileName,$verbal);
     }
  }
}

sub copyFileUnix {
  my($sourceFile,$destDir,$logFileName,$verbal) = @_;
  my $unixCmd = "cp -f ${sourceFile} ${destDir}  2>&1";
  my $retMsg = `${unixCmd}`;
  if ($retMsg ne "") {
     addToLogFile("ERROR:${retMsg}",$logFileName,$verbal);
  } else {
     if ($verbal) {
     	addToLogFile("cp ${sourceFile} ${destDir}",$logFileName,$verbal);
     }
  }
}

sub showUNIX_PATH {
	my ($varName) = @_;
	
	$varName = setDefault($varName,"PATH");
	
	my $pathStr = $ENV{$varName};
	my @pathPart = split(":",$pathStr);
	displayArray(@pathPart);
	return @pathPart;
}

sub showUNIX_LIB_PATH {
	my @pathPart = showUNIX_PATH ("LD_LIBRARY_PATH");
}

sub showHelpfullUnixCmd {
	my $helpText = qq{
		compress:  compress -v file  => file.z
		           gzip file         => file.gz
		
		uncompress: uncompress -v file.z
		            gzip -d file.gz
		            
		package:    tar -cvf ~/file.tar .
		
		unpack:     tar -xvf ~/file.tart .
		            gzip -dc *.tar.gz | tar -xfv -
		            zcat *.tar.Z | tar -xfv -
		            tar -xvf /def/rmt/0   un-tar from tape
		
		showProc    /usr/ucb/ps -auxww
		
		TNS Names   \$TNS_ADMIN/tnsnames.ora
		
		find /app/lighthouse/data/*/mm/reports  \( -name '*.ps' -o -name '*.txt' -o -name '*.asc' -o -name '*.slk' \) -mtime +5 -size +2 -type f -print | while read FILENAME; do /app/bin/gzip $FILENAME; done >/dev/null 2>&1

	};
	print("\n\n".unterstreichen("UNIX commands")."\n${helpText}");
}

sub showMenu_UnixCmd {
	
	 my %menu = (
     "1: Show helpfull UNIX commands  (execPerlFct showMenu_UnixCmd)"               => "showHelpfullUnixCmd;halt",
     "2: Show UNIX Path               (execPerlFct showUNIX_PATH PATH)"             => "showUNIX_PATH;halt",
     "3: Show UNIX LD_LIBRARY_PATHH   (execPerlFct showUNIX_PATH LD_LIBRARY_PATH)"  => "showUNIX_LIB_PATH;halt",
   );
   createAsciiMenuAndPerformActions("0: Exit","Following UNIX-Commands are defined:","\nSelect",%menu);
}

sub getUserDetailsFromUnixPasswd {
	 my($pid,$useUnixStyle)               = @_;
   $useUnixStyle                        = setDefault($useUnixStyle,$TRUE);
   my %userDetail                       = ();
   my $unixCall                         = "getent passwd ${pid}";
   my $userDetailsFromUnix              = `${unixCall}`;
   if (!(0 == $? >> 8)) {
      addToLogFile("INFO: User ${pid} not found in passwd file",$logFileName,$verbal);
      return %userDetail;
   }
   if ($useUnixStyle) {
      @userDetailsValues             = split (":", $userDetailsFromUnix);
      $userDetail{"PID"}             = $userDetailsValues[0];
      $userDetail{"PASSWORD"}        = $userDetailsValues[1];
      $userDetail{"UID"}             = $userDetailsValues[2];
      $userDetail{"GID"}             = $userDetailsValues[3];
      $userDetail{"USERINFO"}        = $userDetailsValues[4];
      $userDetail{"HOMEDIR"}         = $userDetailsValues[5];
      $userDetail{"SHELL"}           = $userDetailsValues[6];
   } else {
   	  my $userDetailsFromUnixName    = getFieldFromString(",",0,$userDetailsFromUnix);
   	  $userDetail{"PID"}             = getFieldFromString(":",0,$userDetailsFromUnix);
   	  $userDetail{"PASSWORD"}        = getFieldFromString(":",1,$userDetailsFromUnix);
   	  $userDetail{"UID"}             = getFieldFromString(":",2,$userDetailsFromUnix);
   	  $userDetail{"GID"}             = getFieldFromString(":",3,$userDetailsFromUnix);
   	  $userDetail{"NAME"}            = getFieldFromString(":",4,$userDetailsFromUnixName);
   	  $userDetail{"DEPARTMENT"}      = getFieldFromString(",",2,$userDetailsFromUnix);
   	  $userDetail{"HOMEDIR"}         = getFieldFromString(":",5,$userDetailsFromUnix);
   	  $userDetail{"SHELL"}           = getFieldFromString(":",6,$userDetailsFromUnix);
   	  if ($userDetail{"NAME"}) {
         if (!($userDetail{"DEPARTMENT"})) { $userDetail{"DEPARTMENT"} = "NOT FOUND"; }
      }
      writeDebugMsg(("userDetailsFromUnixName:${userDetailsFromUnixName}\n"));
      writeDebugMsg(("userDetailsFromUnixDepartment:${userDetailsFromUnixDepartment}\n"));
      writeDebugMsg(("userDetailsFromUnixPid:${userDetailsFromUnixPid}\n"));
      writeDebugMsg(("userDetailsFromUnixPassword:${userDetailsFromUnixPassword}\n"));
      writeDebugMsg(("userDetailsFromUnixUid:${userDetailsFromUnixUid}\n"));
      writeDebugMsg(("userDetailsFromUnixGid:${userDetailsFromUnixGid}\n"));
      writeDebugMsg(("userDetailsFromUnixHomedir:${userDetailsFromUnixHomedir}\n"));
      writeDebugMsg(("userDetailsFromUnixShell:${userDetailsFromUnixShell}\n"));
   }   
   return %userDetail;  
}

############################################################################
# Function for submitting a command and all web controls (UNIX)
############################################################################
# submits a $cmd to execute at a specific future time
#   Command definition:
#      $logFileName = "logFile.txt";
#      $cmd = qq {
#          rm $logFileName
#          ls -al >>$logFileName
#          pwd >>$logFileName
#          cat $logFileName | mailx Felix.Muster\@irgendwo.com
#      };
#
#  StartTime definition:
#      1240     => 12:40 pm
#      now      => immediatly
#      noon     => 12:00 pm
#      midnight => 12:00 am
#      today    => Current day
#      tomorrow => Next day
#      minutes,hours,days,weeks,months,years
#      next     => +1
#
#  e.g. "2pm next week"
#       "0730 tomorrow"
#       "1400 + 2hours"
#       "5pm Friday + 1 week"
#       "1700 Jan 24 + 2 years"
sub submitUnixJob {
   my($startTime,$cmd,$qName) = @_;
   $startTime  = setDefault($startTime,"now");
   if ($qName ne "") {
     $qName = "-q ${qName}";
   }
   my($retStatus) = "";
   $retStatus = `at $qName $startTime 2>&1 <<EOF
   $cmd
EOF`;
   return $retStatus;
}

# Global variables:
#   $helpImg            the image display for help
#   $helpStrStartTime
#   $helpStrNotifyAdr
#   $qName
sub prepareSubmitCmdForm {
   my($cmd,$mode) = @_;
   $Action  = getParam("Action","");
   if ($Action eq "") {
       my($strCancel)        = setDefault($strCancel,          getLangStr("strCancel"));
       my($strExecute)       = setDefault($strExecute,         getLangStr("strExecute"));
       my($strExecuteTime)   = setDefault($strExecuteTime,     getLangStr("strExecuteTime"));
       my($strEmailNotifyTo) = setDefault($strEmailNotifyTo,   getLangStr("strEmailNotifyTo"));
       my($helpStrStartTime) = setDefault($helpStrStartTime,   "Time when job should start e.g. 1450    0730 tomorrow    if empty job runs immediatly");
       my($helpStrNotifyAdr) = setDefault($helpStrNotifyAdr,   "When job will be finished a notification e-mail will be sent to that address");

       prepareSubmitCmdFormHelpJS();
       addJScommon();
       addJScookies();

       print("<SCRIPT>\n");
       print("function initFocus(form) {\n");
       print("  form.startTime.focus()\n");
       print("}\n");

       print("function checkBeforeSubmit (form,button) {\n");
       print("  if (!check(form)) return;\n");
       print("  form.submit();\n");
       print("  return;\n");
       print("}\n");

       print("function check(form) {\n");
       print(" if (form.notifyAdr.value.length != 0) {\n");
       print("     setCookie('notifyAdr', form.notifyAdr.value);\n");
       print("  }\n");
       print("  return (true);\n");
       print("}\n");

       print("function readCookies(form) {\n");
       print("  form.notifyAdr.value = getCookie('notifyAdr','');\n");
       print("}\n");

       print("</SCRIPT>\n");



       print(" <TABLE>\n");
       print("<FORM METHOD=POST NAME=\"SubmitCmdForm\" ACTION=${myCgiFormName}>\n");
       print("  <TR><TD>${strExecuteTime}</TD>  <TD>".prepareSubmitCmdFormHelpBtn($helpStrStartTime)."</TD><TD><INPUT TYPE=TEXT    Name=\"startTime\" VALUE=\"\" SIZE=\"20\"></TD></TR>\n");
       print("  <TR><TD>${strEmailNotifyTo}</TD><TD>".prepareSubmitCmdFormHelpBtn($helpStrNotifyAdr)."</TD><TD><INPUT TYPE=TEXT    Name=\"notifyAdr\" VALUE=\"\" SIZE=\"30\"></TD></TR>\n");
       print("  <INPUT TYPE=HIDDEN  NAME=\"Action\" VALUE=\"Execute\">\n");
       print(produceHiddenField($externalParam,"  "));
       print("  <TR><TD  COLSPAN=3><CENTER><TABLE><TR><TD><INPUT TYPE=BUTTON  NAME=submitted VALUE=\"${strExecute}\" onClick='checkBeforeSubmit(this.form, this)'></TD>");
       print("  <TD><INPUT TYPE=BUTTON  VALUE=\"${strCancel}\" onClick=window.history.back()></TD>");
       print("</FORM><TD><BR> \n");
       print("<SCRIPT>initFocus(document.SubmitCmdForm);readCookies(document.SubmitCmdForm)</SCRIPT>\n");
       prepareSubmitCmdFormShowJobsDisplayBtn(); 
       print(" </TD></TR></TABLE></TD></TR>\n");
       print(" </TABLE>\n");

   } elsif ($Action eq "Execute") {
       my($startTime) = getParam("startTime","");
       my($notifyAdr) = getParam("notifyAdr","");
       my($strJobExecAt) = setDefault($strJobExecAt,   getLangStr("strJobExecAt"));

       my($retVal) = submitUnixJob($startTime,$cmd,$qName);
       print("<!-- ${retVal} -->");
       my(@parts) = split("at ",$retVal);
       printf("${strJobExecAt}",$parts[1]);
       print("<BR><TABLE><TR><TD>");
       prepareSubmitCmdFormShowJobsDisplayBtn();
       print("</TD><TD>");
       prepareSubmitCmdFormSubmitFormDisplayBtn();
       print("</TD></TR></TABLE>");
   } elsif ($Action eq "Show Jobs") {
       prepareSubmitCmdFormAtShowJobs($qName,$mode);
       print("<BR><TABLE><TR><TD>");
       prepareSubmitCmdFormSubmitFormDisplayBtn();
       print("</TD><TD>");
       prepareSubmitCmdFormShowJobsDisplayBtn();
       print("</TD></TR></TABLE>");
   } elsif ($Action eq "Delete Job") {
       if ($mode) {
         my($JobId) = getParam("JobId","");
         `atrm $JobId`;
         prepareSubmitCmdFormAtShowJobs($qName,$mode);
         print("<BR><TABLE><TR><TD>");
         prepareSubmitCmdFormSubmitFormDisplayBtn();
         print("</TD><TD>");
         prepareSubmitCmdFormShowJobsDisplayBtn();
         print("</TD></TR></TABLE>");
       }
   }
}

sub prepareSubmitCmdFormAtShowJobs {
   my($qName,$withDelete) = @_;
   $qName       = setDefault($qName,      "");
   $withDelete  = setDefault($withDelete, $FALSE);

   my(@retVal) = `atq  2>&1`;
   my($tableStr) = "";
   if ($retVal[0] ne "no files in queue.") {
         my($aLine) = "";
         my($first) = $TRUE;
         foreach $aLine (@retVal) {
            if ($first) {
               $first = $FALSE;
            } else {
               $aLine =~ s/\s+/;/g;
               my(@lParts) = split(";",$aLine);
               if (($lParts[8] eq $qName) || ($qName eq "")) {
                 if ($withDelete) {
                   $tableStr = sprintf("${tableStr}<TR><TD>%s</TD><TD>%s</TD><TD>%s</TD><TD>%s<BR> </TD><TD>%s</TD></TR>",$lParts[2],$lParts[3],$lParts[4],$lParts[5],prepareSubmitCmdFormAtDeleteBtn($lParts[7]));
                 } else {
                   $tableStr = sprintf("${tableStr}<TR><TD>%s</TD><TD>%s</TD><TD>%s</TD><TD>%s</TD><TD>%s</TD></TR>",$lParts[2],$lParts[3],$lParts[4],$lParts[5],$lParts[7]);
                 }
               }
            }
         }
   }
   if ($tableStr eq "") {
      $tableStr = "No entries in queue";
   } else {
      $tableStr = "<TABLE valign=MIDDLE border=0>${tableStr}</TABLE>";
   }
   print("<BR>".formatTimeStamp(getTimeStamp(),"", $FALSE, $FALSE, $language)."<BR><BR>${tableStr}\n");
}

sub prepareSubmitCmdFormShowJobsDisplayBtn {
       my($strShowJobs)  = setDefault($strShowJobs,    getLangStr("strShowJobs"));
       print("<FORM METHOD=POST ACTION=${myCgiFormName}>\n");
       print("  <INPUT TYPE=HIDDEN  NAME=\"Action\" VALUE=\"Show Jobs\">\n");
       print(produceHiddenField($externalParam,"  "));
       print("  <INPUT TYPE=SUBMIT  NAME=submitted VALUE=\"${strShowJobs}\">\n");
       print("</FORM>\n");
}

sub prepareSubmitCmdFormSubmitFormDisplayBtn {
       my($strNewJob)  = setDefault($strNewJob,    getLangStr("strNewJob"));
       print("<FORM METHOD=POST ACTION=${myCgiFormName}>\n");
       print("  <INPUT TYPE=HIDDEN  NAME=\"Action\" VALUE=\"\">\n");
       print(produceHiddenField($externalParam,"  "));
       print("  <INPUT TYPE=SUBMIT  NAME=submitted VALUE=\"${strNewJob}\">\n");
       print("</FORM>\n");
}


sub prepareSubmitCmdFormAtDeleteBtn {
   my($jobId) = @_;
   my($retVal) = "<BR>";
   my($strDelete)  = setDefault($strDelete,    getLangStr("strDelete"));

   $retVal = "${retVal}<FORM METHOD=POST ACTION=${myCgiFormName}>\n";
   $retVal = "${retVal}  <INPUT TYPE=HIDDEN  NAME=\"Action\" VALUE=\"Delete Job\">\n";
   $retVal = "${retVal}  <INPUT TYPE=HIDDEN  NAME=\"JobId\"  VALUE=\"${jobId}\">\n";
   $retVal = "${retVal}".produceHiddenField($externalParam,"  ");
   $retVal = "${retVal}  <INPUT TYPE=SUBMIT  NAME=submitted VALUE=\"${strDelete}\">\n";
   $retVal = "${retVal}</FORM>\n";

   return $retVal;
}

sub prepareSubmitCmdFormHelpBtn {
    my($helpStr) = @_;
    my($helpImgStr) = "<IMG SRC=${helpImg} border=0>";
    if ($helpImg eq "") {
       $helpImgStr = "?"; 
    }
    my($retStr) = "<A HREF=\"javascript:showHelp('${helpStr}')\">${helpImgStr}</A>";
    return $retStr;
}

sub prepareSubmitCmdFormHelpJS {
print <<javaScript;
<script language="JavaScript">
<!-- Hide Script from older Browsers.
function showHelp(helpStr) {
   alert(helpStr);
}

// End the hiding here. -->
</SCRIPT>
javaScript
}
############################################################################
# Function for ftp files (UNIX)
############################################################################
sub setFtpSilent {
    my($silent) = @_;
    $silent       = setDefault($silent,$FALSE);
    if ($silent) {
        $silent = "-ni";
    } else {
        $silent = "-nivd";
    }
    return $silent;
}

# ftp a file ($filename) to a remote node ($destNode) into the directory ($descDir)
# As unser name and password the string ($usr_pwd) is taken and looks like "USER PASSWORT"
#  mode: ascii | [bin]
sub ftp {
  my($filename,$destNode,$descDir,$usr_pwd,$sourceDir,$transferMode,$silent) = @_;
  $transferMode   = setDefault($transferMode,"bin");
  my($ftpOptions) = setFtpSilent($silent);
  if ($sourceDir eq "") {
    system("ftp ${ftpOptions} ${destNode} <<END
     $transferMode
     user $usr_pwd
     cd $descDir
     put $filename
     bye
END");
  } else {
    system("ftp ${ftpOptions} ${destNode} <<END
     $transferMode
     user $usr_pwd
     cd $descDir
     lcd $sourceDir
     put $filename
     bye
END");
  }
}

sub ftpPutWithRetVal {
  my($filename,$destNode,$descDir,$usr_pwd,$sourceDir,$transferMode,$silent) = @_;
  $transferMode   = setDefault($transferMode,"bin");
  my($ftpOptions) = setFtpSilent($silent);
  my($retVal) = "";
  if ($sourceDir eq "") {
     $retVal = `ftp ${ftpOptions} ${destNode} <<END
     $transferMode
     user $usr_pwd
     cd $descDir
     put $filename
     bye
END`;
  } else {
    $retVal = `ftp ${ftpOptions} ${destNode} <<END
     $transferMode
     user $usr_pwd
     cd $descDir
     lcd $sourceDir
     put $filename
     bye
END`;
  }
  return $retVal;  
}


sub mkdirViaFtpRetVal {
  my($destNode,$usr_pwd,$destinationDir,$dirToCreate,$silent) = @_;

  my $ftpOptions = setFtpSilent($silent);

  my $retVal = "";

  if ($destinationDir eq "") {
     $retVal = `ftp ${ftpOptions} ${destNode} <<END
     user $usr_pwd
     mkdir $dirToCreate
     bye
END`;
  } else {
    $retVal = `ftp ${ftpOptions} ${destNode} <<END
     user $usr_pwd
     cd $destinationDir
     mkdir $dirToCreate
     bye
END`;
  }
  if ($retVal ne "") {
     $retVal = "${retVal} Parameter were: destNode:${destNode}: usr_pwd:${usr_pwd}: destinationDir:${destinationDir}: dirToCreate:${dirToCreate}: ftpOptions:${ftpOptions}:";
  }
  return $retVal;  
}


sub ftpGetFilesUsingFilePattern {
  my($filenamePattern,$destNode,$remoteDir,$usr_pwd,$localDir,$transferMode,$silent) = @_;
  $transferMode   = setDefault($transferMode,"bin");
  my($ftpOptions) = setFtpSilent($silent);

  my $retVal = "";  
  if ($localDir eq "") {
    $retVal = `ftp ${ftpOptions} ${destNode} <<END
     $transferMode
     user $usr_pwd
     cd $remoteDir
     mget $filenamePattern
     bye
END`;
  } else {
    $retVal = `ftp ${ftpOptions} ${destNode} <<END
     $transferMode
     user $usr_pwd
     cd $remoteDir
     lcd $localDir
     mget $filenamePattern
     bye
END`;
  }
  if ($retVal ne "") {
     $retVal = "${retVal} Parameter were: destNode:${destNode}: usr_pwd:${usr_pwd}: destinationDir:${destinationDir}: localDir:${localDir}: ftpOptions:${ftpOptions}:";
  }
  return $retVal;  
}

sub ftpGet {
  my($filename,$destNode,$remoteDir,$usr_pwd,$localDir,$transferMode,$silent) = @_;
  $transferMode   = setDefault($transferMode,"bin");
  my($ftpOptions) = setFtpSilent($silent);
  if ($localDir eq "") {
    system("ftp ${ftpOptions} ${destNode} <<END
     $transferMode
     user $usr_pwd
     cd $remoteDir
     get $filename
     bye
END");
  } else {
    system("ftp ${ftpOptions} ${destNode} <<END
     $transferMode
     user $usr_pwd
     cd $remoteDir
     lcd $localDir
     get $filename
     bye
END");
  }
}

sub ftpPut {
  my($filename,$destNode,$remoteDir,$usr_pwd,$localDir,$transferMode,$silent) = @_;
  $transferMode   = setDefault($transferMode,"bin");
  my($ftpOptions) = setFtpSilent($silent);
  if ($localDir eq "") {
    system("ftp ${ftpOptions} ${destNode} <<END
     $transferMode
     user $usr_pwd
     cd $remoteDir
     put $filename
     bye
END");
  } else {
    system("ftp ${ftpOptions} ${destNode} <<END
     $transferMode
     user $usr_pwd
     cd $remoteDir
     lcd $localDir
     put $filename
     bye
END");
  }
}

sub ftpGetFileList {   ##### TBS not very efficent
  my($remoteNode,$ftpUser,$ftpPwd,$remoteDir,@files) = @_;
  my($aFile) = "";
  foreach $aFile (@files) {
     ftpGet($aFile,$remoteNode,$remoteDir,"${ftpUser} ${ftpPwd}");
  }
}

sub ftpPutFileList {   ##### TBS not very efficent
  my($remoteNode,$ftpUser,$ftpPwd,$remoteDir,@files) = @_;
  my($aFile) = "";
  foreach $aFile (@files) {
     ftpPut($aFile,$remoteNode,$remoteDir,"${ftpUser} ${ftpPwd}");
  }
}
############################################################################
# Function for mailing any files using mailx and sendmail
############################################################################
sub doTest_sendHtmlMail {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);
   if ($debugThisFct) {
      my $body = qq {
        <body bgcolor=yellow onload="window.focus();" leftmargin="0" topmargin="0">
        <p>
        <form method="GET" action="http://www.yahoo.com"> 
        <input type='text' name="testinput"></input>
        <p>
        <input type="submit" value="click me"></input>
        </form>
        </body>
      };
      sendHtmlMail("\"Walter Rothlin Privat\" \<".$testEmailAdr_1."\>","\"Walter Rothlin Office\" \<".$testEmailAdr_2."\>","TEST HTML mails",$body,"\"Greta Cardiff Office\" \<Greta.Cardiff\@csfb.com\>","\"Siebert Kruger\" \<Siebert.Kruger\@csfb.com\>");
   }
}


sub sendHtmlMail {
  my($fromAdr,$toAdresses,$subject,$bodyMsg,$ccAdresses,$bccAdresses) = @_;
  return sendMailwithAttachments($fromAdr,$toAdresses,$subject,$bodyMsg,$attachmentFileList,$ccAdresses,$bccAdresses,"","",$FALSE,"","","",$TRUE);
}

sub doTest_sendMailwithAttachments {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);
   if ($debugThisFct) {
      my $body = qq {
         Hallo,
         this is just a test.

         Please delete it.

         Best regards,
      };
      $attachmentFileList = "/app/tools/CsfbTools/Independent/LinkExec/libCommon.pm";
      sendMailwithAttachments($testEmailAdr_1,$testEmailAdr_1,"TEST E-mail with attachment (mailx)",$body,$attachmentFileList,$ccAdresses,$bccAdresses,$delim,$tmpDir,$TRUE);
      sendMailwithAttachments("\"Walter Rothlin Privat\" \<".$testEmailAdr_1."\>","\"Walter Rothlin Office\" \<".$testEmailAdr_2."\>","TEST E-mail with attachment (sendmail)",$body,$attachmentFileList,$ccAdresses,$bccAdresses,$delim,$tmpDir,$FALSE);
   }
}

sub sendMailwithAttachments {
	my($fromAdr,$toAdresses,$subject,$bodyMsg,$attachmentFileList,$ccAdresses,$bccAdresses,$delim,$tmpDir,$useMailx,$href_FileDelimeter,$href_ExtReplacement,$href_DelimeterReplace,$isHtmlFile) = @_;
	$tmpDir     = setDefault($tmpDir,"/tmp");
	$delim      = setDefault($delim,"\|");
	$useMailx   = setDefault($useMailx,$useMailxAsDefault);
	$isHtmlFile = setDefault($isHtmlFile,$FALSE);

	$toAdresses  = removeLastSepFromString(removeFromString($toAdresses,"#",","),",");
	$ccAdresses  = removeLastSepFromString(removeFromString($ccAdresses,"#",","),",");
	$bccAdresses = removeLastSepFromString(removeFromString($bccAdresses,"#",","),",");

	my $tmpFileNames      = "";
	my $cmd               = "";
	my %FileDelimeter     = ();
	my %ExtReplacement    = ();
	my %DelimeterReplace  = ();
	my $retVal            = "";
	my $retMsg            = "";
	my @fileNames         = split(",", $attachmentFileList);
	my $pid               =  `echo $$  2>&1` ;  chop $pid; 

	if (ref($href_FileDelimeter) ne 'HASH') {
		%FileDelimeter = (
			"flt" => $delim,
		);
	} else {
		%FileDelimeter = derefHref($href_FileDelimeter);
	}
	if (ref($href_ExtReplacement) ne 'HASH') {
		%ExtReplacement = (
			"flt" =>"xls",
		);
	} else {
		%ExtReplacement = derefHref($href_ExtReplacement);
	}

	if (ref($href_DelimeterReplace) ne 'HASH') {
		%DelimeterReplace = (
			$delim => "\t",
		);
	} else {
		%DelimeterReplace = derefHref($href_DelimeterReplace);
	}
	my $ext       = "";
	my $i         = 0; 
	foreach my $fileName (@fileNames) { 
		$ext = getFileNameExtension($fileName); 
		my $newExt = $ExtReplacement{$ext}; 
		$tmpFileName  = "$tmpDir/MailPart${i}.$pid";
		$tmpFileName2 = "$tmpDir/ConvFltToXls${i}.$pid";
		$i++;

		if ($newExt ne "") { 
			$OutFileName= getFileNameOutOfFullName($fileName);
			$OutFileName= getFilenameWithoutExtension($OutFileName);
			$OutFileName="$OutFileName.$newExt";
		} else {
			$OutFileName = getFileNameOutOfFullName($fileName);
		} 
		$tmpFileNames = "$tmpFileNames $tmpFileName";

		my  $delimeter = $FileDelimeter{$ext};
		my  $replacement = $DelimeterReplace{$delimeter};

		if ($delimeter eq "") {
			$cmd = "${uuencodeCmd} \"$fileName\"  \"$OutFileName\" >$tmpFileName";
		} else {
			convertFLT_to_XLS($fileName,$tmpFileName2);
		$cmd = "cat ${tmpFileName2} | ${uuencodeCmd}  \"${OutFileName}\" >${tmpFileName}";
		} 
		$retMsg = `$cmd  2>&1`;                  $retVal = "${retVal}\n${retMsg}";
		$retMsg = `rm -f $tmpFileName2 2>&1`;    $retVal = "${retVal}\n${retMsg}";
	}
	$tmpFileNames = strip($tmpFileNames);
	my $htmlHeader = "";
	if ($isHtmlFile) { $htmlHeader = "MIME-Version: 1.0\nContent-Type: text/html; charset=us-ascii\nContent-Transfer-Encoding: 7bit\n"; }
  
	if ($useMailx) {
		my $bodyFileName = "$tmpDir/MsgBody.${pid}";
 
		open(BODY_sendMailwithAttachments, ">$bodyFileName") || die "Error (sendMailwithAttachments): Can't open file: $bodyFileName $!\n"; 
		print BODY_sendMailwithAttachments "$bodyMsg\n";
		close BODY_sendMailwithAttachments;

		my $mailxPara = "";     
		if ($fromAdr     ne "") { $mailxPara = "-r \"${fromAdr}\"";                    } 
		if ($ccAdresses  ne "") { $mailxPara = "${mailxPara} -c \"${ccAdresses}\"";    } 
		if ($bccAdresses ne "") { $mailxPara = "${mailxPara} -b \"${bccAdresses}\"";   } 
		if ($subject     ne "") { $mailxPara = "${mailxPara} -s \"${subject}\"";       } 
		## print("mailxPara:${mailxPara}\n");

		$cmd = "cat $bodyFileName $tmpFileNames  2>&1 | mailx $mailxPara $toAdresses  2>&1";
		$retMsg = `$cmd`;                                     $retVal = "${retVal}\n${retMsg}";
		$retMsg = `rm  -f $tmpFileNames $bodyFileName  2>&1`;    $retVal = "${retVal}\n${retMsg}";	
	} else {
		 my($tmpHeaderFile) = "$tmpDir/MailPart_Header.$pid";
		 open(OUTFILE_sendMailwithAttachments,">${tmpHeaderFile}") || showError("Error (sendMailwithAttachments): Can't open file:${tmpHeaderFile}: $!");
		 print(OUTFILE_sendMailwithAttachments "From: ${fromAdr}\n");
		 print(OUTFILE_sendMailwithAttachments "To: ${toAdresses}\n");
		 print(OUTFILE_sendMailwithAttachments "Cc: ${ccAdresses}\n");
		 print(OUTFILE_sendMailwithAttachments "Bcc: ${bccAdresses}\n");
		 print(OUTFILE_sendMailwithAttachments "Subject: ${subject}\n");
		 if ($isHtmlFile) {
		   print(OUTFILE_sendMailwithAttachments "MIME-Version: 1.0\n");
		   print(OUTFILE_sendMailwithAttachments "Content-Type: text/html; charset=us-ascii\n");
		   print(OUTFILE_sendMailwithAttachments "Content-Transfer-Encoding: 7bit\n");
		 }
			  
		 print(OUTFILE_sendMailwithAttachments "\n");
		 print(OUTFILE_sendMailwithAttachments "${bodyMsg}\n");
		 close(OUTFILE_sendMailwithAttachments);

		 if ($tmpFileNames ne "") {
			$retMsg = `cat $tmpFileNames >>$tmpHeaderFile 2>&1`;  $retVal = "${retVal}\n${retMsg}";
		 }
		 open(OUTFILE_sendMailwithAttachments,">>${tmpHeaderFile}") || showError("Errorr (sendMailwithAttachments): Can't open file:${tmpHeaderFile}: $!");
		 print(OUTFILE_sendMailwithAttachments "\n.\n");
		 close(OUTFILE_sendMailwithAttachments);

		 if (($sendMailPath ne "") && (!($sendMailPath =~ /\/$/))) { $sendMailPath = "${sendMailPath}/"; }


		 $cmd = "cat $tmpHeaderFile   2>&1 | ${sendMailPath}sendmail  -t 2>&1";

		 ### print("cmd:${cmd}:\n");

		 $retMsg = `$cmd`;                          $retVal = "${retVal}\n${retMsg}";
		 $retMsg = `rm -f $tmpHeaderFile  2>&1`;    $retVal = "${retVal}\n${retMsg}";
		 if ($tmpFileNames ne "") {
		   $retMsg = `rm -f $tmpFileNames 2>&1`;    $retVal = "${retVal}\n${retMsg}";
		 }
	}
	return $retMsg
}

sub sendFileAsMailUseMailx {
   my($toAdr,$subject,$filename) = @_;
   my($retCode) = "";
   $retCode = `cat $filename | mailx -s "$subject" $toAdr 2>&1`;
   return $retCode;
}

sub sendSingleMailMsgToList {
  my($subject,$body, @toList)=@_;
  foreach $to_address (@toList){
     system("echo \"$body\" | mailx -s $subject $to_address");
  }
}

sub sendMailMsgToList {
  my($subject,$body, @toList)=@_;
  my($to_addresses) = "";

  foreach $to_address (@toList){
    if ($to_addresses eq "") {
       $to_addresses = $to_address;
    } else {
       $to_addresses = "${to_addresses},${to_address}";
    }
  }
  system("echo \"$body\" | mailx -s $subject $to_addresses");
}

sub sendMailMsgUseMailx {
   my($toAdr,$subject,$msg) = @_;
   my($retCode) = "";
   $retCode = `echo $msg | mailx -s "$subject" $toAdr 2>&1`;
   return $retCode;
}

sub sendFileAsMailUseSendmail {
   my($toAdr,$subject,$filename,$fromAdr,$ccAdr,$bccAdr) = @_;
   my($msg) = "";
   open(INFILE_sendFileAsMailUseSendmail,$filename) || showError("Error (sendFileAsMailUseSendmail): Can't open file:${filename}: $!");
   my($aLine) = "";
   while (defined ($aLine = <INFILE_sendFileAsMailUseSendmail>)) {
      chomp($aLine);
      $msg = "${msg}${aLine}\n";
   } # end of while
   close(INFILE_sendFileAsMailUseSendmail);
   my($retCode) = sendMailMsgUseSendmail($toAdr,$subject,$msg,$fromAdr,$ccAdr,$bccAdr);
   return $retCode;
}

sub sendMailMsgUseSendmail {
   my($toAdr,$subject,$msg,$fromAdr,$ccAdr,$bccAdr) = @_;
   my($retCode)     = "";
   my($tStamp)      = getTimeStamp();
   my($tmpFile)     = "tmpMailfile_${tStamp}.txt";
   open(OUTFILE_sendMailMsgUseSendmail,">${tmpFile}") || showError("Error (sendMailMsgUseSendmail): Can't open file:${tmpFile}: $!");
   print(OUTFILE_sendMailMsgUseSendmail "From: ${fromAdr}\n");
   print(OUTFILE_sendMailMsgUseSendmail "To: ${toAdr}\n");
   print(OUTFILE_sendMailMsgUseSendmail "Cc: ${ccAdr}\n");
   print(OUTFILE_sendMailMsgUseSendmail "Bcc: ${bccAdr}\n");
   print(OUTFILE_sendMailMsgUseSendmail "Subject: ${subject}\n");
   print(OUTFILE_sendMailMsgUseSendmail "\n");
   print(OUTFILE_sendMailMsgUseSendmail "${msg}");
   print(OUTFILE_sendMailMsgUseSendmail "\n.\n");
   close(OUTFILE_sendMailMsgUseSendmail);
   if (($sendMailPath ne "") && (!($sendMailPath =~ /\/$/))) { $sendMailPath = "${sendMailPath}/"; }
   $retCode = `cat $tmpFile | ${sendMailPath}sendmail -t $toAdr 2>&1`;
   unlink($tmpFile);
   return $retCode;
}
############################################################################
# Function for handling of char delimited flat files
############################################################################
# Description:
# ------------
# Returns from a list of RecordReferences another list of RecordReferences which is a subset (defined by a where clause) from the input set
# Example:
#	  my @resultList = findRecordsInHashList("CCY1 eq ${ccy1} AND CCY2 eq ${ccy2}",@fxSpotRates);
#    foreach my $aFxSpotRate (@resultList) {
#    	 printf("CCY1:%s:\n",$aFxSpotRate->{CCY1});
#    	 printf("CCY2:%s:\n",$aFxSpotRate->{CCY2});
#    	 printf("Bid:%s:\n",$aFxSpotRate->{BID});
#    	 printf("Ask:%s:\n",$aFxSpotRate->{ASK});
#  	 }	
#  	 
# the where clause has the following format:
#   [fieldName][operator][value] [AND OR] [fieldName][operator][value] ....
#     operator [= eq != ne gt ge lt le like starts ends]  String compare case-sensitve   (gt=greater ge=greater-equal..)
#     operator [  EQ    NE GT GE LT LE LIKE STARTS ENDS]  String compare case-insensitve (GT=greater GE=greater-equal..)
#     operator [< > <= >= ]        Value compare
#     Restrictions: Only AND OR without paranthesis e.g  A AND B OR C  => (A AND (B OR C))
# return TRUE (1) if the condition described in $whereClause matches $aRecord
sub findRecordsInHashList {
   my($whereClause,@recordSet)   = @_; 

   my @retRecSet = ();
   foreach my $aRecRef (@recordSet) {
   	  my @hashKeys    = keys %$aRecRef;
   	  my $aRecord     = "";
   	  my %nameToIndex = ();
   	  my $i           = 0;
   	  foreach my $aKey (@hashKeys) {
   	  	 %nameToIndex = (%nameToIndex,($aKey,$i));
   	  	 if ($aRecord eq "") {
   	  	 	  $aRecord = $aRecRef->{$aKey};
   	  	 } else {
   	  	    $aRecord = $aRecord.";".$aRecRef->{$aKey};
   	  	}
   	  	 $i++;
   	  }
      if (recordMatches(";",$aRecord,$whereClause,%nameToIndex)) {
      	push(@retRecSet,$aRecRef);
      }
   }
   return @retRecSet;
}

# recordMatches
# -------------
# History:
# 01/13/99    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# the where clause has the following format:
#   [fieldName][operator][value] [AND OR] [fieldName][operator][value] ....
#     operator [= eq != ne gt ge lt le like starts ends]  String compare case-sensitve   (gt=greater ge=greater-equal..)
#     operator [  EQ    NE GT GE LT LE LIKE STARTS ENDS]  String compare case-insensitve (GT=greater GE=greater-equal..)
#     operator [< > <= >= ]        Value compare
#     Restrictions: Only AND OR without paranthesis e.g  A AND B OR C  => (A AND (B OR C))
# return TRUE (1) if the condition described in $whereClause matches $aRecord
sub recordMatches {
  my($sepChar,$aRecord,$whereClause,%nameToIndex)   = @_;
  my(@andParts)     = split(" AND ",$whereClause);
  my($andPart)      = "";

  ## $debug = $TRUE;
  ## print("aRecord:${aRecord}:\n");
  ## print("whereClause:${whereClause}:\n");
  my($andRetVal) = 1;

  foreach $andPart (@andParts) {
     ## print("andPart:${andPart}:\n");
     my(@orParts) = split(" OR ",$andPart);
     my($orPart)  = "";

     if ($andRetVal) {
       my($orRetVal) = 0;
       foreach $orPart (@orParts) {
       ## print("orPart:${orPart}:\n");
         if (!($orRetVal)) {
               ## print("Test....");
               $orRetVal = logicTestPart($sepChar,$aRecord,$orPart,%nameToIndex);
               ## print(":${orRetVal}:\n");
         }
       }
       $andRetVal = $orRetVal;
     }
  }
  ## print("==> ${retVal}\n\n");
  return $andRetVal;
}


sub logicTestPart {
     my($sepChar,$aRecord,$anAtomicPart,%nameToIndex) = @_;
     my(@aRecordParts) = split($sepChar,$aRecord);

     ## print("anAtomicPart:${anAtomicPart}:\n");
     my($retVal) = $FALSE;
     if (index($anAtomicPart,">=") >= 0) {
         my(@namVal)   = split(/\>=/,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         ## printf ("%s>=%s ? ",$fieldVal,$namVal[1]);
         if ($fieldVal >= $namVal[1]) { $retVal = $TRUE; }
     } elsif (index($anAtomicPart,"<=") >= 0) {
         my(@namVal)   = split(/\<=/,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         ## printf ("%s<=%s ? ",$fieldVal,$namVal[1]);
         if ($fieldVal <= $namVal[1]) { $retVal = $TRUE; }
     } elsif (index($anAtomicPart,"!=") >= 0) {
         my(@namVal)   = split(/!=/,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         ## printf ("%s!=%s ? ",$fieldVal,$namVal[1]);
         if ($fieldVal ne $namVal[1]) { $retVal = $TRUE; }
     } elsif (index($anAtomicPart," ne ") >= 0) {
         my(@namVal)   = split(/ ne /,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         ## printf ("%s!=%s ? ",$fieldVal,$namVal[1]);
         if ($fieldVal ne $namVal[1]) { $retVal = $TRUE; }
     } elsif (index($anAtomicPart," NE ") >= 0) {
         my(@namVal)   = split(/ NE /,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         ## printf ("%s!=%s ? ",$fieldVal,$namVal[1]);
         if (uc($fieldVal) ne uc($namVal[1])) { $retVal = $TRUE; }
     } elsif (index($anAtomicPart,"=") >= 0) {
         my(@namVal)   = split(/=/,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         ## printf ("%s=%s ? ",$fieldVal,$namVal[1]);
         if ($fieldVal eq $namVal[1]) { $retVal = $TRUE; }
     } elsif (index($anAtomicPart," eq ") >= 0) {
         my(@namVal)   = split(/ eq /,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         ## printf ("%s=%s ? ",$fieldVal,$namVal[1]);
         if ($fieldVal eq $namVal[1]) { $retVal = $TRUE; }
     } elsif (index($anAtomicPart," EQ ") >= 0) {
         my(@namVal)   = split(/ EQ /,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         ## printf ("%s=%s ? ",$fieldVal,$namVal[1]);
         if (uc($fieldVal) eq uc($namVal[1])) { $retVal = $TRUE; }
     } elsif (index($anAtomicPart,"<") >= 0) {
         my(@namVal)   = split(/\</,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         ## printf ("%s<%s ? ",$fieldVal,$namVal[1]);
         if ($fieldVal < $namVal[1]) { $retVal = $TRUE; }
     } elsif (index($anAtomicPart,">") >= 0) {
         my(@namVal)   = split(/\>/,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         ## printf ("%s>%s ? ",$fieldVal,$namVal[1]);
         if ($fieldVal > $namVal[1]) { $retVal = $TRUE; }
     } elsif ($anAtomicPart =~ / like /) {
         my(@namVal)   = split(/ like /,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         ## printf ("%s like %s ? ",$fieldVal,$namVal[1]);
         if (index($fieldVal,$namVal[1]) >= 0) { $retVal = $TRUE; }
     } elsif ($anAtomicPart =~ / not_like /) {
         my(@namVal)   = split(/ not_like /,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         ## printf ("%s not_like %s ? ",$fieldVal,$namVal[1]);
         if (index($fieldVal,$namVal[1]) < 0) { $retVal = $TRUE; }
     } elsif ($anAtomicPart =~ / LIKE /) {
         my(@namVal)   = split(/ LIKE /,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         ## printf ("%s like %s ? ",$fieldVal,$namVal[1]);
         if (index(uc($fieldVal),uc($namVal[1])) >= 0) { $retVal = $TRUE; }
     } elsif ($anAtomicPart =~ / NOT_LIKE /) {
         my(@namVal)   = split(/ NOT_LIKE /,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         ## printf ("%s NOT_LIKE %s ? ",$fieldVal,$namVal[1]);
         if (index(uc($fieldVal),uc($namVal[1])) < 0) { $retVal = $TRUE; }
     } elsif ($anAtomicPart =~ / starts /) {
         my(@namVal)   = split(/ starts /,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         ## printf ("%s starts %s ? ",$fieldVal,$namVal[1]);
         if (index($fieldVal,$namVal[1]) == 0) { $retVal = $TRUE; }
     } elsif ($anAtomicPart =~ / not_starts /) {
         my(@namVal)   = split(/ not_starts /,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         ## printf ("%s not_starts %s ? ",$fieldVal,$namVal[1]);
         if (index($fieldVal,$namVal[1]) != 0) { $retVal = $TRUE; }
     } elsif ($anAtomicPart =~ / STARTS /) {
         my(@namVal)   = split(/ STARTS /,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         ## printf ("%s starts %s ? ",$fieldVal,$namVal[1]);
         if (index(uc($fieldVal),uc($namVal[1])) == 0) { $retVal = $TRUE; }
     } elsif ($anAtomicPart =~ / NOT_STARTS /) {
         my(@namVal)   = split(/ NOT_STARTS /,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         ## printf ("%s NOT_STARTS %s ? ",$fieldVal,$namVal[1]);
         if (index(uc($fieldVal),uc($namVal[1])) != 0) { $retVal = $TRUE; }
     } elsif ($anAtomicPart =~ / ends /) {
         my(@namVal)   = split(/ ends /,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         # ELB
         my $myind = index($fieldVal,$namVal[1]);
         my $field_len = length($fieldVal);
         my $name_len  = length($namVal[1]);
         ## printf ("%s ends %s ? ",$fieldVal,$namVal[1]);
         if ( $myind > -1 && ( $myind == ($field_len - $name_len)) ) { $retVal = $TRUE; } 
     } elsif ($anAtomicPart =~ / not_ends /) {
         my(@namVal)   = split(/ not_ends /,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         # ELB
         my $myind = index($fieldVal,$namVal[1]);
         my $field_len = length($fieldVal);
         my $name_len  = length($namVal[1]);
         ## printf ("%s not_ends %s ? ",$fieldVal,$namVal[1]);
         if ( $myind < 0 || ( $myind != ($field_len - $name_len)) ) { $retVal = $TRUE; } 
     } elsif ($anAtomicPart =~ / ENDS /) {
         my(@namVal)   = split(/ ENDS /,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         # ELB
         my $myind = index(uc($fieldVal),uc($namVal[1]));
         my $field_len = length($fieldVal);
         my $name_len  = length($namVal[1]);
         ## printf ("%s ends %s ? ",$fieldVal,$namVal[1]);
         if ( $myind > -1 && ( $myind == ($field_len - $name_len)) ) { $retVal = $TRUE; } 
     } elsif ($anAtomicPart =~ / NOT_ENDS /) {
         my(@namVal)   = split(/ NOT_ENDS /,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         # ELB
         my $myind = index(uc($fieldVal),uc($namVal[1]));
         my $field_len = length($fieldVal);
         my $name_len  = length($namVal[1]);
         ## printf ("%s NOT_ENDS %s ? ",$fieldVal,$namVal[1]);
         if ( $myind < 0 || ( $myind != ($field_len - $name_len)) ) { $retVal = $TRUE; } 
     } elsif (index($anAtomicPart," gt ") >= 0) {
         my(@namVal)   = split(/ gt /,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         ## printf ("%s gt %s ? ",$fieldVal,$namVal[1]);
         if ($fieldVal gt $namVal[1]) { $retVal = $TRUE; }
     } elsif (index($anAtomicPart," GT ") >= 0) {
         my(@namVal)   = split(/ GT /,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         ## printf ("%s gt %s ? ",$fieldVal,$namVal[1]);
         if (uc($fieldVal) gt uc($namVal[1])) { $retVal = $TRUE; }
     } elsif (index($anAtomicPart," ge ") >= 0) {
         my(@namVal)   = split(/ ge /,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         ## printf ("%s ge %s ? ",$fieldVal,$namVal[1]);
         if ($fieldVal ge $namVal[1]) { $retVal = $TRUE; }
     } elsif (index($anAtomicPart," GE ") >= 0) {
         my(@namVal)   = split(/ GE /,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         ## printf ("%s ge %s ? ",$fieldVal,$namVal[1]);
         if (uc($fieldVal) ge uc($namVal[1])) { $retVal = $TRUE; }
     } elsif (index($anAtomicPart," lt ") >= 0) {
         my(@namVal)   = split(/ lt /,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         ## printf ("%s lt %s ? ",$fieldVal,$namVal[1]);
         if ($fieldVal lt $namVal[1]) { $retVal = $TRUE; }
     } elsif (index($anAtomicPart," LT ") >= 0) {
         my(@namVal)   = split(/ LT /,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         ## printf ("%s lt %s ? ",$fieldVal,$namVal[1]);
         if (uc($fieldVal) lt uc($namVal[1])) { $retVal = $TRUE; }
     } elsif (index($anAtomicPart," le ") >= 0) {
         my(@namVal)   = split(/ le /,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         ## printf ("%s le %s ? ",$fieldVal,$namVal[1]);
         if ($fieldVal le $namVal[1]) { $retVal = $TRUE; }
     } elsif (index($anAtomicPart," LE ") >= 0) {
         my(@namVal)   = split(/ LE /,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{$namVal[0]}];
         ## printf ("%s le %s ? ",$fieldVal,$namVal[1]);
         if (uc($fieldVal) le uc($namVal[1])) { $retVal = $TRUE; }
     } elsif (index($anAtomicPart," in ") >= 0) {
         my(@namVal)   = split(/ in /,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{strip($namVal[0])}];
         my $inValueStr = strip($namVal[1]);
         $inValueStr =~ s/\)$//;
         $inValueStr =~ s/^\(//;
         ## printf ("%s in %s ? \n",$fieldVal,$inValueStr);
         my @inValueArr = trimArray(split(",",$inValueStr));
         if (foundInArray($fieldVal,@inValueArr)) { $retVal = $TRUE; }
     } elsif (index($anAtomicPart," IN ") >= 0) {
         my(@namVal)   = split(/ IN /,$anAtomicPart);
         my($fieldVal) = $aRecordParts[$nameToIndex{strip($namVal[0])}];
         my $inValueStr = strip($namVal[1]);
         $inValueStr =~ s/\)$//;
         $inValueStr =~ s/^\(//;
         ## printf ("%s in %s ? \n",$fieldVal,$inValueStr);
         my @inValueArr = doUpperCaseArray(trimArray(split(",",$inValueStr)));
         if (foundInArray(uc($fieldVal),@inValueArr)) { $retVal = $TRUE; }
     } else {
         print("ERROR: Unknown Operator:${anAtomicPart}\n");
     }
     ## print("${retVal}\n");
     return $retVal;
}

sub byRecordOrder {
   my($myA) = $a;
   my($myB) = $b;
   my($retVal) = 0;

   ## print("a:${myA} ");
   ## print(" ==> b:${myB}\n");

   my(@aRec)  = split($sortSepCharHidden,$myA);
   my(@bRec)  = split($sortSepCharHidden,$myB);

   my($sortFieldName) = "";
   foreach $sortFieldName (@sortByFieldsHidden) {
       ## print("${sortFieldName} checking\n");
       if ($retVal == 0) {
         if ($sortFieldName =~ /!/) {
             my($locFieldName) = $sortFieldName;
             $locFieldName =~  s/!//g;
             ## print("Reverse....");
             my($fieldType) = $myFieldType{$locFieldName};
             if ($fieldType eq "Numeric") {
                  ## printf("Compare (%s) %s <=> %s\n",$locFieldName,$bRec[$sortFieldNamesHidden{$locFieldName}], $aRec[$sortFieldNamesHidden{$locFieldName}]);
                  $retVal = $bRec[$sortFieldNamesHidden{$locFieldName}] <=> $aRec[$sortFieldNamesHidden{$locFieldName}];
             } else {
                  ## printf("Compare (%s) %s cmp %s\n",$locFieldName,$bRec[$sortFieldNamesHidden{$locFieldName}], $aRec[$sortFieldNamesHidden{$locFieldName}]);
                  $retVal = $bRec[$sortFieldNamesHidden{$locFieldName}] cmp $aRec[$sortFieldNamesHidden{$locFieldName}];
             }
         } else {
             ## print("Normal....");
             my($fieldType) = $myFieldType{$sortFieldName};
             if ($fieldType eq "Numeric") {
                ## printf("Compare (%s) %s <=> %s\n",$sortFieldName,$aRec[$sortFieldNamesHidden{$sortFieldName}], $bRec[$sortFieldNamesHidden{$sortFieldName}]);
                $retVal = $aRec[$sortFieldNamesHidden{$sortFieldName}] <=> $bRec[$sortFieldNamesHidden{$sortFieldName}];
             } else {
                ## printf("Compare (%s) %s cmp %s\n",$sortFieldName,$aRec[$sortFieldNamesHidden{$sortFieldName}], $bRec[$sortFieldNamesHidden{$sortFieldName}]);
                $retVal = $aRec[$sortFieldNamesHidden{$sortFieldName}] cmp $bRec[$sortFieldNamesHidden{$sortFieldName}];
             }
          }
       } else {
          last;
       }
   }
   ## print(" .... Done\n\n");
   $retVal
}

sub doTest_getParametersFromSelectString {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   if ($debugThisFct) {

   }
   
   my $sqlStr      = "select distinct * from FILE where       TRADING_BOOK=FRAFUT OR TRADING_BOOK=FRA    ";

      $sqlStr      = "select distinct TRADING_BOOK, TRADING_BOOK from FILE where       TRADING_BOOK=    'FRAFUT' OR TRADING_BOOK   =    'FRA'    ";
   my $whereClause = "";
   my $sortedBy    = "";
   my $distinct    = $FALSE;
   my(@columns)    = ();

   ($distinct,$whereClause,$sortedBy,@columns) = getParametersFromSelectString($sqlStr);

   ## print("sqlStr:${sqlStr}:\n");
   ## print("whereClause:${whereClause}:\n");
   ## print("sortedBy:${sortedBy}:\n");
   ## print("distinct:${distinct}:\n");
   ## print("outfileds....\n");
   ## displayArray(@columns);

}

sub getParametersFromSelectString {
  my($sqlString) = @_;
  
  my $distinct    = $FALSE;

  my $outputFieldsStr = strip(substr($sqlString,index($sqlString,"select ") + length("select ")));
  if (index(uc($sqlString)," DISTINCT ") != -1) {
    $distinct    = $TRUE;
    $outputFieldsStr = strip(substr($outputFieldsStr,index($outputFieldsStr,"distinct ") + length("distinct ")));
  }
  $outputFieldsStr = strip(substr($outputFieldsStr,0,index($outputFieldsStr," from FILE")));

  my(@outFields)  = ();
  if ($outputFieldsStr ne "*") {
     @outFields = setListFromCommonControl($outputFieldsStr);
  }

  my $whereClause = strip(substr($sqlString,index($sqlString," where ") + length(" where ")));
  $whereClause =~ s/\s*=\s*/=/g;
  $whereClause =~ s/'//g;
  my $sortedBy    = "";

  return ($distinct,$whereClause,$sortedBy,@outFields);
}

# selectRowsInFltFile
# -------------------
# History:
# 01/13/99    V1.0 Walter Rothlin     Initial Version
# 11/23/99    V1.1 Walter Rothlin     New sort methode
#
# Description:
# ------------
# reads the column names and built two translation tables
#    $colInd   = $colNameToIndex{"ColumnName"};
#    $colTitel = $indexToColName{1};
# Using this two tables prevent you from accessing the columns by absolut positioning
# After processing the header line this function than calls a user defined function (callback)
# for each line in the file. This callback function is called like the following (e.g.)
# sub myCallbackFunction {
#   my($header,$line,$sepChar,$refLocNameToIndex,$refUserParam)   = @_;
#   my(%locNameToIndex) = derefHref($refLocNameToIndex);
#   my(@parts) = split($sepChar,$line);
#   printf("%s\n",$parts[$locNameToIndex{"Name"}]);
# }
# With these function it is possible to create select like queries to a flat file in that way:
#
# e.g. Delimiter Char is ";"
#
#   $sortedBy="columnName1;!columnName2";  # ! means reverse order
#   to distinct between Numeric and Alphabetic sorting the global variable 
#   %myFieldType = (        # default is String
#      "columnName1" => "Numeric",
#      "columnName2" => "Numeric",
#   );
#
#
#   $where="columnName1=value1 AND columnName2=value2 AND columnName3=value3";
#
#   $selectRowsInFltFile("filename","delimiter",$where,$sortedBy,\&myCallbackFunction);
#
#   is about the same query as in SQL:
#      select * from filename
#         where  columnName1=value1 AND
#                columnName2=value2 AND
#                columnName3=value3
#         order by columnName1 columnName2;
#
sub selectRowsInFltFile {
   my($fileName,$sepChar,$whereClause,$sortedBy,$cbRowProcessing,$refUserParam)   = @_;
   my(@fltTable)       = readFltTable($fileName);
   my(@selList)        = ();
   my $headerLine      = $fltTable[0];
   my(%locNameToIndex) = ();

   if ($sepChar eq "") {
     $sepChar = getSepCharFromHeader($headerLine,$TRUE);
   }

   # reads the column names from table file
   %locNameToIndex = updateIndexTables($sepChar,$headerLine);

   $i = 1;
   my $countLines = @fltTable;
   # process the where clause
   foreach ($i=1; $i < $countLines; $i++) {
      if (recordMatches($sepChar,$fltTable[$i],$whereClause,%locNameToIndex)) {
         push(@selList,$fltTable[$i]);
      }
   }
   ## foreach $selEntrie (@selList) {
   ##    print("After Selected Lines:${selEntrie}:<BR>\n");
   ## }

   # process the orderBy clause
   ## print("Sorted by :${sortedBy}:<BR>\n");
   if ($sortedBy eq "") {
      foreach $selEntrie (@selList) {
         ## print("Calling (1)....");
         &$cbRowProcessing($headerLine,$selEntrie,$sepChar,\%locNameToIndex,$refUserParam);
      }
   } else {
      $sortKeyFieldsHidden  = $headerLine;
      $sortSepCharHidden    = $sepChar;
      @sortByFieldsHidden   = split($sepChar,$sortedBy);
      %sortFieldNamesHidden =  %locNameToIndex;
      foreach $selEntrie (sort byRecordOrder @selList) {
         &$cbRowProcessing($headerLine,$selEntrie,$sepChar,\%locNameToIndex,$refUserParam);
      }
   }
}

# Description:
# ------------
# Similar to the function getAllMatchesFromFltFileAsHashes but can be used for any kind of seperated files (no header required).
# Returns a array of references to a hash
#
# calling: e.g. @records = getAllRecordsFromFileAsHashes("data.flt",",",("NAME","VORNAME"));
# foreach $record(@records ) {
#   printf("Name:%s:\n",$record->{"NAME"});
# }
sub getRecordSetFromFile {
  my($fileName,$sepChar,@fieldNames)   = @_; 
  $sepChar    = setDefault($sepChar,";");
  
  my @records = ();
  my @fileLines = readFile($fileName);
  ## displayArray(@fileLines);
  foreach my $aLine (@fileLines) {
  	 my %oneRecord  = (); 
  	 my @lineParts  = split($sepChar, $aLine);
  	 ## displayArray(@lineParts); halt();
  	 my $fieldCount = 0;
  	 my $countOfFieldNames = @fieldNames;
     foreach my $oneField (@lineParts) {
     	   my $fieldName = "FIELD_${fieldCount}";
     	   if ($fieldCount < $countOfFieldNames) {
     	   	   if ($fieldNames[$fieldCount] ne "") {
     	   	     $fieldName = $fieldNames[$fieldCount];
     	   	   }
     	   } 
     	   %oneRecord = (%oneRecord,($fieldName,$oneField));
     	   $fieldCount++;
     }
     ## displayHashTable(%oneRecord);print("\n");
     push(@records,\%oneRecord);
  }
  return @records;
}



# getAllMatchesFromFltFile
# ------------------------
# History:
# 08/03/99    V1.0 Dmitriy Volfson    Initial Version
# 11/23/99    V1.1 Walter Rothlin     New sort methode
#
# Description:
# ------------
# Similar to the function selectRowsInFltFile and getColumnValues. Instead of calling a Callback function it
# returns the following parameters:
#   $header
#   $RefAll
#   $sepChar
#   $locNameToIndexRef
#
# calling: e.g. ($header,$RefAll,$sepChar,$locNameToIndexRef) = getAllMatchesFromFltFile("data.flt",";","Name like Rothlin","Name");
sub getAllMatchesFromFltFile {
   my($fileName,$sepChar,$whereClause,$sortedBy)   = @_;
   my(@fltTable)           = readFltTable($fileName);
   my(@selList)            = ();
   my $headerLine          = $fltTable[0];
   my(%locNameToIndex)     = ();
   my $RecCount            = 0;
   my(@AllRecordsArray)    = ();
   my $AllRecordsArrayRef  = \@AllRecordsArray;
   my $selEntrie           = "";

   if ($sepChar eq "") {
     $sepChar = getSepCharFromHeader($headerLine,$TRUE);
   }

   # reads the column names from table file
   %locNameToIndex = updateIndexTables($sepChar,$headerLine);

   $i = 1;
   my($countLines) = 0;      #! don't put these two statements in one! It doesn't work! Why?
   $countLines = @fltTable;

   # process the where clause
   foreach ($i=1; $i < $countLines; $i++) {
      if (recordMatches($sepChar,$fltTable[$i],$whereClause,%locNameToIndex)) {
         #print"Match wo=ith $whereClause \n";
         push(@selList,$fltTable[$i]);
      }
   }

   # process the orderBy clause
   ## print("Sorted by :${sortedBy}:<BR>\n");
   if ($sortedBy eq "") {
      foreach $selEntrie (@selList) {
        $AllRecordsArray[$RecCount++] = $selEntrie;
      }
      return $headerLine, $AllRecordsArrayRef, $sepChar,\%locNameToIndex;
   } else {
      $sortKeyFieldsHidden = $headerLine;
      $sortSepCharHidden   = $sepChar;
      @sortByFieldsHidden  = split($sepChar,$sortedBy);
      %sortFieldNamesHidden =  %locNameToIndex;      
          
      foreach $selEntrie (sort byRecordOrder @selList) {
           $AllRecordsArray[$RecCount++] = $selEntrie;
      }
      return $headerLine, $AllRecordsArrayRef, $sepChar,\%locNameToIndex;   
   }
}

# Description:
# ------------
# Input:
#   inFilename           : flt file (e.g. CcyPair|CCY2|FundB1_Name|FundB2
#   primaryKeyFieldName  : a fieldname in the flt file
#   whereClause          : filter criteria
#
# e.g.
# CcyPair|CCY2|FundB1_Name|FundB2
# AUD/CAD|AUD|FWDTR2|2
# AUD/CZK|AUD|FWDTR4|3
# AUD/NZD|EUR|FWDTR5|6
# AED/CHF|CHF|FWDTR3|

# Calling e.g.: %mroDefinitions_nonCHF    = createRefHashTblOutOfFltFile($mroFN_flt,"CcyPair","CCY2 ne CHF");
#               displayHashWithHashRef("mroDefinitions_nonCHF",$TRUE,%mroDefinitions_nonCHF);
#               print("aRecRef:".$mroDefinitions_nonCHF{"AUD/CAD"}->{"FundB1_Name"}."\n");    --> FWDTR2
# Result:
# Hash:   "AUD/CAD"     => (
#                            "CcyPair"        => "AUD/CAD",
#                            "CCY2"           => "AUD",
#                            "FundB1_Name"    => "FWDTR2",
#                            "FundB2"         => "2"
#                           )
#         "AUD/CZK"     => (
#                            "CcyPair"        => "AUD/CZK",
#                            "CCY2"           => "AUD",
#                            "FundB1_Name"    => "FWDTR4",
#                            "FundB2"         => "3"
#                           )
#         "AUD/NZD"     => (
#                            "CcyPair"        => "AUD/NZD",
#                            "CCY2"           => "EUR",
#                            "FundB1_Name"    => "FWDTR5",
#                            "FundB2"         => "6"
#                           )
sub createRefHashTblOutOfFltFile {
	  my($inFilename,$primaryKeyFieldName,$whereClause) = @_;
	
	  my %hashRefTbl = ();
  	my @records = getAllMatchesFromFltFileAsHashes($inFilename,"",$whereClause);
    foreach my $aRecord(@records) {
      %hashRefTbl = (%hashRefTbl,($aRecord->{$primaryKeyFieldName},$aRecord));
    }
	  return %hashRefTbl;
}

# Description:
# ------------
# Similar to the function getAllMatchesFromFltFile.
# Returns a array of references to a hash
#
# calling: e.g. @records = getAllMatchesFromFltFileAsHashes("data.flt",";","Name like Rothlin","Name");
# foreach my $aRecord(@records) {
#   printf("Name:%s:\n",$aRecord->{Name});
# }
sub getAllMatchesFromFltFileAsHashes {
  my($fileName,$sepChar,$whereClause,$sortedBy)   = @_; 
  $sepChar    = setDefault($sepChar,getSepCharFromTable($fileName,$TRUE));

  my (@records) = ();
  my ($header,$RefAll,$LocalsepChar, $locNameToIndexRef) = 
                              getAllMatchesFromFltFile($fileName,$sepChar,$whereClause,$sortedBy);

  my @columns = split($sepChar, $header);
  my @dealRecords = derefAref( $RefAll);
 
  my $singleRecord = ""; 
  my $column = "";

  foreach $singleRecord (@dealRecords) { 
    my @values = split($sepChar, $singleRecord );
      foreach $column (@columns ) {
        my $value = shift @values;
        $record -> {"$column"} =  $value;
      }
      @records = (@records, $record);
      $record = {};
   } 

  return   @records; 
}

# getRowsInFltFile
# ----------------
# History:
# 01/31/99    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# Is a similar interface as selectRowsInFltFile. Instead of callback a user function
# for each row found it returns a list containing all rows. For detailed desription
# see selectRowsInFltFile
sub getRowsInFltFile {
   my($fileName,$sepChar,$whereClause,$sortedBy)   = @_;

   if ($sepChar eq "") {
     $sepChar = getSepCharFromHeader(getTableHeader($fileName),$TRUE);
   }

   @hiddenRetList_1 = ();
   selectRowsInFltFile($fileName,$sepChar,$whereClause,$sortedBy,\&cbHidden_1,"");
   return @hiddenRetList_1;
}

sub cbHidden_1 {
  my($header,$line,$sepChar,$refLocNameToIndex,$refUserParam)   = @_;
  push(@hiddenRetList_1,$line);
}


# returns true if all sortFileds are in the reqFields
sub sortCanBeDoneLater {
   my($reqFields,$sortedBy,$sepChr) = @_;
   my($retVal)  = $TRUE;
   $sortedBy =~ s/!//g;
   my(@sortParts) = split($sepChr,$sortedBy);
   my($aSortPart) = "";
   foreach $aSortPart (@sortParts) {
       if ($retVal) {
           $retVal = ($reqFields =~ $aSortPart);
           ## if ($retVal) {
           ##    print("$aSortPart is in ${reqFields}\n");      
           ## } else {
           ##    print("$aSortPart is not in ${reqFields}\n");     
           ## }
       }
   }
   return $retVal;
}


# getColumnValues
# ---------------
# History:
# 02/20/99    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# Is a similar interface as selectRowsInFltFile or getRowsInFltFile. Instead of callback
# a user function for each row found it returns a list containing all rows. For detailed
# desription see selectRowsInFltFile or getRowsInFltFile.
#
# reqFields should contain one or more fieldnames separated by ; (always)
# sortedBy fieldnames separated by $sepChar
#
# In addition the caller can define which columns should be selected. This is the most
# generic one
sub getColumnValues {
   my($fileName,$sepChar,$reqFields,$locWhereClause,$sortedBy,$distinct)   = @_;
   
   ### print("getColumnValues: fileName:${fileName}: sepChar:${sepChar}: reqFields:${reqFields}: locWhereClause:${locWhereClause}: sortedBy:${sortedBy}: distinct:${distinct}:<BR>\n");
   my(%retList_2)      = ();
   my(@retList_1)      = ();
   my $selRow          = "";
   my(%locNameToIndex) = ();

   my $headerLine      = getTableHeader($fileName);

   if ($sepChar eq "") {
     $sepChar = getSepCharFromHeader($headerLine,$TRUE);
   }


   %locNameToIndex   = updateIndexTables($sepChar,$headerLine);

   my(@selectedRows) = ();

   # if all sortfields are part of the reqFields the sort can be done later and faster
   my($doSortAtTheEnd) = sortCanBeDoneLater($reqFields,$sortedBy,$sepChar);
   ## my($doSortAtTheEnd) = $FALSE;
   if ($doSortAtTheEnd) {
      ## print("Sorting done later\n");
      @selectedRows = getRowsInFltFile($fileName,$sepChar,$locWhereClause,"");
   } else {
      ## print("Sorting needs to be done now\n");
      @selectedRows = getRowsInFltFile($fileName,$sepChar,$locWhereClause,$sortedBy);
   }

   my(@reqFields)    = split(";",$reqFields);
   my($locSepChar)   = $sepChar;
   if ($locSepChar ne ";") {
      $locSepChar = "\|";
   }
   foreach $selRow (@selectedRows) {
       my($newRow)       = "";
       my(@selRowFields) = split($sepChar,$selRow);
       my($firstTime)    = $TRUE;
       foreach $fieldName (@reqFields) {
          if ($firstTime) {
             $newRow = $selRowFields[$locNameToIndex{$fieldName}];
             $firstTime = $FALSE;
          } else {
             $newRow = "${newRow}${locSepChar}".$selRowFields[$locNameToIndex{$fieldName}];
          }
       }
       if ($distinct) {
          if (!(foundInArray($newRow,@retList_1))) {
            push(@retList_1,$newRow);
          }
       } else {
          push(@retList_1,$newRow);
       }
   }

   ## do sorting
   my(@retList_2) = ();
   if (($sortedBy ne "") && ($doSortAtTheEnd)) {
      ### print("Now do sorting at the end!!!\n");
      $sortKeyFieldsHidden = $reqFields;
      $sortSepCharHidden   = $sepChar;
      @sortByFieldsHidden  = split($sepChar,$sortedBy);
      my(@reqFieldsArr)    = split($sepChar,$reqFields);
      %sortFieldNamesHidden =  createHashOutOfArrayStr($reqFields,";",$TRUE);
      my($selEntrie) = "";
      ### displayHashTable(%sortFieldNamesHidden);    
      foreach $selEntrie (sort byRecordOrder @retList_1) {
          push(@retList_2,$selEntrie);
      }
   } else {
      @retList_2 = @retList_1;
   }
   return @retList_2;
}

sub countColumnValues {
   my($fileName,$sepChar,$reqFields,$locWhereClause,$distinct)   = @_;

   if ($sepChar eq "") {
     $sepChar = getSepCharFromHeader(getTableHeader($fileName),$TRUE);
   }

   my(@retList_1) = getColumnValues($fileName,$sepChar,$reqFields,$locWhereClause,"",$distinct);
   my($count) = 0;
   $count = @retList_1;
   return $count;
}

sub getSingleRecInHash {
  my($tabName,$sepChar,$selFields,$locWhereClause,$keyPrefix,$withBrakets) = @_;

  if ($sepChar eq "") {
     $sepChar = getSepCharFromHeader(getTableHeader($tabName),$TRUE);
  }

  my(@retValues) = ();
  my $keyValue   = $selFields;
  my(%retHash)   = ();
  my $locSepChar = $sepChar;
  my(@saveParts) = @parts;
  if ($selFields eq "") {
      @retValues = getRowsInFltFile($tabName,$sepChar,$locWhereClause,"");
      $keyValue  = getTableHeader($tabName);
  } else {
      @retValues  = getColumnValues($tabName,$sepChar,$selFields,$locWhereClause,"",$TRUE);
      if ($sepChar ne ";") {
          $keyValue =~ s/;/|/g;
      }
  }
  my $count = @retValues;
  if ($count != 0) {
    %retHash = createHashTab($keyValue,$retValues[0],$locSepChar,$keyPrefix,$withBrakets);
  }

  @parts = @saveParts;
  return %retHash;
}

# selectHashInFltFile
# -------------------
# History:
# 03/16/99    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# Is a similar interface as selectRowsInFltFile or getRowsInFltFile. The callback function gets
# as a parameter a hash table with the Column-Names as the key and the Column-Value as the hash value.

# sub myCallbackFunction {
#   my($recCount, $refToRecord, $refUserParam) = @_;
#   my(%aRecord) = derefHref($refToRecord);
#   printf("%s\n",$aRecord{"Name"});
# }
sub selectHashInFltFile {
   my($fileName,$sepChar,$whereClause,$sortedBy,$distinct,$cbRowProcessing,$keyPrefix,$withBrakets,$refUserParam)   = @_;
   my $keyValue      = getTableHeader($fileName);

   if ($sepChar eq "") {
      $sepChar = getSepCharFromHeader($keyValue,$TRUE);
   }

   my(@selectedRows) = getRowsInFltFile($fileName,$sepChar,$whereClause,$sortedBy);


   my $selRow        = "";
   my(%retList_2)    = ();
   my(@retList_1)    = ();


   if ($distinct) {
      foreach $selRow (@selectedRows) {
         if (!(foundInArray($selRow,@retList_1))) {
            push(@retList_1,$selRow);
         }
      }
   } else {
      @retList_1 = @selectedRows;
   }

   my($count) = 0;
   foreach $selRow (@retList_1) {
      my(%singleRecHash)  = createHashTab($keyValue,$selRow,$sepChar,$keyPrefix,$withBrakets);
      &$cbRowProcessing($count,\%singleRecHash,$refUserParam);
      $count++;
   }
}

# getTransTable
# -------------
# History:
# 06/27/99    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# selects in a flt file two colums and creates an hash table. This function can be used to generate a
# translation table out of a flt file which than can be used a transTab for e.g. replacePlaceholdersStr()
sub getTransTable {
   my($fileName,$sepChar,$whereClause,$keyFieldName,$valueFieldName,$keyFieldFormat,$valueFieldFormat) = @_;
   $keyFieldFormat    = setDefault($keyFieldFormat,   "\%s");
   $valueFieldFormat  = setDefault($valueFieldFormat, "\%s");

   if ($sepChar eq "") {
      $sepChar = getSepCharFromTable($fileName,$TRUE);
   }
   
   my(@selectedRows) = getColumnValues($fileName,$sepChar,"${keyFieldName};${valueFieldName}",$whereClause,"",$TRUE);
   my($selRow)       = "";
   my(%retList)      = ();
   foreach $selRow (@selectedRows) {
       my(@rowPart) = split($sepChar,$selRow);
       my($key)     = sprintf($keyFieldFormat  ,$rowPart[0]);
       my($val)     = sprintf($valueFieldFormat,$rowPart[1]);
       %retList = (%retList,($key,$val));
   }
   return %retList;
}

sub getTransTableFromNormalFile {
   my($fileName,$sepChar,$keyFieldPosition,$valueFieldPosition,$keyFieldFormat,$valueFieldFormat,$logFileName,$verbal) = @_;
   $keyFieldFormat    = setDefault($keyFieldFormat,   "\%s");
   $valueFieldFormat  = setDefault($valueFieldFormat, "\%s");

   my @selectedRows = readFile($fileName);
 
   my %retList       = ();
   foreach $selRow (@selectedRows) {
       my @rowPart = split($sepChar,$selRow);
       my $key     = sprintf($keyFieldFormat  ,$rowPart[$keyFieldPosition]);
       my $val     = sprintf($valueFieldFormat,$rowPart[$valueFieldPosition]);
       if (exists($retList{$key})) {
          if ($val eq $retList{$key}) {
              addToLogFile("WARNING: double entries found for Key:${key} in file ${fileName}",$logFileName,$verbal);
          	  addToLogFile("WARNING: --> Both entries are the same. One eliminated",$logFileName,$verbal);   	
          } else {
          	  addToLogFile("WARNING: double entries found for Key:${key} in file ${fileName}",$logFileName,$verbal);
          	  addToLogFile("WARNING: --> First Value  (taken)  :  ".$retList{$key}." (".getNameForPid($retList{$key}).")",$logFileName,$verbal);
          	  addToLogFile("WARNING:     Second Value (removed):  ".$val." (".getNameForPid($val).")",$logFileName,$verbal);
          }
       } else {
          %retList = (%retList,($key,$val));
       }
   }
   return %retList;
}

sub serializeTransTab {
   my($fileName,%aHash) = @_;
   writeHashToFlatFile($fileName,"\\|","Key","Value","Hash",$FALSE,%aHash);
}

sub deserializeTransTab {
   my($fileName,$replace_BR) = @_;
   $replace_BR = setDefault($replace_BR,$FALSE);
   my(@selectedRows) = getColumnValues($fileName,"\\|","Key;Value","","",$TRUE);
   my($selRow)       = "";
   my(%retList)      = ();
   foreach $selRow (@selectedRows) {
       my(@rowPart) = split("\\|",$selRow);
       my($key)     = $rowPart[0];
       my($val)     = $rowPart[1];
       if ($replace_BR) {
           $val =~ s/\<BR\>/\n/g;
       }
       %retList = (%retList,($key,$val));
   }
   return %retList;
}

# addUserColumn
# -------------
# History:
# 08/02/99    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# This function can be used to insert a new column at a particular position. The value of the new field can
# be set in a user function. The function "append" all the new records in the $outFileName.
# If you want to create a new file do not forget to delete an old file. $newPosition starts at 0
#
# No effect of: $whereClause,$sortedBy (at the moment)
#
# e.g. addUserColumn("testBar.txt","testBar_1.txt","\\|","UserField",2,"","",\&aUserFct,"");
#
## sub aUserFct {
##   BEGIN {
##     my($aHash)  = 0;
##   }
##   my($refToRecord, $refUserParam) = @_;
##   my(%aRecord) = derefHref($refToRecord);
##   $aHash++;
##   return sprintf("${aHash} %s %s aus %s",$aRecord{"Vorname"},$aRecord{"Name"},$aRecord{"Ort"});
## }
sub addUserColumn {
   my($inFileName,$outFileName,$sepChar,$newFieldName,$newPosition,$whereClause,$sortedBy,$cbRowProcessing,$refUserParam) = @_;
   my($line)      = "";
   my($isHeader)  = $TRUE;
   my($oldHeader) = "";
   my($sepChar_2) = ";";
   if ($newPosition < 0) {
     $newPosition = 0;
   }

   if ($sepChar ne ";") {
       $sepChar_2 = "|";
   }
   open(TABFILE_addUserColumn,$inFileName) || showError("ERROR (addUserColumn): Can't open tabfile:${inFileName}: $!");
   open(OUTFILE_addUserColumn,">$outFileName") || showError("ERROR (addUserColumn): Can't open outfile:${outFileName}: $!");
   while (defined($line = <TABFILE_addUserColumn>)) {
      chomp($line);
      #skip comment and blank lines
      if (($line =~ /^#/) || ($line =~ /^\s+$/) || (length($line) == 0)) {
         print(OUTFILE_addUserColumn "${line}\n");
      } else {
             my(@lineParts) = split($sepChar,$line);
             my($anzParts)  = 0; $anzParts = @lineParts;
             my($i) = 0;
             foreach ($i=0; $i<$anzParts; $i++) {
                if ($newPosition >= $anzParts ) {
                   printf(OUTFILE_addUserColumn "%s${sepChar_2}",$lineParts[$i]);
                   if ($i >= $anzParts - 1) {
                       if ($isHeader) {
                           # is header
                           $isHeader  = $FALSE;
                           $oldHeader = $line;
                           print(OUTFILE_addUserColumn "${newFieldName}${sepChar_2}");
                       } else {
                           # is normal record
                           my(%oldRec) = createHashTab($oldHeader,$line,$sepChar,"",$FALSE);
                           printf(OUTFILE_addUserColumn "%s${sepChar_2}",&$cbRowProcessing(\%oldRec,$refUserParam));
                       }
                   }
                } else {
                   if ($i == $newPosition) {
                       if ($isHeader) {
                           # is header
                           $isHeader  = $FALSE;
                           $oldHeader = $line;
                           print(OUTFILE_addUserColumn "$newFieldName}${sepChar_2}");
                       } else {
                           # is normal record
                           my(%oldRec) = createHashTab($oldHeader,$line,$sepChar,"",$FALSE);
                           printf(OUTFILE_addUserColumn "%s${sepChar_2}",&$cbRowProcessing(\%oldRec,$refUserParam));
                       }
                   }
                   printf(OUTFILE_addUserColumn "%s${sepChar_2}",$lineParts[$i]);
                }
             }
             print(OUTFILE_addUserColumn "\n");
      }
   } # end of while
   close(OUTFILE_addUserColumn);
   close(TABFILE_addUserColumn);
}

# setBitsForFltEntry
# ------------------
# History:
# 08/17/06    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# 
#
# Input: $headerStr       = "A;B;C;D;E;F;G";
#        $valueStr        = "C;F;E";
#        $valueForSet     = "1";
#        $valueForUnset   = "0";
#
# returnStr    = "0;0;1;0;1;1;0";
sub setBitsForFltEntry {
  my($headerStr, $valueStr, $valueForSet, $valueForUnset, $sepHeader, $sepValue, $sepResult) = @_;
  $valueForSet   = setDefault($valueForSet,"1");
  $valueForUnset = setDefault($valueForUnset,"0");
  $sepHeader     = setDefault($sepHeader, getSepCharFromHeader($headerStr,$TRUE));
  $sepValue      = setDefault($sepValue,  getSepCharFromHeader($valueStr, $TRUE));
  $sepResult     = setDefault($sepResult, getSepCharFromHeader($headerStr,$FALSE));
  
  
  my @headerList = split($sepHeader,$headerStr);
  my @valueList  = split($sepValue, $valueStr);
  my @resList    = ();
  ## print("headerStr:${headerStr}:\n");
  ## displayArray(@headerList);
  ## print("valueStr:${valueStr}:\n");
  ## displayArray(@valueList);
  foreach my $aHeaderElement (@headerList) {
  	  if ( foundInArray($aHeaderElement,@valueList)) {
  	  	  push(@resList,$valueForSet);
  	  } else {
  	  	  push(@resList,$valueForUnset);
  	  }
  }
  my $resStr = makeStrFromArray($sepResult,@resList);
  ## print("resStr:${resStr}:\n");
  return $resStr;	
}

sub doTest_setBitsForFltEntry {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);   
   
   if (setBitsForFltEntry("A;BBB;C;D;EEE;F;G","C;F;EEE") ne "0;0;1;0;1;1;0") {
       print("ERROR: ${myFullName} failed (A)\n");
   }
   if (setBitsForFltEntry("A|BBB|C|D|EEE|F|G","C|F|EEE") ne "0|0|1|0|1|1|0") {
       print("ERROR: ${myFullName} failed (B)\n");
   }
   if (setBitsForFltEntry("A|BBB|C|D|EEE|F|G","C;F;EEE") ne "0|0|1|0|1|1|0") {
       print("ERROR: ${myFullName} failed (C)\n");
   }
   
}

# getTableHeader
# --------------
# History:
# 01/31/99    V1.0 Walter Rothlin     Initial Version
# 07/20/00    V1.1 Walter Rothlin     Made it faster
#
# Description:
# ------------
# returns the header line from a flat file
sub getTableHeader {
   my($fileName) = @_;
   my $headerLine = "";
   open(TABFILE_getTableHeader,$fileName) || showError("ERROR (getTableHeader): Can't open file:${fileName}: $!");
   while (defined($headerLine = <TABFILE_getTableHeader>)) {
      chomp($headerLine);
      #skip comment and blank lines
      if (($headerLine =~ /^#/) || ($headerLine =~ /^\s+$/) || (length($headerLine) == 0)) {

      } else {
         close(TABFILE_getTableHeader);
         return $headerLine;
      }
   } # end of while
   return $headerLine;
}

sub getTableHeaderAndOneConntent {
   my($fileName) = @_;
   my @twoLines  = ();
   my $count     = 0;

   open(TABFILE_getTableHeader,$fileName) || showError("ERROR (getTableHeaderAndOneConntent): Can't open file:${fileName}: $!");
   while (defined($aLine = <TABFILE_getTableHeader>)) {
      chomp($aLine);
      #skip comment and blank lines
      if (($aLine =~ /^#/) || ($aLine =~ /^\s+$/) || (length($aLine) == 0)) {

      } else {
         push(@twoLines,$aLine);
         $count++;
         if ($count >= 2) {
            last;
         }
         
      }
   } # end of while
   close(TABFILE_getTableHeader);
   return @twoLines;
}

sub getOneFltTableRecord {
   my($fileName) = @_;
   my($headerLine,$contentLine) = getTableHeaderAndOneConntent($fileName);
   my %retHash = createHashTab($headerLine,$contentLine,getSepCharFromHeader($headerLine,$TRUE),"",$FALSE);
   return %retHash;
}


sub doTest_getTableHeaderComments {
   my($myFullName,$debugThisFct) = @_;
   $debugThisFct = setDefault($debugThisFct,$FALSE);

   if ($debugThisFct) {
        my $fileName = readln("FLT filename:","TestSort.flt");
        displayArray(getTableHeaderComments($fileName));
        print("Add one comment header line\n");
        putLineOnTop($fileName,"# 1.Zeile");
        displayArray(getTableHeaderComments($fileName));
        
        print("Add some more comment header lines\n");
        putLinesOnTop($fileName,("#  1.1Zeile","   ","#  2.2 Zeile"));
        displayArray(getTableHeaderComments($fileName));

   }
}

sub getTableHeaderComments {
   my($fileName) = @_;
   my(@headerCommentLines) = ();
   open(TABFILE_getTableHeaderComments,$fileName) || showError("ERROR (getTableHeaderComments): Can't open file:${fileName}: $!");
   while (defined($headerLine = <TABFILE_getTableHeaderComments>)) {
      chomp($headerLine);
      #skip comment and blank lines
      if (($headerLine =~ /^#/) || ($headerLine =~ /^\s+$/) || (length($headerLine) == 0)) {
          push(@headerCommentLines,$headerLine);
      } else {
          last;
      }
   } # end of while
   close(TABFILE_getTableHeaderComments);
   return @headerCommentLines;
}


sub getTableHeaderAsArray {
   my($fileName) = @_;
   my $headerLine = getTableHeader($fileName);
   return split(getSepCharFromHeader($headerLine,$TRUE),$headerLine);
}

sub isFieldNamePartOfHeader {
   my($fileName,$fieldName) = @_;
   return foundInArray($fieldName,getTableHeaderAsArray($fileName));
}

sub getSepCharFromTable {
   my($tableFileName,$doubleQuoted) = @_;
   $doubleQuoted  = setDefault($doubleQuoted,$TRUE);
   my $header     = getTableHeader($tableFileName);
   return getSepCharFromHeader($header,$doubleQuoted);
}

sub getSepCharFromHeader {
   my($header,$doubleQuoted) = @_;
   $doubleQuoted  = setDefault($doubleQuoted,$TRUE);
   my($sepChar)     = "";
   if (index($header,";") == -1) {
      if ($doubleQuoted) {
         $sepChar     = "\\|";
      } else {
         $sepChar     = "\|";
      }
   } else {
      $sepChar     = ";";
   }
   return $sepChar;
}

# getCountOfColumns
# -----------------
# History:
# 08/02/99    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# returns count of columns
#   $sepChar is optional (Read from table file)
sub getCountOfColumns {
   my($locFileName,$sepChar) = @_;
   my($headerStr)   = getTableHeader($locFileName);
   if ($sepChar eq "") {
     $sepChar= getSepCharFromHeader($headerStr);
   }

   my(@columnNames) = split($sepChar,$headerStr);
   my($retVal)      = 0; $retVal = @columnNames;
   return $retVal;
}


# updateIndexTables
# -----------------
# History:
# 01/13/99    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# updates the indexTables for CoulmnByNames and Positions depending from
# the column titles in the file
#   $sepChar is optional (Read from table file)
sub updateIndexTables {
   my($sepChar,$headerLine) = @_;
   if ($sepChar eq "") {
     $sepChar= getSepCharFromHeader($headerLine);
   }

   %colNameToIndex = ();
   %indexToColName = ();
   @parts=split($sepChar,$headerLine);
   my($i) = 0;
   foreach $part (@parts) {
       %colNameToIndex = (%colNameToIndex,($part,$i));
       %indexToColName = (%indexToColName,($i,$part));
       $i++;
   }
   return %colNameToIndex;
}


# updateRecordByHash
# ------------------
# History:
# 07/19/99    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# modifies a record in a flat file
#   $sepChar is optional (Read from table file)
sub updateRecordByHash {
   my($fileName,$sepChar,$hashFieldName,%newRecord)   = @_;
   my($headerLine) = getTableHeader($fileName);
   if ($sepChar eq "") {
     $sepChar= getSepCharFromHeader($headerLine);
   }

   my($newRecordString) = generateNewRecord($fileName,$sepChar,%newRecord);
   my($whereClause)     = sprintf("${hashFieldName}=%s",$newRecord{$hashFieldName});
   return updateRecord($fileName,$sepChar,$whereClause,"MODIFY",$newRecordString);
}

# fltUpdateRecordByHash
# ---------------------
# History:
# 07/20/00    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# modifies a record in a flat file or deletes it depending on the action
#   action = [DELETE | MARK_AS_DELETE | MODIFY]
#
#
sub fltUpdateRecordByHash {
   my($fileName,$whereClause,$action,%newRecord)   = @_;
   my $lockName       = "${fileName}_Lock";
   my $tmpFileName    = sprintf("%s%s",$fileName,getTimeStamp());
   my @oldRecords     = ();
   my %locNameToIndex = ();
   my $firstDone      = $FALSE;
   $fltUpdateRecordByHash_Verbal = setDefault($fltUpdateRecordByHash_Verbal,$TRUE);

   my $headerLine = getTableHeader($fileName);
   my $sepChar    = getSepCharFromHeader($headerLine);

   %locNameToIndex = updateIndexTables($sepChar,$headerLine);
   if (!(setAndGetLockFast($lockName,$fltUpdateRecordByHash_Verbal))) {
     push(@oldRecords,$FALSE);
     return @oldRecords;
   } else {
     writeDebugMsg ("<BR>Open File ${fileName}<BR>\n");
     open(TABFILE_fltUpdateRecordByHash,$fileName) || showError("ERROR (fltUpdateRecordByHash): Can't open tab file:${fileName}: $!");
     my($tmpOutFileName) = ">${tmpFileName}";
     open(TMPFILE_fltUpdateRecordByHash,$tmpOutFileName) || showError("ERROR (fltUpdateRecordByHash): Can't open tmp file:${tmpOutFileName}: $!");
     while (defined($line = <TABFILE_fltUpdateRecordByHash>)) {
       chomp($line);
       #skip comment and blank lines
       if (($line =~ /^#/) || ($line =~ /^\s+$/) || (length($line) == 0)) {
          print (TMPFILE_fltUpdateRecordByHash "$line\n");
       } else {
           if (($firstDone) && (recordMatches($sepChar,$line,$whereClause,%locNameToIndex))) {
              push(@oldRecords,$line);
              if (($action eq "MODIFY") || ($action eq "MARK_AS_DELETE")) {
                 my(%oldRec) = createHashTab($headerLine,$line,$sepChar,"",$FALSE);
                 my(%newRec) = updateHash(\%oldRec,\%newRecord);
                 my($newRecord) = generateNewFltRecord($headerLine,%newRec);
                 if ($action eq "MARK_AS_DELETE") {
                    print (TMPFILE_fltUpdateRecordByHash "${deleteMark}${newRecord}\n");
                 } elsif ($action eq "MODIFY") {
                    print (TMPFILE_fltUpdateRecordByHash "$newRecord\n");
                 }
              }
           } else {
              $firstDone = $TRUE;
              print (TMPFILE_fltUpdateRecordByHash "$line\n");
           }
       }
     } # end of while
     close(TMPFILE_fltUpdateRecordByHash);
     close(TABFILE_fltUpdateRecordByHash);
     unlink($fileName);
     rename($tmpFileName,$fileName);
     releaseLockFast($lockName,$fltUpdateRecordByHash_Verbal);
     return @oldRecords;
   }
}

# updateRecord
# ------------
# History:
# 01/13/99    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# modifies a record in a flat file or deletes it depending on the action
#   action = [DELETE | MODIFY]
# returns
#   a list of records matched. If return record eq "" than no record was found in file
#   $FALSE if a lock was detected      
sub updateRecord {
   my($fileName,$sepChar,$whereClause,$action,$newRecord,$verbal)   = @_;
   my($lockName)       = "${fileName}_Lock";
   my($tmpFileName)    = "${fileName}".getTimeStamp();
   my(@oldRecords)     = ();
   my(%locNameToIndex) = ();
   $verbal = setDefault($verbal,$TRUE);

   my($headerLine) = getTableHeader($fileName);
   if ($sepChar eq "") {
     $sepChar= getSepCharFromHeader($headerLine);
   }

   %locNameToIndex = updateIndexTables($sepChar,$headerLine);
   
   if (!(setAndGetLockFast($lockName,$verbal))) {
     push(@oldRecords,$FALSE);
     return @oldRecords;
   } else {
     writeDebugMsg("<BR>Open File ${fileName}<BR>\n");
     open(TABFILE_updateRecord,$fileName) || showError(sprintf("ERROR (updateRecord): Can't open tab file: %s : %s",$fileName,$!));
     my($tmpOutFileName) = ">${tmpFileName}";
     open(TMPFILE_updateRecord,$tmpOutFileName) || showError(sprintf("ERROR (updateRecord): Can't open tmp file: %s : %s",$tmpOutFileName,$!));
     while (defined($line = <TABFILE_updateRecord>)) {
       chomp($line);
       #skip comment and blank lines
       if (($line =~ /^#/) || ($line =~ /^\s+$/) || (length($line) == 0)) {
          print(TMPFILE_updateRecord "${line}\n");
       } else {
           ### TBS BUG 1 $debug = $TRUE;
           if (recordMatches($sepChar,$line,$whereClause,%locNameToIndex)) {
              writeDebugMsg ("<HR>SepChar:${sepChar}:  whereClause:${whereClause}<BR>\n");
              writeDebugMsg ("Line:${line}: --> Matches<BR><HR>\n");
              push(@oldRecords,$line);
              $markAsDelete = setDefault($markAsDelete,$FALSE);
              if (($action eq "MODIFY") || (($action eq "DELETE") && ($markAsDelete))){
                 writeDebugMsg ("Old Record:${line}<BR>\n");
                 writeDebugMsg ("New Record (19):${newRecord}<BR>\n");
                 my(@newFields) = split($sepChar,$newRecord);
                 ### TBS BUG 1 my($aaaa) = 0; $aaaa = @newFields;
                 ### TBS BUG 1 print("Anzahl Felder:${aaaa}:\n");
                 my(@oldFields) = split($sepChar,$line);
                 my($newField)  = "";
                 my($i)         = 0;
                 $newRecord     = "";
                 my($sepCharLoc)= $sepChar;
                 if (${sepCharLoc} ne ";") {
                   $sepCharLoc = "|";
                 }
                 my($firstTime) = $TRUE;
                 foreach $newField (@newFields) {
                    if ($firstTime) {
                      if ($newFields[0] eq $NotDefined) {
                         $newRecord = $oldFields[$i];
                      } else {
                         $newRecord = $newField;
                      }
                      $firstTime = $FALSE;
                    } else {
                      if ($newField eq $NotDefined) {
                         $newRecord = "${newRecord}${sepCharLoc}${oldFields[$i]}";
                      } else {
                         $newRecord = "${newRecord}${sepCharLoc}${newField}";
                      }
                    }
                    $i++;
                 }
                 $newRecord = "${newRecord}${sepCharLoc}";
                 writeDebugMsg ("New Record (20):${newRecord}<BR>\n");
                 if (($action eq "DELETE") && ($markAsDelete)) {
                    print(TMPFILE_updateRecord "${deleteMark}${newRecord}\n");
                 } else {
                    print(TMPFILE_updateRecord "${newRecord}\n");
                 }
              }
           } else {
              print(TMPFILE_updateRecord "${line}\n");
           }
       }
     } # end of while
     close(TMPFILE_updateRecord);
     close(TABFILE_updateRecord);
    
    # DV 
    #   unlink($fileName);
    #   rename($tmpFileName,$fileName);
    my $ret = `cp $tmpFileName $fileName `; #calling unix copy
    unlink($tmpFileName);

     releaseLockFast($lockName,$verbal);
     return @oldRecords;
   }
}

# createFltFromHash
# -----------------
# History:
# 06/01/00    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# creates a flat file using a hashToLoad
#
# e.g.
# $sepChar          = "\|";
# %myTestHash = (
#    "Name"      => "",
#    "FirstName" => "Walti",
#    "PLZ"       => "8855",
#    "Ort"       => "",
#    "TelNr"     => "055 xxx yy zz",
# );
#
# file which is produced
# FirstName|Name|Ort|PLZ|TelNr
# Walti|||8855|055 xxx yy zz
sub createFltFromHash {
  my($tabName,$tabSepChar,%hashToLoad) = @_;
  unlink($tabName);
  my(@fieldNames) = sort keys %hashToLoad;
  appendLine($tabName,sprintf("%s",makeQuotedStrFromArray($tabSepChar,"",@fieldNames)));
  my(@values) = ();
  my($aKey) = "";
  foreach $aKey (@fieldNames) {
      push(@values,$hashToLoad{$aKey});
  }
  appendLine($tabName,sprintf("%s",makeQuotedStrFromArray($tabSepChar,"",@values)));
}

# %newNameValuePairs = (
#     "F1"   => "ff1xxxx",
#     "F5"   => "ff3xaaaa",
#     "F5x"  => "NotHere",
#     "Hash" => getNextKey($aTable,"","Hash"), 
# );
# 
# fltInsertRecordByHash($aTable,%newNameValuePairs);
# 
sub fltInsertRecordByHash {
   my($fileName,%newRecord)   = @_;
   my($headerLine) = getTableHeader($fileName);
   my($newRecord)  = generateNewFltRecord($headerLine,%newRecord);
   insertRecord($fileName,$newRecord);
}

# insertRecord
# ------------
# History:
# 01/13/99    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# inserts a record in a flat file
sub insertRecord {
   my($fileName,$newRecord)   = @_;
   my($outFileName) = ">>${fileName}";
   open(OUTFILE_insertRecord,$outFileName) || showError(sprintf("ERROR (insertRecord): Can't open file: %s : %s",$outFileName,$!));
   print(OUTFILE_insertRecord "${newRecord}\n");
   close(OUTFILE_insertRecord);
}

# getNextKey
# ----------
# History:
# 01/13/99    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# get the next unique key back looking up the existing table
# for sepChar use "\\|"
sub getNextKey {
 my($fileName,$sepChar,$keyFieldName) = @_;
 my($maxHash)        = 0;
 my(%locNameToIndex) = ();

 my(@recordList) = readFltTable($fileName);
 if ($sepChar eq "") {
   $sepChar= getSepCharFromHeader($recordList[0]);
 }

 %locNameToIndex = updateIndexTables($sepChar,$recordList[0]);

 $i = 1;
 my($countLines) = 0;      #! don't put these two statements in one! It doesn't work! Why?
 $countLines = @recordList;

 # process the where clause
 foreach ($i=1; $i < $countLines; $i++) {
    ### printf ("Next Key:%s:\n",$recordList[$i]);
    my(@tmpFields) = split(/$sepChar/,$recordList[$i]);
    if ($tmpFields[$locNameToIndex{$keyFieldName}] > $maxHash) {
       $maxHash = $tmpFields[$locNameToIndex{$keyFieldName}];
    }
 }
 return $maxHash + 1;
}

# generateNewRecord
# -----------------
# History:
# 01/13/99    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# builds a newRecord using a hash table with the Name => Value pairs
sub generateNewRecord {
	my($fileName,$sepChar,%newNameValuePairs) = @_;
	my $headerLine = getTableHeader($fileName);
	return generateNewFltRecord($headerLine,%newNameValuePairs);
}

# generateNewFltRecord
# --------------------
# History:
# 07/20/00    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# %newNameValuePairs = (
#    "F1" => "ff1x",
#    "F5" => "ff3x",
#    "F5x" => "NotHere",
# );
# $aHeaderLine = "Hash;F1;F2;F3;F4;F5;F6;F7;F8;";
#
# Result:
# $resLine = generateNewFltRecord($aHeaderLine,%newNameValuePairs);
sub generateNewFltRecord {
	my($headerLine,%newNameValuePairs) = @_;
	my $newRecord      = "";
	my $sepChar        = ";";
	my $printSepChar   = ";";

	if (index($headerLine,";") == -1) {
		$sepChar      = "\\|";
		$printSepChar = "\|";
	}
	my(@headerParts) = split($sepChar,$headerLine);
	## print("headerParts:${headerLine}:${sepChar}:\n");
	## displayArray(@headerParts);
	my $headerPart = "";
	my $first      = $TRUE;
	foreach my $headerPart (@headerParts) {
	my $aVal = "";
	if (exists($newNameValuePairs{$headerPart})) {
		$aVal = $newNameValuePairs{$headerPart};
	}
	if ($first) {
		$first = $FALSE;
		$newRecord = $aVal;
	} else {
		$newRecord = "${newRecord}${printSepChar}${aVal}";
	}
 }
 ## print("newRecord:${newRecord}\n");
 return $newRecord;
}


sub parseWhereClause {
  my($whereClause)  = @_;
  my(%retVal)       = ();
  my(@andParts)     = split(" AND ",$whereClause);

  foreach $andPart (@andParts) {
    my(@condParts) = split("=",$andPart);
    %retVal = (%retVal,($condParts[0],$condParts[1]));
  }
  return %retVal;
}

############################################################################
# Function for vCard
############################################################################
sub createVcardStringArrayFromFltFile {
	my($adressFileName,$templateFileName,$whereClause,$fieldsForCardName) = @_;
  my @templateLines = ();
  my @cardNameFields = split(";",$fieldsForCardName);
  
  my %vCardsStr = ();
  # read template
  if (-e $templateFileName) {
	 	 @templateLines = readFile($templateFileName);
  } else {
     print("ERROR: Template <B>${templateFileName}</B> not found<BR>\n");
     return;
  }
  
  # read addressFile
  my @records = getAllMatchesFromFltFileAsHashes($adressFileName,"\\|",$whereClause);
  
  # go through the address list
	foreach $record(@records) {
		# prepare card name
		my $cardName = "";
		foreach my $aFieldName (@cardNameFields) {
			 if ($cardName eq "") {
			   	$cardName = $record->{$aFieldName};
			 } else {
			 	  $cardName = $cardName."_".$record->{$aFieldName};
			 }
		}
		
		# generate card from template
    %vCardsStr = (%vCardsStr,($cardName,replacePlaceholdersStr(makeStrFromArray("\n",@templateLines),replaceASCII_to_HEX_InHashValues("3",updateHashKeys($record)))));
  }
  return %vCardsStr;
}

sub createVcardFilesFromFltFile {
	my($adressFileName,$templateFileName,$whereClause,$fieldsForCardName,$outputFilePath) = @_;

  my %vCardsHash = createVcardStringArrayFromFltFile($adressFileName,$templateFileName,$whereClause,$fieldsForCardName);
  my @cardNames = keys %vCardsHash;
  foreach my $aCardName (@cardNames) {
  	writeStringToFile("${outputFilePath}${aCardName}.vcf",$FALSE,$vCardsHash{$aCardName});
  }
}

sub sendVcardFromFltFileViaHttp {
	my($adressFileName,$templateFileName,$whereClause,$fieldsForCardName) = @_;

  my %vCardsHash = createVcardStringArrayFromFltFile($adressFileName,$templateFileName,$whereClause,$fieldsForCardName);
  my @cardNames = keys %vCardsHash;
  foreach my $aCardName (@cardNames) {
  	vcfMimeType();
  	print($vCardsHash{$aCardName});
  	return $TRUE;
  	last;
  }
  return $FALSE;
}


###############################################################################
# cgi function to manipulate flat files
###############################################################################
sub getDefaultVal {
  my($aKey)   = @_;
  my($retVal) = "";
  if (exists($myDefaultValues{$aKey})) {
    $retVal = $myDefaultValues{$aKey};
  } else {
    $retVal = $NotDefined;
  }
  return $retVal;
}

sub transformFieldHidden {
  my($fieldName,$fieldValue) = @_;
  my($retVal)  = "";

  if (exists($enumerationTrans{"${fieldName}:${fieldValue}"})) {
     $retVal = $enumerationTrans{"${fieldName}:${fieldValue}"};
  } elsif (exists($enumerationTrans{"${fieldName}:UseHash"}))  {
      my($hashRef) = $enumerationTrans{"${fieldName}:UseHash"};
      if (exists($$hashRef{"${fieldName}"}))  {
         $retVal = $hashRef->{$fieldValue};
      } else {
         $retVal = $fieldValue;
      }
  } else {
      $retVal = $fieldValue;
  }
  return $retVal;
}

sub formatFieldHidden {
  my($fieldValue,$format,$forAutoFilter)   = @_;
  $forAutoFilter    = setDefault($forAutoFilter,$FALSE);
  my($retVal)       = "";
  my(@formartParts) =  split(":",$format);

  if ($fieldValue eq $NotDefined) {
     $retVal = "";
  } elsif ($formartParts[0] eq "Date") {
     my($dateFormat) = "";
     if ($language eq $LangEnglish) {
        $dateFormat = "USA";
     } elsif ($language eq $LangGerman) {
        $dateFormat = "EUR";
     }
     my($dayByName)   = $FALSE;
     my($monthByName) = $FALSE;
     if (($formartParts[1] eq "Day")         || ($formartParts[2] eq "Day"))         { $dayByName = $TRUE; }
     if (($formartParts[1] eq "MonthByName") || ($formartParts[2] eq "MonthByName")) { $monthByName = $TRUE; }
     $retVal = formatTimeStamp($fieldValue,$dateFormat,$dayByName,$monthByName,$language);
  } elsif ($formartParts[0] eq "float") {
     if ($fieldValue ne "") {
           my(@stellenZahl) =  split("\\.",$formartParts[1]);
           my($valStr) = realFormat($fieldValue,$stellenZahl[1],"0");
           $retVal = repNullStr(paddenNull($valStr,$stellenZahl[0]," "));
     }
  } elsif ($formartParts[0] eq "curr") {
     if ($fieldValue ne "") {
           my(@stellenZahl) =  split("\\.",$formartParts[1]);
           my($valStr) = currFormat($fieldValue,$stellenZahl[1],"0",$currCommaChar,$currMilSep);
           $retVal = repNullStr(paddenNull($valStr,$stellenZahl[0]," "));
     }
  } elsif ($formartParts[0] eq "email") {
     if ($fieldValue ne "") {
       $retVal = "<A HREF=\"mailto:${fieldValue}\">${fieldValue}</A>";
     }
  } elsif (($formartParts[0] eq "url") && ($action ne "ShowDetail")) {
     my($urlLink) = $fieldValue;
     if (!($urlLink =~ /\:/)) {
        $urlLink = "http://${urlLink}";
     }
     if ($formartParts[1] eq "") {
        $retVal = "<A HREF=\"${urlLink}\">${fieldValue}</A>";
     } else {
        $retVal = sprintf ("<A HREF=\"%s\">%s</A>",$parts[$colNameToIndex{$formartParts[1]}],$fieldValue);
     }
  } elsif ($formartParts[0] eq "urlTarget") {
     if ($formartParts[2] eq "") {
        my($urlLink) = $fieldValue;
        if (!($urlLink =~ /\:/)) { $urlLink = "http://${urlLink}"; }
        $retVal = sprintf ("<A HREF=\"%s\" TARGET=\"%s\">%s</A>",$urlLink,$formartParts[1],$fieldValue);
     } else {
        my($urlLink) = $parts[$colNameToIndex{$formartParts[2]}];
        if (!($urlLink =~ /\:/)) { $urlLink = "http://${urlLink}"; }
        $retVal = sprintf ("<A HREF=\"%s\" TARGET=\"%s\">%s</A>",$urlLink,$formartParts[1],$fieldValue);
     }
  } elsif ($formartParts[0] eq "privilege") {
     if (length($fieldValue) > 0) {
       $fieldValue =~ s/\<BR\>/\&/g;
        my(@privList) = split("&",$fieldValue);
        my($aPriv)    = "";
        $retVal       = "";
        foreach $aPriv (@privList) {
           my($aFormatedPriv) = "";
           my(@aPrivParts)    = split(":",$aPriv);
           $aPrivParts[0] = strip($aPrivParts[0]);
           $aPrivParts[1] = strip($aPrivParts[1]);
           if ($aPriv eq $ROOT_ID) {
              $aFormatedPriv = "<font color=\"#ff0000\">${ROOT_ID}</font>";
           } elsif ($aPrivParts[1] eq "") {
              $aFormatedPriv = sprintf("<font color=\"#009900\">%s</font>",$aPrivParts[0]);
           } else {
              if ($aPrivParts[1] eq $ROOT_ID) {
                 $aFormatedPriv = sprintf("%s:<font color=\"#990000\">%s</font>",$aPrivParts[0],$aPrivParts[1]);
              } else {
                 $aFormatedPriv = sprintf("%s:<font color=\"#00ff00\">%s</font>",$aPrivParts[0],$aPrivParts[1]);
              }
           }
           if ($retVal eq "") {
              $retVal = $aFormatedPriv;
           } else {
              $retVal = "${retVal}<BR>${aFormatedPriv}";
           }
        }
    }
  } elsif (($formartParts[0] eq "detailLink") && ($action ne "ShowDetail")) {
     $retVal = sprintf("<A HREF=\"javascript:showDetailPageHidden('%s${paramSep}Action=ShowDetail&doWhereClause=%s+eq+%s&%s%s')\">${fieldValue}</A> \n",$myCgiFormName,$keyFieldName,$parts[$colNameToIndex{$keyFieldName}],$externalParam,$tmpWhereClause);
  } elsif ($formartParts[0] eq "userDefined") {
     my($usrFunc) = $formartParts[1];
     $retVal = &$usrFunc($fieldValue);
  } elsif (($formartParts[0] eq "userDefined_1") && (!($forAutoFilter))) {
     my($usrFunc) = $formartParts[1];
     $retVal = &$usrFunc($fieldValue);
  } else {
     $retVal = $fieldValue;
  }
  if (($format =~ /detailLink/) && (!($retVal =~ /<A HREF=/)) && ($retVal ne "") && ($action ne "ShowDetail")) {
    $retVal = sprintf("<A HREF=\"javascript:showDetailPageHidden('%s${paramSep}Action=ShowDetail&doWhereClause=%s+eq+%s&%s%s')\">${retVal}</A> \n",$myCgiFormName,$keyFieldName,$parts[$colNameToIndex{$keyFieldName}],$externalParam,$tmpWhereClause);
  }
  return $retVal;
}

sub cbLineProcForCGIhidden {
  my($header,$line,$sepChar,$refLocNameToIndex,$refUserParam)   = @_;

  my(%locNameToIndex) =  derefHref($refLocNameToIndex);
  @parts=split($sepChar,$line);

  if ($action eq "") {
     $countHidden++;
     print(" <TR>\n");
     foreach $column (@myDisplayOrder) {
       my($fieldVal)     = transformFieldHidden($column,$parts[$locNameToIndex{$column}]);
       my($formFieldVal) = formatFieldHidden($fieldVal,$spezFormat{$column});
       my($tableEntryFormatTmp) = $tableEntryFormat;
       my($attr)      = $myTableAttr{$column};
       my(%transList) = ();
       if ($attr ne "") {
          %transList = ("{tdAttr}" => $attr);
       } else {
          %transList = (" {tdAttr}" => "");
       }
       $tableEntryFormatTmp = replacePlaceholdersStr($tableEntryFormat,%transList);
       printf("  %s%s</TD>\n",$tableEntryFormatTmp,htmlNullStr($formFieldVal));
     }
     if ($displayCommandColumn) {
       my($empty) = $TRUE;
       print("  ${tableActionFormat}\n");
       # prepare where clause
       my($tmpWhereClause) = $whereClause;
       if (length($whereClause) > 0) {
          $tmpWhereClause =~ s/\=/\%3D/g;   ###### WR TBS
          if (!($linkAsHiddenForms)) {
             $tmpWhereClause =~ s/ /\+/g;
          }
          $tmpWhereClause = "&WhereClause=${tmpWhereClause}";
       }
       if (($deleteFunction || $copyFunction || $modifyFunction || $displayDetail) && ($linkAsHiddenForms)) {
          print("      <TABLE><TR>\n");
       }
       if ($modifyFunction) {
         if (!($linkAsHiddenForms)) {
            printf ("         <A HREF=\"%s${paramSep}Action=ForModify&doWhereClause=%s%s%s&%s%s\">${strModify}</A> \n",$myCgiFormName,$keyFieldName,cgiEncode("="),$parts[$locNameToIndex{$keyFieldName}],$externalParam,$tmpWhereClause);
         } else {
            print("        ${tableActionFormat}\n");
            my($parStr) = sprintf ("Action=ForModify&doWhereClause=%s%s%s&%s%s",$keyFieldName,cgiEncode("="),$parts[$locNameToIndex{$keyFieldName}],$externalParam,$tmpWhereClause);
            makeFormLink("         ",$strModify,$gifModify,$myCgiFormName,$parStr);
            print("</TD>\n");
         }
         $empty = $FALSE;
       }
       if ($copyFunction) {
         if (!($linkAsHiddenForms)) {
            printf ("         <A HREF=\"%s${paramSep}Action=ForCopy&doWhereClause=%s%s%s&%s%s\">${strCopy}</A> \n",$myCgiFormName,$keyFieldName,cgiEncode("="),$parts[$locNameToIndex{$keyFieldName}],$externalParam,$tmpWhereClause);
         } else {
            print("        ${tableActionFormat}\n");
            my($parStr) = sprintf ("Action=ForCopy&doWhereClause=%s%s%s&%s%s",$keyFieldName,cgiEncode("="),$parts[$locNameToIndex{$keyFieldName}],$externalParam,$tmpWhereClause);
            makeFormLink("         ",$copyModify,$gifCopy,$myCgiFormName,$parStr);
            print("</TD>\n");
         }
         $empty = $FALSE;
       }
       if ($deleteFunction) {
         if (!($linkAsHiddenForms)) {
            printf ("         <A HREF=\"%s${paramSep}Action=ForDelete&doWhereClause=%s%s%s&%s%s\">${strDelete}</A> \n",$myCgiFormName,$keyFieldName,cgiEncode("="),$parts[$locNameToIndex{$keyFieldName}],$externalParam,$tmpWhereClause);
         } else {
            print("        ${tableActionFormat}\n");
            my($parStr) = sprintf ("Action=ForDelete&doWhereClause=%s%s%s&%s%s",$keyFieldName,cgiEncode("="),$parts[$locNameToIndex{$keyFieldName}],$externalParam,$tmpWhereClause);
            makeFormLink("         ",$strDelete,$gifDelete,$myCgiFormName,$parStr);
            print("</TD>\n");
         }
         $empty = $FALSE;
       }
       if ($passwordForgottenFunction) {
         if (!($linkAsHiddenForms)) {
            printf ("         <A HREF=\"%s${paramSep}Action=PasswordForgotten&doWhereClause=%s%s%s&%s%s\">${strForgotten}</A> \n",$myCgiFormName,$keyFieldName,cgiEncode("="),$parts[$locNameToIndex{$keyFieldName}],$externalParam,$tmpWhereClause);
         } else {
            print("        ${tableActionFormat}\n");
            my($parStr) = sprintf ("Action=PasswordForgotten&doWhereClause=%s%s%s&%s%s",$keyFieldName,cgiEncode("="),$parts[$locNameToIndex{$keyFieldName}],$externalParam,$tmpWhereClause);
            makeFormLink("         ",$strForgotten,$gifForgotten,$myCgiFormName,$parStr);
            print("</TD>\n");
         }
         $empty = $FALSE;
       }

       if ($displayDetail) {
         if (!($linkAsHiddenForms)) {
            printf ("         <A HREF=\"javascript:showDetailPageHidden('%s${paramSep}Action=ShowDetail&doWhereClause=%s+eq+%s&%s%s')\">${strDetail}</A> \n",$myCgiFormName,$keyFieldName,$parts[$locNameToIndex{$keyFieldName}],$externalParam,$tmpWhereClause);
         } else {
            if ($gifDetail ne "") {
               printf ("        %s<A HREF=\"javascript:showDetailPageHidden('%s${paramSep}Action=ShowDetail&doWhereClause=%s%s%s&%s%s')\" onmouseover=\"showStatus('${strDetail}'); return true\"><IMG SRC=\"%s\" border=0></A></TD>\n",$tableActionFormat,$myCgiFormName,$keyFieldName,cgiEncode("="),$parts[$locNameToIndex{$keyFieldName}],$externalParam,$tmpWhereClause,$gifDetail);
            } else {
               my($url) = sprintf("%s${paramSep}Action=ShowDetail&doWhereClause=%s%s%s&%s%s",$myCgiFormName,$keyFieldName,cgiEncode("="),$parts[$locNameToIndex{$keyFieldName}],$externalParam,$tmpWhereClause);
               print("        ${tableActionFormat}<FORM><INPUT TYPE=BUTTON  VALUE=\"${strDetail}\" onClick=showDetailPageHidden('${url}')></FORM></TD>\n");
            }
         }
         $empty = $FALSE;
       }
       if (($deleteFunction || $copyFunction || $modifyFunction || $displayDetail) && ($linkAsHiddenForms)) {
          print("      </TR></TABLE>\n");
      }


       if (length($ownActionFunction) > 0) {
         &$ownActionFunction();
         $empty = $FALSE;
       }

       if ($empty) {
         printf ("%s</TD>\n",htmlNullStr(""));
       } else {
         print("      </font></TD>\n");
       }
     }
     print(" </TR>\n");
  }
  if (($action eq "ForModify") || ($action eq "ForCopy")) {
    my($tmpVal) = "";
    my($p1) = "";
    my($p2) = "";
    if ($modifyTemplateName ne "") {
      $p1 = "{";
      $p2 = "}";
    }

    ### if (isDebug()) {printf ("ForModify: myEditFieldFormat<BR>\n"); displayHashTableHTML(%myEditFieldFormat); }
    my($focusSet) = $FALSE;
    my($localStr) = "";

    if ($action eq "ForModify") {
      printf ("   <INPUT TYPE=HIDDEN  NAME=\"%s\" VALUE=\"%s\">\n",$keyFieldName,$parts[$locNameToIndex{$keyFieldName}]);
    }
    if ($modifyDateFieldName ne "") {
      printf ("   <INPUT TYPE=HIDDEN  NAME=\"%s\" VALUE=\"%s\">\n",$modifyDateFieldName,getTimeStamp());
    }
    foreach $key (@myEditFieldOrder) {
      if (exists($myEditFieldFormat{$key})) {
         if ($passwordFieldName eq $key) {
             %transTabXXXX = (%transTabXXXX,("${p1}Title:${key}${p2}",$myTitles{$key}));
             $localStr = sprintf ("<INPUT TYPE=PASSWORD  NAME=%s size=\"%s\" VALUE=\"\">",$passwordFieldName,$myEditFieldFormat{$key});
             %transTabXXXX = (%transTabXXXX,("${p1}${passwordFieldName}${p2}",$localStr));

             %transTabXXXX = (%transTabXXXX,("${p1}Title:NewPwd${p2}",$newPwdLabel));
             $localStr = sprintf ("<INPUT TYPE=PASSWORD  NAME=\"NewPwdXXX\" size=\"%s\" VALUE=\"\">",$myEditFieldFormat{$key});
             %transTabXXXX = (%transTabXXXX,("${p1}NewPwd${p2}",$localStr));

             %transTabXXXX = (%transTabXXXX,("${p1}Title:NewPwdVery${p2}",$newPwdLabelVerify));
             $localStr = sprintf ("<INPUT TYPE=PASSWORD  NAME=\"NewPwdXXXVerify\" size=\"%s\" VALUE=\"\">",$myEditFieldFormat{$key});
             %transTabXXXX = (%transTabXXXX,("${p1}NewPwdVery${p2}",$localStr));
         } else {
             my($dispVal) = $parts[$locNameToIndex{$key}];

             if ($dispVal eq $NotDefined) {
                my($defaultVal) = getDefaultVal($key);
                if ($defaultVal eq $NotDefined) {
                    $defaultVal = "";
                }
                $dispVal = $defaultVal;
             } else {
                my(@inFormParts) = split(":",$myInputFormats{$key});
                if ($inFormParts[0] eq "Date") {
                    my($dateFormat) = "";
                    if ($language eq $LangEnglish) {
                       $dateFormat = "USA";
                    } elsif ($language eq $LangGerman) {
                       $dateFormat = "EUR";
                    }
                    $dispVal = formatTimeStamp($dispVal,$dateFormat,$FALSE,$FALSE,$language);
                } elsif ($inFormParts[0] eq "curr") {
                    my($dateFormat) = "";
                    if ($language eq $LangEnglish) {
                       $dateFormat = "USA";
                    } elsif ($language eq $LangGerman) {
                       $dateFormat = "EUR";
                    }
                    $dispVal = formatTimeStamp($dispVal,$dateFormat,$FALSE,$FALSE,$language);
                }
             }
             if (substr($myEditFieldFormat{$key},0,1) eq "[") {
                %transTabXXXX = (%transTabXXXX,("${p1}Title:${key}${p2}",$myTitles{$key}));
                my($enumVal)    = substr($myEditFieldFormat{$key},1,length($myEditFieldFormat{$key})-2);
                my(@enuValList) = split(",",$enumVal);
                ### $localStr = getSelectorWidget(1,$key,$dispVal, @enuValList);
                $localStr = getSelectorWidgetForValueTextPair(";",1,$key,$dispVal,$FALSE,@enuValList);

                %transTabXXXX = (%transTabXXXX,("${p1}${key}${p2}",$localStr));
             } elsif ($myEditFieldFormat{$key} =~ /\*/) {
                %transTabXXXX = (%transTabXXXX,("${p1}Title:${key}${p2}",$myTitles{$key}));
                my(@widthHeigtList) = split("\\*",$myEditFieldFormat{$key});
                my $width = $widthHeigtList[0];
                my $heigt = $widthHeigtList[1];
                my $wrapString = " WRAP=virtual";
                if (index($heigt,"NoWrap") != -1) {
                  $wrapString = " WRAP=off";
                }
                $heigt =~ s/ //g;
                $heigt =~ s/NoWrap//g;

                $dispVal =~ s/\<BR\>/\n/g;
                $localStr = "<TEXTAREA NAME=\"${key}\" ROWS=${width} COLS=${heigt} ${wrapString}>${dispVal}</TEXTAREA>";
                %transTabXXXX = (%transTabXXXX,("${p1}${key}${p2}",$localStr));
             } elsif ($myEditFieldFormat{$key} eq "static") {
                %transTabXXXX = (%transTabXXXX,("${p1}Title:${key}${p2}",$myTitles{$key}));
                $dispVal = formatFieldHidden($dispVal,$spezFormat{$key});
                %transTabXXXX = (%transTabXXXX,("${p1}${key}${p2}",$dispVal));
             } else {
                %transTabXXXX = (%transTabXXXX,("${p1}Title:${key}${p2}",$myTitles{$key}));
                $localStr = sprintf ("<INPUT TYPE=TEXT name=\"%s\" size=\"%s\" value=\"%s\">",$key,$myEditFieldFormat{$key},$dispVal);
                %transTabXXXX = (%transTabXXXX,("${p1}${key}${p2}",$localStr));
             }
         }
      }
    } # end of foreach
  }
  if ($action eq "ForDelete") {
    my($tmpVal) = "";
    my($p1) = "";
    my($p2) = "";
    if ($deleteTemplateName ne "") {
      $p1 = "{";
      $p2 = "}";
    }
    foreach $key (@myDeleteNotificationOrder) {
       %transTabXXXX = (%transTabXXXX,("${p1}Title:${key}${p2}",$myTitles{$key}));
       if ($passwordFieldName eq $key) {
          $tmpVal = sprintf ("<INPUT TYPE=PASSWORD  NAME=%s size=\"%s\" VALUE=\"\">",$passwordFieldName,$myEditFieldFormat{$key});
       } else {
          my($val) = $parts[$locNameToIndex{$key}];
          if ($val eq $NotDefined) {
             $val = "";
          }
          $val = formatFieldHidden($val,$spezFormat{$key});
          $tmpVal = sprintf ("%s",htmlNullStr($val));
       }
       %transTabXXXX = (%transTabXXXX,("${p1}${key}${p2}",$tmpVal));
    }  # end of foreach
    $loVal = "<INPUT TYPE=SUBMIT NAME=submitted VALUE=\"${strDelete}\">";
    %transTabXXXX = (%transTabXXXX,("${p1}Button:Submit${p2}",$loVal));
    $loVal = "<INPUT TYPE=BUTTON  VALUE=\"${strCancel}\" onClick=window.history.back()>";
    %transTabXXXX = (%transTabXXXX,("${p1}Button:Back${p2}",$loVal));
  }
  if ($action eq "PasswordForgotten") {
    my($tmpVal) = "";
    my($p1) = "";
    my($p2) = "";
    if ($deleteTemplateName ne "") {
      $p1 = "{";
      $p2 = "}";
    }
    foreach $key (@myDeleteNotificationOrder) {
       if ($passwordFieldName ne $key) {
          %transTabXXXX = (%transTabXXXX,("${p1}Title:${key}${p2}",$myTitles{$key}));
          my($val) = $parts[$locNameToIndex{$key}];
          if ($val eq $NotDefined) {
             $val = "";
          }
          $val = formatFieldHidden($val,$spezFormat{$key});
          $tmpVal = sprintf ("%s",htmlNullStr($val));
                  %transTabXXXX = (%transTabXXXX,("${p1}${key}${p2}",$tmpVal));
       }
    }  # end of foreach
    $loVal = "<INPUT TYPE=SUBMIT NAME=submitted VALUE=\"${strPwdSend}\">";
    %transTabXXXX = (%transTabXXXX,("${p1}Button:Submit${p2}",$loVal));
    $loVal = "<INPUT TYPE=BUTTON  VALUE=\"${strCancel}\" onClick=window.history.back()>";
    %transTabXXXX = (%transTabXXXX,("${p1}Button:Back${p2}",$loVal));
  }
}

sub displayTableHidden {
  my($sortedBy,$initWhereClause) = @_;
  addJSshowPage("",$detailToolbar,$detailStatus,$detailScrollbars,"yes",$detailViewWidth,$detailViewHeight,"showDetailPageHidden");
  addJSshowPage("",$detailToolbar,$detailStatus,$detailScrollbars,"yes",600,200,"showUploadPageHidden");
  addJSshowPage("",$detailToolbar,$detailStatus,$detailScrollbars,"yes",300,200,"showLockingPageHidden");
  print("${tableFormatBig}\n");
  print(" <TR>\n");
  my($sendWhereClause) = "";
  foreach $column (@myDisplayOrder) {
   if ($myTitles{$column} eq "") {
       printf ("  %s%s</TD>\n",$tableTitelFormat,repNullStr(" "));
   } else {
       # prepare where clause
       my($tmpWhereClause) = $initWhereClause;
       if (length($whereClause) > 0) {
          $tmpWhereClause =~ s/\=/\%3D/g;
          if (!($linkAsHiddenForms)) {
              $tmpWhereClause =~ s/ /\+/g;
          }
          $tmpWhereClause = "&WhereClause=${tmpWhereClause}";
       }
       $sendWhereClause = $tmpWhereClause;
       if ($sortFunction && (foundInArray($column,@mySorterFields))) {
              my($sortDirection) = "";
              my($sortDirIdent)  = "";
              if ($sortedBy eq $column) {
                 $sortDirection = "\%%21";
                 $sortDirIdent  = " ^";
              }
              if (!($linkAsHiddenForms)) {
                 printf ("  %s<A HREF=\"%s${paramSep}SortedBy=${sortDirection}%s&%s%s\">%s</a>${sortDirIdent}</TD>\n",$tableTitelFormat,$myCgiFormName,$column,$externalParam,$tmpWhereClause,$myTitles{$column});
              } else {
                 print("    ${tableTitelFormat}\n");
                 print("      <BR><FORM METHOD=POST ACTION=${myCgiFormName}>\n");
                 my($parStr) = "${externalParam}&${tmpWhereClause}&SortedBy=${sortDirection}${column}";
                 printf ("%s",produceHiddenField($parStr,"      "));
                 printf ("      <INPUT TYPE=SUBMIT NAME=submitted VALUE=\"%s${sortDirIdent}\">\n",removeHtmlTags($myTitles{$column}));
                 print("      </FORM></TD>\n");
              }
       } else {
          printf ("  %s%s</TD>\n",$tableTitelFormat,$myTitles{$column});
       }
   }
  } # end foreach
  if ($displayCommandColumn) {
   print("  ${tableTitelFormat}${strAction}<BR>\n");
   if ($insertFunction) {
        if ($builtInInsert) {
          print("      <A HREF=\"#insert\">${strInsert}</A>\n");
        } else {
          my($tmpWhereClause) = $initWhereClause;
          if (length($whereClause) > 0) {
             $tmpWhereClause =~ s/\=/\%3D/g;
             if (!($linkAsHiddenForms)) {
                $tmpWhereClause =~ s/ /\+/g;
             }
             $tmpWhereClause = "&WhereClause=${tmpWhereClause}";
          }
          if (!($linkAsHiddenForms)) {
             print("      <A HREF=\"${myCgiFormName}${paramSep}Action=ForInsert&${externalParam}${tmpWhereClause}\">${strInsert}</A> \n");
          } else {
             print("      <FORM METHOD=POST ACTION=${myCgiFormName}>\n");
             my($parStr) = "${externalParam}&${tmpWhereClause}&Action=ForInsert";
             printf ("%s",produceHiddenField($parStr,"      "));
             print("      <INPUT TYPE=SUBMIT NAME=submitted VALUE=\"".removeHtmlTags($strInsert)."\">\n");
             print("      </FORM>\n");
          }
        }
   }
   if ($qbeFunction) {
      print("      <A HREF=\"#qbeForm\">${strQBE}</A>\n");
   }
   if ($sendDbViaEmail) {
      print ("      <A HREF=\"${myCgiFormName}${paramSep}Action=ForSendingDb&${externalParam}${sendWhereClause}\">${strSendDbFile}</A>\n");
   }
   if ($uploadDb) {
      print ("      <A HREF=\"javascript:showUploadPageHidden('${myCgiFormName}${paramSep}Action=ForUploadingDb&${externalParam}')\">${strUploadDbFile}</A>\n");
   }

   if (lockFileExists($tabName)) {
      if ($lockingDb) {
         print ("      <A HREF=\"${myCgiFormName}${paramSep}Action=UnlockingDb&${externalParam}\">${strUnlock}</A>\n");
      } else {
         print ("      <A HREF=\"javascript:showLockingPageHidden('${myCgiFormName}${paramSep}Action=ForShowLockDb&${externalParam}')\">${strIsLocked}</A>\n");
      }
   } elsif ($lockingDb) {
         print ("      <A HREF=\"${myCgiFormName}${paramSep}Action=LockingDb&${externalParam}\">${strLock}</A>\n");
   }



   print("   </TD>\n");
  } # action title
  print(" </TR>\n");

  # Add autofilters--------------------------------------------------------------------------
  if ($autoFilter) {
    displayAutoFilter($initWhereClause);
  } # end autofilter


  $countHidden = 0;
  # Add $fixedWhereClause to the $initWhereClause
  my($locWhereClause) = $initWhereClause;
  if (!($locWhereClause =~ $fixedWhereClause)) {
     if ($locWhereClause eq "") {
       $locWhereClause = $fixedWhereClause;
     } else {
       $locWhereClause = "${locWhereClause} AND ${fixedWhereClause}";
     }
     ### print("Select WhereClause: ${locWhereClause}<BR>\n");
  }

  selectRowsInFltFile($tabName,$tabSepChr,$locWhereClause,$sortedBy,\&cbLineProcForCGIhidden,"");
  print("</TABLE>\n");
  if (length($emailColumnName) > 0) {
     if ($emailAsLink) {
        printf ($displayEmailListStr,mkEmailLinkFromTab($tabName,$tabSepChr,$emailColumnName,$emailLinkStr,$locWhereClause,$emailColumnName));
     } else {  
        mkEmailSelectorFromTab($tabName,$tabSepChr,$emailColumnName,$emailNameColumnName,$locWhereClause,$emailColumnName);
        if ($smsColumnName ne "") {
            mkEmailSelectorFromTab($tabName,$tabSepChr,$smsColumnName,$emailNameColumnName,$locWhereClause,$smsColumnName,$TRUE);
        }
     }
  }
  if (length($recordsFoundFormatStr) > 0) {
     printf (" ${recordsFoundFormatStr}",$countHidden);
  }
}

sub displayAutoFilter {
    my($oldWhereClause) = @_;
    my($firstCon) = $TRUE;
    my(%selected) = ();
    %selected = parseWhereClause($oldWhereClause);
    ### displayHashTableHTML(%selected);
    print("<SCRIPT>\n");
    print(" function beforeSendAutoFilter(aForm) {\n");
    print("  firstCon = \"TRUE\";\n");
    foreach $column (@myDisplayOrder) {
       if (foundInArray($column,@myAutofilterFields)) {
          print("   if (aForm.sel${column}.options[aForm.sel${column}.selectedIndex].value != \"${strAll}\") {\n");
          print("     if (firstCon == \"TRUE\") {\n");
          print("       aForm.WhereClause.value = \"${column}=\"+ aForm.sel${column}.options[aForm.sel${column}.selectedIndex].value;\n");
          print("       firstCon = \"FLASE\";\n");
          print("     } else {\n");
          print("       aForm.WhereClause.value += \" AND ${column}=\"+ aForm.sel${column}.options[aForm.sel${column}.selectedIndex].value;\n");
          print("     }\n");
          print("   }\n");
       }
    } # foreach autofilter selection
    if ($autoFireAutofilter) {
       print("   aForm.submit();\n");
    }
    print(" }\n");
    print("</SCRIPT>\n");
    print("<FORM Name=\"AutoFilterForm\" onSubmit=\"beforeSendAutoFilter(this)\" METHOD=POST ACTION=${myCgiFormName}>\n");
    print(" <TR>\n");
    foreach $column (@myDisplayOrder) {
       print("  ${tableTitelFormat}");
       if (foundInArray($column,@myAutofilterFields)) {
         displayOneAutofilter($tabName,$tabSepChr,$column,$selected{$column});
       } else {
         printf ("%s",repNullStr(" "));
       }
       print("  </TD>\n");
    } # action autofilter foreach
    if ($displayCommandColumn) {
          print("  ${tableTitelFormat}\n");
    }
    printf ("%s",produceHiddenField($externalParam,"      "));
    if (!($autoFireAutofilter)) {
       print("      <INPUT TYPE=SUBMIT NAME=submitted VALUE=\"${strSelect}\">&nbsp;\n");
    } else {
       if ($displayCommandColumn) {
          print("      &nbsp;\n");
       }
    }
    ## print("      <INPUT TYPE=RESET   VALUE=\"Undo\">\n");
    print("      <INPUT TYPE=HIDDEN name=\"SortedBy\"  value=\"${sortedBy}\">");
    if (isDebug()) {
      print("<BR><INPUT TYPE=TEXT name=\"WhereClause\"  value=\"\">");
    } else {
      print("<INPUT TYPE=HIDDEN name=\"WhereClause\"  value=\"\">");
    }
    if ($displayCommandColumn) {
          print("  </TD>\n");
    }
    print(" </TR>\n");
    print("</FORM>\n");
}


sub displayForSendingDbHidden {
  my($locWhereClause) = @_;
  my($sendBtnLbl) = getLangStr("strSendDbFile");
  my($emailLbl)   = getLangStr("strEmailAdr");
  print("<TABLE border=1 cellpadding=3 cellspacing=0><TR><TD colspan=2 bgcolor=silver><CENTER><B>${strSendDbFile}</B></TD></TR>\n");
  print("<FORM Name=\"SendingForm\" METHOD=POST ACTION=${myCgiFormName}>\n");
  print("<TD>${emailLbl}</TD><TD><INPUT TYPE=Text    NAME=emailAdr    SIZE=45 VALUE=\"\"></TD>\n");
  print("<INPUT TYPE=Hidden  NAME=Action           VALUE=\"SendingDb\">\n");
  print("<INPUT TYPE=Hidden  NAME=WhereClause      VALUE=\"${locWhereClause}\">\n");
  printf ("%s",produceHiddenField($externalParam,"     "));
  print("<TR><TD colspan=2><CENTER><INPUT TYPE=SUBMIT  NAME=submitted        VALUE=\"${sendBtnLbl}\">&nbsp;&nbsp;");
  print("<INPUT TYPE=BUTTON  VALUE=\"${strCancel}\" onClick=window.history.back()>&nbsp;&nbsp;");
  print("<INPUT TYPE=RESET   VALUE=\"${strUndo}\"></TD></TR></TABLE>");
  print("</FORM>\n");
}


sub displayModifyRecHidden {
  my($locWhereClause) = @_;
  my($onClickEVH) = "";
  my($localStr)   = "";
  %transTabXXXX = ();
  my($p1) = "";
  my($p2) = "";
  if ($modifyTemplateName ne "") {
    $p1 = "{";
    $p2 = "}";
  }

  if (length($checkInsertModformJS) > 0) {
     $onClickEVH = "onClick='checkBeforeSubmit(this.form, this)'";
     addJScheckBeforeSubmit($checkInsertModformJS,"checkBeforeSubmit");
     &$checkInsertModformJS();
  }

  my($btnLbl) = $strModify;
  if ($action eq "ForCopy") {
     $btnLbl = removeHtmlTags($strInsert);
  }
  print("<FORM Name=\"ModifyForm\" METHOD=POST ACTION=${myCgiFormName}>\n");
  print("<!-- Start of selectRowsInFltFile-->\n");
  print("<!-- locWhereClause (1):${locWhereClause}:-->\n");
  selectRowsInFltFile($tabName,$tabSepChr,$locWhereClause,"",\&cbLineProcForCGIhidden,"");
  print("<!-- End of selectRowsInFltFile-->\n");
  if (length($checkInsertModformJS) > 0) {
     $localStr = "<INPUT TYPE=BUTTON NAME=Submit VALUE=\"${btnLbl}\" ${onClickEVH}>";
  } else {
     $localStr = "<INPUT TYPE=SUBMIT NAME=submitted VALUE=\"${btnLbl}\">";
  }

  %transTabXXXX = (%transTabXXXX,("${p1}Button:Submit${p2}",$localStr));
  $localStr = "<INPUT TYPE=BUTTON  VALUE=\"${strCancel}\" onClick=window.history.back()>";
  %transTabXXXX = (%transTabXXXX,("${p1}Button:Back${p2}",$localStr));
  $localStr = "<INPUT TYPE=RESET   VALUE=\"${strUndo}\">";
  %transTabXXXX = (%transTabXXXX,("${p1}Button:Reset${p2}",$localStr));

  if (isDebug()) {printf ("ForModify: EditorFields<BR>\n"); displayHashTableHTML(%transTabXXXX); }

  if ($modifyTemplateName eq "") {
      displayStandartFormForModify(%transTabXXXX);
  } else {
      my(@allLines) = replacePlaceholdersInFile($modifyTemplateName,%transTabXXXX);
      my($aLine) = "";
      foreach $aLine (@allLines) {
        print("${aLine}\n");
      }
  }

  if ($action eq "ForCopy") {
     print("     <INPUT TYPE=HIDDEN  NAME=Action      VALUE=Insert>\n");
  } else {
     print("     <INPUT TYPE=HIDDEN  NAME=Action      VALUE=Modify>\n");
  }
  my($tmpWhereClause) = $whereClause;
  ### $tmpWhereClause =~ s/\=/\%3D/g;
  print("     <INPUT TYPE=HIDDEN  NAME=WhereClause   VALUE=\"${tmpWhereClause}\">\n");
  printf ("%s",produceHiddenField($externalParam,"     "));
  if ($modifyTemplateName eq "") {
     print(" </TR>\n");
     print("</TABLE>\n");
  }
  print("</FORM>\n");
}

sub displayStandartFormForModify {
  my(%transTab) = @_;
  my($titleLbl) = $modifyTitle;
  if ($action eq "ForCopy") {
     $titleLbl = $insertTitle;
  }

  print("${tableFormatSmall}\n");
  print(" <TR>${titleLbl}</TR>\n");

  foreach $key (@myEditFieldOrder) {
      if (exists($myEditFieldFormat{$key})) {
         if ($passwordFieldName eq $key) {
            printf (" <TR><TD>${labelFormat}%s</td>\n",$transTabXXXX{"Title:${key}"});
            printf ("     <TD>%s</td></tr>\n",$transTabXXXX{$key});
            printf (" <TR><TD>${labelFormat}%s</td>\n",$transTabXXXX{"Title:NewPwd"});
            printf ("     <TD>%s</td></tr>\n",$transTabXXXX{"NewPwd"});
            printf (" <TR><TD>${labelFormat}%s</td>\n",$transTabXXXX{"Title:NewPwdVery"});
            printf ("     <TD>%s</td></tr>\n",$transTabXXXX{"NewPwdVery"});
         } else {
           if ($myEditFieldFormat{$key} =~ /\*/) {
              printf (" <TR><TD colspan=2>${labelFormat}<CENTER>%s<BR>\n",$transTabXXXX{"Title:${key}"});
              printf ("        %s",$transTabXXXX{$key});
              print("</td></tr>\n");
           } else {
              printf (" <TR><TD>${labelFormat}%s</td>\n",$transTabXXXX{"Title:${key}"});
              printf ("     <TD>%s</td></tr>\n",$transTabXXXX{$key});
           }
         }
         if ((!$focusSet) && ($myEditFieldFormat{$key} ne "static")) {
            print("<SCRIPT> document.ModifyForm.${key}.focus()</SCRIPT>\n");
            $focusSet = $TRUE;
         }
      }
    } # end of foreach
    print(" <TR><TD colspan=${colSpanDelete}>${labelFormat}<CENTER><BR>\n");
    printf ("     %s&nbsp;&nbsp;&nbsp;\n",$transTab{"Button:Submit"});
    printf ("     %s&nbsp;&nbsp;&nbsp;\n",$transTab{"Button:Reset"});
    printf ("     %s<BR>&nbsp;</CENTER></td>\n",$transTab{"Button:Back"});
}

sub displayDetailHidden {
  my($locWhereClause) = @_;
  my(@aRecList) = getRowsInFltFile($tabName,$tabSepChr,$locWhereClause,"");
  htmlHeaderNoMimeType("Detail","");
  addJScommon();
  ## print("whereClause:${locWhereClause}:>BR>\n");
  ### TBS BUG 1 printf ("aRecList:%s:<BR>\n",$aRecList[0]);
  @parts = split(/$tabSepChr/,$aRecList[0]);
  my($part) = "";
  my(%nameValPair) = ();
  my($count) = 0;
  my($cOfFi) = 0;  $cOfFi = @myDisplayDetailFields;
  foreach $part (@parts) {
    my($colName)  = ${indexToColName{$count}};
    ### TBS Bug 1 falls letzter Eintrag leer -> Feld wird nicht genommen!!!!!!!
    ### TBS BUG 1 print("${colName}:${part}:<BR>\n");
    my($fieldVal) = transformFieldHidden($colName,$part);
    my($formFieldVal) = formatFieldHidden($fieldVal,$spezFormat{$colName});
    %nameValPair = (%nameValPair,("{Title:${colName}}",$myTitles{$colName}));
    if (($cOfFi == 0) || (foundInArray($colName,@myDisplayDetailFields))) {
       %nameValPair = (%nameValPair,("{${colName}}",${formFieldVal}));
    } else {
       %nameValPair = (%nameValPair,("{${colName}}",$fieldIsHiddenStr));
    }
    $count++;
  }
  if ($showDetailTemplateName eq "") {
    print("<BODY><CENTER>\n");
    print("<H1>${strDetail}</H1>\n");
    displayStandartFormForDetail(%nameValPair);
  } else {
    ### TBS BUG 1 displayHashTableHTML(%nameValPair);
    my(@allLines) = replacePlaceholdersInFile($showDetailTemplateName,%nameValPair);
    my($aLine) = "";
    print("<BODY>\n");
    foreach $aLine (@allLines) {
       print("${aLine}\n");
    }
  }
  print("<CENTER>\n");
  print("<FORM><INPUT TYPE=BUTTON  VALUE=\"${strClose}\" onClick=closeMe()></FORM>\n");
  print("</CENTER>\n");
  htmlTail();
}

sub displayStandartFormForDetail {
 my(%aHashTab)  = @_;
 my($key)       = "";
 my(@keyOfHash) = keys %aHashTab;
 print("<TABLE border=${DefaultTableBorder} cellpadding=${DefaultTableCellPadding} cellspacing=${DefaultTableCellSpacing}>\n");
 my($cOfFi) = 0;  $cOfFi = @myDisplayDetailFields;
 if ($cOfFi != 0) {
   my($locKey) = "";
   @keyOfHash = ();
   foreach $locKey (@myDisplayDetailFields) {
     push(@keyOfHash,"{${locKey}}");
   }
 }
 foreach $key (@keyOfHash) {
   if (!($key =~ /^{Title:/)) {
     my($title) = $key;
     $title =~ s/{//g;
     $title =~ s/}//g;
     ## if (($cOfFi == 0) || (foundInArray($title,@myDisplayDetailFields))) {
     printf("<TR><TD>%s</td><TD>%s</td></tr>\n",$myTitles{$title},htmlNullStr($aHashTab{$key}));
     ## }
   }
 }
 print("</TABLE>\n");
}

sub displayDeleteRecHidden {
  my($locWhereClause) = @_;
  my($loVal)  = "";
  %transTabXXXX = ();

  selectRowsInFltFile($tabName,$tabSepChr,$locWhereClause,"",\&cbLineProcForCGIhidden,"");
  if (isDebug()) { printf ("Delete Form Palceholders:<BR>\n"); displayHashTableHTML(%transTabXXXX); }

  print("<FORM Name=\"DeleteForm\" METHOD=POST ACTION=${myCgiFormName}>\n");
  if ($deleteTemplateName eq "") {
      displayStandartFormForDelete(%transTabXXXX);
  } else {
      my(@allLines) = replacePlaceholdersInFile($deleteTemplateName,%transTabXXXX);
      my($aLine) = "";
      foreach $aLine (@allLines) {
        print("${aLine}\n");
      }
  }
  if ($modifyDateFieldName ne "") {
    printf ("     <INPUT TYPE=HIDDEN  NAME=%s  VALUE=%s>\n",$modifyDateFieldName,getTimeStamp());
  }
  print("     <INPUT TYPE=HIDDEN  NAME=Action      VALUE=Delete>\n");
  my($tmpWhereClause) = $whereClause;
  ### $tmpWhereClause =~ s/\=/\%3D/g;
  print("     <INPUT TYPE=HIDDEN  NAME=WhereClause   VALUE=\"${tmpWhereClause}\">\n");
  printf ("     <INPUT TYPE=HIDDEN  NAME=doWhereClause VALUE=%s=%s>\n",$keyFieldName,$parts[$colNameToIndex{$keyFieldName}]);
  printf ("%s",produceHiddenField($externalParam,"     "));
  print("</FORM>\n");
}

sub displayStandartFormForDelete {
  my(%transTab) = @_;
  print("${tableFormatSmall}\n");
  print(" <TR>${deleteTitle}</TR>\n");
  foreach $key (@myDeleteNotificationOrder) {
     printf (" <TR><TD>${labelFormat}%s</td>\n",$transTab{"Title:${key}"});
     printf ("     <TD><B>%s</B></td></tr>\n",$transTab{$key});
  }  # end of foreach
  print(" <TR><TD colspan=${colSpanDelete}>${labelFormat}<CENTER><BR>\n");
  printf ("     %s&nbsp;&nbsp;&nbsp;\n",$transTab{"Button:Submit"});
  printf ("     %s<BR>&nbsp;</CENTER></td>\n",$transTab{"Button:Back"});
  print(" </TR>\n");
  print("</TABLE>\n");
}

sub displayForgottenRecHidden {
  my($locWhereClause) = @_;
  my($loVal)  = "";
  %transTabXXXX = ();

  selectRowsInFltFile($tabName,$tabSepChr,$locWhereClause,"",\&cbLineProcForCGIhidden,"");
  if (isDebug()) { printf ("Forgotten Form Palceholders:<BR>\n"); displayHashTableHTML(%transTabXXXX); }

  print("<FORM Name=\"ForgottenForm\" METHOD=POST ACTION=${myCgiFormName}>\n");
  if ($forgottenTemplateName eq "") {
      displayStandartFormForForgotten(%transTabXXXX);
  } else {
      my(@allLines) = replacePlaceholdersInFile($forgottenTemplateName,%transTabXXXX);
      my($aLine) = "";
      foreach $aLine (@allLines) {
        print("${aLine}\n");
      }
  }
  print("     <INPUT TYPE=HIDDEN  NAME=Action      VALUE=PasswordSend>\n");
  my($tmpWhereClause) = $whereClause;
  ### $tmpWhereClause =~ s/\=/\%3D/g;
  print("     <INPUT TYPE=HIDDEN  NAME=WhereClause   VALUE=\"${tmpWhereClause}\">\n");
  printf ("     <INPUT TYPE=HIDDEN  NAME=doWhereClause VALUE=%s=%s>\n",$keyFieldName,$parts[$colNameToIndex{$keyFieldName}]);
  printf ("%s",produceHiddenField($externalParam,"     "));
  print("</FORM>\n");
}

sub displayStandartFormForForgotten {
  my(%transTab) = @_;
  print("${tableFormatSmall}\n");
  print(" <TR>${forgotTitle}</TR>\n");
  foreach $key (@myDeleteNotificationOrder) {
     if ($passwordFieldName ne $key) {
       printf (" <TR><TD>${labelFormat}%s</td>\n",$transTab{"Title:${key}"});
       printf ("     <TD><B>%s</B></td></tr>\n",$transTab{$key});
         }
  }  # end of foreach
  print(" <TR><TD colspan=${colSpanDelete}>${labelFormat}<CENTER><BR>\n");
  printf ("     %s&nbsp;&nbsp;&nbsp;\n",$transTab{"Button:Submit"});
  printf ("     %s<BR>&nbsp;</CENTER></td>\n",$transTab{"Button:Back"});
  print(" </TR>\n");
  print("</TABLE>\n");
}

sub displayInsertFieldsHidden {
  my($key)        = "";
  my($setFocusOn) = "";
  my(%transTab)   = ();
  my($onClickEVH) = "";
  # prepare the data
  # ----------------
  my($p1) = "";
  my($p2) = "";
  if ($insertTemplateName ne "") {
    $p1 = "{";
    $p2 = "}";
  }
  if (isDebug()) { print("DefaultValues:<BR>\n"); displayHashTableHTML(%myDefaultValues); }
  foreach $key (@myEditFieldOrder) {
    my($default) = getDefaultVal($key);
    if ($default eq $NotDefined) {
      $default = "";
    }
    $dispVal = $default;
    if (exists($myEditFieldFormat{$key})) {
      if (($setFocusOn eq "") && ($myEditFieldFormat{$key} ne "static")) {
           $setFocusOn = $key;
      }
      if ($passwordFieldName eq $key) {
           %transTab = (%transTab,("${p1}Title:${key}${p2}",$myTitles{$key}));
           $tmpStr = sprintf ("<INPUT TYPE=PASSWORD  NAME=%s size=\"%s\" VALUE=\"${dispVal}\">",$passwordFieldName,$myEditFieldFormat{$key});
           %transTab = (%transTab,("${p1}${key}${p2}",$tmpStr));

           %transTab = (%transTab,("${p1}Title:PasswordVerify${p2}",$newPwdLabelVerify));
           $tmpStr = sprintf ("<INPUT TYPE=PASSWORD  NAME=\"NewPwdXXXVerify\" size=\"%s\" VALUE=\"${dispVal}\">",$myEditFieldFormat{$key});
           %transTab = (%transTab,("${p1}PasswordVerify${p2}",$tmpStr));
      } else {
           if (substr($myEditFieldFormat{$key},0,1) eq "[") {
              %transTab = (%transTab,("${p1}Title:${key}${p2}",$myTitles{$key}));
              my($enumVal)    = substr($myEditFieldFormat{$key},1,length($myEditFieldFormat{$key})-2);
              my(@enuValList) = split(",",$enumVal);
              ### $tmpStr = getSelectorWidget(1,$key,$dispVal, @enuValList);
              $tmpStr = getSelectorWidgetForValueTextPair(";",1,$key,$dispVal,$FALSE,@enuValList);
              %transTab = (%transTab,("${p1}${key}${p2}",$tmpStr));
           } elsif ($myEditFieldFormat{$key} =~ /\*/) {
              my(@widthHeigtList) = split("\\*",$myEditFieldFormat{$key});
              my $width = $widthHeigtList[0];
              my $heigt = $widthHeigtList[1];
              my $wrapString = " WRAP=virtual";
              if (index($heigt,"NoWrap") != -1) {
                  $wrapString = " WRAP=off";
              }
              $heigt =~ s/ //g;
              $heigt =~ s/NoWrap//g;
              %transTab = (%transTab,("${p1}Title:${key}${p2}",$myTitles{$key}));
              $tmpStr = "<TEXTAREA NAME=\"${key}\" ROWS=${width} COLS=${heigt} ${wrapString}></TEXTAREA>";
              %transTab = (%transTab,("${p1}$key${p2}",$tmpStr));
           } elsif ($myEditFieldFormat{$key} eq "static") {
              %transTab = (%transTab,("${p1}Title:${key}${p2}",$myTitles{$key}));
              $tmpStr = "${dispVal}";
              %transTab = (%transTab,("${p1}${key}${p2}",$tmpStr));
           } else {
              %transTab = (%transTab,("${p1}Title:${key}${p2}",$myTitles{$key}));
              $tmpStr = sprintf ("<INPUT TYPE=TEXT name=\"%s\" size=\"%s\" value=\"${dispVal}\">",$key,$myEditFieldFormat{$key});
              %transTab = (%transTab,("${p1}${key}${p2}",$tmpStr));
           }
      }
    } # end of if edit field is in edit format
  } # foreach
  if (length($checkInsertModformJS) > 0) {
     $onClickEVH = "onClick='checkBeforeSubmit(this.form, this)'";
     $tmpStr = "<INPUT TYPE=BUTTON NAME=Submit VALUE=\"".removeHtmlTags($strInsert)."\" ${onClickEVH}>";
     %transTab = (%transTab,("${p1}Button:Submit${p2}",$tmpStr));
  } else {
     $tmpStr = "<INPUT TYPE=SUBMIT NAME=submitted VALUE=\"".removeHtmlTags($strInsert)."\">";
     %transTab = (%transTab,("${p1}Button:Submit${p2}",$tmpStr));
  }
  $tmpStr = "<INPUT TYPE=BUTTON  VALUE=\"${strCancel}\" onClick=window.history.back()>";
  %transTab = (%transTab,("${p1}Button:Back${p2}",$tmpStr));

  $tmpStr = "<INPUT TYPE=RESET   VALUE=\"${strUndo}\">";
  %transTab = (%transTab,("${p1}Button:Reset${p2}",$tmpStr));

  if (isDebug()) { print("Insert Placeholders:<BR>\n"); displayHashTableHTML(%transTab); }
  # display form
  # ------------
  print("<a name=\"insert\"></a>");

  if (length($checkInsertModformJS) > 0) {
     addJScheckBeforeSubmit($checkInsertModformJS,"checkBeforeSubmit");
     &$checkInsertModformJS();
  }
  print("<FORM Name=\"InsertForm\" METHOD=POST ACTION=${myCgiFormName}>\n");

  if ($insertTemplateName eq "") {
      displayStandartFormForInsert(%transTab);
  } else {
      my(@allLines) = replacePlaceholdersInFile($insertTemplateName,%transTab);
      my($aLine) = "";
      foreach $aLine (@allLines) {
        print("${aLine}\n");
      }
      print("     <INPUT TYPE=HIDDEN  NAME=Action        VALUE=Insert>\n");
      my($tmpWhereClause) = $whereClause;
      ### $tmpWhereClause =~ s/\=/\%3D/g;
      print("     <INPUT TYPE=HIDDEN  NAME=WhereClause   VALUE=\"${tmpWhereClause}\">\n");
      printf ("%s",produceHiddenField($externalParam,"     "));
      if ($modifyDateFieldName ne "") {
         printf ("     <INPUT TYPE=HIDDEN  NAME=%s  VALUE=%s>\n",$modifyDateFieldName,getTimeStamp());
      }
      print("</TABLE>\n");
      print("</FORM>\n");
  }
  if (!$builtInInsert) {
    print("<SCRIPT> document.InsertForm.${setFocusOn}.focus()</SCRIPT>\n");
  }
}

sub displayStandartFormForInsert {
  my(%transTab) = @_;
  print("${tableFormatSmall}\n");
  print(" <TR>${insertTitle}</TR>\n");
  foreach $key (@myEditFieldOrder) {
    if (exists($myEditFieldFormat{$key})) {
      if (($setFocusOn eq "") && ($myEditFieldFormat{$key} ne "static")) {
           $setFocusOn = $key;
      }
      if ($myEditFieldFormat{$key} =~ /\*/) {
          printf (" <TR><TD colspan=2><CENTER>${labelFormat}%s<BR>\n",$transTab{"Title:${key}"});
          printf ("         %s",$transTab{$key});
          print("</td></tr>\n");
      } else {
          printf (" <TR><TD>${labelFormat}%s</td>\n",$transTab{"Title:${key}"});
          printf ("     <TD>%s</td></tr>\n",$transTab{$key});
          if ($passwordFieldName eq $key) {
            printf (" <TR><TD>${labelFormat}%s</td>\n",$transTab{"Title:PasswordVerify"});
            printf ("     <TD>%s</td></tr>\n",$transTab{"PasswordVerify"});
          }
      }
    } # end of if edit field is in edit format
  } # foreach
  print(" <TR><TD colspan=${colSpanInsert}>${labelFormat}<CENTER><BR>\n");
  printf ("     %s&nbsp;&nbsp;&nbsp;\n",$transTab{"Button:Submit"});
  printf ("     %s&nbsp;&nbsp;&nbsp;\n",$transTab{"Button:Reset"});
  printf ("     %s<BR>&nbsp;&nbsp;</CENTER></td>\n",$transTab{"Button:Back"});
  print("     <INPUT TYPE=HIDDEN  NAME=Action        VALUE=Insert>\n");
  my($tmpWhereClause) = $whereClause;
  ## $tmpWhereClause =~ s/\=/\%3D/g;
  ## $tmpWhereClause =~ s/ /\+/g;
  print("     <INPUT TYPE=HIDDEN  NAME=WhereClause   VALUE=\"${tmpWhereClause}\">\n");
  printf ("%s",produceHiddenField($externalParam,"     "));
  if ($modifyDateFieldName ne "") {
    printf ("     <INPUT TYPE=HIDDEN  NAME=%s  VALUE=%s>\n",$modifyDateFieldName,getTimeStamp());
  }
  print(" </TR>\n");
  print("</TABLE>\n");
  print("</FORM>\n");
}


# if there is a conversion error it sets the variable $errorReturnCode otherwise it is ""
sub getCgiValuesHidden {
  my(%retValue) =  ($keyFieldName => getParam($keyFieldName,getNextKey($tabName,$tabSepChr,$keyFieldName)));
  my(@aKeysOfHash) = @myEditFieldOrder;

  foreach $key (@aKeysOfHash) {
    if (!($key eq $keyFieldName)) {
        my($cgiParamVal) = getParamRem($key,$NotDefined,$tabSepChr," ");
        $cgiParamVal =~ s/\"/\'/g;
        $cgiParamVal =~ s/\n/\<BR\>/g;
        $cgiParamVal =~ s/\r//g;
        %retValue = (%retValue,($key => $cgiParamVal));
    }
    if (exists($myFixedValues{$key})) {
        delete $retValue{$key};
        %retValue = (%retValue,($key => $myFixedValues{$key}));
    }
    if (exists($myInputFormats{$key})) {
        my($parsedVal)   = "";
        my(@inFormParts) = split(":",$myInputFormats{$key});
        if ($inFormParts[0] eq "Date") {
             $parsedVal = readDate($retValue{$key},$language);
             if (index($parsedVal,$ErrorString) >= 0) {
                 $errorReturnCode = sprintf("%s\n<BR>Field:%s",substr($parsedVal,length($ErrorString)+1),$myTitles{$key});
             } else {
                 delete $retValue{$key};
                 %retValue = (%retValue,($key => $parsedVal));
             }
        } elsif ($inFormParts[0] eq "curr") {
             $parsedVal = readCurr($retValue{$key},$language);
             if (index($parsedVal,$ErrorString) >= 0) {
                 $errorReturnCode = sprintf("%s\n<BR>Field:%s",substr($parsedVal,length($ErrorString)+1),$myTitles{$key});
             } else {
                 delete $retValue{$key};
                 %retValue = (%retValue,($key => $parsedVal));
             }
        } elsif ($inFormParts[0] eq "userDefined") {
             my($usrFunc) = $inFormParts[1];
             $parsedVal = &$usrFunc($retValue{$key},$language);
             if (index($parsedVal,$ErrorString) >= 0) {
                $errorReturnCode = sprintf("%s\n<BR>Field:%s",substr($parsedVal,length($ErrorString)+1),$myTitles{$key});
             } else {
                delete $retValue{$key};
                %retValue = (%retValue,($key => $parsedVal));
             }
        }
    }
  }

  if (isDebug()) {
    print("In getCgiValuesHidden<BR>\n");
    displayHashTableHTML(%retValue);
  }
  return %retValue;
}

sub displayQBEForm {
  print("<SCRIPT>\n");
  print(" function beforeSendQBEForm(aForm) {\n");
  print("       aForm.WhereClause.value = aForm.fieldNames1.options[aForm.fieldNames1.selectedIndex].value;\n");
  print("       aForm.WhereClause.value += aForm.operator1.options[aForm.operator1.selectedIndex].value;\n");
  print("       aForm.WhereClause.value += aForm.compValue1.value;\n");
  print(" }\n");
  print("</SCRIPT>\n");
  print("<a name=\"qbeForm\"></a>");
  print("<FORM Name=\"QBEForm\" onSubmit=\"beforeSendQBEForm(this)\" METHOD=POST ACTION=${myCgiFormName}>\n");
  print("${tableFormatSmall}\n");
  print(" <TR>${qbeTitle}</TR>\n");
  print(" <TR><TD>Field-Name:</TD><TD><SELECT NAME=fieldNames1>\n");
  @aKeysOfHash = keys %myTitles;
  print("   <OPTION VALUE=\"\"> \n");
  foreach $key (@aKeysOfHash) {
    printf ("   <OPTION VALUE=\"%s\">%s\n",$key,removeHtmlTags($myTitles{$key}));
  }
  print(" </SELECT></TD></TR>\n");
  print(" <TR><TD>Operator:</TD><TD><SELECT NAME=operator1>\n");
  print("   <OPTION VALUE=\"\"> \n");
  print("   <OPTION VALUE=\"=\">=\n");
  print("   <OPTION VALUE=\"!=\">!=\n");
  print("   <OPTION VALUE=\"<\">< (numeric)\n");
  print("   <OPTION VALUE=\">\">> (numeric)\n");
  print("   <OPTION VALUE=\"<=\"><= (numeric)\n");
  print("   <OPTION VALUE=\">=\">>= (numeric)\n");
  print("   <OPTION VALUE=\" like \">like\n");
  print("   <OPTION VALUE=\" starts \">starts\n");
  print("   <OPTION VALUE=\" ends \">ends\n");
  print("   <OPTION VALUE=\" like \">like\n");
  print("   <OPTION VALUE=\" gt \">greater (alphabetic)\n");
  print("   <OPTION VALUE=\" ge \">greater or equal (alphabetic)\n");
  print("   <OPTION VALUE=\" lt \">lower (alphabetic)\n");
  print("   <OPTION VALUE=\" le \">lower or equal (alphabetic)\n");
  print(" </SELECT></TD></TR>\n");
  print(" <TR><TD>Value:</TD><TD><INPUT TYPE=TEXT name=\"compValue1\"  value=\"\"></TD></TR>\n");
  if (isDebug()) {
    print(" <TR BGCOLOR=\"ff0000\"><TD>SQL:</TD><TD><INPUT TYPE=TEXT name=\"WhereClause\"  value=\"${whereClause}\"></TD></TR>\n");
  } else {
    print(" <INPUT TYPE=HIDDEN name=\"WhereClause\"  value=\"${whereClause}\">\n");
  }
  printf ("%s",produceHiddenField($externalParam," "));
  print(" <TR><TD colspan=2><CENTER><INPUT TYPE=SUBMIT NAME=submitted VALUE=\"Select\"></TD></TR>\n");
  print("</TABLE>\n");
  print("</FORM>\n");
}

$lockFilePostFixStr = "_Looked";

sub lockFileExists {
  my($tabName) = @_;
  my($lockName) = "${tabName}${lockFilePostFixStr}";
  if (-e $lockName) {
    return $TRUE;
  } else {
    return $FALSE;
  }
}

sub createLookFile {
  my($tabName,$reason) = @_;
  my($lockName) = "${tabName}${lockFilePostFixStr}";
  unlink($lockName);
  appendLine($lockName,$reason);
}

sub removeLookFile {
  my($tabName,$reason) = @_;
  my($lockName) = "${tabName}${lockFilePostFixStr}";
  unlink($lockName);
}

# crypt dB File
# -------------
sub createDecryptedDbFile {
  my($dBName,$key) = @_;
  if ($key ne "") {
     cryptUNIXFile("${dBName}_crypted",$dBName,$key);
  }
}

sub removeDecryptedDbFile {
  my($dBName,$key) = @_;
  if ($key ne "") {
     unlink($dBName);
  }
}

sub createCryptedDbFile {
  my($dBName,$key) = @_;
  if ($key ne "") {
     cryptUNIXFile($dBName,"${dBName}_crypted",$key);
     unlink($dBName);
  }
}

sub prepareHTML_StandardFormForIt {
   my($actionPassed,$doWhereClausePassed) = @_;

$action         = getParam("Action","");
$sortedBy       = getParam("SortedBy",$initialSortClause);
if (($action eq "ForSendingDb") ||
    ($action eq "SendingDb")) {
    $whereClause    = getParam("WhereClause","");
} else {
    $whereClause    = getParam("WhereClause",$initialWhereClause);
}
$doWhereClause  = getParam("doWhereClause","");

if ($actionPassed ne "") {
   $action = $actionPassed;
}

if ($actionPassed eq $DefaultPrepareAction) {
   $action = "";
}

if ($doWhereClausePassed ne "") {
   $doWhereClause = $doWhereClausePassed;
}
$fontSizeNr     = getParam("fontSizeNr",$fontSizeDefault);

## print("action:${action}<BR>\n");
## print("doWhereClause:${doWhereClause}<BR>\n");
## print("whereClause:${whereClause}<BR>\n");


## print("whereClause:${whereClause}:<BR>\n");

## $whereClause   =~ s/\;/\=/g;
## $doWhereClause =~ s/\;/\=/g;
if ($tabSepChr  eq "\\|" ) {
   $sortedBy =~ s/\;/\|/g;
} elsif ($tabSepChr  eq ";" ){
   $sortedBy = $sortedBy;
} else {
   print("ERROR: The delimiter should either be a <B>|</b> or a <B>;</b><BR>");
}

writeDebugMsg("WhereClause:${whereClause}:<BR>\n");
writeDebugMsg("doWhereClause:${doWhereClause}:<BR>\n");
writeDebugMsg("SortedBy:${sortedBy}:<BR>\n");
writeDebugMsg("externalParam:${externalParam}:<BR>\n");

if (length($fontFace)          == 0) { $fontFace   = "face='helvetica,arial'"; }
if (length($fontSizeNr)        == 0) { $fontSizeNr = "-1"; }
if (length($fontSize)          == 0) { $fontSize = "size=${fontSizeNr}"; }

if (length($tableTitelFormat)  == 0) { $tableTitelFormat  = "<TD bgcolor=silver><font ${fontSize} ${fontFace}><CENTER>"; }
if (length($labelFormat)       == 0) { $labelFormat       = "<font ${fontSize} ${fontFace}>"; }
if (length($tableEntryFormat)  == 0) { $tableEntryFormat  = "<TD {tdAttr}><font ${fontSize} ${fontFace}>"; }
if (length($tableActionFormat) == 0) { $tableActionFormat = "<TD><font ${fontSize} ${fontFace}><CENTER>"; }
if (length($tableFormatSmall)  == 0) { $tableFormatSmall  = "<TABLE border=${DefaultTableBorder} cellpadding=${DefaultTableCellPadding} cellspacing=${DefaultTableCellSpacing}>"; }
if (length($tableFormatBig)    == 0) { $tableFormatBig    = "<TABLE border=${DefaultTableBorder} cellpadding=${DefaultTableCellPadding} cellspacing=${DefaultTableCellSpacing}>"; }
if (length($minPasswdLen)      == 0) { $minPasswdLen      = 4; }

if (length($linkAsHiddenForms) == 0) { $linkAsHiddenForms = $FALSE; }

if (length($emailAsLink)       == 0) { $emailAsLink       = $TRUE; }
if (length($emailSelSize)      == 0) { $emailSelSize      = "4"; }
if (length($emailSelTab)       == 0) { $emailSelTab       = "<TABLE>"; }


if (length($detailScrollbars)  == 0) { $detailScrollbars  = $TRUE; }
if (length($detailToolbar)     == 0) { $detailToolbar     = $FALSE; }
if (length($detailStatus)      == 0) { $detailStatus      = $FALSE; }

$enableForgottenPassword  = setDefault($enableForgottenPassword,$TRUE);
if (($passwordFieldName ne "") && ($emailColumnName  ne "") && ($enableForgottenPassword)) {
    $passwordForgottenFunction = $TRUE;
} else {
    $passwordForgottenFunction = $FALSE;
}

if ($detailScrollbars) {
   $detailScrollbars = "yes";
} else {
   $detailScrollbars = "no";
}
if ($detailToolbar) {
   $detailToolbar = "yes";
} else {
   $detailToolbar = "no";
}
if ($detailStatus) {
   $detailStatus = "yes";
} else {
   $detailStatus = "no";
}

$language             = setDefault($language,             $DefaultLang);
$strSelect            = setDefault($strSelect,            getLangStr("strSelect"));
$strAll               = setDefault($strAll,               getLangStr("strAll"));
$strAction            = setDefault($strAction,            getLangStr("strAction"));
$strInsert            = setDefault($strInsert,            getLangStr("strInsert"));
$strModify            = setDefault($strModify,            getLangStr("strModify"));
$strCopy              = setDefault($strCopy,              getLangStr("strCopy"));
$strDelete            = setDefault($strDelete,            getLangStr("strDelete"));
$strDetail            = setDefault($strDetail,            getLangStr("strDetail"));
$strCancel            = setDefault($strCancel,            getLangStr("strCancel"));
$strUndo              = setDefault($strUndo,              getLangStr("strUndo"));
$strClose             = setDefault($strClose,             getLangStr("strClose"));
$strQBE               = setDefault($strQBE,               getLangStr("strQBE"));
$newPwdLabel          = setDefault($newPwdLabel,          getLangStr("newPwdLabel"));
$newPwdLabelVerify    = setDefault($newPwdLabelVerify,    getLangStr("newPwdLabelVerify"));
$insertTitleStr       = setDefault($insertTitleStr,       getLangStr("insertTitleStr"));
$deleteTitleStr       = setDefault($deleteTitleStr,       getLangStr("deleteTitleStr"));
$modifyTitleStr       = setDefault($modifyTitleStr,       getLangStr("modifyTitleStr"));
$qbeTitleStr          = setDefault($qbeTitleStr,          getLangStr("qbeTitleStr"));
$emailLinkStr         = setDefault($emailLinkStr,         getLangStr("emailLinkStr"));
$emailSendBtnLb1      = setDefault($emailSendBtnLb1,      getLangStr("emailSendBtnLb1"));
$emailSendBtnLb2      = setDefault($emailSendBtnLb2,      getLangStr("emailSendBtnLb2"));
$displayEmailListStr  = setDefault($displayEmailListStr,  sprintf("${labelFormat}%s</font><BR>",getLangStr("displayEmailListStr")));
$pwdMissMatch         = setDefault($pwdMissMatch,         sprintf("${labelFormat}%s</font><BR><BR>\n",getLangStr("pwdMissMatch")));
$pwdError1            = setDefault($pwdError1,            sprintf("${labelFormat}%s</font><BR><BR>\n",getLangStr("pwdError1")));
$pwdError2            = setDefault($pwdError2,            sprintf("${labelFormat}%s</font><BR><BR>\n",getLangStr("pwdError2")));
$strForgotten         = setDefault($strForgotten,         getLangStr("strForgotten"));
$forgottenTitle       = setDefault($forgottenTitle,       getLangStr("forgottenTitle"));
$strPwdSend           = setDefault($strPwdSend,           getLangStr("strPwdSend"));
$emailNotifySubject   = setDefault($emailNotifySubject,   getLangStr("emailNotifySubject"));
$forgottenPwdMsg      = setDefault($forgottenPwdMsg,      getLangStr("forgottenPwdMsg"));
$strSendDbFile        = setDefault($strSendDbFile,        getLangStr("strSendDbFile"));
$sendingDbFromAdr     = setDefault($sendingDbFromAdr,     "");
$sendingDbSubject     = setDefault($sendingDbSubject,     "New Excel-File");
$sendingDbMsg         = setDefault($sendingDbMsg,         "Attached a new Excel file");
$sendingDbCcAdr       = setDefault($sendingDbCcAdr,       "");
$sendingDbBccAdr      = setDefault($sendingDbBccAdr,      "");
$strUploadDbFile      = setDefault($strUploadDbFile,      getLangStr("strUploadDbFile"));
$strUnlock            = setDefault($strUnlock,            getLangStr("strUnlock"));
$strIsLocked          = setDefault($strIsLocked,          getLangStr("strIsLocked"));
$strLock              = setDefault($strLock,              getLangStr("strLock"));

if ($language  eq $LangEnglish) {
   if (length($currCommaChar) == 0) { $currCommaChar = "."; }
   if (length($currMilSep)    == 0) { $currMilSep    = ","; }
} else {
   if (length($currCommaChar) == 0) { $currCommaChar = "."; }
   if (length($currMilSep)    == 0) { $currMilSep    = "'"; }
}

if (length($colSpanInsert)     == 0) { $colSpanInsert     = "2"; }
if (length($insertTitle)       == 0) { $insertTitle       = "<TD colspan=${colSpanInsert} bgcolor=silver><font ${fontFace}><CENTER><B>${insertTitleStr}</B>"; }
if (length($colSpanDelete)     == 0) { $colSpanDelete     = "2"; }
if (length($deleteTitle)       == 0) { $deleteTitle       = "<TD colspan=${colSpanDelete} bgcolor=silver><font ${fontFace}><CENTER><B>${deleteTitleStr}</B>"; }
if (length($forgotTitle)       == 0) { $forgotTitle       = "<TD colspan=${colSpanDelete} bgcolor=silver><font ${fontFace}><CENTER><B>${forgottenTitle}</B>"; }
if (length($colSpanModify)     == 0) { $colSpanModify     = "2"; }
if (length($modifyTitle)       == 0) { $modifyTitle       = "<TD colspan=${colSpanModify} bgcolor=silver><font ${fontFace}><CENTER><B>${modifyTitleStr}</B>"; }
if (length($qbeTitle)          == 0) { $qbeTitle          = "<TD colspan=2 bgcolor=silver><font ${fontFace}><CENTER><B>${qbeTitleStr}</B></TD>"; }


if (length($ownActionFunction)       == 0) { $ownActionFunction       = ""; }
if (length($pwdVerificationFunction) == 0) { $pwdVerificationFunction = "pwdVeriFuncHidden"; }

if (length($builtInInsert) == 0) { $builtInInsert  = $TRUE; }
if (length($fullFunction)  == 0) { $fullFunction   = $FALSE; }
if ($fullFunction) {
   $insertFunction = $TRUE;
   $copyFunction   = $TRUE;
   $deleteFunction = $TRUE;
   $modifyFunction = $TRUE;
   $qbeFunction    = $TRUE;
   $sortFunction   = $TRUE;
   $autoFilter     = $TRUE;
   $displayDetail  = $TRUE;
   $displayTable   = $TRUE;
   $sendDbViaEmail = $TRUE;
   $uploadDb       = $TRUE;
   $lockingDb      = $TRUE;
} else {
   if (length($insertFunction) == 0) { $insertFunction = $TRUE; }
   if (length($copyFunction)   == 0) { $copyFunction   = $FALSE; }
   if (length($deleteFunction) == 0) { $deleteFunction = $TRUE; }
   if (length($modifyFunction) == 0) { $modifyFunction = $TRUE; }
   if (length($qbeFunction)    == 0) { $qbeFunction    = $TRUE; }
   if (length($sortFunction)   == 0) { $sortFunction   = $TRUE; }
   if (length($autoFilter)     == 0) { $autoFilter     = $TRUE; }
   if (length($displayDetail)  == 0) { $displayDetail  = $TRUE; }
   if (length($displayTable)   == 0) { $displayTable   = $TRUE; }
   if (length($sendDbViaEmail) == 0) { $sendDbViaEmail = $FALSE; }
   if (length($uploadDb)       == 0) { $uploadDb       = $FALSE; }
   if (length($lockingDb)      == 0) { $lockingDb      = $FALSE; }
}

if (length($checkIfTblDefIsUpToDate)  == 0) { $checkIfTblDefIsUpToDate   = $FALSE; }

if (($action ne "UnlockingDb") && (lockFileExists($tabName))) {
   $insertFunction = $FALSE;
   $copyFunction   = $FALSE;
   $deleteFunction = $FALSE;
   $modifyFunction = $FALSE;
} 

if ($checkIfTblDefIsUpToDate) {
   #check if flt file is up-to-date (no missing fields there)
   #---------------------------------------------------------
   my $upgradeStatus = upgradeFltFileDefinition($tabName,"",@myEditFieldOrder);
   print("<!-- Table definition Upgrade status:${upgradeStatus}-->\n");
} else {
   print("<!-- Table definition Upgrade status:Not checked-->\n");
}

createDecryptedDbFile($tabName,$cryptKeyForDbFile);

if (length($autoFireAutofilter)   == 0) { $autoFireAutofilter  = $TRUE; }

# if the $myCgiFormName already have a ? than use a & to append the parameters (used for dispatch)
$paramSep = "?";
if ($myCgiFormName =~ /\?/) { $paramSep = "&"; }


# just there was a typo in the var name
if (@myAutofilterFields == 0) {
    if (@myAutofilterFileds != 0) {
      @myAutofilterFields = @myAutofilterFileds;
      writeDebugMsg("WARNING: Still used myAutofilterFileds<BR>\n");
    }
}

# decide if command column has been displyed (Last column)
$displayCommandColumn = ($deleteFunction || $copyFunction || $modifyFunction || $insertFunction || $qbeFunction || $displayDetail || $sendDbViaEmail || (length($ownActionFunction) > 0));
if (!($displayCommandColumn)) {
   if (($autoFilter) && (!($autoFireAutofilter))) {
      $displayCommandColumn = $TRUE;
   }
}

writeIntoLog($logFileName,"prepareHTML_StandardFormForIt${logSepChar}${loginUserId}${logSepChar}${tabName}${logSepChar}${action}${logSepChar}");
writeDebugMsg("Action:${action}:<BR>");

if (($action eq "") || ($action eq "displayTable")) {
  if ($displayTable) {
     $action = "";
     displayTableHidden($sortedBy,$whereClause);
  }
  if (($insertFunction) && ($builtInInsert)) {
     displayInsertFieldsHidden();
  }
  if ($qbeFunction) {
     displayQBEForm();
  }
}
if ($action eq "ShowDetail") {
  displayDetailHidden($doWhereClause);
}
if (($action eq "ForModify") || ($action eq "ForCopy")) {
  displayModifyRecHidden($doWhereClause);
}
if ($action eq "ForDelete") {
  displayDeleteRecHidden($doWhereClause);
}
if ($action eq "PasswordForgotten") {
  displayForgottenRecHidden($doWhereClause);
}
if ($action eq "ForInsert") {
  displayInsertFieldsHidden();
}
if ($action eq "Delete") {
  my $doesMatch = $TRUE;
  my $errMsg    = "";
  my $modRecord = "";
  if ($passwordFieldName ne "") {
      @oldPasswords = getColumnValues($tabName,$tabSepChr,$passwordFieldName,$doWhereClause,"");
      $aWhereClause = sprintf("%s AND %s=%s",$doWhereClause,$passwordFieldName,$oldPasswords[0]);
      writeDebugMsg(sprintf ("OldPassword:%s:<BR>\n",$oldPasswords[0]));
      my($entredPasswd) = getParam($passwordFieldName);
      writeDebugMsg("NewPassword:${entredPasswd}:<BR>\n");
      if ($oldPasswords[0] ne $entredPasswd) {
         $doesMatch = $FALSE;
      }
  }
  if ($markAsDelete) {
      $errorReturnCode = "";
      %newNameValuePairs1 = getCgiValuesHidden();
      $errMsg = $errorReturnCode;
      if ($errMsg ne "") {
         $doesMatch = $FALSE;
      } else {
         $modRecord = generateNewRecord($tabName,$tabSepChr,%newNameValuePairs1);
      }
  }
    
  if ($doesMatch) {
    @deletedRecord = updateRecord($tabName,$tabSepChr,$doWhereClause,"DELETE",$modRecord);
    if ($deletedRecord[0]) {
      if ($notifyEmailToAdr_Delete) {
        my(%delRecHash) = cretateHashTabFromStr($tabName,$tabSepChr,$deletedRecord[0]);
        my($msg) = hashTableToStr($TRUE,%delRecHash);
        my($retMsg) = sendMailMsgUseSendmail($notifyEmailToAdr_Delete,$notifyEmailSubject_Delete,$msg,$notifyEmailFromAdr_Delete,"","");
        print("<!-- ${notifyEmailSubject_Delete} has been sent to ${notifyEmailToAdr_Delete} (Status:${retMsg}) -->\n");
      }
      $action = "";
      writeDebugMsg("<BR>WhereClause (after Delete):${whereClause}:<BR>\n");
      if ($displayTable) {
       displayTableHidden($sortedBy,$whereClause);
      }
      if (($insertFunction) && ($builtInInsert)) {
       displayInsertFieldsHidden();
      }
      if ($qbeFunction) {
       displayQBEForm();
      }
    } else {
        printf ("%s<BR>",getLangStr("strFileLocked"));
        printf (" <FORM> <INPUT TYPE=BUTTON  VALUE=\"%s\" onClick=window.history.back()></FORM>\n",getLangStr("strTryAgain"));
    }
  } else {
    print("${pwdMissMatch}");
    printf (" <FORM> <INPUT TYPE=BUTTON  VALUE=\"%s\" onClick=window.history.back()></FORM>\n",getLangStr("strBack"));

  }
}

if ($action eq "ForUploadingDb") {
  my $pathName = getPathNameOutOfFullName($tabName);
  my $filename = getFileNameOutOfFullName($tabName);
  createFileUploadForm($myCgiFormName,"UploaderForm",getLangStr("strSave"),$fieldLength,$pathName,1,$filename,$externalParameter,getLangStr("strClose"),"Action","UploadDb");
}

if ($action eq "UploadDb") {
     my $docUploadDestination = getParam("docUploadDestination","");
     print("<!-- docUploadDestination:$docUploadDestination -->\n");
     my(%FileHandlesAndNames) = getFileHandlesAndNames();
     ### displayHashTableHTML(%FileHandlesAndNames);
     my(@uploadFileNames) = keys %FileHandlesAndNames;
     my $uploadFileName  = $uploadFileNames[0];
     my $pathName        = getPathNameOutOfFullName($tabName);
     if ($pathName ne "") {
         $uploadFileName = "${pathName}/${uploadFileName}";
     }
     my($FileHandlesAndNamesHashRef) = \%FileHandlesAndNames;
     ## print("docUploadDestination:${docUploadDestination}<BR>\n");
     ## print("maxByte:${maxByte}<BR>\n");
     ## print("successURL:${successURL}<BR>\n");   
     if ($uploadDb) {
        my($tabNameWithVersion) = putTimeStampInFileName($tabName);
        rename($tabName,$tabNameWithVersion);
        uploadFiles($docUploadDestination,$maxByte,$successHtmlTemplate,$FileHandlesAndNamesHashRef,$loginUserId,$FALSE);
        if ($uploadFileName ne $tabName) {
           my($sepChar) = $tabSepChr;
           if ($sepChar ne ";") {
                $sepChar = "|";
           }
           print("<!--");
           convertTXT_to_FLT($uploadFileName,$sepChar,$tabName);
           unlink($uploadFileName);
           print("-->");
        }
     } else {
        printf("%s",getLangStr("strNotAuthorized"));
        printf("<FORM><INPUT TYPE=BUTTON  VALUE=\"%s\" onClick=self.close()></FORM>\n",getLangStr("strClose"));
        writeIntoLog($docArchiveLogFileName,"accessDocumentArchive${logSepChar}${docArchiveRoot}${logSepChar}${docViewAction}${logSepChar}${loginUserId}${logSepChar}Upload denied");
     } 
}


if ($action eq "UnlockingDb") {
    removeLookFile($tabName);
    $action = "";
    ### print("<BR>WhereClause (after Sedning Db):${whereClause}:<BR>\n");
    if ($displayTable) {
     displayTableHidden($sortedBy,$whereClause);
    }
    if (($insertFunction) && ($builtInInsert)) {
     displayInsertFieldsHidden();
    }
    if ($qbeFunction) {
     displayQBEForm();
    }
}

if ($action eq "ForShowLockDb") {
  displayLockFileConent($tabName);
}

if ($action eq "LockingDb") {
    createLookFile($tabName,$reason);
    if (lockFileExists($tabName)) {
       $insertFunction = $FALSE;
       $copyFunction   = $FALSE;
       $deleteFunction = $FALSE;
       $modifyFunction = $FALSE;
    } 

    $action = "";
    ### print("<BR>WhereClause (after Sedning Db):${whereClause}:<BR>\n");
    if ($displayTable) {
     displayTableHidden($sortedBy,$whereClause);
    }
    if (($insertFunction) && ($builtInInsert)) {
     displayInsertFieldsHidden();
    }
    if ($qbeFunction) {
     displayQBEForm();
    }
}

if ($action eq "ForSendingDb") {
  displayForSendingDbHidden($whereClause);
}

if ($action eq "SendingDb") {
    $toAdr = getParam("emailAdr","");

    my $inFiPath = getPathNameOutOfFullName($tabName);  if ($inFiPath ne "") { $inFiPath = "${inFiPath}/"; }
    my($msg) = `rm -f ${inFiPath}ForSending_*.flt 2>&1`;
    print("<!-- msg:$msg -->\n");  
    my $tmpOutFileName = sprintf("${inFiPath}ForSending_%s.flt",getTimeStamp());
    selectFromFltToOtherFlt($tabName,$tmpOutFileName,$tabSepChr,$whereClause,$sortedBy,$FALSE,@sendingDbColumns);
    my $mailRetMsg = sendMailwithAttachments($sendingDbFromAdr,$toAdr,$sendingDbSubject,$sendingDbMsg,$tmpOutFileName,$sendingDbCcAdr,$sendingDbBccAdr,$tabSepChr,"",$FALSE);
    print("<!-- mailRetMsg:${mailRetMsg} -->\n");
    $action = "";
    writeDebugMsg("<BR>WhereClause (after Sedning Db):${whereClause}:<BR>\n");
    if ($displayTable) {
     displayTableHidden($sortedBy,$whereClause);
    }
    if (($insertFunction) && ($builtInInsert)) {
     displayInsertFieldsHidden();
    }
    if ($qbeFunction) {
     displayQBEForm();
    }
    unlink($tmpOutFileName);
}

if ($action eq "PasswordSend") {
    my(%aRecord) = getSingleRecInHash($tabName,$tabSepChr,"",$doWhereClause,"",$TRUE);
    displayHashTableHTMLdebug(%aRecord);
    my $emailAdrStr  = "{${emailColumnName}}";
    my $emailAdr     = $aRecord{$emailAdrStr};
    my $passwordStr  = "{${passwordFieldName}}";
    my $password     = $aRecord{$passwordStr};
    writeDebugMsg("${emailAdr}<BR>\n");
    writeDebugMsg("${password}<BR>\n");

    my $emailMsg = "";
    if ($fNameForgottenPwdEmail eq "") {
        $emailMsg = sprintf("${forgottenPwdMsg}\n",$password);
    } else {
        my(@allLines) = replacePlaceholdersInFile($fNameForgottenPwdEmail,%aRecord);
        foreach my $aLine (@allLines) {
          $emailMsg = "${emailMsg}${aLine}\n";
        }
    }
    writeDebugMsg("${emailMsg}<BR>\n");
    if ($emailAdr ne "") {
        sendMailMsgUseSendmail($emailAdr,$emailNotifySubject,$emailMsg,$emailNotifyFromAdr,"",$emailNotifyCCAdr);
    } else {
        print("User has no e-mail address!!<BR>\n");
    }
    $action = "";
    writeDebugMsg("<BR>WhereClause (after Delete):${whereClause}:<BR>\n");
    if ($displayTable) {
     displayTableHidden($sortedBy,$whereClause);
    }
    if (($insertFunction) && ($builtInInsert)) {
     displayInsertFieldsHidden();
    }
    if ($qbeFunction) {
     displayQBEForm();
    }
}

if ($action eq "Modify") {
  my $errMsg       = "";
  $errorReturnCode = "";
  %newNameValuePairs1 = getCgiValuesHidden();
  $errMsg = $errorReturnCode;
  my $doesMatch = $TRUE;
  if ($errMsg eq "") {
    $debug = "FALSE";
    writeDebugMsg(sprintf("keyFieldName:${keyFieldName}=%s<BR>",$newNameValuePairs1{$keyFieldName}));
    $aWhereClause  = sprintf("%s=%s",$keyFieldName,$newNameValuePairs1{$keyFieldName});

    if ($passwordFieldName ne "") {
      @oldPasswords = getColumnValues($tabName,$tabSepChr,$passwordFieldName,$aWhereClause,"",$FALSE);
      $aWhereClause = sprintf("%s AND %s=%s",$aWhereClause,$passwordFieldName,$oldPasswords[0]);
      writeDebugMsg(sprintf ("OldPassword:%s:<BR>\n",$oldPasswords[0]));
      writeDebugMsg(sprintf ("NewPassword:%s:<BR>\n",$newNameValuePairs1{$passwordFieldName}));
      if ($oldPasswords[0] ne $newNameValuePairs1{$passwordFieldName}) {
         $doesMatch = $FALSE;
      } else {
         my $changedPwd       = getParam("NewPwdXXX","");
         my $changedPwdVerify = getParam("NewPwdXXXVerify","");
         if (length($changedPwd) > 0) {
            $errMsg = &$pwdVerificationFunction($changedPwd,$changedPwdVerify);
            if ($errMsg eq "") {
                delete $newNameValuePairs1{$passwordFieldName};
                %newNameValuePairs1 = (%newNameValuePairs1,($passwordFieldName,$changedPwd));
            } else {
                $doesMatch = $FALSE;
            }
         }
      }
    }
  } else {
     $doesMatch = $FALSE;
  }
  if ($doesMatch) {
     # select old Record
     my(%oldRercord) = getSingleRecInHash($tabName,$tabSepChr,"",$aWhereClause,"","");
     if (isDebug()) { print("Modify: OldRecord<BR>\n"); displayHashTableHTML(%oldRercord); }

     # load default values into %newNameValuePairs1 where the field in %newNameValuePairs1 is eq $NotDefined
     # AND field in %oldRercord is eq $NotDefined
     # Add default value if there are not already set
     my($defaultKey)  = "";
     my(@defaultKeys) = ();
     @defaultKeys = keys %myDefaultValues;
     if (isDebug()) { print("Modify: Default-Values<BR>\n"); displayHashTableHTML(%myDefaultValues); }
     foreach $defaultKey (@defaultKeys) {
        if (($newNameValuePairs1{$defaultKey} eq $NotDefined) &&
                    ($oldRercord{$defaultKey} eq $NotDefined)) {
          %newNameValuePairs1 = (%newNameValuePairs1,($defaultKey,$myDefaultValues{$defaultKey}));
        }
     }

     $modRecord = generateNewRecord($tabName,$tabSepChr,%newNameValuePairs1);
     my %modRecHash = %newNameValuePairs1;
     if ($recModifiedCallback ne "") {
         &$recModifiedCallback(\%oldRercord,\%modRecHash,$loginUserId);	
     } elsif ($notifyEmailToAdr_Modify) {
         my %diffHash   = diffInHashes(\%oldRercord,\%modRecHash,getLangStr("strOld"),getLangStr("strNew"),getLangStr("strOnlyOld"),getLangStr("strOnlyNew"));
         my $msg = hashTableToStr($TRUE,%diffHash);
         my $retMsg = sendMailMsgUseSendmail($notifyEmailToAdr_Modify,$notifyEmailSubject_Modify,$msg,$notifyEmailFromAdr_Modify,"","");
         print("<!-- ${notifyEmailSubject_Modify} has been sent to ${notifyEmailToAdr_Modify} (Status:${retMsg}) -->\n");
     }
     writeDebugMsg("<BR>ModRecord in main:${modRecord}:\n");
     @oldRecord = updateRecord($tabName,$tabSepChr,$aWhereClause,"MODIFY",$modRecord);
            if ($oldRecord[0]) {
      if (isDebug()) { print("<BR>Modify: After updateRecord (Must have only one Record)<BR>\n"); displayArrayHTML(@oldRecord); }
        $action      = "";
        writeDebugMsg("<BR>WhereClause (after Modify):${whereClause}:<BR>\n");
        if ($displayTable) {
           displayTableHidden($sortedBy,$whereClause);
        }
        if (($insertFunction) && ($builtInInsert)) {
           displayInsertFieldsHidden();
        }
        if ($qbeFunction) {
           displayQBEForm();
        }        
         } else {
            printf ("%s<BR>",getLangStr("strFileLocked"));
            printf (" <FORM> <INPUT TYPE=BUTTON  VALUE=\"%s\" onClick=window.history.back()></FORM>\n",getLangStr("strTryAgain"));
         }
    } else {
      if ($errMsg eq "") {
        print("${pwdMissMatch}");
      } else {
        print("${errMsg}");
      }
      printf (" <FORM> <INPUT TYPE=BUTTON  VALUE=\"%s\" onClick=window.history.back()></FORM>\n",getLangStr("strBack"));
    }
}

if (($action eq "Insert") && ($insertFunction)) {
  fromWebInterfaceInsertToDb();
}

createCryptedDbFile($tabName,$cryptKeyForDbFile);

} # end of sub prepareHTML_StandardFormForIt



sub fromWebInterfaceInsertToDb {
  my($defaultKey)     = "";
  my(@defaultKeys)    = ();
  my($errMsg)         = "";
  $errorReturnCode    = "";
  %newNameValuePairs1 = getCgiValuesHidden();
  $errMsg = $errorReturnCode;

  if ($errMsg eq "") {
    # Add default value if there are not already set
    @defaultKeys = keys %myDefaultValues;
    if (isDebug()) { print("Insert: Default-Values<BR>\n"); displayHashTableHTML(%myDefaultValues); }
    foreach $defaultKey (@defaultKeys) {
     if ($newNameValuePairs1{$defaultKey} eq $NotDefined) {
       %newNameValuePairs1 = (%newNameValuePairs1,($defaultKey,$myDefaultValues{$defaultKey}));
     }
    }
    if (isDebug()) { print("Insert: New-Values<BR>\n"); displayHashTableHTML(%newNameValuePairs1); }



    if ($passwordFieldName ne "") {
      my($pwd)       = $newNameValuePairs1{$passwordFieldName};
      my($pwdVerify) = getParam("NewPwdXXXVerify","");
      $errMsg = &$pwdVerificationFunction($pwd,$pwdVerify);
    }
  }

  if ($errMsg eq "") {
    $newRecord = generateNewRecord($tabName,$tabSepChr,%newNameValuePairs1);
    if ($notifyEmailToAdr_Insert) {
         my(%newRecHash) = %newNameValuePairs1;
         my($msg) = hashTableToStr($TRUE,%newRecHash);
         my($retMsg) = sendMailMsgUseSendmail($notifyEmailToAdr_Insert,$notifyEmailSubject_Insert,$msg,$notifyEmailFromAdr_Insert,"","");
         print("<!-- ${notifyEmailSubject_Insert} has been sent to ${notifyEmailToAdr_Insert} (Status:${retMsg}) -->\n");
    }

    writeDebugMsg("Insert-Record in main:${newRecord}:<BR>\n");
    insertRecord($tabName,$newRecord);
    $action = "";
    if ($displayTable) {
        displayTableHidden($sortedBy,$whereClause);
    }
    if (($insertFunction) && ($builtInInsert)) {
        displayInsertFieldsHidden();
    }
    if ($qbeFunction) {
        displayQBEForm();
    }
  } else {
    print("${errMsg}");
    printf (" <FORM> <INPUT TYPE=BUTTON  VALUE=\"%s\" onClick=window.history.back()></FORM>\n",getLangStr("strLoginFailBtn"));
  }
}

sub displaySelector {
  my($tabName,$tabSepChr,$columnName,$size,$widgetName,$selectedStr,@aList) = @_;
  my(@retList1) = getColumnValues($tabName,$tabSepChr,$columnName,"",$columnName,$TRUE);
  my(@retList)  = concatArray(@aList,@retList1);

  my($aField)   = "";
  if (length($size)        == 0) {$size        = "1"; }
  if (length($widgetName)  == 0) {$widgetName  = ""; }
  if (length($selectedStr) == 0) {$selectedStr = ""; }


  print("<SELECT NAME=\"${widgetName}\" size=\"${size}\">\n");
  foreach $aField (@retList) {
     if ($selectedStr eq $aField) {
       print("   <OPTION VALUE=\"${aField}\" SELECTED>${aField}\n");
     } else {
       print("   <OPTION VALUE=\"${aField}\">${aField}\n");
     }
  }
  print("</SELECT>\n");
}

sub displaySelectorNew {
  my($tabName,$tabSepChr,$columnName,$size,$widgetName,$selectedStr,$whereClause,@aList) = @_;
  my(@retList1) = getColumnValues($tabName,$tabSepChr,$columnName,$whereClause,$columnName,$TRUE);
  my(@retList)  = concatArray(@aList,@retList1);

  my($aField)   = "";
  if (length($size)        == 0) {$size        = "1"; }
  if (length($widgetName)  == 0) {$widgetName  = ""; }
  if (length($selectedStr) == 0) {$selectedStr = ""; }


  print("<SELECT NAME=\"${widgetName}\" size=\"${size}\">\n");
  foreach $aField (@retList) {
     if ($selectedStr eq $aField) {
       print("   <OPTION VALUE=\"${aField}\" SELECTED>${aField}\n");
     } else {
       print("   <OPTION VALUE=\"${aField}\">${aField}\n");
     }
  }
  print("</SELECT>\n");
}

sub displaySelectorNew1 {
  my($tabName,$tabSepChr,$columnName,$size,$widgetName,$widgetOptions,$selectedStr,$whereClause,@aList) = @_;
  my(@retList1) = getColumnValues($tabName,$tabSepChr,$columnName,$whereClause,$columnName,$TRUE);
  my(@retList)  = concatArray(@aList,@retList1);

  my($aField)   = "";
  if (length($size)        == 0) {$size        = "1"; }
  if (length($widgetName)  == 0) {$widgetName  = ""; }
  if (length($selectedStr) == 0) {$selectedStr = ""; }

  print("<SELECT NAME=\"${widgetName}\" size=\"${size}\" ${widgetOptions}>\n");

  foreach $aField (@retList) {
     if ($selectedStr eq $aField) {
       print("   <OPTION VALUE=\"${aField}\" SELECTED>${aField}\n");
     } else {
       print("   <OPTION VALUE=\"${aField}\">${aField}\n");
     }
  }
  print("</SELECT>\n");
}

sub displaySelectorNew2 {
  my($tabName,$tabSepChr,$columnName,$size,$widgetName,$widgetOptions,$selectedStr,$whereClause,$useFormat,@aList) = @_;
  my(@retList1) = getColumnValues($tabName,$tabSepChr,$columnName,$whereClause,$columnName,$TRUE);
  my(@retList)  = concatArray(@aList,@retList1);

  my($aField)   = "";
  if (length($size)        == 0) {$size        = "1"; }
  if (length($widgetName)  == 0) {$widgetName  = ""; }
  if (length($selectedStr) == 0) {$selectedStr = ""; }
  if (length($useFormat)   == 0) {$useFormat   = $TRUE; }

  print("<SELECT NAME=\"${widgetName}\" size=\"${size}\" ${widgetOptions}>\n");

  foreach $aField (@retList) {
     my($optionText) = $aField;
     if (($useFormat) && ($aField ne $strAll)) {
        $optionText = formatFieldHidden($aField,$spezFormat{$columnName},$TRUE);
        $optionText = removeHtmlTags($optionText);
     }
     if ($selectedStr eq $aField) {
       print("   <OPTION VALUE=\"${aField}\" SELECTED>${optionText}\n");
     } else {
       print("   <OPTION VALUE=\"${aField}\">${optionText}\n");
     }
  }
  print("</SELECT>\n");
}

sub displayOneAutofilter {
  my($tabName,$tabSepChr,$columnName,$selField) = @_;
  if (length($strAll)   == 0) { $strAll   = "All"; }
  if (length($selField) == 0) { $selField = $strAll; }
  my($widgetOptions) = "";
  if ($autoFireAutofilter) {
    $widgetOptions = "onChange=\"beforeSendAutoFilter(this.form)\"";
  }
  displaySelectorNew2($tabName,$tabSepChr,$columnName,"1","sel${columnName}",$widgetOptions,$selField,$fixedWhereClause,$TRUE,($strAll));
}

sub pwdVeriFuncHidden {
   my($pwd1,$pwd2) = @_;
   my($retVal) = "";
   writeDebugMsg("Password compaire:${pwd1}:${pwd2}:\n");
   if ($pwd1 eq $pwd2) {
      if (length($pwd1) <= $minPasswdLen) {
         $retVal = "${pwdError2}${minPasswdLen}";
      }
   } else {
     $retVal = $pwdError1;
   }
   return $retVal;
}
# -----------------------------------------------------------------------------
# cgi function to manipulate a whiteboard
# -----------------------------------------------------------------------------
sub getUserAndDateFromChatfile {
   my($fileName) = @_;
   my @fileLines = readFile($fileName);
   $firtsLine = $fileLines[0];
   my @parts = split("\>",$firtsLine);
   my $modifierName = @parts[2];
   $modifierName = substr($modifierName,0,index($modifierName,"\<"));
   my $modifyDate   = @parts[3];
   $modifyDate = substr($modifyDate,index($modifyDate,",")+1);
   $modifyDate = substr($modifyDate,0,index($modifyDate,"\<"));
   $modifyDate =~ s/:/ /g;
   my @dateParts = split(" ",$modifyDate);
   my %monthNameToNumber = swapHash(%monatNamesE);
   my $monthNr = $monthNameToNumber{$dateParts[0]} + 1;
   if (length($monthNr) eq 1) { $monthNr = "0".$monthNr; }
   $modifyDate = $dateParts[2].$monthNr.$dateParts[1].$dateParts[3].$dateParts[4].$dateParts[5];
   ## $modifyDate = $monthNr;

   return ($modifierName,$modifyDate);
}

sub addJS_HTML_Area {
  my($installationRoot,$textAreaFieldName) = @_;
  $installationRoot     = setDefault($installationRoot,  "HTMLArea");
  $textAreaFieldName    = setDefault($textAreaFieldName, "enterField");
  
print <<javaScript;
    <script type="text/javascript">
      _editor_url = "/HTMLArea/";
      _editor_lang = "en";
    </script>

    <!-- load the main HTMLArea files -->
    <script type="text/javascript" src="/${installationRoot}/htmlarea.js"></script>

    <script type="text/javascript">
      HTMLArea.loadPlugin("FullPage");

      function initDocument() {
        var editor = new HTMLArea("${textAreaFieldName}");
        editor.registerPlugin(FullPage);
        editor.generate();
      }

      HTMLArea.onload = initDocument;
    </script>
javaScript
}



sub manipulateWhiteBoard {
   my($boradName,$callersName,$chatPath,$useLoginName,$userNameFixed,$emailAdrFixed,$allowedUrl,$filterNames,$ipNames,$use_HTML_Editor,$createFileIfNotExist) = @_;
   $use_HTML_Editor          = setDefault($use_HTML_Editor,  $FALSE);
   $createFileIfNotExist     = setDefault($createFileIfNotExist,  $FALSE);
   
   my $action           = getParam("Action","");
   my $enterField       = getParam("enterField","");
   my $userNameFixed    = setDefault($userNameFixed,getLangStr("strUnknown"));
   my $loginUserId      = getParam("loginUserId",$userNameFixed);
   my $emailAdr         = getParam("emailAdr",$emailAdrFixed);
   my $fullFileName     = "${chatPath}${boradName}";


   # spam filter
   if ($allowedUrl ne "") {
   	  if ($ENV{"HTTP_REFERER"} ne $allowedUrl) {
   	    $enterField = "<font color=red>Du bist nun in die Falle geraten!</font><BR>Ich habe Deine IP Adresse (".$ENV{"REMOTE_ADDR"}.") und kann Dich nun zurückverfolgen! Stop diese unberechtigte Benutzung des Scripts, ansonsten ich rechtliche Schritte unternehmen werde!";
   	    
   	  }
   }
   if ($enterField ne "") {
	 	   my @ipList = split(",",$ipNames);
	 	   foreach my $aFilterStr (@ipList) {
   	 	   if ($ENV{"REMOTE_ADDR"} eq $aFilterStr) {
   	 	   	  $enterField = "";
   	 	   	  last;
   	 	   }
       }
   }
   if ($enterField ne "") {
	 	   my @filterList = split(",",$filterNames);
	 	   foreach my $aFilterStr (@filterList) {
   	 	   if (index(lc($enterField),lc($aFilterStr)) >= 0) {
   	 	   	  $enterField = "";
   	 	   	  last;
   	 	   }
       }
   }
   
   if ($use_HTML_Editor) {
   	  addJS_HTML_Area();
   	  
   	  # remove html and header, body tags from msg
   	  # <html><head></head><body style="visibility: visible;"><p><br /></p></body></html>:83<SCRIPT>
          ### TBS TBS 30.9.09
   	  ### print("enterField:${enterField}:".length($enterField));
   	  if ((length($enterField) ==  83) ||
   	      (length($enterField) ==  48)) {
   	  	$enterField = "";
   	  }
   }
   
   
   if ($enterField ne "") {
     $enterField = "<!--HTTP_REFERER:".$ENV{"HTTP_REFERER"}." REMOTE_ADDR:".$ENV{"REMOTE_ADDR"}."-->\n${enterField}"; 
   }
   
   
   $useLoginName   = setDefault($useLoginName,$FALSE);
   if (length($fontFace)          == 0) { $fontFace       = "face='helvetica,arial'"; }
   if (length($userNameLength)    == 0) { $userNameLength = "14"; }
   if (length($msgLength)         == 0) { $msgLength      = "50"; }
   if (length($msgBoxHeigh)       == 0) { $msgBoxHeigh    = "20"; }

   if (length($emailAdrLength)    == 0) { $emailAdrLength = "30"; }
   if (length($inputEmailAdr)     == 0) { $inputEmailAdr  = $TRUE; }

   if (length($fontSizeNr)        == 0) { $fontSizeNr     = "-1"; }
   if (length($fontSize)          == 0) { $fontSize       = "size=${fontSizeNr}"; }
   if (length($msgLayout)         == 0) { $msgLayout      = "<HR>%s<BR>%s"; }
   if (length($boradTitle)        == 0) { $boradTitle     = $boradName; }
   if (length($bgTitle)           == 0) { $bgTitle        = "bgcolor='silver'"; }
   if (length($bgBorad)           == 0) { $bgBorad        = "bgcolor='#FFFFFF'"; }
   if (length($bgInput)           == 0) { $bgInput        = "bgcolor='teal'"; }
   if (length($placeToAdd)        == 0) { $placeToAdd     = "bottom"; }

   my $fontTag = "<FONT ${fontSize} ${fontFace}>";

   if (($action eq "AppendMsg") && (length($enterField) > 0)) {
      my $tStamp   = sprintf ("%s",formatTimeStamp(getTimeStamp(),"",$TRUE,$TRUE,$language));
      my $nameLink = "${loginUserId}: ${tStamp}";
      if ($inputEmailAdr) {
        $nameLink = "<A href=\"mailto:${emailAdr}\">${loginUserId}</A>: ${tStamp}";
      }
      
      if ($createFileIfNotExist) {
      	  if (!(isFileExists($fullFileName))) {
      	     open(TABFILE_manipulateWhiteBoard,">${fullFileName}") || showError("ERROR (manipulateWhiteBoard): Can't open file:${fullFileName}: $!");
             close(TABFILE_manipulateWhiteBoard);	
      	  }
      }
   
   
      if ($placeToAdd eq "bottom") {
        appendLine($fullFileName,sprintf($msgLayout,$nameLink,$enterField));  # don't replace sprintf
      } else {
        putLineOnTop($fullFileName,sprintf($msgLayout,$nameLink,$enterField)); # don't replace sprintf
      }
   }
   

   
   print("<SCRIPT>\n");
   print("function initFocus(form) {\n");
   print("  form.enterField.focus()\n");
   print("}\n");

   print("function checkBeforeSubmit (form,button) {\n");
   print("  if (!check(form)) return;\n");
   print("  form.submit();\n");
   print("  return;\n");
   print("}\n");

   print("function check(form) {\n");
   printf (" if ((form.loginUserId.value == '%s') || (form.loginUserId.value.length == 0)) {\n",getLangStr("strUnknown"));
   printf ("   alert ('%s');\n",getLangStr("strInputRequired"));
   print("   form.loginUserId.focus();\n");
   print("   return (false);\n");
   print("  }\n");
   if ($inputEmailAdr) {
      print(" if (form.emailAdr.value.length == 0) {\n");
      printf ("   alert ('%s');\n",getLangStr("strInputRequired"));
      print("   form.emailAdr.focus();\n");
      print("   return (false);\n");
      print("  }\n");
      print("  setCookie('emailAdr', form.emailAdr.value);\n");
   }
   print("  setCookie('UserName', form.loginUserId.value);\n");
   print("  return (true);\n");
   print("}\n");

   print("function readCookies(form) {\n");
   if (($loginUserId eq getLangStr("strUnknown")) || ($loginUserId eq "")) {
      printf ("  form.loginUserId.value = getCookie('UserName','%s');\n",getLangStr("strUnknown"));
   }
   if (($inputEmailAdr) && ($emailAdr eq "")) {
      print("  form.emailAdr.value = getCookie('emailAdr','');\n");
   }
   print("}\n");

   print("</SCRIPT>\n");
   addJScommon();
   addJScookies();

   print("<FORM Name=\"BoardForm\" METHOD=POST ACTION=${callersName}>\n");
   print("<TABLE border=${DefaultTableBorder} cellpadding=${DefaultTableCellPadding} cellspacing=${DefaultTableCellSpacing}>\n");
   print(" <TR><TD colspan=2 ${bgTitle}><CENTER><B>${fontTag}${boradTitle}</TD></TR>\n");
   if ($placeToAdd ne "bottom") {
     displayBoardGUI($boradName,$bgInput,$fontTag,$msgLength,$msgBoxHeigh,$userNameLength,$loginUserId,$useLoginName,$emailAdr,$emailAdrLength,$inputEmailAdr);
   }
   print(" <TR><TD colspan=2 ${bgBorad}>\n");
   
   
   open(BOARDFILE_manipulateWhiteBoard,$fullFileName); ### || showError("ERROR (manipulateWhiteBoard): Can't open file:${fullFileName}: $!");
   while (defined($line = <BOARDFILE_manipulateWhiteBoard>)) {
      chomp($line);
      print("${fontTag}${line}</FONT><BR>\n");
   } # end of while
   close(BOARDFILE_manipulateWhiteBoard);
   print("</TD></TR>\n");

   if ($placeToAdd eq "bottom") {
     displayBoardGUI($boradName,$bgInput,$fontTag,$msgLength,$msgBoxHeigh,$userNameLength,$loginUserId,$useLoginName,$emailAdr,$emailAdrLength,$inputEmailAdr);
   }
   print("</TD></TR></TABLE>\n");
   print("</FORM>\n");
   print("<SCRIPT>initFocus(document.BoardForm);readCookies(document.BoardForm)</SCRIPT>\n");
   if ($use_HTML_Editor) {
     print("<script type=\"text/javascript\">\n");
     print(" HTMLArea.init()\n");
     print("</script>\n");
   }
   return $enterField;
}

sub displayBoardGUI {
   my($boradName,$bgInput,$fontTag,$msgLength,$msgBoxHeigh,$userNameLength,$loginUserId,$useLoginName,$emailAdr,$emailAdrLength,$inputEmailAdr) = @_;
   print(" <TR><TD colspan=2 ${bgInput}><CENTER><TABLE border=0 cellpadding=3 cellspacing=0>\n");
   if ($useLoginName) {
      print(" <TR><TD ${bgInput}>${fontTag}".getLangStr("strName").":</TD><TD ${bgInput}><B>${loginUserId}</B><INPUT TYPE=HIDDEN name=\"loginUserId\"  value=\"${loginUserId}\"></td>\n");
   } else {
      print(" <TR><TD ${bgInput}>${fontTag}".getLangStr("strName").":</TD><TD ${bgInput}><INPUT TYPE=TEXT name=\"loginUserId\"    size=\"${userNameLength}\" value=\"${loginUserId}\"></td>\n");
   }
   if ($inputEmailAdr) {
   	  if ($emailAdr eq "") {
          print(" <TD ${bgInput}>${fontTag}".getLangStr("strEmailAdr").":</TD><TD ${bgInput}><INPUT TYPE=TEXT name=\"emailAdr\"    size=\"${emailAdrLength}\" value=\"${emailAdr}\"></td>\n");
      } else {
      	  print(" <TD ${bgInput}>${fontTag}".getLangStr("strEmailAdr").":</TD><TD ${bgInput}><B>${emailAdr}</B><INPUT TYPE=HIDDEN name=\"emailAdr\"    value=\"${emailAdr}\"></td>\n");
      }
   } else {
      print(" <TD ${bgInput}></TD><TD ${bgInput}></td>\n");
   }

   print(" </TR>\n");
   print(" <TR><TD  colspan=4 ${bgInput}><CENTER><TEXTAREA ID=\"enterField\" NAME=\"enterField\" COLS=\"${msgLength}\" ROWS=\"${msgBoxHeigh}\" WRAP=virtual></TEXTAREA></td></tr>\n");
   print(" <TR><TD ${bgInput}>&nbsp;</TD><TD colspan=4  ${bgInput}><CENTER>\n");
   # print("     <INPUT TYPE=BUTTON  NAME=Submit     VALUE=\"".getLangStr("strRefreshEnter")."\" onClick='checkBeforeSubmit(this.form, this)'>\n");
   
   print("     <input type=\"submit\" name=\"save\" value=\"".getLangStr("strRefreshEnter")."\"  />\n");
   print("     <INPUT TYPE=HIDDEN  NAME=Action     VALUE=AppendMsg>\n");
   print("     <INPUT TYPE=HIDDEN  NAME=BoardName  VALUE=\"${boradName}\">\n");
   print(" </TR>\n");
   print("</TABLE>\n");
}
# -----------------------------------------------------------------------------
# cgi function to maintain a unixCommander
# -----------------------------------------------------------------------------
# These function creates an web interface to execute UNIX commands on the server
# e.g.
#    my($homeDir) = $ENV{DOCUMENT_ROOT};
#    createUnixCommander("unixCommander.pl","comanderForm","uname -a ; pwd",$TRUE,$homeDir);

sub createUnixCommander {
  my($cgiName,$formName,$intiCmd,$loginNeeded,$initialWorkingDir)   = @_;

  my($cmdSepStr)  = " ;; ";

  my($command)           = getParam ("command",$intiCmd);
  my($workingDir)        = getParam ("workingDir",$initialWorkingDir);
  my($cmdHist)           = getParam ("cmdHist","");
  my($workingDirHist)    = getParam ("workingDirHist","");


  $cmdHist        = "${cmdHist}${cmdSepStr}${command}";
  $workingDirHist = "${workingDirHist}${cmdSepStr}${workingDir}";

  my(@cmdList) = split($cmdSepStr,$cmdHist);
  @cmdList = makeArrayEntriesDestinct($TRUE,@cmdList);
  $cmdHist = makeStrFromArray($cmdSepStr,@cmdList);

  my(@cdList)     = split($cmdSepStr,$workingDirHist);
  @cdList         = makeArrayEntriesDestinct($FALSE,@cdList);
  $workingDirHist = makeStrFromArray($cmdSepStr,@cdList);

  addJavaScript($formName);
  print("<TABLE border=3><TR><TD bgcolor=\"teal\"><FONT FACE=\"Courier\" COLOR=\"white\" SIZE=\"-1\">\n");
  print("\$ ${command}<BR>\n");

  if ($workingDir eq "") {
     $retMsg = `$command 2>&1`;
  } else {
     $retMsg = `cd $workingDir ; $command 2>&1`;
  }
  $retMsg =~ s/\</\&lt\;/g;
  $retMsg =~ s/\n/\<BR\> /g;
  $retMsg =~ s/ /\&nbsp\;/g;
  print("${retMsg}\n");
  print("</TD></TR><TR><TD bgcolor=\"gray\"><CENTER>\n");
  displayCommanderForm($cgiName,$formName,$workingDir,$cmdHist,$cmdSepStr,$workingDirHist,$loginNeeded);
  print("</TD></TR></TABLE>\n");
}

sub addJavaScript {
my($formName)  = @_;
print <<EndOfHeadText;
<script language="JavaScript">
<!-- Hide Script from older Browsers.

function initFocus() {
  document.${formName}.command.focus()
}

function clearCmdHist() {
  document.${formName}.cmdHist.value = "";
   alert("Command history has been deleted");
}

function clearCdHist() {
  document.${formName}.workingDirHist.value = "";
   alert("History of working dierectories has been deleted");
}

function getFromHistSel(aForm) {
   aForm.command.value = aForm.histSelector.options[aForm.histSelector.selectedIndex].value;
}

function getFromCdHistSel(aForm) {
   aForm.workingDir.value = aForm.cdHistSelector.options[aForm.cdHistSelector.selectedIndex].value;
}

// End the hiding here. -->
</SCRIPT>
EndOfHeadText
} # end of addJavaScript

sub displayCommanderForm {
   my($cgiName,$formName,$workingDir,$cmdHist,$cmdSepStr,$workingDirHist,$loginNeeded) = @_;
   print("<FORM METHOD=POST        Name=${formName}    ACTION=${cgiName}>\n");
   print("<TABLE bgcolor=\"gray\" cellpadding=\"3\" cellspacing=\"3\" border=0>\n");
   print("<TR><TD colspan = 4>Enter Command:</TD></TR>\n");
   print("<TR><TD colspan = 3><INPUT TYPE=TEXT      Name=command   VALUE=\"\" SIZE=\"60\"></TD>\n");
   print("    <TD><INPUT TYPE=SUBMIT    Name=submitted VALUE=\"Execute\"></TD></TR>\n");

   if ($cmdHist ne "") {
     print("<TR><TD colspan = 3><SELECT NAME=\"histSelector\" size=\"1\" onChange=\"getFromHistSel(this.form)\">\n");
     my(@cmdList) = split($cmdSepStr,$cmdHist);
     my($aItem1)  = "";
     print("<OPTION VALUE=\" \" SELECTED>Command History\n");
     foreach $aItem1 (@cmdList) {
        print("<OPTION VALUE=\"${aItem1}\">${aItem1}\n");
     }
     print("</SELECT></TD>\n");
     print("<TD><INPUT TYPE=Button Name=cmdHistClearBtn    VALUE=\"Clear\" onClick=\"clearCmdHist()\"></TD>\n");
   }
   print("</TR>\n");
   print("<TR><TD colspan = 4></TD></TR>\n");
   print("<TR><TD colspan = 4>Working Directory:</TD></TR>\n");
   print("<TR><TD colspan = 4><INPUT TYPE=TEXT   Name=workingDir     VALUE=\"${workingDir}\" SIZE=\"60\"></TD></TR>\n");
   if ($workingDirHist ne "") {
     print("<TR><TD colspan = 3><SELECT NAME=\"cdHistSelector\" size=\"1\" onChange=\"getFromCdHistSel(this.form)\">\n");
     my(@cdList) = split($cmdSepStr,$workingDirHist);
     my($aItem)  = "";
     print("<OPTION VALUE=\" \" SELECTED>History\n");
     foreach $aItem (@cdList) {
      print("<OPTION VALUE=\"${aItem}\">${aItem}\n");
     }
     print("</SELECT></TD>\n");
     print("<TD><INPUT TYPE=Button Name=cdHistClearBtn    VALUE=\"Clear\" onClick=\"clearCdHist()\"></TD></TR>\n");
   }
   print("</TABLE>\n");
   print("<INPUT TYPE=HIDDEN Name=cmdHist            VALUE=\"${cmdHist}\"        SIZE=\"20\">\n");
   print("<INPUT TYPE=HIDDEN Name=workingDirHist     VALUE=\"${workingDirHist}\" SIZE=\"20\">\n");
   if ($loginNeeded) {
      print("<INPUT TYPE=HIDDEN Name=loginUserId        VALUE=\"${loginUserId}\" >\n");
      print("<INPUT TYPE=HIDDEN Name=loginPassword      VALUE=\"${loginPassword}\">\n");
      print("<INPUT TYPE=HIDDEN Name=loginAction        VALUE=\"Login\">\n");
   }
   print("</FORM>\n");
   print("<SCRIPT>initFocus();</SCRIPT>\n");
} # end of displayCommanderForm


# -----------------------------------------------------------------------------
# cgi function to maintain a fileEditor
# -----------------------------------------------------------------------------
# These function creates an web interface to edit files on the server
# e.g.
#        my($homeDir) = $ENV{DOCUMENT_ROOT};
#        createFileEditor($myCgiName,"EditorForm",$TRUE,$homeDir,"testFile.txt","","",$FALSE,"afterSaveFunction");
#        
#        sub afterSaveFunction {
#           my($filename) = @_;
#        }

sub createFileEditor {
	my($cgiName,$formName,$loginNeeded,$initialWorkingDir,$initFileToEdit,$rows,$cols,$noFileBrowsing,$afterSaveUserFct,$maxTopWorkingDir,$dirChangable) = @_;
	my $cmdSepStr  = " ;; ";
	$rows         = setDefault($rows,"30");
	$cols         = setDefault($cols,"120");
	$dirChangable = setDefault($dirChangable,$TRUE);

	my $filename          = getParam ("filename",$initFileToEdit);
	my $workingDir        = getParam ("workingDir",$initialWorkingDir);
	my $fileEditorAction  = getParam ("fileEditorAction","");
	my $fileContent       = getParam ("fileContent","");
	my $chmodOld          = getParam ("chmodOld","");

	if ($noFileBrowsing) {
		$filename   = $initFileToEdit;
		$workingDir = $initialWorkingDir;
		if ($fileEditorAction  eq "") {
			$fileEditorAction  = "Open";
		}
	}


	my $fullFilename  = $filename;
	if ($workingDir ne "") {
		$fullFilename = "${workingDir}/${filename}";
	}
	addJavaScriptHidden_11($formName,$noFileBrowsing);

	if ($fileEditorAction  eq "SaveAs") {
		unlink($fullFilename);
		open(AFILE_createFileEditor,">${fullFilename}") || showError(sprintf("Error (createFileEditor): Can't open file: %s : %s",$fullFilename,$!));
		$fileContent =~ s/\r//g;
		print(AFILE_createFileEditor "${fileContent}");
		close(AFILE_createFileEditor);
		chmod (octal2Dec($chmodOld),$fullFilename);
		displayEditorForm($cgiName,$formName,$loginNeeded,$workingDir,$filename,$fileContent,$rows,$cols,$noFileBrowsing,$dirChangable);

		if ($afterSaveUserFct ne "") {
			&$afterSaveUserFct($fullFilename);
		}
	} elsif ($fileEditorAction  eq "Open") {
		my @lines       = readFile($fullFilename);
		my $fileContent = makeStrFromArray("\n",@lines);
		displayEditorForm($cgiName,$formName,$loginNeeded,$workingDir,$filename,$fileContent,$rows,$cols,$noFileBrowsing,$dirChangable);
	} elsif ($fileEditorAction  eq "New") {
		displayEditorForm($cgiName,$formName,$loginNeeded,$workingDir,$filename,$fileContent,$rows,$cols,$noFileBrowsing,$dirChangable);
	} else {
		if ($noFileBrowsing) {
			print("Not authorized for this function (${fileEditorAction})<BR>\n");
		} else {
			displayDir($cgiName,$formName,$loginNeeded,$workingDir,$filter,$maxTopWorkingDir);
		}
	}
}

sub addJavaScriptHidden_11 {
my($formName,$noFilename)  = @_;
print <<EndOfHeadText;
<script language="JavaScript">
<!-- Hide Script from older Browsers.

fileTouched = false;

function initFocus() {
  document.${formName}.fileContent.focus()
}

function setFileChanged(newStat) {
   fileTouched = newStat;
   if (fileTouched) {
     window.status = "File has been changed!!!";
   }
}

function clearIt(aForm) {
    // if (fileTouched) {
    //    alert("do you really want to clear the");
    // }
    aForm.fileContent.value = "";
EndOfHeadText
    if (!$noFilename) {
       print("aForm.filename.value = \"\";\n");
    }
print <<EndOfHeadText;
}


EndOfHeadText
    if (!$noFilename) {
       print("function openNewFile(aForm) {\n");
       print("  aForm.filename.value = \"\";\n");
       print("  aForm.fileEditorAction.value = \"\";\n");
       print("  aForm.submit();\n");
       print("}\n");
    }
print <<EndOfHeadText;

// End the hiding here. -->
</SCRIPT>
EndOfHeadText
} # end of addJavaScript

sub displayEditorForm {
   my($cgiName,$formName,$loginNeeded,$workingDir,$filename,$fileContent,$rows,$cols,$noFileBrowsing,$dirChangable) = @_;
   $rows         = setDefault($rows,"24");
   $cols         = setDefault($cols,"80");
   $dirChangable = setDefault($dirChangable,$TRUE);
	
   print("<FORM METHOD=POST        Name=${formName}    ACTION=${cgiName}>\n");
   print("<TABLE border=3>\n");
   print("<TR><TD bgcolor=\"gray\">\n");
   print(" <TABLE bgcolor=\"gray\" cellpadding=\"3\" cellspacing=\"3\" border=0>\n");
   print(" <TR>\n");
   print("    <TD><INPUT TYPE=Button    Name=createNewDoc    VALUE=\"Create new\" onClick=\"clearIt(this.form)\">\n");
   if (!$noFileBrowsing) {
      print("    <TD><INPUT TYPE=Button    Name=openNew         VALUE=\"Open...\"    onClick=\"openNewFile(this.form)\">\n");
   }
   print("    <TD><INPUT TYPE=SUBMIT    Name=submitted       VALUE=\"Save as\"></TD>\n");
   if ($noFileBrowsing) {
       print("    <TD><B>${filename}</B> </TD>\n");
       if ($workingDir ne "") {
           print("    <TD> Directory </TD>\n");
           print("    <TD><B>${workingDir}</B></TD>\n");
       }
   } else {
       print("    <TD><INPUT TYPE=TEXT      Name=filename        VALUE=\"${filename}\" SIZE=\"30\"></TD>\n");
       print("    <TD> Directory:</TD>\n");
       if ($dirChangable) {
			print("    <TD><INPUT TYPE=TEXT      Name=workingDir VALUE=\"${workingDir}\" SIZE=\"50\"></TD>\n");
	   } else {
	        print("    <TD><B>${workingDir}</B></TD>\n");
	   }
   }
   my $chmodOld = getFilePermission("${workingDir}/${filename}");
   print("    <TD> Mod:</TD><TD><INPUT TYPE=TEXT      Name=chmodOld VALUE=\"${chmodOld}\" SIZE=\"5\"></TD>\n");
   print(" </TR>\n");
   print(" </TABLE>\n");
   print("</TD></TR>\n");

   print("<TR><TD bgcolor=\"teal\"><CENTER>\n");
   print("<FONT FACE=\"Courier\" COLOR=\"white\" SIZE=\"-1\">\n");
   print("<CENTER><TEXTAREA NAME=fileContent ROWS=${rows} COLS=${cols}  wrap=\"off\" onChange=\"setFileChanged(true)\">\n");
   print("${fileContent}\n");
   print("</TEXTAREA></CENTER>\n");
   if ($loginNeeded) {
      print("<INPUT TYPE=HIDDEN Name=loginUserId        VALUE=\"${loginUserId}\" >\n");
      print("<INPUT TYPE=HIDDEN Name=loginPassword      VALUE=\"${loginPassword}\">\n");
      print("<INPUT TYPE=HIDDEN Name=loginAction        VALUE=\"Login\">\n");
   }
   print("<INPUT TYPE=HIDDEN Name=fileEditorAction   VALUE=\"SaveAs\">\n");
   print("</TD></TR></TABLE>\n");

   print("</FORM>\n");
   print("<SCRIPT>initFocus();</SCRIPT>\n");
} # end of displayCommanderForm

sub displayDir {
	my($cgiName,$formName,$loginNeeded,$workingDir,$filter,$topWorkingDir) = @_;

	$workingDir = cleanupFilePath($workingDir);
	addJavaScriptHidden_12($formName);

	print("<TABLE border=3><TR><TD bgcolor=\"gray\"><FONT FACE=\"Arial\" COLOR=\"black\" SIZE=\"-1\"><CENTER>\n");
	print("Current directory:<BR/><B>${workingDir}</B></CENTER></TD></TR>\n");
	print("<TR><TD bgcolor=\"teal\"><FONT FACE=\"Courier\" COLOR=\"white\" SIZE=\"-1\"><CENTER>\n");
	print("<FORM METHOD=POST        Name=${formName}    ACTION=${cgiName}>\n");
	my($unixCmd) = "ls -al";
	if ($workingDir eq "") {
		$retMsg = `${unixCmd} 2>&1`;
	} else {
		$retMsg = `cd ${workingDir} ; ${unixCmd} 2>&1`;
	}
	my(@dirList)  = split("\n",$retMsg);
	my($aEntry) = "";
	print("<BR/><TABLE><TR><TD bgcolor=\"teal\"><FONT FACE=\"Arial\" COLOR=\"white\" SIZE=\"-1\"><CENTER>\n");
	print("Directories:<BR/><SELECT NAME=DirList SIZE=6 onChange=\"changeDirList(this.form)\">\n");
	foreach $aEntry (@dirList) {
		if ($aEntry =~ /^d/) {
			my $dName = extractFileNameFromDirEntry($aEntry);
			if ($dName ne ".") {
				if (($topWorkingDir ne "") && ($workingDir eq $topWorkingDir) && ($dName eq "..")) {
					## print("<OPTION VALUE=${dName}>${dName}\n");
				} else {
					print("<OPTION VALUE=${dName}>${dName}\n");
				}
			}
		}
	}
	print("</SELECT></TD><TD bgcolor=\"teal\"><FONT FACE=\"Arial\" COLOR=\"white\" SIZE=\"-1\"><CENTER>\n");

	print("Files:<BR/><SELECT NAME=FileList SIZE=6 onChange=\"changeFileList(this.form)\">\n");
	foreach $aEntry (@dirList) {
		if (!(($aEntry =~ /^d/) || ($aEntry =~ /^total/))) {
			my($fName) = extractFileNameFromDirEntry($aEntry);
			print("<OPTION VALUE=${fName}>${fName}\n");
		}
	}
	print("</SELECT>\n");
	print("<INPUT TYPE=HIDDEN Name=workingDir         VALUE=\"${workingDir}\" >\n");
	print("<INPUT TYPE=HIDDEN Name=filename           VALUE=\"\">\n");
	print("<INPUT TYPE=HIDDEN Name=fileEditorAction   VALUE=\"\">\n");

	if ($loginNeeded) {
		print("<INPUT TYPE=HIDDEN Name=loginUserId        VALUE=\"${loginUserId}\" >\n");
		print("<INPUT TYPE=HIDDEN Name=loginPassword      VALUE=\"${loginPassword}\">\n");
		print("<INPUT TYPE=HIDDEN Name=loginAction        VALUE=\"Login\">\n");
	}
	print("</TD></TR></TABLE></FORM>\n");
	print("</CENTER></TD></TR></TABLE>\n");
}

sub addJavaScriptHidden_12 {
my($formName)  = @_;
print <<EndOfHeadText;
<script language="JavaScript">
<!-- Hide Script from older Browsers.
function changeDirList(aForm) {
   if (aForm.workingDir.value != "") {
        aForm.workingDir.value = aForm.workingDir.value + "/" + aForm.DirList.options[aForm.DirList.selectedIndex].value;
   } else {
        aForm.workingDir.value = aForm.DirList.options[aForm.DirList.selectedIndex].value;
   }
   aForm.submit();
}

function changeFileList(aForm) {
   aForm.fileEditorAction.value = "Open";
   aForm.filename.value = aForm.FileList.options[aForm.FileList.selectedIndex].value;
   aForm.submit();
}
// End the hiding here. -->
</SCRIPT>
EndOfHeadText
}

# -----------------------------------------------------------------------------
# cgi function to maintain a gif-Viewer
# -----------------------------------------------------------------------------
# These function creates an web interface to gif-viewer
# e.g.
#        displayGifs($myCgiName,$formName,$docRoot,$initWorkingDir,$namePattern,$saveFileName,$timeStamp,$headerStr);

sub displayGifs {
   my($myCgiName,$formName,$docRoot,$initWorkingDir,$namePattern,$saveFileName,$timeStamp,$headerStr) = @_;
   my($retMsg)  = "";
   my($unixCmd) = "ls -al";

   $workingDir      = getParam("workingDir",$initWorkingDir);
   $gifEditorAction = getParam("gifEditorAction","");

   my($wDirFull) = "${docRoot}${workingDir}";
   if ($wDirFull eq "") {
      $retMsg = `${unixCmd} 2>&1`;
   } else {
      $retMsg = `cd $wDirFull ; ${unixCmd} 2>&1`;
   }
   my(@dirList)  = split("\n",$retMsg);
   my($aEntry)   = "";
   my(@gifNames) = ();
   my(@dirNames) = ();
   foreach $aEntry (@dirList) {
      if (!(($aEntry =~ /^d/) || ($aEntry =~ /^total/) || ($aEntry =~ /^l/))) {
          my($fName) = extractFileNameFromDirEntry($aEntry);
          my(@patternParts) = split(";",$namePattern);
          my($aPatternPart) = "";
          foreach $aPatternPart (@patternParts) {
             if ($fName =~ $aPatternPart) {
                   push(@gifNames,$fName);
             }
          }
      }
      if ($aEntry =~ /^d/) {
          my($dName) = extractFileNameFromDirEntry($aEntry);
          if ($dName ne ".") {
             push(@dirNames,$dName);
          }
      }
   }

   my($outStr) = $headerStr;
   $outStr = sprintf("${outStr}<HR>${timeStamp} <B>%s</B><BR>\n",formatTimeStamp(getTimeStamp(),"", $TRUE, $TRUE,""));
   $outStr = "${outStr}File-System Path: <B>${wDirFull}</B><BR>\n";
   $outStr = "${outStr}Document root: <B>${docRoot}</B><BR>\n";
   my($aDirName) = "";
   $outStr = "${outStr}<HR><H2>Sub-Directories</H3>\n";
   foreach $aDirName (@dirNames) {
     my($dirPath) = cleanupFilePath("${workingDir}/${aDirName}");
     my($dispStr) = $aDirName;
     if ($dispStr eq "..") {
       $dispStr = "<B>Parent</B>";
     }
     if ($gifEditorAction eq "Save") {
         $outStr = "${outStr}${dispStr}<BR>\n";
     } else {
         $outStr = "${outStr}<A HREF=\"${myCgiName}?workingDir=${dirPath}&loginUserId=${loginUserId}&loginPassword=${loginPassword}&loginAction=Login\">${dispStr}</A><BR>\n";
     }
   }

   my($aGifName) = "";
   $outStr = "${outStr}<HR><H2>Images</H3>\n";
   foreach $aGifName (@gifNames) {
     $outStr = "${outStr}${aGifName} <IMG SRC=\"${workingDir}/${aGifName}\" border=0><BR><HR>\n";
   }

   if ($gifEditorAction eq "Save") {
       my($sFilename) = getParam("saveFileName","");
       my($fullFilename) = "${wDirFull}/${sFilename}";
       open(AFILE_displayGifs,">${fullFilename}") || showError(sprintf("Error (displayGifs): Can't open file: %s : %s",$fullFilename,$!));
       print(AFILE_displayGifs "${outStr}");
       close(AFILE_displayGifs);
       print($headerStr);
       print("File has been saved as:<A HREF=\"/${workingDir}/${sFilename}\">${fullFilename}</A><BR>\n");
   } else {
       print($outStr);
       print("<BR><HR noshade><FORM METHOD=POST Name=${formName}    ACTION=${cgiName}>\n");
       print("  <INPUT TYPE=SUBMIT    Name=submitted          VALUE=\"Save as\">\n");
       print("  <INPUT TYPE=TEXT      Name=saveFileName       VALUE=\"${saveFileName}\" SIZE=\"10\">\n");
       print("  <INPUT TYPE=TEXT      Name=workingDir         VALUE=\"${workingDir}\" SIZE=\"10\">\n");
       print("  <INPUT TYPE=HIDDEN    NAME=\"loginUserId\"    VALUE=\"${loginUserId}\">\n");
       print("  <INPUT TYPE=HIDDEN    NAME=\"loginPassword\"  VALUE=\"${loginPassword}\">\n");
       print("  <INPUT TYPE=HIDDEN    NAME=\"loginAction\"    VALUE=\"Login\">\n");
       print("  <INPUT TYPE=HIDDEN    Name=gifEditorAction    VALUE=\"Save\">\n");
       print("</FORM>\n");
   }
}

sub replaceWithFormFieldForFormHandler {
  	my($fieldValue,%formFields) = @_;
  	my $indicator = "FormField:";
  	if (index($fieldValue,$indicator) != -1) {
  		  $fieldValue = substr($fieldValue,index($fieldValue,$indicator)+length($indicator));
  		  ## print("fieldValue:${fieldValue}:<BR>\n");
  		  if (exists($formFields{$fieldValue})) {
  		  	 ## print("fieldFromForm:".$formFields{$fieldValue}.":<BR>\n");
  		  	 return $formFields{$fieldValue};
  		  } else {
  		     return $fieldValue;
  		  }   
  	} else {
  		  return $fieldValue;
  	}
}

# -----------------------------------------------------------------------------
# cgi function to formHandler (receives a HTML form and formats an e-mail)
# -----------------------------------------------------------------------------
# takes the content of a HTML form and sends the content via e-mail
# For the e-mail a template can be defined. Also for the answer html page a template can be defined. In a case some 
# constraints defined in the form (hidden fields) the answer page can also be defined as an HTML template. These 
# templates can be on any other server reaching via http.
#
# Templates can have any kind of placeholders for form fields. Use the fieldnames with {} around. The function replaces these placeholders with real values.
#
# e.g. for a success Template (testSuccess.html)
# ----------------------------------------------
## <HMTL><HEAD></HEAD><BODY>
## <H1> Daten wurden an {cgiCmdHidden_emailToAddrs} &#252;bermittelt (von SI.com)</H1>
## Passwort war <B>{Passwort}</B>
## Vielen Dank</BODY></HTML>
#
# e.g. for an error return page (testNotSuccess.html)
# ---------------------------------------------------
## <HMTL><HEAD></HEAD>
## <BODY>
## <H1> Fehler ist aufgetaucht!!!!! (von SI.com)</H1>
## {ERROR_MSG}<BR><BR>Vielen Dank
## </BODY></HTML>"
#
# e.g. for an e-mail template (test.txt)
# --------------------------------------
## Hallo Walter Rothlin, (von SI.com)
## Hier eine neue Anmeldung
##
## Password:{Passwort}
## Gruss Walti
#
# Meaning of used hidden fields
# =============================
# the following hidden form fields have special meanings:
## <INPUT TYPE=HIDDEN NAME=cgiCmdHidden_replyTemplateSuccess    VALUE="http://www.sauterinformatik.com/Test/testSuccess.html">
## <INPUT TYPE=HIDDEN NAME=cgiCmdHidden_replyTemplateNotSuccess VALUE="http://www.sauterinformatik.com/Test/testNotSuccess.html">
## <!-- Definitions if the templates are local
## <INPUT TYPE=HIDDEN NAME=cgiCmdHidden_replyTemplateSuccess    VALUE="testSuccess.html">
## <INPUT TYPE=HIDDEN NAME=cgiCmdHidden_replyTemplateNotSuccess VALUE="testNotSuccess.html">

## -->
## <INPUT TYPE=HIDDEN NAME=cgiCmdHidden_emailSubject       VALUE="Antwort">
## <INPUT TYPE=HIDDEN NAME=cgiCmdHidden_emailToAddrs       VALUE="xxxxx1.yyyyyyy@zzzz.ww">
## <INPUT TYPE=HIDDEN NAME=cgiCmdHidden_emailCcAddrs       VALUE="xxxxx2.yyyyyyy@zzzz.ww">
## <INPUT TYPE=HIDDEN NAME=cgiCmdHidden_emailBccAddrs      VALUE="xxxxx3.yyyyyyy@zzzz.ww">
## <INPUT TYPE=HIDDEN NAME=cgiCmdHidden_emailFromAddr      VALUE="xxxxx4.yyyyyyy@zzzz.ww">
## <INPUT TYPE=HIDDEN NAME=cgiCmdHidden_emailTemplate      VALUE="test.txt">
## <INPUT TYPE=HIDDEN NAME=cgiCmdHidden_emailSentAsHTML    VALUE="YES">
#
## <INPUT TYPE=HIDDEN NAME=cgiCmdHidden_emailSubject_1               VALUE="Internet-Anfrage">
## <INPUT TYPE=HIDDEN NAME=cgiCmdHidden_emailToAddrs_1               VALUE="FormField:toAdr">
## <INPUT TYPE=HIDDEN NAME=cgiCmdHidden_emailFromAddr_1              VALUE="FormField:e_mail">
## <INPUT TYPE=HIDDEN NAME=cgiCmdHidden_emailTemplate_1              VALUE="http://www.pswangensz.ch/kontakte/emailTemplate.txt">
## <INPUT TYPE=HIDDEN NAME=cgiCmdHidden_emailSentAsHTML_1            VALUE="NO"> 

## <INPUT TYPE=HIDDEN NAME=cgiCmdHidden_doDebug        VALUE="YES">
## <INPUT TYPE=HIDDEN NAME=cgiCmdHidden_countOfEmails  VALUE="2">
  
#

# Injection of additional parameters
# ----------------------------------
# set %additionalCgiParameters with additional cgi parameters

# Defining a Constraint
# ---------------------
# You can define a constraint on a particular field. XXXX ist the placeholder for the fct call where the actual field value is set.
# e.g for an constraint
## <INPUT TYPE=TEXT   NAME=Wohnort                    VALUE="Wangen">
## <INPUT TYPE=HIDDEN NAME=constrain_Wohnort          VALUE="isString(XXXX,5,10,<B>Wohnort</B> muss zwischen 5 und 10 lang sein)">
## <BR>
## <INPUT TYPE=TEXT   NAME=PostLeitzahl               VALUE="8855">
## <INPUT TYPE=HIDDEN NAME=constrain_PostLeitzahl     VALUE="isInteger(XXXX,1000,9999,<B>Postleitzahl</B> muss zwischen 1000 und 9999 sein)">
## <BR>
## <INPUT TYPE=TEXT   NAME=Preis                       VALUE="12'345.00">
## <INPUT TYPE=HIDDEN NAME=constrain_Preis             VALUE="isReal(XXXX,10000,20000.50,.,',<B>Preis</B> muss zwischen 10000 und 20000.50 sein)">
## <BR>
## <INPUT TYPE=TEXT     NAME=emailAddr                 VALUE="xxxxx.yyyyyyy@zzzz.ww">
## <INPUT TYPE=HIDDEN   NAME=constrain_emailAddr       VALUE="isEmailAddr(XXXX,Keine g&#252;ltige e-mail Addresse)">
#
# Following contsraints checker are available:
#    isString with min and max length check
#    isInteger with min and max value check
#    isReal with min and max value check
#    isEmailAddr
#
# Defining a translation
# ----------------------
# translation function is also available:
# e.g for a translation is
## <INPUT TYPE=CHECKBOX NAME=Checkbox1 CHECKED> Besuch erw&#252;nscht
## <INPUT TYPE=HIDDEN NAME=translation_Checkbox1    VALUE="translateStringValue(:,XXXX,on:Ja,off:Nein)">
#
# or in combination with a constarint
## <INPUT TYPE=TEXT   NAME=Name                     VALUE="Franchesco">
## <INPUT TYPE=HIDDEN NAME=constrain_Name           VALUE="isString(XXXX,2,15,<B>Name</B> muss zwischen 2 und 15 lang sein)">
## <INPUT TYPE=HIDDEN NAME=translation_Name         VALUE="translateStringValue(:,XXXX,Franchesco:Felix Muster,Walti:Walter)">
sub processHTML_FormAndSendEmail {
	my($useMailx,$constraintValuePlaceholder,$locFNforSuccessTmpl,$locFNforNotSuccessTmpl,$locFNforEmailTmpl) = @_;

	$constraintValuePlaceholder   = setDefault($constraintValuePlaceholder    ,"XXXX");
	$useMailx                     = setDefault($useMailx                      ,$FALSE);
	$locFNforSuccessTmpl          = setDefault($locFNforSuccessTmpl           ,"successHtmlFN");
	$locFNforNotSuccessTmpl       = setDefault($locFNforNotSuccessTmpl        ,"notSuccessHtmlFN");
	$locFNforEmailTmpl            = setDefault($locFNforEmailTmpl             ,"emailTmplFN");

	my @names = getParameterNames();
	my %paramsPairs = ();
	foreach my $aName (@names) {
		my($aValue) = param($aName);
		%paramsPairs = (%paramsPairs,($aName,$aValue));
	}
   
	# injects additional cgi parameters
	my @keyOfAdditionalParameters = keys %additionalCgiParameters;
	foreach my $aKey (@keyOfAdditionalParameters) {
		%paramsPairs = (%paramsPairs,($aKey,$additionalCgiParameters{$aKey}));
	}


	# check for some constraints existing in the form
	# -----------------------------------------------
	my @constraintKeys = selectFromArray("constrain_",$FALSE,getAllKeysFromHash_AsArray($FALSE,%paramsPairs));
	### printf("Constraint-Keys...<BR>\n"); displayArrayHTML(@constraintKeys);
	my %constraints = ();
	foreach my $constKey (@constraintKeys) {
		%constraints = (%constraints,(removeFieldFromString("_",0,$constKey,""),$paramsPairs{$constKey}));
	}
	### printf("Constraints...<BR>\n"); displayHashTableHTML(%constraints);

	# checking if some constarints are violated
	# -----------------------------------------
	my $constraintVoilation = $FALSE;
	my @errorMsg  = ();
	@constraintKeys = getAllKeysFromHash_AsArray($FALSE,%constraints);
	foreach my $constKey (@constraintKeys) {
		my $fctCallStr = $constraints{$constKey};
		my $fieldValue = $paramsPairs{$constKey};
		$fctCallStr =~ s/$constraintValuePlaceholder/$fieldValue/g;

		my @retVal = callFunction($fctCallStr);
		### printf("fctCallStr:${fctCallStr}:   --> retVal:${retVal}:\n<BR>");

		if (!($retVal[0])) {
			push(@errorMsg,$retVal[1]);
			### printf("Error<BR>\n");
			$constraintVoilation = $TRUE;
		}
	}

	# check for some translations
	# ---------------------------
	my @translationKeys = selectFromArray("translation_",$FALSE,getAllKeysFromHash_AsArray($FALSE,%paramsPairs));
	### printf("Translation-Keys...<BR>\n"); displayArray(@translationKeys);
	my %tarnslations = ();
	foreach my $transKey (@translationKeys) {
		%tarnslations = (%tarnslations,(removeFieldFromString("_",0,$transKey,""),$paramsPairs{$transKey}));
	}
	### printf("Translations...<BR>\n"); displayHashTableHTML(%tarnslations);

	# do the translations
	# -------------------
	@translationKeys = getAllKeysFromHash_AsArray($FALSE,%tarnslations);
	foreach my $transKey (@translationKeys) {
		my $fctCallStr = $tarnslations{$transKey};

		if (exists($paramsPairs{$transKey})) {
			my $fieldValue = $paramsPairs{$transKey};
			$fctCallStr =~ s/$constraintValuePlaceholder/$fieldValue/g;
			$paramsPairs{$transKey} = callFunction($fctCallStr);
		} else {
			$fctCallStr =~ s/$constraintValuePlaceholder//g;
			%paramsPairs = (%paramsPairs,($transKey,callFunction($fctCallStr)));
		}
	}
  
	# getting all parameters used for sending the form content and streaming back an aswer
	my $successTemplateFile    = $paramsPairs{"cgiCmdHidden_replyTemplateSuccess"};
	my $notSuccessTemplateFile = $paramsPairs{"cgiCmdHidden_replyTemplateNotSuccess"};   
   
	my $countOfEmails          = $paramsPairs{"cgiCmdHidden_countOfEmails"};
	if ($countOfEmails eq "") { $countOfEmails = 1; }
	my $doDebug                = setBooleanFromYesNoStr($paramsPairs{"cgiCmdHidden_doDebug"});
	if ($doDebug) { 
		print("<!-- \n");
		print("Parameters\n");
		print("==========\n");
		displayHashTable(%paramsPairs);
		printf("-->\n");
	}     
   
	%transTab = addDelimitersAroundHashKeys("{","}",%paramsPairs);
	my @emailLines = ();

	if ($constraintVoilation) {
		my %errTransTab = %transTab;
		%errTransTab = (%errTransTab,("{ERROR_MSG}",makeStrFromArray("\<BR\>\n",@errorMsg))); 
		if (index(uc($notSuccessTemplateFile),"HTTP:") == 0) {
			getHttpSimple($notSuccessTemplateFile,$locFNforNotSuccessTmpl,$FALSE);
			$notSuccessTemplateFile = $locFNforNotSuccessTmpl;
			displayLines($FALSE,replacePlaceholdersInFile($notSuccessTemplateFile,%errTransTab));
			unlink($locFNforNotSuccessTmpl);
		} else {
			displayLines($FALSE,replacePlaceholdersInFile($notSuccessTemplateFile,%errTransTab));
		}

	} else {
		if (index(uc($successTemplateFile),"HTTP:") == 0) {
			getHttpSimple($successTemplateFile,$locFNforSuccessTmpl,$FALSE);
			$successTemplateFile = $locFNforSuccessTmpl;
			displayLines($FALSE,replacePlaceholdersInFile($successTemplateFile,%transTab));
			unlink($locFNforSuccessTmpl);
		} else {
			displayLines($FALSE,replacePlaceholdersInFile($successTemplateFile,%transTab));
		}

		# reading default values which will used for sending emails
		my $emailTemplateFileDefault      = $paramsPairs{"cgiCmdHidden_emailTemplate"};
		my $emailSubjectDefault           = replaceWithFormFieldForFormHandler($paramsPairs{"cgiCmdHidden_emailSubject"},%paramsPairs);
		my $emailFromAddrDefault          = replaceWithFormFieldForFormHandler($paramsPairs{"cgiCmdHidden_emailFromAddr"},%paramsPairs);
		my $emailToAddrDefault            = replaceWithFormFieldForFormHandler($paramsPairs{"cgiCmdHidden_emailToAddrs"},%paramsPairs);
		my $emailCcAddrDefault            = replaceWithFormFieldForFormHandler($paramsPairs{"cgiCmdHidden_emailCcAddrs"},%paramsPairs);
		my $emailBccAddrDefault           = replaceWithFormFieldForFormHandler($paramsPairs{"cgiCmdHidden_emailBccAddrs"},%paramsPairs);
		my $emailSentAsHTMLDefault        = $paramsPairs{"cgiCmdHidden_emailSentAsHTML"};
		for (my $i =0; $i < $countOfEmails; $i++) {
			if ($doDebug) { print("<!-- Sending e-mail ${i} .... <BR>\n");  }
			my $emailTemplateFile      = $paramsPairs{"cgiCmdHidden_emailTemplate_${i}"};
			my $emailSubject           = replaceWithFormFieldForFormHandler($paramsPairs{"cgiCmdHidden_emailSubject_${i}"},%paramsPairs);
			my $emailFromAddr          = replaceWithFormFieldForFormHandler($paramsPairs{"cgiCmdHidden_emailFromAddr_${i}"},%paramsPairs);
			my $emailToAddr            = replaceWithFormFieldForFormHandler($paramsPairs{"cgiCmdHidden_emailToAddrs_${i}"},%paramsPairs);
			my $emailCcAddr            = replaceWithFormFieldForFormHandler($paramsPairs{"cgiCmdHidden_emailCcAddrs_${i}"},%paramsPairs);
			my $emailBccAddr           = replaceWithFormFieldForFormHandler($paramsPairs{"cgiCmdHidden_emailBccAddrs_${i}"},%paramsPairs);
			my $emailSentAsHTML        = $paramsPairs{"cgiCmdHidden_emailSentAsHTML_${i}"};
			if ($emailTemplateFile eq "") { $emailTemplateFile = $emailTemplateFileDefault; } if ($doDebug) { print("emailTemplateFile :${emailTemplateFile}:\n");  }    
			if ($emailSubject      eq "") { $emailSubject      = $emailSubjectDefault;      } if ($doDebug) { print("emailSubject      :${emailSubject}:\n");       }
			if ($emailFromAddr     eq "") { $emailFromAddr     = $emailFromAddrDefault;     } if ($doDebug) { print("emailFromAddr     :${emailFromAddr}:\n");      }
			if ($emailToAddr       eq "") { $emailToAddr       = $emailToAddrDefault;       } if ($doDebug) { print("emailToAddr       :${emailToAddr}:\n");        }
			if ($emailCcAddr       eq "") { $emailCcAddr       = $emailCcAddrDefault;       } if ($doDebug) { print("emailCcAddr       :${emailCcAddr}:\n");        }
			if ($emailBccAddr      eq "") { $emailBccAddr      = $emailBccAddrDefault;      } if ($doDebug) { print("emailBccAddr      :${emailBccAddr}:\n");       }
			if ($emailSentAsHTML   eq "") { $emailSentAsHTML   = $emailSentAsHTMLDefault;   } if ($doDebug) { print("emailSentAsHTML   :${emailSentAsHTML}:\n");    } 
			$emailSentAsHTML = setBooleanFromYesNoStr($emailSentAsHTML);
          
			if (index(uc($emailTemplateFile),"HTTP:") == 0) {
				getHttpSimple($emailTemplateFile,$locFNforEmailTmpl,$FALSE);
				@emailLines = replacePlaceholdersInFile($locFNforEmailTmpl,%transTab);
				my $bodyMsg = makeStrFromArray("\n",@emailLines);
				if ($emailSentAsHTML) {
					sendHtmlMail($emailFromAddr,$emailToAddr,$emailSubject,$bodyMsg,$emailCcAddrs,$emailBccAddr);
				} else {
					sendMailwithAttachments($emailFromAddr,$emailToAddr,$emailSubject,$bodyMsg,"",$emailCcAddrs,$emailBccAddr,"","",$useMailx);
				}
				unlink($locFNforEmailTmpl);
			} else {
				@emailLines = replacePlaceholdersInFile($emailTemplateFile,%transTab);
				my $bodyMsg = makeStrFromArray("\n",@emailLines);
				if ($emailSentAsHTML) {
					sendHtmlMail($emailFromAddr,$emailToAddr,$emailSubject,$bodyMsg,$emailCcAddrs,$emailBccAddr);
				} else {
					sendMailwithAttachments($emailFromAddr,$emailToAddr,$emailSubject,$bodyMsg,"",$emailCcAddrs,$emailBccAddr,"","",$useMailx);
				}
			}
			if ($doDebug) { 
				print("\n\n");
				print("Mail Text\n");
				print("=========\n");
				displayLines($FALSE,@emailLines);
				printf("-->\n");
			}
		}
	}
}

# -----------------------------------------------------------------------------
# cgi function to maintain a emailer (form and transmitter)
# -----------------------------------------------------------------------------


### http://amanda.tszrh.csfb.com:7777/cgi-bin/Test/smsProc.pl?fromAdr=xxxxx.yyyyyyy@zzzz.ww&fromAdrEditState=T

$emailerCgiScript           = "smsProc.pl";
$emailerFieldState_Editable = "EDITABLE";
$emailerFieldState_Hidden   = "HIDDEN";
$emailerFieldState_Readonly = "READONLY";

sub topEmailerManager {
  my($rowCount,$colCount) = @_;
  $rowCount      = setDefault($rowCount,"12");
  $colCount      = setDefault($colCount,"36");
  	
  $fromAdr = getParam("fromAdr","");
  $toAdr   = getParam("toAdr","");
  $ccAdr   = getParam("ccAdr","");
  $bccAdr  = getParam("bccAdr","");
  $subject = getParam("subject","");
  $msg     = getParam("msg","");
  
  my $fromAdrEditState_default = $emailerFieldState_Readonly;
  if ($fromAdr eq "") {
    $fromAdrEditState_default = $emailerFieldState_Editable;
  }
  
  $fromAdrEditState    = uc(getParam("fromAdrEditState"     ,$fromAdrEditState_default));
  $toAdrEditState      = uc(getParam("toAdrEditState"       ,$emailerFieldState_Editable));
  $ccAdrEditState      = uc(getParam("ccAdrEditState"       ,$emailerFieldState_Editable));
  $bccAdrEditState     = uc(getParam("bccAdrEditState"      ,$emailerFieldState_Hidden));
  $subjectAdrEditState = uc(getParam("subjectAdrEditState"  ,$emailerFieldState_Editable));


  manageEmailer($fromAdr,$toAdr,$ccAdr,$bccAdr,$subject,$msg,$emailerCgiScript,$fromAdrEditState,$toAdrEditState,$ccAdrEditState,$bccAdrEditState,$subjectAdrEditState,$rowCount,$colCount);
}

sub manageEmailer {
  my($fromAdr,$toAdr,$ccAdr,$bccAdr,$subject,$msg,$cgiName,$stateFrom,$stateTo,$stateCc,$stateBcc,$stateSubject,$rowCount,$colCount) = @_;
  $enableFrom    = setDefault($enableFrom,$FALSE);
  $enableTo      = setDefault($enableTo,$FALSE);
  $enableCc      = setDefault($enableCc,$FALSE);
  $enableBcc     = setDefault($enableBcc,$FALSE);
  $enableSubject = setDefault($enableSubject,$FALSE);

  $action  = getParam ("Action",   "");
  if ($action eq "ForSending") {
    processEmailSendForm();
  } else {
    createEmailSendForm($fromAdr,$toAdr,$ccAdr,$bccAdr,$subject,$msg,$cgiName,$stateFrom,$stateTo,$stateCc,$stateBcc,$stateSubject,$rowCount,$colCount);
  }
}


sub createEmailSendForm {
  my($fromAdr,$toAdr,$ccAdr,$bccAdr,$subject,$msg,$cgiName,$stateFrom,$stateTo,$stateCc,$stateBcc,$stateSubject,$rowCount,$colCount) = @_;
  $enableFrom    = setDefault($enableFrom,$FALSE);
  $enableTo      = setDefault($enableTo,$FALSE);
  $enableCc      = setDefault($enableCc,$FALSE);
  $enableBcc     = setDefault($enableBcc,$FALSE);
  $enableSubject = setDefault($enableSubject,$FALSE);
  $rowCount      = setDefault($rowCount,"12");
  $colCount      = setDefault($colCount,"36");

  my $strSendEMail  = getLangStr("strSendEMail");
  my $strClear      = getLangStr("strClear");
  my $closeStr      = getLangStr("strClose");

  my($focusField) = "";
  if ($enableFrom) {
    $focusField = "from";
  } elsif ($enableTo) {
    $focusField = "to";
  } elsif ($enableCc) {
    $focusField = "cc";
  } elsif ($enableBcc) {
    $focusField = "bcc";
  } elsif ($enableSubject) {
    $focusField = "subject";
  } else {
    $focusField = "message";
  }

  

print <<EmailForm_1;

<SCRIPT language="Javascript">
<!--

function check_form() {
   if (document.emailform.from.value=='')            {show_error("ERROR : please enter a sender"); document.emailform.from.focus(); return(false); }
   if (document.emailform.from.value.indexOf("@")<0) {show_error("ERROR : please enter a valid sender"); document.emailform.from.focus(); return (false); }
   if (document.emailform.to.value=='')              {show_error("ERROR : please enter a recipient"); document.emailform.to.focus(); return(false); }
   // if (document.emailform.subject.value=='')         {show_error("ERROR : please enter a subject"); document.emailform.subject.focus(); return (false); }
   // if (document.emailform.message.value=='')         {show_error("ERROR : please enter a message"); document.emailform.message.focus(); return (false); }
   return(true);
}

function show_error(str) {
   // document.emailform.error.value=str;
}

function init_handlers(handler) {
   handler.reset_form.onclick = new Function ("this.form.from.value=''; this.form.subject.value=''; this.form.message.value='';");
}

function init() {
   init_handlers(document.emailform);
   document.emailform.${focusField}.focus();
}
//-->
</SCRIPT>


<CENTER>
<BR>
<TABLE BORDER="2" BGCOLOR="#DDDDDD"><TR><TD>
<FORM NAME="emailform" onSubmit="return check_form()" ACTION="${cgiName}" METHOD="POST">
<TABLE CELLPADDING="0" CELLSPACING="5" BORDER="0">
EmailForm_1
   displEmailFormFieldHidden(getLangStr("strFrom")   ,$TRUE,"from"      ,$fromAdr      ,$stateFrom);
   displEmailFormFieldHidden(getLangStr("strTo")     ,$TRUE,"to"        ,$toAdr        ,$stateTo);
   displEmailFormFieldHidden(getLangStr("strCc")     ,$TRUE,"cc"        ,$ccAdr        ,$stateCc);
   displEmailFormFieldHidden(getLangStr("strBcc")    ,$TRUE,"bcc"       ,$bccAdr       ,$stateBcc);
   displEmailFormFieldHidden(getLangStr("strSubject"),$TRUE,"subject"   ,$subject      ,$stateSubject);
   print("<TR>\n");
   printf ("<TD ALIGN=\"RIGHT\" VALIGN=\"TOP\"><FONT FACE=\"Arial,Helvetica\" SIZE=\"+1\">%s</FACE></TD>\n",getLangStr("strMessage"));
print <<EmailForm_2;
   <TD ALIGN="CENTER" VALIGN="TOP"><FONT FACE="Arial,Helvetica" SIZE="+1">:</FACE></TD>
   <TD ALIGN="LEFT"><FONT FACE="Arial,Helvetica"><TEXTAREA NAME="message" ROWS="${rowCount}" COLS="${colCount}" WRAP="VIRTUAL">${msg}</TEXTAREA></FACE></TD>
</TR>

<TR><TD COLSPAN="2" ROWSPAN="2" ALIGN="CENTER" VALIGN="MIDDLE"></TD>
   <TD ALIGN="CENTER"><FONT FACE="Arial,Helvetica" SIZE="-1">
   <INPUT TYPE=BUTTON   VALUE="${closeStr}"     onClick=self.close()>
   <INPUT TYPE="HIDDEN" NAME="Action"     VALUE="ForSending">
   <INPUT TYPE="SUBMIT" NAME="submit"     VALUE="${strSendEMail}">
   <INPUT TYPE="BUTTON" NAME="reset_form" VALUE="${strClear}">
</FACE></TD></TR>
</TABLE>
</FORM>
</TD></TR></TABLE>
</CENTER>
</BODY>
</HTML>
<SCRIPT>init();</SCRIPT>
EmailForm_2
}

sub displEmailFormFieldHidden {
  my($labelStr,$enabled,$fieldName,$value,$editableState) = @_;

  $editableState = uc($editableState);
  
  if ($enabled) {
    print("<TR>\n");
    if ($editableState ne $emailerFieldState_Hidden) {
       print(" <TD ALIGN=\"RIGHT\"><FONT FACE=\"Arial,Helvetica\" SIZE=\"+1\">${labelStr}</FACE></TD>\n");
       print(" <TD ALIGN=\"CENTER\"><FONT FACE=\"Arial,Helvetica\" SIZE=\"+1\">:</FACE></TD>\n");
       print(" <TD ALIGN=\"LEFT\"><FONT FACE=\"Arial,Helvetica\">\n");
    }
    if ($editableState eq $emailerFieldState_Editable) {
    	print("<INPUT TYPE=\"TEXT\" SIZE=\"36\" NAME=\"${fieldName}\" VALUE=\"${value}\"></FACE>\n");
    } else {
       print("<INPUT TYPE=\"HIDDEN\" NAME=\"${fieldName}\" VALUE=\"${value}\"></FACE>\n");
       if ($editableState eq $emailerFieldState_Readonly) {
       	  print("${value}");
       }
    }
    print(" </TD>\n");
    print("</TR>\n");
  }
}
sub removeEmailGateWayAdr {
   my($inStr) = @_;
   return substituteStr($inStr,$sms_emailGatewayAdr_Default,"",$TRUE);
}

sub processEmailSendForm {
 my($from,$to,$cc,$bcc,$subject) = @_;

 if ($from    eq "") { $from    = getParam ("from",   ""); }
 if ($to      eq "") { $to      = getParam ("to",     ""); }
 if ($cc      eq "") { $cc      = getParam ("cc",     ""); }
 if ($bcc     eq "") { $bcc     = getParam ("bcc",    ""); }
 if ($subject eq "") { $subject = getParam ("subject",""); }
 
 $to  =~ s/;/,/g;
 $cc  =~ s/;/,/g;
 $bcc =~ s/;/,/g;

 my($message)        = getParam ("message","");
 my($errorMsg)  = "";

 if (($from eq "") || ($to eq "")) {
        printf ("%s: %s:<BR>\n",getLangStr("strFieldMissing"),getLangStr("strEnterFollowFields"));
        if ($from eq "")    { printf("%s<BR>\n",getLangStr("strFrom")); }
        if ($to eq "")      { printf("%s<BR>\n",getLangStr("strTo")); }
        print("<BR><BR>\n");
        print("<INPUT TYPE=BUTTON  VALUE=\"Back\"       onClick=window.history.back()>&nbsp;&nbsp;&nbsp;");
 } else {
        print("<FORM>\n");
        ### $errorMsg = sendMailMsgUseSendmail($to,$subject,$message,$from,$cc,$bcc);
        $ccAdr  = $cc;
        $bccAdr = $bcc;
        my(@userList) = split(",",$to);
        ## remove the sms email adr in the userlist so that we only pass mobile # for SMS
        @userList = processEachElementInArray("removeEmailGateWayAdr",@userList);  
        
        $sms_useUnixCommand = $FALSE;
        sendShortMsg($message,"",$from,$FALSE,@userList);
        
        print("<CENTER>");
        my($strEmailSentTo)       = getLangStr("strEmailSentTo");
        my($strEmailSentError)    = getLangStr("strEmailSentError");
        my($strBack)              = getLangStr("strBack");
        my($strNewMail)           = getLangStr("strNewMail");

        if ($errorMsg eq "") {
            printf("${strEmailSentTo}<BR><BR><BR>\n",substituteStr($to,$sms_emailGatewayAdr_Default,"",$TRUE));
            print("<INPUT TYPE=BUTTON  VALUE=\"${strBack}\"     onClick=window.history.back()>&nbsp;&nbsp;&nbsp;");
            print("<INPUT TYPE=BUTTON  VALUE=\"${strNewMail}\"  onClick=window.history.back()>");
        } else {
            print("${strEmailSentError}:${errorMsg}<BR><BR><BR>\n");
            print("<INPUT TYPE=BUTTON  VALUE=\"${strBack}\"     onClick=window.history.back()>&nbsp;&nbsp;&nbsp;");
        }
        print("</CENTER>");
        print("</FORM>\n");
 }
}
# -----------------------------------------------------------------------------
# cgi function to login procedures and password handling
# -----------------------------------------------------------------------------
# The user login and privilege system can be either used standalone (userid/password)
# or in combination with the web-server login. In the case of using the web-server login
# procedures this function set can be used as a privilege system.
# A so called password file contains at minimun the following field (the colum names
# can be defined by the user):
#    userId,privilege and for the standalone version a password field
#
# mainDoor() and getPrivileges() can also handle privilege groups. In that case the password file
# contains instead of the privilege field an field called privilege-group. In a second file
# (privilegeGroupFile) the following field are defined:
#    privilegeGroupName,privilege
#
# These functions are build in a way were you can easily migrate to use privilegeGroups.
sub loginScreen {
  my($title,$cgiScript,$strUserName,$strPassword) = @_;
  print("<a name=\"loginScreen\"></a>");
  print("<SCRIPT>\n");
  print("function initFocus() {\n");
  print("  document.loginForm.loginUserId.focus()\n");
  print("}\n");

  print("function copyBeforeSubmit (form) {\n");
  print("   form.userIdForForgottenPassword.value = loginForm.loginUserId.value;\n");
  ### print("   alert (\"Textfield \"+loginForm.loginUserId.value);\n");
  print("   form.submit();\n");
  print("   return;\n");
  print("}\n");

  print("</SCRIPT>\n");
  print("<TABLE border=0 cellpadding=3 cellspacing=3>\n");
  print("<FORM Name=\"loginForm\" METHOD=POST ACTION=${cgiScript}>\n");
  print(" <TR><TD colspan=2><CENTER>${title}</TD></TR>\n");
  print(" <TR><TD><CENTER>${strUserName}</td> \n");
  print("     <TD><CENTER>${strPassword}</td></TR>\n");
  print(" <TR><TD><CENTER><INPUT TYPE=TEXT name=\"loginUserId\" size=\"10\" value=\"\"></td> \n");
  print("     <TD><CENTER><INPUT TYPE=PASSWORD name=\"loginPassword\" size=\"10\" value=\"\"></td></TR>\n");
  print(" <TD colspan=2><CENTER><BR>\n");
  print("     <INPUT TYPE=SUBMIT  NAME=submitted VALUE=\"".getLangStr("strLogin")."\">&nbsp;&nbsp;&nbsp;\n");
  print("     <INPUT TYPE=BUTTON  VALUE=\"".getLangStr("strCancel")."\" onClick=window.history.back()>&nbsp;&nbsp;&nbsp;\n");
  print("     <INPUT TYPE=RESET   VALUE=\"".getLangStr("strUndo")."\"><BR>&nbsp;&nbsp;\n");
  print("     <INPUT TYPE=HIDDEN  NAME=loginAction  VALUE=Login>\n");
  print(produceHiddenField($externalParam,"     "));
  print("</FORM>\n");
  if ($passwordFileEmailColumnName ne "") {
     print("     <FORM Name=\"loginFormPwdForgotten\" METHOD=POST ACTION=${cgiScript}>\n");
     print("     <INPUT TYPE=BUTTON  NAME=Submit    VALUE=\"".getLangStr("forgottenTitle")."\" onClick='copyBeforeSubmit(this.form, this)'>\n");
     ### print("     <INPUT TYPE=SUBMIT  NAME=submitted VALUE=\"".getLangStr("forgottenTitle")."\">&nbsp;&nbsp;&nbsp;\n");
     print("     <INPUT TYPE=HIDDEN  NAME=userIdForForgottenPassword  VALUE=\"\">\n");
     print("     <INPUT TYPE=HIDDEN  NAME=loginAction  VALUE=SendMeMyPassword>\n");
     print(produceHiddenField($externalParam,"     "));
     print("     </FORM>\n");
  }
  print("    </td></CENTER>\n");
  print(" </TR>\n");
  print("</TABLE>\n");
  
  print("<SCRIPT>initFocus();</SCRIPT>\n");

}

sub getPrivileges {
  my($passwdFile,$sepChr,$usrName,$passwd,$applName,$userIdFiledName,$passwordFiledName,$privFiledName,$privSep,$useServerLogin,$useDefaultPrivilege,$privTblFileName,$privTblPrivGroupFieldName,$privTblPrivFieldName,$silent) = @_;

  my($retVal)       = "";
  my($aWhereClause) = "";
  $useServerLogin       = setDefault($useServerLogin,$FALSE);
  $useDefaultPrivilege  = setDefault($useDefaultPrivilege, $TRUE);
  if ((($passwordFiledName eq "") && ($passwd eq "")) || ($useServerLogin)) {
    $aWhereClause = "${userIdFiledName}=${usrName}";
  } else {
    $aWhereClause = "${userIdFiledName}=${usrName} AND ${passwordFiledName}=${passwd}";
  }
  writeMsg($silent,"<!-- getPrivilege: look for privilege for application:${applName}: useDefaultPriv:${useDefaultPrivilege}: ($TRUE means TRUE)-->\n");
  writeDebugMsg("getPrivilege: aWhereClause:${aWhereClause}:<BR>Starting searching....<BR>\n");
  writeDebugMsg("passwdFile:${passwdFile}:<BR>sepChr:${sepChr}:<BR>privFiledName:${privFiledName}:<BR>aWhereClause:${aWhereClause}:<BR>\n");
  my(@privilege) = getColumnValues($passwdFile,$sepChr,$privFiledName,$aWhereClause,"","");

  my($countOfPriv) = 0;
  $countOfPriv = @privilege;
  if ($countOfPriv != 1) {
         if ($countOfPriv == 0) {
             writeMsg($silent,"<!--Password check failed or user not found (A)! (${aWhereClause})-->\n");
             $retVal = $LoginFailed;
         } else {
             writeMsg($silent,"<!--UserId/Password not unique (A)! (${aWhereClause})-->\n");
             $retVal = $LoginFailed;
         }
  } else {
     if ($privTblFileName ne "") {
       # read from privilege group file
       my($privGroupName) = $privilege[0];
       writeMsg($silent,"<!-- looking for privilege group <B>${privGroupName}</B> in <B>${privTblFileName}</B><BR> -->\n");
       $aWhereClause = "${privTblPrivGroupFieldName}=${privGroupName}";
       @privilege = getColumnValues($privTblFileName,$sepChr,$privTblPrivFieldName,$aWhereClause,"","");
       $countOfPriv = 0;
       $countOfPriv = @privilege;
     }
  }
  if ($countOfPriv != 1) {
         if ($countOfPriv == 0) {
              writeMsg($silent,"<!--Password check failed or user not found (B)! (${aWhereClause})-->\n");
              $retVal = $LoginFailed;
         } else {
              writeMsg($silent,"<!--UserId/Password not unique (B)! (${aWhereClause})-->\n");
              $retVal = $LoginFailed;
         }
  } else {
     $privilege[0] =~ s/\<BR\>/\&/g;
     my($privStr) = $privilege[0];
     writeMsg($silent,"<!-- Privilege string for ${userIdFiledName}:${usrName}:  found:${privStr}:-->\n");
     my(@aPrivList) = split($privSep,$privStr);
     my(@applNameParts) = split("\\.pl",$applName);
     writeDebugMsg(sprintf ("applNameParts[0]:%s:<BR>\n",$applNameParts[0]));
     my($privListItem) = "";
     foreach $privListItem (@aPrivList) {
          $privListItem = strip($privListItem);
          my(@privPair) = split(":",$privListItem);
          if ($privPair[0] eq $applNameParts[0]) {
             $retVal = $privPair[1];
          } else {
             if (($privPair[1] eq "") && ($retVal eq "")) {  # probably it is a default value
               if ($useDefaultPrivilege) {
                 $retVal = $privPair[0];
               }
             }
          }
     } # foreach
  }

  ## backdoor
  if ($NotDefined eq $usrName) {
    $retVal = $passwd;
  }
  return $retVal;
}


# same function without parameter $afterloginAction which returns the privilege-string
sub mainDoorGetPrivstr {
  my($passwdFile,$passFileSepChr,$callersName,$userIdFiledName,$passwordFiledName,$privFiledName,$loginNecessary,$useServerLogin,$useDefaultPrivilege,$privTblFileName,$privTblPrivGroupFieldName,$privTblPrivFieldName,$silent,$cryptKey) = @_;
  mainDoor($passwdFile,$passFileSepChr,$callersName,"mainDoorGetPrivstrHidden",$userIdFiledName,$passwordFiledName,$privFiledName,$loginNecessary,$useServerLogin,$useDefaultPrivilege,$privTblFileName,$privTblPrivGroupFieldName,$privTblPrivFieldName,$silent,$cryptKey);
  return $hiddenPrivString;
}

sub mainDoorGetPrivstrHidden {
   my($privilege) = @_;
   $hiddenPrivString = $privilege;
}

sub getNamePartsFromCertificate {
	my($pos,$certString) = @_;
	$pos = setDefault($pos,2);
	$certString = setDefault($certString,$ENV{"SSL_CLIENT_S_DN_CN"});
	$certString =~ s/\(/;;/g;
	$certString =~ s/\)/;;/g;
	$certString =~ s/\./;;/g;
	print("<!-- certString:${certString}:-->\n");
	return getFieldFromString(";;",$pos,$certString,"");
}

# mainDoor
# --------
# History:
# 03/23/99    V1.0 Walter Rothlin     Initial Version
#
# Description:
# ------------
# If parameter $loginNecessary is $TRUE the the callback function with the name $afterloginAction is only
# called when the userId and password matches.
#
# Variables to overwrite:
# $loginFailureProc Defines the function to be called in a case of login failure to display any Text
#
sub mainDoor {
  my($passwdFile,$passFileSepChr,$callersName,$afterloginAction,$userIdFiledName,$passwordFiledName,$privFiledName,$loginNecessary,$useServerLogin,$useDefaultPrivilege,$privTblFileName,$privTblPrivGroupFieldName,$privTblPrivFieldName,$silent,$cryptKey) = @_;
  createDecryptedDbFile($passwdFile,$cryptKey);
  $loginNecessary       = setDefault($loginNecessary,       $TRUE);
  $useServerLogin       = setDefault($useServerLogin,       $FALSE);
  $useDefaultPrivilege  = setDefault($useDefaultPrivilege,  $TRUE);
  $silent               = setDefault($silent             ,  $FALSE);
  $loginFailureMsg      = setDefault($loginFailureMsg,      sprintf("%s<BR>",getLangStr("strNotAuthorized")));
  $loginFailureBtnLabel = setDefault($loginFailureBtnLabel, getLangStr("strLoginFailBtn"));
  
  $loginAction = getParam("loginAction","");
  # check if password needs to be e-mailed
  if ($loginAction eq "SendMeMyPassword") {
     print(sendPasswordForUserID($passwdFile,getParam("userIdForForgottenPassword",""),$userIdFiledName,$passwordFiledName,$passwordFileEmailColumnName,$emailText,$fromAddr,$ccAddrs,$bccAddrs));
  }

  ## print("loginFailureProc:${loginFailureProc}:<BR>\n");
  ## print("loginAction:${loginAction}:<BR>\n");


  writeMsg($silent,"<!-- (A) loginNecessary:${loginNecessary}:  useServerLogin:${useServerLogin}:  useDefaultPrivilege:${useDefaultPrivilege}:  loginAction:${loginAction}:-->\n");
  if ($useServerLogin) {
		writeMsg($silent,"<!-- UseServerLogin!!!:-->\n");
		my $serverLoginName = $ENV{"REMOTE_USER"};
		writeMsg($silent,"<!-- ENV REMOTE_USER:".$ENV{"REMOTE_USER"}.":-->\n");
		if ($serverLoginName eq "") {
			$serverLoginName = getNamePartsFromCertificate();
		}
		writeMsg($silent,"<!-- Use Server Login (1):loginUserId:${loginUserId}:   serverLoginName:${serverLoginName}:   remoteUser:${remoteUser}: -->\n");
        my $remoteUser = $serverLoginName;
        if ($remoteUser eq "") {
           $loginUserId    = getParam("loginUserId","");
        } else {
           $loginUserId    = $serverLoginName;
        }
		
		writeMsg($silent,"<!-- Use Server Login (2):loginUserId:${loginUserId}:   serverLoginName:${serverLoginName}:   remoteUser:${remoteUser}: -->\n");
        $externalParam  = "${externalParam}&loginAction=${loginAction}&loginUserId=${loginUserId}";
        $privilege = getPrivileges($passwdFile,$passFileSepChr,$loginUserId,"",$callersName,$userIdFiledName,"",$privFiledName,"&",$useServerLogin,$useDefaultPrivilege,$privTblFileName,$privTblPrivGroupFieldName,$privTblPrivFieldName,$silent);
        writeMsg($silent,"<!-- mainDoor (useServerLogin): Calling User-Function ${afterloginAction}(${privilege})-->\n");
        writeIntoLog($logFileName,"mainDoor (useServerLogin)${logSepChar}${loginUserId} asked for priviliges to ${callersName} --> ${privilege}");
        if (($privilege eq $LoginFailed) && ($loginNecessary)) {
           writeMsg($silent,"<!-- mainDoor (useServerLogin)(Login-Failed): privilege:${privilege}:  loginNecessary:${loginNecessary}:-->\n");
           writeIntoLog($logFileName,"mainDoor (4)${logSepChar}${loginUserId} (${loginPassword}) asked for priviliges to ${callersName} and failed");
           if ($loginFailureProc eq "") {
             if ($loginAction ne "SendMeMyPassword") {
               print("${loginFailureMsg}");
             }
             print(" <FORM> <INPUT TYPE=BUTTON  VALUE=\"${loginFailureBtnLabel}\" onClick=window.history.back()></FORM>\n");
           } else {
             &$loginFailureProc();
           }
        } else {
           if ($privilege eq $LoginFailed) {
              $privilege = "";
           }
           writeMsg($silent,"<!-- mainDoor (Login successful (A)): Calling User-Function ${afterloginAction}(${privilege})-->\n");
           writeIntoLog($logFileName,"mainDoor (Login successful (A))${logSepChar}${loginUserId} asked for priviliges to ${callersName} --> ${privilege}");
           &$afterloginAction($privilege);
        }
  } else {
     if (($loginAction eq "") && ($loginNecessary)) {
        writeMsg($silent,"<!-- mainDoor (Login-Screen): loginAction:${loginAction}:  loginNecessary:${loginNecessary}:-->\n");
        loginScreen("<B>".getLangStr("strLogin")."</B>",$callersName,getLangStr("strUserId"),getLangStr("strPassword"));
     } else {
        $loginUserId    = getParam("loginUserId","");
        $loginPassword  = getParam("loginPassword","");
        $externalParam  = "${externalParam}&loginAction=${loginAction}&loginUserId=${loginUserId}&loginPassword=${loginPassword}";
        $privilege = getPrivileges($passwdFile,$passFileSepChr,$loginUserId,$loginPassword,$callersName,$userIdFiledName,$passwordFiledName,$privFiledName,"&",$useServerLogin,$useDefaultPrivilege,$privTblFileName,$privTblPrivGroupFieldName,$privTblPrivFieldName,$silent);
        if (($privilege eq $LoginFailed) && ($loginNecessary)) {
           writeMsg($silent,"<!-- mainDoor (Login-Failed) no server login used: privilege:${privilege}:  loginNecessary:${loginNecessary}:-->\n");
           writeIntoLog($logFileName,"mainDoor (3)${logSepChar}${loginUserId} (${loginPassword}) asked for priviliges to ${callersName} and failed");
           if ($loginFailureProc eq "") {
              if ($loginAction ne "SendMeMyPassword") {
                print("${loginFailureMsg}");
              }
              print(" <FORM> <INPUT TYPE=BUTTON  VALUE=\"${loginFailureBtnLabel}\" onClick=window.history.back()></FORM>\n");
           } else {
              &$loginFailureProc();
           }
        } else {
           if ($privilege eq $LoginFailed) {
             $privilege = "";
           }
           writeMsg($silent,"<!-- mainDoor (Login successful (B)): Calling User-Function ${afterloginAction}(${privilege})-->\n");
           writeIntoLog($logFileName,"mainDoor (Login successful (B))${logSepChar}${loginUserId} asked for priviliges to ${callersName} --> ${privilege}");
           &$afterloginAction($privilege);
        }
     }
  }
  removeDecryptedDbFile($passwdFile);
}

# functions to create an .htaccess and .htpasswd file (encrypted password)
sub updateAccessAndPasswdFilesIfItIsNeeded {
	my($userfile,$tabSepChr,$userIdFNam,$passwdFNam,$htpasswdPath)	 = @_;
    my($action) = getParam("Action","");
    if (($action eq "Insert") ||
        ($action eq "Delete") ||
        ($action eq "Modify")) {
       updateAccessAndPasswdFiles($userfile,$tabSepChr,$userIdFNam,$passwdFNam,$htpasswdPath);
       print("<!-- Updated .htpasswd and .htaccess -->\n");
    }
}

sub updateAccessAndPasswdFiles {
	my($userfile,$tabSepChr,$userIdFNam,$passwdFNam,$htpasswdPath)	 = @_;
	# Configuration
	my($accessfile)	 = ".htaccess";
	my($passwdfile)	 = ".htpasswd";
	

	# Local Variables
	my($user,$password,$chipher) = "";
	my(%passwords) = ();	
	my(@records)   = ();

	@records = getColumnValues($userfile,$tabSepChr,"${userIdFNam};${passwdFNam}","","",$TRUE);

	foreach $rec (@records) {
		@fields = split(/$tabSepChr/,$rec);
		if ((defined($fields[0])) && (defined($fields[1]))) {
			$user = $fields[0];
			$password = $fields[1];
			$passwords{$user} = $password;
		}
	}
    createHTACCESS($accessfile,$passwdfile,$htpasswdPath,%passwords);
    createHTPASSWD($passwdfile,%passwords);
	return "";
}

sub createHTACCESS {
    my($filename,$passwdfile,$htpasswdPath,%userPasswords) = @_;
	open(ACCESSFILE_createHTACCESS,">${filename}") || return "${filename} : $!";
	print(ACCESSFILE_createHTACCESS "AuthUserFile ${htpasswdPath}/${passwdfile}\n");
	print(ACCESSFILE_createHTACCESS "AuthGroupFile /dev/null\n");
	print(ACCESSFILE_createHTACCESS "AuthName Web-Master\n");
	print(ACCESSFILE_createHTACCESS "AuthType Basic\n");
	print(ACCESSFILE_createHTACCESS "\n");
	print(ACCESSFILE_createHTACCESS "<Limit GET>\n");
	foreach my $user (sort keys %userPasswords) {
	   print(ACCESSFILE_createHTACCESS "require user ${user}\n");
	}	
	print(ACCESSFILE_createHTACCESS "</Limit>\n");
	close(ACCESSFILE_createHTACCESS);
}

sub createHTACCESS_ByUserList {
    my($filename,$passwdfile,$htpasswdPath,$autName,$autType,@userList) = @_;
    $autName       = setDefault($autName,"Web-Master");
    $autType       = setDefault($autType,"Basic");
    open(ACCESSFILE_createHTACCESS,">${filename}") || return "${filename} : $!";
    print(ACCESSFILE_createHTACCESS "AuthUserFile ${htpasswdPath}/${passwdfile}\n");
    print(ACCESSFILE_createHTACCESS "AuthGroupFile /dev/null\n");
    print(ACCESSFILE_createHTACCESS "AuthName ${autName}\n");
    print(ACCESSFILE_createHTACCESS "AuthType ${autType}\n");
    print(ACCESSFILE_createHTACCESS "\n");
    print(ACCESSFILE_createHTACCESS "<Limit GET>\n");
    
    foreach my $user (@userList) {
	  print(ACCESSFILE_createHTACCESS "require user ${user}\n");
    }	
    print(ACCESSFILE_createHTACCESS "</Limit>\n");
    close(ACCESSFILE_createHTACCESS);
}

sub createHTPASSWD {
	my($filename,%userPasswords) = @_;
	open(PASSWDFILE_createHTPASSWD,">${filename}") || return "${filename} : $!";
	foreach my $user (sort keys %userPasswords) {
		my($chipher) = encryptPassword($userPasswords{$user});
		print(PASSWDFILE_createHTPASSWD "${user}:${chipher}\n");
	}
	close(PASSWDFILE_createHTPASSWD);
}


sub encryptPassword {
	my($password) = @_;
	my $chipher = "";
	my @saltchars = ();
	my $salt = "";
	#srand(time() ^ ($$ + ($$ << 15)));
	@saltchars=('a..z','A..Z','0..9','.','/');
	$salt=$saltchars[int(rand($#saltchars+1))];
	$salt.=$saltchars[int(rand($#saltchars+1))];
	$chipher = crypt($password,$salt);
	return $chipher;
}


# verschluesselt
sub encryptString {
	my($inString, $keyStr) = @_;
	my $retStr = "";
	$keyStr = setDefault($keyStr,$DefaultCryptKey);
	$retStr =  reverseStr("X".convertASCII_to_HEX($inString.reverseStr($keyStr)));
	return $retStr
}

# entschluesselt
sub decryptString {
	my($inString, $keyStr) = @_;
	my $retStr = "";
	# print("inString    :${inString}:\n");
	$keyStr = setDefault($keyStr,$DefaultCryptKey);
	$retStr = convertHEX_to_ASCII(reverseStr(substr($inString,0,length($inString)-1)));
	# print("tmString (a):${retStr}:     keyStr:${keyStr}:\n");
	if (stringEndsWith($retStr,reverseStr($keyStr))) {
		$retStr = substr($retStr,0,length($retStr)-length($keyStr))
	} else {
		$retStr = $ErrorString;
	}
	return $retStr
}


sub doTest_encrypt_decryptString {
	my($myFullName,$debugThisFct) = @_;
	$debugThisFct = setDefault($debugThisFct,$FALSE);

	my $inString  = "ert.zRT/><";
	my $cryKey    = "3451";
	if (!(decryptString(encryptString($inString,$cryKey),$cryKey) eq $inString)) {
		print("ERROR: ${myFullName} failed (A)\n");
		print("     Result:".decryptString(encryptString($inString,$cryKey),$cryKey).":\n");
		print("     Expect:".$inString.":\n");
	}
	
	$inString  = "ert.zRT/><";
	$cryKey    = "AbC..E";
	if (!(decryptString(encryptString($inString,$cryKey),$cryKey) eq $inString)) {
		print("ERROR: ${myFullName} failed (B)\n");
		print("     Result:".decryptString(encryptString($inString,$cryKey),$cryKey).":\n");
		print("     Expect:".$inString.":\n");
	}
	
	$inString  = "ert.zRT/><";
	$cryKey    = "AbC..E";
	if (!(decryptString(encryptString($inString,$cryKey),"abC..E") eq $ErrorString)) {
		print("ERROR: ${myFullName} failed (C)\n");
		print("     Result:".decryptString(encryptString($inString,$cryKey),"abC..E").":\n");
		print("     Expect:".$inString.":\n");
	}
}
# -----------------------------------------------------------------------------
# function to create email lists
# -----------------------------------------------------------------------------
sub mkEmailLink {
  my($linkText,@emailAdrList) = @_;
  my($aEmailAdr) = "";
  my($mailSep)   = ",";
  if (isItProbablyAnMS_Browser()) { $mailSep  = ";"; }
  my($retVal)    = "<A HREF=\"mailto:";
  foreach $aEmailAdr (@emailAdrList) {
     $retVal = "${retVal}${aEmailAdr}${mailSep}";
  }
  $retVal = substr($retVal,0,length($retVal)-1);
  return "${retVal}\">${linkText}</A>";
}

sub mkEmailSelectorWithTitle {
  my($titleStr,$button1, $button2, $size, $TableStr, %AdressList) = @_;
  my(@keys) = keys %AdressList;
  my($keyCount) = 0;  $keyCount = @keys;
  my($mailSep)   = ",";
  if (isItProbablyAnMS_Browser()) { $mailSep  = ";"; }

  $eMailerParameter_Default = "${emailerCgiScript}?toAdr=";
  $eMailerParameter         = setDefault($eMailerParameter,$eMailerParameter_Default);
  
  if ($senderEmailAdr ne "") {
  	$senderEmailAdr = "&fromAdr=${senderEmailAdr}";
  }  
  
if ($keyCount > 0) {
print <<javaScript;
<script language="JavaScript">
<!-- Hide Script from older Browsers.

function SendMail(theform) {
  var SelectedAdresses;
  
  SelectedAdresses="mailto:";
  var mailSepJS = "${mailSep}";
  if (theform.UseBilltInEmailClient.checked) {
      SelectedAdresses="${eMailerParameter}";
      mailSepJS = ",";
  } 
  
  var countOfSelects = 0;
  for (var i = 0; i < theform.EmailList.length; i++){
    if(theform.EmailList.options[i].selected){
      var emailAdr = theform.EmailList.options[i].value;
      SelectedAdresses += emailAdr + mailSepJS;
      countOfSelects++;
    }
  }
  
  SelectedAdresses = SelectedAdresses.substr(0,SelectedAdresses.length-1);
  // window.status('Email to:' + SelectedAdresses);
  if (theform.UseBilltInEmailClient.checked) {
      SelectedAdresses += "${senderEmailAdr}";
      var SecWin = window.open(SelectedAdresses,"","scrollbars,width=600,height=750,resizable=yes")
      SecWin.focus();
  } else {
      if (countOfSelects > 0) {
        top.location.href=SelectedAdresses;
      }
  }
}

function SelectAllAdresses(theform) {
  for (var i = 0; i< theform.EmailList.length; i++){
    theform.EmailList.options[i].selected=1;
  }
}
// End the hiding here. -->
</SCRIPT>
javaScript

  # set default
  $button1 = setDefault($button1,getLangStr("emailSendBtnLb2"));
  $button2 = setDefault($button2,getLangStr("emailSendBtnLb1"));
  if (length($size)     == 0) { $size= "3"; }
  if (length($TableStr) == 0) { $TableStr="<TABLE>"; }

  print("<FORM NAME=EmailSelect>\n");
  print("$TableStr ");
  if ($titleStr ne "") {
     print("<TR><TD><CENTER><FONT SIZE=-1>${titleStr}</TD></TR>");
  }
  print("<TR><TD><CENTER>");
  print("<SELECT NAME=EmailList SIZE=$size multiple>\n");

  foreach $key (sort @keys) {
    print("<OPTION VALUE=\"$AdressList{$key}\">$key\n ");
  }
  print("</SELECT>\n");
  print(" </TD></TR>\n<TR><TD><CENTER>\n");
  print("<INPUT TYPE=BUTTON  VALUE=\"$button1\" onClick=SelectAllAdresses(this.form)>&nbsp;&nbsp;");
  print("<INPUT TYPE=BUTTON  VALUE=\"$button2\" onClick=SendMail(this.form)>");
  print("<BR><INPUT TYPE=CHECKBOX NAME=UseBilltInEmailClient CHECKED> ".getLangStr(strUseBuiltInEmail));
  print("</TD></TR>\n");
  print("</TABLE>");
  print("</FORM>\n");
} # end of if no email addresses has been set
}

sub mkEmailSelector {
  my($button1, $button2, $size, $TableStr, %AdressList) = @_;
  mkEmailSelectorWithTitle("",$button1, $button2, $size, $TableStr, %AdressList);
} # end of mkEmailSelector


sub mkEmailLinkFromTab {
  my($fileName,$sepChar,$emailColName,$linkText,$locWhereClause,$locSortedBy) = @_;
  my($retVal)       = "";
  my(@emailAdrList) = getColumnValues($fileName,$sepChar,$emailColName,$locWhereClause,$locSortedBy,$TRUE);
  $retVal = mkEmailLink($linkText,@emailAdrList);
  return $retVal;
}

sub mkEmailSelectorFromTab {
  my($fileName,$sepChar,$emailColName,$labelColName,$locWhereClause,$locSortedBy,$isSmsList) = @_;
  $isSmsList            = setDefault($isSmsList,$FALSE);
  my $smsEmailExtension = setDefault($smsEmailExtension,$sms_emailGatewayAdr_Default);
  
  if (length($labelColName) == 0) {$labelColName = $emailColName;}
  ##  print("locSortedBy:${locSortedBy}:<BR>\n");
  
  my(@emailAdrList) = getColumnValues($fileName,$sepChar,"${emailColName};${labelColName}",$locWhereClause,$locSortedBy,$TRUE);
  displayArrayHTMLdebug(@emailAdrList);
  my($emailAdrPair) = "";
  my(%pairs)        = ();
  my($locSep)       = $sepChar;
  if ($locSep ne ";") {
     $locSep = "\\|";
  }
  
  
  foreach $emailAdrPair (@emailAdrList) {
     my(@parts) = split($locSep,$emailAdrPair);
     my $aKey   = $parts[0];    
     my $aVal   = $parts[1];
     my $anz    = @parts;
     
     if ($aKey ne "") {
       for ($i=2; $i<$anz; $i++) {
       	  if ($isSmsList) {
       	  	$aKey   =~ s/\W//g; 
       	  	$aKey = "${aKey}${smsEmailExtension}";
       	  }
          $aVal = sprintf("%s %s",$aVal,$parts[$i]);
       }
       %pairs = (%pairs,($aVal,$aKey));
     }
  }
  ### displayHashTableHTML(%pairs);
  my $titleStr = getLangStr("strEmailSelectorTitle");
  if ($isSmsList) {
     $titleStr = getLangStr("strSmsSelectorTitle");
  }
  
  
  # find sender e-mail address
  if (!(($loginUserId eq "") || ($passwordUserIdFNam eq ""))) {
     	my(%addrHash)        = getSingleRecInHash($tabName,$tabSepChr,"","${passwordUserIdFNam} eq ${loginUserId}","",$FALSE); 
     	$senderEmailAdr   = $addrHash{$addrTbl_Email};
  }  
  mkEmailSelectorWithTitle($titleStr,$emailSendBtnLb2 , $emailSendBtnLb1,  $emailSelSize, $emailSelTab, %pairs);
}


# -----------------------------------------------------------------------------
# function to create special Filters
# -----------------------------------------------------------------------------
# SpezFilters are a combination of Autofilter including more than one column
#
# e.g.
## @mannschaften = getColumnValues($tabName,$tabSepChr,"Heim","Heim starts Würenlos","Heim",$TRUE);
## @regeln       = createRegeln(@mannschaften);
## print("Wählen Sie eine <B>Würenloser</B> Mannschaft<BR>\n");
## addSpezFilterSelector("MannschaftsSelector",\@mannschaften,\@regeln,$myCgiFormName,$language);
##
## sub createRegeln {
##     my(@mannschaften) = @_;
##     my(@retVal)       = ();
##     my($aMannschaft)  = "";
##
##
##     foreach $aMannschaft (@mannschaften) {
##         push(@retVal,"Heim=${aMannschaft} OR Gast=${aMannschaft}");
##     }
##     return @retVal;
## }

sub addSpezFilterSelector {
  my($filterName,$refNameList,$refValueList,$scriptName,$language,$refHiddenParameterHash) = @_;
  my(@nameList)    = @$refNameList;
  my(@valueList)   = @$refValueList;
  my(%hiddenParam) = %$refHiddenParameterHash;

  my $oldState        = getParam($filterName,"");
  my $loginUserId     = getParam("loginUserId","");
  my $loginPassword   = getParam("loginPassword","");
  my $sortedBy        = getParam("SortedBy",$initialSortClause);   # STE
  my $loginAction     = getParam("loginAction","");
  ### STE my($externalParam)  = getParam("externalParam","");
  my $strAll          = setDefault($strAll,getLangStr("strAll"));

print <<javaScript;
<script language="JavaScript">
<!-- Hide Script from older Browsers.

 function beforeSend${filterName}(aForm) {
   aForm.${filterName}.value = aForm.WhereClause.options[aForm.WhereClause.selectedIndex].value;
   aForm.submit();
 }
// End the hiding here. -->
</SCRIPT>

<FORM Name="Filter_${filterName}" onSubmit="beforeSend${filterName}(this)" METHOD=POST ACTION=${scriptName}>
<SELECT NAME="WhereClause" size="1" onChange="beforeSend${filterName}(this.form)">
    <OPTION VALUE="">${strAll}
javaScript



## print("oldState:${oldState}:\n");
my($count)     = 0;

foreach $name (@nameList) {
   if ($valueList[$count] ne $oldState) {
     print("<OPTION VALUE=\"$valueList[$count]\">$name\n");
   } else {
     print("<OPTION VALUE=\"$valueList[$count]\" SELECTED>$name\n");
   }
   $count++;
}
print <<javaScript1;
</SELECT>
<INPUT TYPE=HIDDEN NAME="${filterName}"  VALUE="">

<INPUT TYPE=HIDDEN NAME="language"       VALUE="${language}">
<INPUT TYPE=HIDDEN NAME="loginAction"    VALUE="">
<INPUT TYPE=HIDDEN NAME="loginUserId"    VALUE="${loginUserId}">
<INPUT TYPE=HIDDEN NAME="loginPassword"  VALUE="${loginPassword}">
<INPUT TYPE=HIDDEN NAME="SortedBy"       VALUE="${sortedBy}">
<INPUT TYPE=HIDDEN NAME="loginAction"    VALUE="${loginAction}">
<INPUT TYPE=HIDDEN NAME="externalParam"  VALUE="${externalParam}">
javaScript1

 my(@aKeyList) = keys %hiddenParam;
 my($aKey)     = "";
 foreach $aKey (@aKeyList) {
   printf("<INPUT TYPE=HIDDEN NAME=\"%s\"  VALUE=\"%s\">\n",$aKey,$hiddenParam{$aKey});

 }
 print("</FORM>\n");
}


# e.g.
## $aWhereClause = "'Heim like ' + %s + ' OR Gast starts ' + %s";
## addSpezFilterTextbox("MannschaftsSelector",$myCgiFormName,$language,$aWhereClause);
##
sub addSpezFilterTextbox {
  my($filterName,$scriptName,$language,$whereClause,$whereClauseCaseInsensitv,$defaultToggleSet,$refHiddenParameterHash) = @_;

  my($oldValue)       = getParam($filterName,"");
  my($loginUserId)    = getParam("loginUserId",$loginUserId);
  my($loginPassword)  = getParam("loginPassword","");
  my($sortedBy)       = getParam("SortedBy",$initialSortClause);   # STE
  my($loginAction)    = getParam("loginAction","");
  ### STE  my($externalParam)  = getParam("externalParam","");

  my($strAll)             = setDefault($strAll,           getLangStr("strAll"));
  my($strSelect)          = setDefault($strSelect,        getLangStr("strSelect"));
  my($strCaseMatch)       = setDefault($strCaseMatch,     getLangStr("strCaseMatch"));
  $defaultToggleSet       = setDefault($defaultToggleSet, $TRUE);

  my(%hiddenParam)        = %$refHiddenParameterHash;

  $whereClause            =~ s/\%s/enteredValue/g;

  my($enableCaseToggle) = $FALSE;
  if ($whereClauseCaseInsensitv ne "") {
    $whereClauseCaseInsensitv =~ s/\%s/enteredValue/g;
    $enableCaseToggle = $TRUE;
  }


print <<javaScript;
<script language="JavaScript">
<!-- Hide Script from older Browsers.

 function beforeSend${filterName}(aForm) {
   var enteredValue = aForm.${filterName}.value;
javaScript
if ($enableCaseToggle) {
  print("   if (aForm.CaseSensitiv.checked) {\n");
  print("      aForm.WhereClause.value = ${whereClause};\n");
  print("   } else {\n");
  print("      aForm.WhereClause.value = ${whereClauseCaseInsensitv};\n");
  print("   }\n");
} else {
  print("   //no CaseToggle \n");
  print("   aForm.WhereClause.value = ${whereClause};\n");
}
print <<javaScript1;
   aForm.submit();
 }

 function clear${filterName}(aForm) {
   aForm.${filterName}.value = '';
   beforeSend${filterName}(aForm);
 }

// End the hiding here. -->
</SCRIPT>

<FORM Name="Filter_${filterName}" onSubmit="beforeSend${filterName}(this)" METHOD=POST ACTION=${scriptName}>
<INPUT TYPE=TEXT name="${filterName}" value="${oldValue}">

<INPUT TYPE=HIDDEN NAME="WhereClause"    VALUE="">
<INPUT TYPE=HIDDEN NAME="language"       VALUE="${language}">
<INPUT TYPE=HIDDEN NAME="loginAction"    VALUE="${loginAction}">
<INPUT TYPE=HIDDEN NAME="loginUserId"    VALUE="${loginUserId}">
<INPUT TYPE=HIDDEN NAME="loginPassword"  VALUE="${loginPassword}">
<INPUT TYPE=HIDDEN NAME="SortedBy"       VALUE="${sortedBy}">
<INPUT TYPE=HIDDEN NAME="loginAction"    VALUE="${loginAction}">
<INPUT TYPE=HIDDEN NAME="externalParam"  VALUE="${externalParam}">
<INPUT TYPE=SUBMIT NAME=submitted        VALUE="${strSelect}">
<INPUT TYPE=BUTTON                       VALUE="${strAll}" onClick=clear${filterName}(this.form)><BR>
javaScript1
if ($enableCaseToggle) {
  if ($defaultToggleSet) {
     print("<INPUT TYPE=CHECKBOX NAME=CaseSensitiv CHECKED> ${strCaseMatch}\n");
  } else {
     print("<INPUT TYPE=CHECKBOX NAME=CaseSensitiv> ${strCaseMatch}\n");
  }
}
my(@aKeyList) = keys %hiddenParam;
my($aKey)     = "";
foreach $aKey (@aKeyList) {
   printf("<INPUT TYPE=HIDDEN NAME=\"%s\"  VALUE=\"%s\">\n",$aKey,$hiddenParam{$aKey});

}
print("</FORM>\n");
}

# e.g.
##  if (!(((index($action,"For") == 0) || ($action eq "ShowDetail")))) {
##    @searchFieldNames = ("Name","Vorname","email","plz","Ort");
##    print("Suchen nach...<BR>\n");
##    addSpezFilterSearchBox("SearchFilter",$myCgiFormName,$language,\@searchFieldNames,"like",$TRUE);
##  }
sub addSpezFilterSearchBox {
  my($filterName,$scriptName,$language,$refToFieldNames,$oparator,$enableCaseToggle,$refHiddenParameterHash) = @_;
  $enableCaseToggle  = setDefault($enableCaseToggle, $TRUE);
  $oparator          = setDefault($oparator,         "starts");

  my($defaultToggleSet) = $FALSE;
  if ($oparator eq lc($oparator)) {
     $defaultToggleSet = $TRUE;
  } else {
     if ($enableCaseToggle) {
        $oparator = lc($oparator);
     }
  }

  $oparator2 = uc($oparator);
  my($aFieldName)    = "";
  my($aWhereClause)  = "";
  my($aWhereClause2) = "";
  my(@fieldNames)    = derefAref($refToFieldNames);
  foreach $aFieldName (@fieldNames) {
     if ($aWhereClause eq "") {
        $aWhereClause = "\'${aFieldName} ${oparator} \' + %s";
     } else {
        $aWhereClause = "${aWhereClause} + \' OR ${aFieldName} ${oparator} \' + %s";
     }

     if ($enableCaseToggle) {
       if ($aWhereClause2 eq "") {
          $aWhereClause2 = "\'${aFieldName} ${oparator2} \' + %s";
       } else {
          $aWhereClause2 = "${aWhereClause2} + \' OR ${aFieldName} ${oparator2} \' + %s";
       }
     }
  }
  addSpezFilterTextbox($filterName,$scriptName,$language,$aWhereClause,$aWhereClause2,$defaultToggleSet,$refHiddenParameterHash);
}

# -----------------------------------------------------------------------------
# function to log actions
# -----------------------------------------------------------------------------
$logSepChar         = ";";
$logWithWeekday     = $TRUE;
$logUseMonthByName  = $TRUE;
$logLanguage        = $language;

sub writeIntoLog {
  my($logFileName,$logStr) = @_;
  if ($logFileName ne "") {
     if (!open(OUTFILE_writeIntoLog, ">>${logFileName}")) {
        print("<!-- Could not open logfile:${logFileName} -->\n");
     } else {
        close(OUTFILE_writeIntoLog);
        my($timeStamp) = formatTimeStamp(getTimeStamp (),"",$logWithWeekday,$logUseMonthByName,$logLanguage);
        appendLine($logFileName,"${timeStamp}${logSepChar}${logStr}");
     }
  }
}
# -----------------------------------------------------------------------------
# function to convert JavaScript Menutrees in both directions *.txt <---> *.js
# -----------------------------------------------------------------------------
# Creates a text file out of a JS menu tree. This file can also be used by
# the menu editor running on Windows. That function is used for reverse engineering.
sub JSmenuToText {
 my ($JSmenuFileName,$outTxtFileName,$delimeter) = @_;
 my ($i) ;
 $delimeter = setDefault($delimeter, "|");
 (@records) =  readFile($JSmenuFileName);
 open(FILE_JSmenuToText,"> $outTxtFileName"); 
 for ($i=1 ; $i <= $#records; $i++){ 
   $found = 0;
   for ($j = 0; $j <= $#records; $j++) {
     $MenuArrName = "arMenu${i}"; 
     if ($records[$j] =~ /$MenuArrName /) { # not perfect
      $found = 1;
      aJSmenuToText_Hidden($j,$i,1,"     ",1,$delimeter,FILE_JSmenuToText);
     }
   }
   if (!$found) {
    $i = $#records;
   }
  }
  close(FILE_JSmenuToText);
}

# Creates the JS menu tree used for HierMenu out of a text file
sub BuildMenuTreeJS {
  my($MenuFileName,$JSoutFileName,$separator) = @_; 
  my ($j) = 0;
  my ($level) = "";
  my (@pair) = ();
  my ($FirstMenuName) = 1;
  $separator = setDefault($separator, "\\|");
  (@records) =  readFileWithIncludes($MenuFileName,"","",$FALSE); 
  open(FILE_BuildMenuTreeJS,"> $JSoutFileName");
  for ($j = 0; $j <= $#records; $j++) { 
  ### print("Zeile######:$records[$j]:<BR>\n");
    @pair = split($separator, $records[$j]);
    $level = $pair[0];
    $text = $pair[1];
    $text = strip($text);
    if ($level == 0 && $level ne "") {
      BuildaJSMenu_Hidden($j,$FirstMenuName,1,$separator,FILE_BuildMenuTreeJS);
      $FirstMenuName ++;
    }
  }
  close (FILE_BuildMenuTreeJS);
}

# Creates the HTML menu tree out of a text file
sub BuildMenuTreeHTML {
  my($MenuFileName,$outputPath,$separator,$headerFileName,$footerFileName) = @_; 
  print("BuildMenuTreeHTML called with ${MenuFileName} ${outputPath}<BR>\n");

  
  # read header and footer
  my $headerLines = "";
  my $footerLines = "";
  if (isFileExists($headerFileName)) {
     $headerLines = makeStrFromArray("\n",readFile($headerFileName));
  }
  if (isFileExists($footerLines)) {
     $footerLines = makeStrFromArray("\n",readFile($footerLines));
  }
  
  # add Menutree
  my ($j) = 0;
  my ($level) = "";
  my (@pair) = ();
  $separator = setDefault($separator, "\\|");

  if (!($outputPath =~ /\/$/)) {
     $outputPath = "${outputPath}/";
  }

  my(@records) =  readFileWithIncludes($MenuFileName,"","",$FALSE);
  
  my $fileIsOpen = $FALSE;

  for (my $j = 0; $j <= $#records; $j++) { 
    
    my $aLine = $records[$j];   $aLine = strip($aLine);


    if (($aLine eq "") || ($aLine =~ /^#/)) { next; }
    my(@pair) = split($separator,$aLine);
    ## print("Line:${aLine}:\n");
    my $level = $pair[0];  $level = strip($level);
    my $text  = $pair[1];  $text  = strip($text); $text =~ s/\<BR\>/ /g;
    my $aLink = $pair[2];  $aLink = strip($aLink);
    ## print("level:${level}:  text:${text}:  aLink:${aLink}:\n");
    if ($level == 0) {
        if ($fileIsOpen) {
          print(FILE_BuildMenuTree "${footerLines}");
          close (FILE_BuildMenuTree);
          print("closed!<BR>\n");
          $fileIsOpen = $FALSE;
        }
        my $outFileName = "Menu_${text}.html";
        print("Open Filename ${outputPath}${outFileName}....");
        open(FILE_BuildMenuTree,">${outputPath}${outFileName}");
        print(FILE_BuildMenuTree "${headerLines}");
        $fileIsOpen = $TRUE;
    } else {
        for (my $k = 0; $k <= $level; $k++) {
          print(FILE_BuildMenuTree "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
        }
        if ($text ne "") {
          if ($aLink eq "") {
              print(FILE_BuildMenuTree "${text}<BR>\n");
          } else {
              print(FILE_BuildMenuTree "<A href='${aLink}'>${text}</A><BR>\n");
          }
        }

    }
  }
  if ($fileIsOpen) {
    print(FILE_BuildMenuTree "${footerLines}");
    close (FILE_BuildMenuTree);
    print("closed!<BR>\n");
    $fileIsOpen = $FALSE;
  }
}


# Hidden functions
# ----------------

sub getChildren_Hidden {
  my($parent, $separator) =@_;
  my (@children) =();
  my ($j) = 0;

  @pair = split($separator, $records[$parent]);
  $level = $pair[0];
 
  $i = $parent; 
  $done = 0; 
  
  if ($level == 0) {
    for ($j = ($parent + 1); $j <= $#records; $j++) {
     my (@pair) = split($separator, $records[$j]);
     my ($level) = $pair[0];
     if ($level == 1){
        @children = (@children, $j);
     } elsif ( $level == 0) {
        return @children ; 
     }
    } 
    return @children;
  } 

  while(!$done) {  
    $i++; 
    @pair2 = split($separator, $records[$i]);
    $nextRecordLevel = $pair2[0];
    if ( $nextRecordLevel == ( $level +1)) {
      @children = (@children, $i);
    } elsif($nextRecordLevel == $level || $i == $#records || $nextRecordLevel eq "") {
      $done = 1;
    }  
  }
  return @children;
}

sub BuildaJSMenu_Hidden {
  my($parent,$level,$root,$separator,$fh) = @_;
  my(@children) = ();
  my(@tmp)      = ();
  my($i)        = 0;
  my(@pair)     = ();
  @children = getChildren_Hidden($parent,$separator); 
  print $fh ("arMenu$level = new Array  (\n");
  if ($root ne "") {
    my($i);
    my @pair = split($separator, $records[$parent]);
    #displayArray(@pair);

    for( $i=2; $i <= 10; $i++){
       $pair[$i] = strip($pair[$i]);
       if ($i != 2 && $i != 3 && $i != 4) {
         $pair[$i] = "\"$pair[$i]\"";
       }
       print $fh "$pair[$i],";
       if ( $i == 2 || $i == 4 || $i == 6 || $i == 8) {
         print $fh "\n";
       }
     } 
     print $fh "\n";
  }

  for ($j = 0; $j <= $#children; $j++){
   $child = $children[$j];
   @pair = split($separator, $records[$child]);
   $text = $pair[1];
   $link = $pair[2];
   $link = strip($link); 
   $text = strip($text);
   print $fh ("\"$text\",\"$link\",");

   if (getChildren_Hidden($child,  $separator)) {
     print $fh ("1");
   } else {
     print $fh ("0");
   }
   if ($j != $#children) {
     print $fh (",\n");
   } else {
     print $fh "\n";
   }
  }
  print $fh ")\n\n";
  $i =0;
  foreach $child (@children) {
    @tmp = getChildren_Hidden($child, $separator);
    $i++;
    if(@tmp) {
      $newlevel = "${level}_${i}";
      BuildaJSMenu_Hidden($child,$newlevel,"",$separator,$fh); 
    }
  }
}


sub getChlidIndex_Hidden {
  my($MenuArrName) = @_;
  my ($j) = 0;
  for ($j = 0; $j <= $#records; $j++) {
   if ($records[$j] =~ /$MenuArrName /) {
     return $j;
   }
  }
}

sub aJSmenuToText_Hidden {
  my ($parent,$level,$root,$blanks,$Menulevel,$delimeter,$fh) = @_;
  my ($j)            = 0;
  my ($WholeRecord)  = "";
  my ($k)            = 0;
  my ($start)        = "";
  my (@RecordParts)  = ();
  my ($childcount)   = 1;
  my ($childIndex)   = -1;
  my ($newMenulevel) = 0;

  if ($root) {
     my ($i)      = 0;
     my ($top)    = "";
     my ($topStr) = "";
     print $fh "\n\n0${delimeter}";
     for ( $i= $parent ; $i < ($parent + 6); $i++) {
        if ($i == $parent) {
           $char = '\(';
           @tmpName = split ($char, $records[$parent]);
           my $MenuName  = (split("=", $tmpName[0]))[0];  
           $MenuName = strip($MenuName);
           $MenuName =~ s/\"//g;
           print $fh "${MenuName}${delimeter}";
        } elsif ($i == $parent + 1 ) {
           $topStr = $records[$i];
           $topStr  =~ s/\,//g;
           $topStr  =~ s/\"//g;        
           print $fh "$topStr${delimeter}";
        } else {
           my (@tmp) = split (",",$records[$i]);
           $topPart =  "$tmp[0]${delimeter}$tmp[1]${delimeter}";    
           $topPart =~ s/\"//g;
           print $fh "$topPart";
        }
    }
    $top  =~ s/\"//g; 
    print $fh "$top\n";
    $start = ($parent + 6);
  } else {
    $start = $parent+ 1;
  }


  for ($k =  $start; $k < $#records; $k++) {
      if ($records[$k] eq "" || $records[$k] eq ")" || $records[$k] =~ /^\s*$/) {
        $k = $#records;
        next;
      }
     
      my @tmp = split(",", $records[$k]);
      #displayArray(@tmp); 
      $name = $tmp[0];
      $link = "";
      for ($i = 1; $i< $#tmp  ; $i++) {
            if($link eq "") {
              $link = $tmp[$i];
            } else {
              $link = sprintf("%s,%s",$link,$tmp[$i]); ##WR satisfied compiler old: $link = "${link},${tmp[$i]}";
            }
      } 
      $name = strip($name); 
      $link = strip( $link);
      $link =~ s/^\"//;
      $link =~ s/\"$//;
      $link = strip( $link);
      $name =~ s/\"//g;
      #$link =~ s/\"//g;
      if ($link ne "") {
         $link = "${delimeter}  $link";
      } 
      print FILE_JSmenuToText ("${Menulevel}${delimeter}$blanks $name $link\n");
      #print FILE_JSmenuToText ("${Menulevel}${delimeter}$blanks $name \n");
      $chilIndex = getChlidIndex_Hidden("arMenu${level}_$childcount"); 
      if ($chilIndex >  0) {
        $newlevel = "${level}_$childcount";
        $newblanks = "$blanks    ";
        $newMenulevel = $Menulevel + 1; 
        aJSmenuToText_Hidden($chilIndex,$newlevel,0,$newblanks,$newMenulevel,$delimeter,$fh); 
      } 
      $childcount++; 
  }
}

# -----------------------------------------------------------------------------
# function to convert Menutrees for hv-Menu *.txt <---> *.js
# -----------------------------------------------------------------------------
# Creates the HTML menu tree out of a text file
# 
# Inputfile
# ---------
#    #Level|Name|menuHight|menuWidth|NOP|bgColorNormal|bgColorOver|fgColorNormal|fgColorOver|borderColor|NOP
#    #
#    0|arMenu1|20|50|NOP|FFFFFF|000080|000080|FFFFFF|000000|NOP
#    1|   A1            | link_1
#    2|      A1_1       | link_1_1
#    2|      A1_2       | link_1_2
#    2|      A1_3       | link_1_3
#    3|      	A1_3_1   | link_1_3_1 | bgImage.gif
#    3|      	A1_3_2   | link_1_3_2
#    3|      	A1_3_3   | link_1_3_3
#    4|      	  A1_3_3_1   | link_1_3_3_1
#    4|      	  A1_3_3_2   | link_1_3_3_2
#    2|      A1_3       | link_1_3
#    1|   A2            | link_2
#    1|   A3            | link_3
#    1|   A4            | link_4
#    2|   		A4_1       | link_4_1
#    1|   A5            | link_5
#    2|   		A5_1       | link_5_1

# Output file
# -----------
#   var NoOffFirstLineMenus=5;
#        Menu1=new Array("A1","link_1","",3,20,50);
#           Menu1_1=new Array("A1_1","link_1_1","",0,20,50);
#           Menu1_2=new Array("A1_2","link_1_2","",0,20,50);
#           Menu1_3=new Array("A1_3","link_1_3","",3,20,50);
#              Menu1_3_1=new Array("A1_3_1","link_1_3_1","bgImage.gif",0,20,50);
#              Menu1_3_2=new Array("A1_3_2","link_1_3_2","",0,20,50);
#              Menu1_3_3=new Array("A1_3_3","link_1_3_3","",2,20,50);
#                 Menu1_3_3_1=new Array("A1_3_3_1","link_1_3_3_1","",0,20,50);
#                 Menu1_3_3_2=new Array("A1_3_3_2","link_1_3_3_2","",0,20,50);
#        Menu2=new Array("A2","link_2","",1,20,50);
#           Menu2_1=new Array("A1_3","link_1_3","",0,20,50);
#        Menu3=new Array("A3","link_3","",0,20,50);
#        Menu4=new Array("A4","link_4","",1,20,50);
#           Menu4_1=new Array("A4_1","link_4_1","",0,20,50);
#        Menu5=new Array("A5","link_5","",1,20,50);
#           Menu5_1=new Array("A5_1","link_5_1","",0,20,50);
        
sub BuildMenuTreeJS_forHvMenu {
  my($menuFileName,$outFileName,$separator) = @_; 
  $separator   = setDefault($separator,   "\\|");
  $outFileName = setDefault($outFileName, setNewFilenameExtension($menuFileName,"js"));
  
  $hvMenu_header = qq {
//	MenuX=new Array(
//              Text to show,
//              link,
//              background image (optional),
//              number of sub elements,
//              height,
//              width);
//	For rollover images set "Text to show" to:  "rollover:Image1.jpg:Image2.jpg"	
   };

  # read Menutree file
  # ==================
  my $j      = 0;
  my $level  = "";
  my @pair   = ();
  my @records    =  trimRemoveEmptiesAndCommentsInArray(readFileWithIncludes($menuFileName,"","",$FALSE));

  open(FILE_BuildMenuTree,">${outFileName}") || showError(sprintf("ERROR (BuildMenuTreeHTML_forHvMenu): Can't open file: %s : %s",$outFileName,$!));
  my $aLine = $records[0];
  my @pair = split($separator,$aLine);
  ## print("Line:${aLine}:\n");
  my $level = strip($pair[0]);
  if ($level != 0) {
     print("ERROR: must start with level 0!\n");
     return;
  }
  
  # process level 0
  # ===============
  my $menuHight     = strip($pair[2]);
  my $menuWidth     = strip($pair[3]);
  my $bgColorNormal = strip($pair[5]);
  my $bgColorOver   = strip($pair[6]);
  my $fgColorNormal = strip($pair[7]);
  my $fgColorOver   = strip($pair[8]);
  my $borderColor   = strip($pair[9]);
  
	print(FILE_BuildMenuTree "var LowBgColor       ='#${bgColorNormal}';			// Background color when mouse is not over\n");
	print(FILE_BuildMenuTree "var LowSubBgColor    ='#${bgColorNormal}';			// Background color when mouse is not over on subs\n");
	
	print(FILE_BuildMenuTree "var HighBgColor      ='#${bgColorOver}';			// Background color when mouse is over\n");
	print(FILE_BuildMenuTree "var HighSubBgColor   ='#${bgColorOver}';			// Background color when mouse is over on subs\n");
	
	print(FILE_BuildMenuTree "var FontLowColor     ='#${fgColorNormal}';			// Font color when mouse is not over\n");
	print(FILE_BuildMenuTree "var FontSubLowColor  ='#${fgColorNormal}';			// Font color subs when mouse is not over\n");
	
	print(FILE_BuildMenuTree "var FontHighColor    ='#${fgColorOver}';			// Font color when mouse is over\n");
	print(FILE_BuildMenuTree "var FontSubHighColor ='#${fgColorOver}';			// Font color subs when mouse is over\n");
	
	print(FILE_BuildMenuTree "var BorderColor      ='#${borderColor}';			// Border color\n");
	print(FILE_BuildMenuTree "var BorderSubColor   ='#${borderColor}';			// Border color for subs\n");
  
  # process menu entries
  # ====================
  # 1) parse file and fill structure
  my %initHash = (
     "menuNr"               => "",
     "level"                => "",
     "menuText"             => "",
     "link"                 => "",
     "countOfSubMenus"      => "",
  );
  
  my @menuTree = ();
  my $lastLevel = 100000;
  for (my $j=1; $j <= $#records; $j++) { 
    my $aLine = $records[$j];
    # print("Line $j:${aLine}:\n");
    my @pair = split($separator,$aLine);
    my %newRec = %initHash;
    $newRec{"level"}           = strip($pair[0]);
    $newRec{"menuText"}        = strip($pair[1]);  $newRec{"menuText"} =~ s/\<BR\>/ /g;
    $newRec{"link"}            = strip($pair[2]);
    $newRec{"bgImage"}         = strip($pair[3]);
    $newRec{"countOfSubMenus"} = 0;
    if (($newRec{"level"}     == $lastLevel) ||
        ($newRec{"level"}     == $lastLevel + 1) ||
        ($newRec{"level"} < $lastLevel)) {
          $lastLevel = $newRec{"level"};
    } else {
    	  print("ERROR: Wrong menuLevel (".$newRec{"level"}.") in line:${aLine}:\n");
    	  return;
    }
    push(@menuTree,\%newRec);    
  }
  
  # Display parsed records
  # ======================
  ## foreach my $oneRecRef (@menuTree) {
  ## 	 print($oneRecRef->{"level"}."   ".$oneRecRef->{"menuText"}."\n");
  ## }
  
  # 2) set Menunumber and count of sub menus recursivly
  my $j = 0;
  my $countOfTopMenus = getHvMenuChildrenHidden(\$j,"",@menuTree);	
  print(FILE_BuildMenuTree "// Created by littlePerlLib.pm (${libLatestVersion}) at ".formatTimeStamp(getTimeStamp())." ${menuFileName} --> ${outFileName}\n\n");
  print(FILE_BuildMenuTree "${hvMenu_header}\n");
  print(FILE_BuildMenuTree "var NoOffFirstLineMenus=${countOfTopMenus};\n");
  
  
  # write file
  # ==========
  foreach my $aRecRef (@menuTree) {
    my $menuNr           = $aRecRef->{"menuNr"};
    my $level            = $aRecRef->{"level"};
    my $menuText         = $aRecRef->{"menuText"};
    my $linkText         = $aRecRef->{"link"};
    my $countOfSubMenus  = $aRecRef->{"countOfSubMenus"};
    my $bgImage          = $aRecRef->{"bgImage"};
    my $levelStr = createMarker($level*3," "," ");
    
    ## Menu1_3_1=new Array("A1_3_1","link_1_3_1","bgImage.gif",0,20,50);
    print(FILE_BuildMenuTree "${levelStr} Menu${menuNr}=new Array(\"${menuText}\",\"${linkText}\",\"${bgImage}\",${countOfSubMenus},${menuHight},${menuWidth});\n");
  } 
  close (FILE_BuildMenuTree);
}

sub getHvMenuChildrenHidden {
  my($jRef,$levelCountStr,@menuTree) = @_; 
  
  my $countOfRecords = @menuTree;
  ## print("Count of records:${countOfRecords}:   levelCountStr:${levelCountStr}\n");

  my $countOfPeerMenus = 0;
  my $counter          = 1;
  my $parentRecord     = $$jRef;
  
  while($$jRef <= $countOfRecords) {
    my $recRef = $menuTree[$$jRef];
    my %rec    = %$recRef;
    ## print("\njRef:".$$jRef."\n");
    ## displayHashTable(%rec);
    
    
    my $countOfSubMenus  = 0;
    
    
    ## print("levelCountStr:${levelCountStr}:    counter:${counter}:    parentRecord:".$menuTree[$parentRecord]->{"level"}."   jRef_Level:".$menuTree[$$jRef]->{"level"}."\n");
    if ($menuTree[$parentRecord]->{"level"} > $menuTree[$$jRef]->{"level"}) {
    	## print("Exit because of new level -1\n");
      last;	
    }
    
    if ($menuTree[$parentRecord]->{"level"}  + 1 == $menuTree[$$jRef]->{"level"}) {
        ## print("recursive call on Line $$jRef\n");
        $counter--;
        my $dadyRecord = $$jRef-1;
        $menuTree[$dadyRecord]->{"countOfSubMenus"} = getHvMenuChildrenHidden($jRef,"${levelCountStr}_".$counter,@menuTree);
        $counter++;
        ## print(".. return from recursive call on Line $$jRef\n");
    } else {
    	  $menuTree[$$jRef]->{"menuNr"} = substr("${levelCountStr}_${counter}",1);
    	  $$jRef++;
    	  $countOfPeerMenus++;
    	  $counter++;
    }
  } # of while
  return $countOfPeerMenus;
}

# -----------------------------------------------------------------------------
# function for littlePerlLib itself
# -----------------------------------------------------------------------------
sub createLittlePerlLibWebDefinitions {
   my($tableFileName,$outFileName,$varPrefix) = @_;
   my($header) = getTableHeader($tableFileName);
   my(@headerParts) = ();
   my($sepChar)     = "";
   if (index($header,";") == -1) {
      @headerParts = split("\\|",$header);
      $sepChar     = "\|";
   } else {
      @headerParts = split(";",$header);
      $sepChar     = "\|";
   }
   my($aHeaderName) = "";   
   open(OUTFILE_createLittlePerlLibWebDefinitions,">$outFileName") || showError(sprintf("ERROR (createLittlePerlLibWebDefinitions): Can't open file: %s : %s",$outFileName,$!));

   #### printf("Max:%s\n",getLongestValFromArray(@headerParts));
   my($maxLen) = length(getLongestValFromArray(@headerParts)) + length($varPrefix) + 3;
   # create variables
   foreach $aHeaderName (@headerParts) {
        printf(OUTFILE_createLittlePerlLibWebDefinitions "\$%-${maxLen}s = \"${aHeaderName}\";\n","${varPrefix}${aHeaderName}");
   }
   print(OUTFILE_createLittlePerlLibWebDefinitions "\n\n");

   # create titles
   print(OUTFILE_createLittlePerlLibWebDefinitions "\%${varPrefix}Titles  = (\n");
   foreach $aHeaderName (@headerParts) {
        printf(OUTFILE_createLittlePerlLibWebDefinitions "      \$%-${maxLen}s => \"${aHeaderName}\",\n","${varPrefix}${aHeaderName}");
   }
   print(OUTFILE_createLittlePerlLibWebDefinitions ");\n\n");

   # create EditFieldFormat
   print(OUTFILE_createLittlePerlLibWebDefinitions "\%${varPrefix}EditFieldFormat  = (\n");
   foreach $aHeaderName (@headerParts) {
        printf(OUTFILE_createLittlePerlLibWebDefinitions "      \$%-${maxLen}s => \"30\",\n","${varPrefix}${aHeaderName}");
   }
   print(OUTFILE_createLittlePerlLibWebDefinitions ");\n\n");

   # create DisplayOrder
   print(OUTFILE_createLittlePerlLibWebDefinitions "\@${varPrefix}DisplayOrder  = (\n");
   foreach $aHeaderName (@headerParts) {
        printf(OUTFILE_createLittlePerlLibWebDefinitions "      \$%-${maxLen}s,\n","${varPrefix}${aHeaderName}");
   }
   print(OUTFILE_createLittlePerlLibWebDefinitions ");\n\n");

   # create SorterFields
   print(OUTFILE_createLittlePerlLibWebDefinitions "\@${varPrefix}SorterFields = (\n");
   foreach $aHeaderName (@headerParts) {
        printf(OUTFILE_createLittlePerlLibWebDefinitions "      \$%-${maxLen}s,\n","${varPrefix}${aHeaderName}");
   }
   print(OUTFILE_createLittlePerlLibWebDefinitions ");\n\n");

   # create AutofilterFileds
   print(OUTFILE_createLittlePerlLibWebDefinitions "\@${varPrefix}AutofilterFileds  = (\n");
   foreach $aHeaderName (@headerParts) {
        printf(OUTFILE_createLittlePerlLibWebDefinitions "      \$%-${maxLen}s,\n","${varPrefix}${aHeaderName}");
   }
   print(OUTFILE_createLittlePerlLibWebDefinitions ");\n\n");

   # create DeleteNotificationOrder
   print(OUTFILE_createLittlePerlLibWebDefinitions "\@${varPrefix}DeleteNotificationOrder  = (\n");
   foreach $aHeaderName (@headerParts) {
        printf(OUTFILE_createLittlePerlLibWebDefinitions "      \$%-${maxLen}s,\n","${varPrefix}${aHeaderName}");
   }
   print(OUTFILE_createLittlePerlLibWebDefinitions ");\n\n");

   # create EditFieldOrder
   print(OUTFILE_createLittlePerlLibWebDefinitions "\@${varPrefix}EditFieldOrder = (\n");
   foreach $aHeaderName (@headerParts) {
        printf(OUTFILE_createLittlePerlLibWebDefinitions "      \$%-${maxLen}s,\n","${varPrefix}${aHeaderName}");
   }
   print(OUTFILE_createLittlePerlLibWebDefinitions ");\n\n");

   # create SearchFields
   print(OUTFILE_createLittlePerlLibWebDefinitions "\@${varPrefix}searchFieldNames = (\n");
   foreach $aHeaderName (@headerParts) {
        printf(OUTFILE_createLittlePerlLibWebDefinitions "      \$%-${maxLen}s,\n","${varPrefix}${aHeaderName}");
   }
   print(OUTFILE_createLittlePerlLibWebDefinitions ");\n\n");

}


# produceHTMLDescription
# ----------------------
# History:
# 01/13/99    V1.0 Walter Rothlin     Initial Version
# 04/30/99    V1.1 Walter Rothlin     Stephan's Wunsch
# 25-May_2019 V1.2 Walter Rothlin     Replaced $comLine =~ s/ {//g;    by     $comLine =~ s/ \{//g;
#
# Description:
# ------------
# calls getDescriptionLines and formats the comment lines in a html file
sub produceHTMLDescription {
  my($inFileName,$outFileName)   = @_;
  my($comLine) = "";

  open(HTMLFILE_produceHTMLDescription,">${outFileName}") || showError(sprintf("ERROR (produceHTMLDescription): Can't open file: %s : %s",$outFileName,$!));
  print(HTMLFILE_produceHTMLDescription "<HTML>\n");
  print(HTMLFILE_produceHTMLDescription "<HEAD>\n");
  print(HTMLFILE_produceHTMLDescription " <TITLE>${inFileName}</TITLE>\n");
  printf (HTMLFILE_produceHTMLDescription " <!-- Uses %s-->\n",getLibDescription());
  print(HTMLFILE_produceHTMLDescription " <script language=\"JavaScript\">\n");
  print(HTMLFILE_produceHTMLDescription " <!-- Hide Script from older Browsers.\n");
  print(HTMLFILE_produceHTMLDescription " function jumpTo(url) {\n");
  print(HTMLFILE_produceHTMLDescription "   document.location = url;\n");
  print(HTMLFILE_produceHTMLDescription " }\n");
  print(HTMLFILE_produceHTMLDescription " // End the hiding here. -->\n");
  print(HTMLFILE_produceHTMLDescription " </SCRIPT>\n");
  print(HTMLFILE_produceHTMLDescription "</HEAD>\n");
  print(HTMLFILE_produceHTMLDescription "<BODY>\n");
  print(HTMLFILE_produceHTMLDescription "<FONT FACE=\"Courier\">\n");
  print(HTMLFILE_produceHTMLDescription "<H1>Description: ${inFileName} <FONT SIZE=-2><A HREF=\"#SOURCECODE\">(Source)</a></FONT></H1>\n");
  my($aField) = "";
  my(@subName) = getSubNames($inFileName);
  print(HTMLFILE_produceHTMLDescription "<a name=\"fncOver\"></A>\n");
  print(HTMLFILE_produceHTMLDescription "<TABLE><TR><TD>\n");
  print(HTMLFILE_produceHTMLDescription "Grouped by functionality<BR>\n");
  print(HTMLFILE_produceHTMLDescription "<FORM><SELECT size=\"4\" onChange='jumpTo(this.options[this.selectedIndex].value)'>\n");
  foreach $aField (@subName) {
     my($optionText) = $aField;
     print(HTMLFILE_produceHTMLDescription " <OPTION VALUE=\"#${aField}\">${optionText}\n");
  }
  print(HTMLFILE_produceHTMLDescription "</SELECT></FORM>\n");
  print(HTMLFILE_produceHTMLDescription "</TD><TD>\n");
  print(HTMLFILE_produceHTMLDescription "Sorted by Name<BR>\n");
  print(HTMLFILE_produceHTMLDescription "<FORM><SELECT size=\"4\" onChange='jumpTo(this.options[this.selectedIndex].value)'>\n");
  foreach $aField (sort (@subName)) {
     my($optionText) = $aField;
     print(HTMLFILE_produceHTMLDescription " <OPTION VALUE=\"#${aField}\">${optionText}\n");
  }
  print(HTMLFILE_produceHTMLDescription "</SELECT></FORM>\n");
  print(HTMLFILE_produceHTMLDescription "</TD></TR></TABLE>\n");


  my(@commentLines) = getDescriptionLines($inFileName);

  foreach $comLine (@commentLines) {
    $comLine =~ s/\</\&lt;/g;
    $comLine =~ s/\>/\&gt;/g;
    if ($comLine =~ /^\s*sub /) {
       ## print("${comLine}\n");
       $comLine =~ s/sub //g;
       $comLine =~ s/ \{//g;
       $comLine = strip($comLine);
       $comLine = "<a name=\"${comLine}\"></a><A HREF=\"#Source_${comLine}\"><B>${comLine}</B></A>&nbsp;&nbsp;&nbsp;<FONT SIZE=-2><A HREF=\"#fncOver\">OverView</A></FONT>";
       print(HTMLFILE_produceHTMLDescription "${comLine}<BR>\n");
    } elsif ($comLine =~ /^\s*return /) {
       ## print("${comLine}\n");
       $comLine = strip($comLine);
       $comLine = "  ${comLine}<BR>";
       printf (HTMLFILE_produceHTMLDescription "%s<BR>\n",repNullStr($comLine));
    } elsif ($comLine =~ /\@_;/) {
       ## print("${comLine}\n");
       $comLine = strip($comLine);
       if (!($comLine =~ /^#/)) {
          $comLine = "  ${comLine}";
       }
       printf (HTMLFILE_produceHTMLDescription "%s<BR>\n",repNullStr($comLine));
    } elsif ($comLine =~ /^#######/) {
       $comLine = "<HR>";
       printf (HTMLFILE_produceHTMLDescription "%s<BR>\n",repNullStr($comLine));
    } else {
       printf (HTMLFILE_produceHTMLDescription "%s<BR>\n",repNullStr($comLine));
    }
  }
  print(HTMLFILE_produceHTMLDescription "<a name=\"SOURCECODE\"></a>\n");
  print(HTMLFILE_produceHTMLDescription "<CENTER><BR><HR>SOURCE-CODE <FONT SIZE=-2><A HREF=\"#fncOver\">(Function-Overview)</A></FONT><HR><BR></CENTER><Font Size=-1>\n");
  open(TABFILE_produceHTMLDescription,$inFileName) || showError(sprintf("ERROR (produceHTMLDescription): Can't open file: %s : %s",$inFileName,$!));
  my(@subParts)   = ();
  while (defined($comLine = <TABFILE_produceHTMLDescription>)) {
    chomp($comLine);
    $comLine =~ s/\</\&lt;/g;
    $comLine =~ s/\>/\&gt;/g;
    if ($comLine =~ /^\s*sub /) {
        $comLine = strip($comLine);
        $comLine =~ s/\s+/ /g;
        @subParts = split(" ",$comLine);
        $comLine = "<a name=\"Source_$subParts[1]\">sub <B>$subParts[1]</B> {&nbsp;&nbsp;&nbsp;<FONT SIZE=-2><A HREF=\"#fncOver\">OverView</A></FONT>";
        print(HTMLFILE_produceHTMLDescription "${comLine}<BR>\n");
    } else {
        printf (HTMLFILE_produceHTMLDescription "%s<BR>\n",repNullStr($comLine));
    }
  } # end of while
  close(TABFILE_produceHTMLDescription);
  print(HTMLFILE_produceHTMLDescription "</FONT></BODY>\n");
  print(HTMLFILE_produceHTMLDescription "</HTML>\n");
  close(HTMLFILE_produceHTMLDescription);
}

# -----------------------------------------------------------------------------
# function parse web-Server log files (Access-Statistics)
# -----------------------------------------------------------------------------
sub parseLogEntry {
    my($aEntry)   = @_;
    my(%retVal)   = ();
    my($tmpEntry) = "";
    my(@parts_1)  = ();

    # prepare hostname and field2 and 3
    $tmpEntry = $aEntry;
    @parts_1 = split(" ",$tmpEntry);
    %retVal = (%retVal,("ClientNode",$parts_1[0]));
    %retVal = (%retVal,("Field_1",$parts_1[1]));
    %retVal = (%retVal,("Field_2",$parts_1[2]));

    # prepare Date / Time field
    $tmpEntry = $aEntry;
    $tmpEntry =~ s/\[/;/;
    $tmpEntry =~ s/\]/;/;
    @parts_1 = split(";",$tmpEntry);
    %retVal = (%retVal,("DateTime",$parts_1[1]));

    # remove all before time and date and date and time
    $tmpEntry = $aEntry;
    $tmpEntry =~ s/\]/______/;
    @parts_1  = split("______",$tmpEntry);
    my($restOfLine) = $parts_1[1];

    # prepare Methode and Requested URL
    $tmpEntry = $restOfLine;
    $tmpEntry =~ s/"//;
    $tmpEntry =~ s/"/______/;
    @parts_1 = split("______",$tmpEntry);
    my($urlPart) = $parts_1[0];

    my(@parts_2)  = split(" ",$urlPart);
    %retVal = (%retVal,("Methode",strip($parts_2[0])));

    my($anz) = 0; $anz = @parts_2;
    if ($anz >= 2) {
        my($reqURL_1) = strip($parts_2[1]);
        %retVal = (%retVal,("RequestedURL",$reqURL_1));
        $reqURL_1 =~ s/\?/______/g;
        my(@parts_3)  = split("______",$reqURL_1);
        %retVal = (%retVal,("RequestedURLWithNoParameter",$parts_3[0]));
        %retVal = (%retVal,("Protokoll",strip($parts_2[2])));
    } else {
        %retVal = (%retVal,("RequestedURL",""));
        %retVal = (%retVal,("RequestedURLWithNoParameter",""));
        %retVal = (%retVal,("Protokoll",""));
    }
    # remove url-Field
    $restOfLine = $parts_1[1];

    # prepare field7 and 8
    @parts_1 = split(" ",$restOfLine);
    %retVal = (%retVal,("Field_7",strip($parts_1[0])));
    %retVal = (%retVal,("Field_8",strip($parts_1[1])));

    # remove al before
    $tmpEntry = $restOfLine;
    $tmpEntry =~ s/"/______/;
    @parts_1 = split("______",$tmpEntry);
    $restOfLine = $parts_1[1];

    # prepare requester URL
    $tmpEntry = $restOfLine;
    $tmpEntry =~ s/" "/______/;
    @parts_1 = split("______",$tmpEntry);
    %retVal = (%retVal,("RequesterURL",$parts_1[0]));
    $tmpEntry = $parts_1[1];
    $tmpEntry =~ s/"//;
    %retVal = (%retVal,("RequesterDetails",$tmpEntry));

    # prepare requester Details
    $restOfLine = $parts_1[1];
    $tmpEntry = $restOfLine;
    ### print("tmpEntry:${tmpEntry}\n");
    if ($tmpEntry =~ /\[/) {
        $tmpEntry =~ s/\[/______/;
        $tmpEntry =~ s/\]/______/;
        @parts_1 = split("______",$tmpEntry);
        %retVal = (%retVal,("BrowserType",$parts_1[0]));
        %retVal = (%retVal,("Language",$parts_1[1]));
        $tmpEntry = $parts_1[2];
        $tmpEntry =~ s/"//;
        %retVal = (%retVal,("OS-Details",$tmpEntry));
    } else {
        $tmpEntry =~ s/"//;
        %retVal = (%retVal,("BrowserType",$tmpEntry));
        %retVal = (%retVal,("Language",""));
        %retVal  = (%retVal,("OS-Details",""));
    }
    return %retVal;
}

sub createLogEntry {
  my(%logHash)  = @_;
  my($logEntry) = "";
  my($tmpStr)   = "";
  $logEntry = $logHash{"ClientNode"};
  $tmpStr   = $logHash{"Field_1"};        $logEntry = "${logEntry} ${tmpStr}";
  $tmpStr   = $logHash{"Field_2"};        $logEntry = "${logEntry} ${tmpStr}";
  $tmpStr   = $logHash{"DateTime"};       $logEntry = "${logEntry} [${tmpStr}]";
  $tmpStr   = $logHash{"Methode"};        $logEntry = "${logEntry} \"${tmpStr}";
  if ($logHash{"RequestedURL"} ne "") {
    $tmpStr   = $logHash{"RequestedURL"}; $logEntry = "${logEntry} ${tmpStr}";
  }
  if ($logHash{"Protokoll"} ne "") {
    $tmpStr   = $logHash{"Protokoll"};    $logEntry = "${logEntry} ${tmpStr}\"";
  } else {
    $logEntry = "${logEntry}\"";
  }
  $tmpStr   = $logHash{"Field_7"};        $logEntry = "${logEntry} ${tmpStr}";
  $tmpStr   = $logHash{"Field_8"};        $logEntry = "${logEntry} ${tmpStr}";
  $tmpStr   = $logHash{"RequesterURL"};   $logEntry = "${logEntry} \"${tmpStr}\"";
  $tmpStr   = $logHash{"BrowserType"};    $logEntry = "${logEntry} \"${tmpStr}";

  if ($logHash{"Language"} ne "") {
     $tmpStr   = $logHash{"Language"};    $logEntry = "${logEntry}\[${tmpStr}\]";
     $tmpStr   = $logHash{"OS-Details"};  $logEntry = "${logEntry}${tmpStr}\"";
  } else {
     $logEntry = "${logEntry}\"";
  }
  return $logEntry;
}

sub verifyPasing {
  my($fullLogFileName) = @_;
  open(INFILE_verifyPasing,$fullLogFileName) || showError(sprintf("Error (verifyPasing): Can't open file: %s : %s",$fullLogFileName,$!));
  while (defined ($aLine = <INFILE_verifyPasing>)) {
    chomp($aLine);
    %anEntry = parseLogEntry($aLine);
    $aEntryStr = createLogEntry(%anEntry);
    %anEntry = stripHashValues($FALSE,%anEntry);
    ### displayHashTableSpezial(%anEntry);
    ### print("\n");
    if ($aLine ne $aEntryStr) {
      print("\n\n\nFound differences\n");
      print("\n");
      print("Old:${aLine}::\n");
      print("New:${aEntryStr}::\n\n");
    }
  }
  close(INFILE_verifyPasing);
}

sub writeNiceServerLogfile {
   my($logFileName,$outFilename,$sepChar,$withGifs,$doTrace,@fieldNames) = @_;
   open(INFILE_writeNiceServerLogfile,"${logFileName}") || showError(sprintf("Error (writeNiceServerLogfile): Can't open input-file: %s : %s",$logFileName,$!));
   open(OUTFILE_writeNiceServerLogfile,">${outFilename}") || showError(sprintf("Error (writeNiceServerLogfile): Can't open output-file: %s : %s",$outFilename,$!));
   print(OUTFILE_writeNiceServerLogfile "# LogFileDate:${yearMonthStr}\n");
   printf(OUTFILE_writeNiceServerLogfile unterstreichen(sprintf("Produced by writeNiceServerLogfile at %s",formatTimeStamp(getTimeStamp(),"", $TRUE, $TRUE, $LangEnglish)),"=","# "));
   my($reqField) = "";
   my($count)    = 0;
   foreach $reqField (@fieldNames) {
      print(OUTFILE_writeNiceServerLogfile "${reqField}${sepChar}");
   }
   print(OUTFILE_writeNiceServerLogfile "Hash${sepChar}\n");
   while (defined ($aLine = <INFILE_writeNiceServerLogfile>)) {
         chomp($aLine);     ## $anEntry{"RequestedURLWithNoParameter"}
         if (($withGifs) ||
             ((index($aLine,".gif") < 0) &&
              (index($aLine,".GIF") < 0) &&
              (index($aLine,".jpg") < 0) &&
              (index($aLine,".JPG") < 0) &&
              (index($aLine,".class") < 0) &&
              (index($aLine,".js") < 0))
            ) {
            %anEntry = parseLogEntry($aLine);
            %anEntry = stripHashValues($FALSE,%anEntry);
            foreach $reqField (@fieldNames) {
              printf(OUTFILE_writeNiceServerLogfile "%s${sepChar}",$anEntry{$reqField});
            }
            print(OUTFILE_writeNiceServerLogfile "${count}${sepChar}\n");
            $count++;
            if ($doTrace && (($count % 200) == 0)) { print("Processed: ${count}\n"); }
         }
   }
   close(INFILE_writeNiceServerLogfile);
   close(OUTFILE_writeNiceServerLogfile);
}

sub writeHitsStatisticFile {
  my($inFileName,$outFileName,$limit,$sepChar,$doTrace) = @_;
  my($count)    = 0;
  open(OUTFILE_writeHitsStatisticFile,">${outFileName}") || showError(sprintf("Error (writeHitsStatisticFile): Can't open output-file: %s : %s",$outFileName,$!));
  print(OUTFILE_writeHitsStatisticFile "# LogFileDate:${yearMonthStr}\n");
  printf(OUTFILE_writeHitsStatisticFile unterstreichen(sprintf("Produced by writeHitsStatisticFile at %s",formatTimeStamp(getTimeStamp(),"", $TRUE, $TRUE, $LangEnglish)),"=","# "));
  if ($doTrace) { print("starting getColumnValues...\n"); }
  my(@aArray) = getColumnValues($inFileName,$sepChar,"RequestedURLWithNoParameter","","RequestedURLWithNoParameter",$FALSE);
  if ($doTrace) { print("starting countApperanceOfNames...\n"); }
  %aHash = countApperanceOfNames($TRUE,$TRUE,$modToOnlyFirstUpperCase,@aArray);
  if ($doTrace) { print("starting getKeyListForSortedValuesInHash...\n"); }
  my(@sortedNameList) = getKeyListForSortedValuesInHash($TRUE,%aHash);
  my($aName) = "";
  print(OUTFILE_writeHitsStatisticFile "RequestedURLWithNoParameter${sepChar}Hits${sepChar}Hash${sepChar}\n");
  foreach $aName (@sortedNameList) {
   if ($aHash{$aName} >= $limit) {
     printf (OUTFILE_writeHitsStatisticFile "${aName}${sepChar}%s${sepChar}${count}${sepChar}\n",$aHash{$aName});
         $count++;
     if ($doTrace && (($count % 10) == 0)) { print("Processed: ${count}\n"); }
   }
  }
  close(OUTFILE_writeHitsStatisticFile);
}

sub writeIPStatisticFile {
  my($inFileName,$outFileName,$limit,$sepChar,$doTrace) = @_;
  my($count)    = 0;
  open(OUTFILE_writeIPStatisticFile,">${outFileName}") || showError(sprintf("Error (writeIPStatisticFile): Can't open output-file: %s : %s",$outFileName,$!));
  print(OUTFILE_writeIPStatisticFile "# LogFileDate:${yearMonthStr}\n");
  printf(OUTFILE_writeIPStatisticFile unterstreichen(sprintf("Produced by writeIPStatisticFile at %s",formatTimeStamp(getTimeStamp(),"", $TRUE, $TRUE, $LangEnglish)),"=","# "));
  if ($doTrace) { print("starting getColumnValues...\n"); }
  my(@aArray) = getColumnValues($inFileName,$sepChar,"ClientNode","","ClientNode",$FALSE);
  if ($doTrace) { print("starting countApperanceOfNames...\n"); }
  %aHash = countApperanceOfNames($TRUE,$TRUE,$modToOnlyFirstUpperCase,@aArray);
  my(@sortedNameList) = getKeyListForSortedValuesInHash($TRUE,%aHash);
  my($aName) = "";
  print(OUTFILE_writeIPStatisticFile "ClientNode${sepChar}Hits${sepChar}Hash${sepChar}\n");
  foreach $aName (@sortedNameList) {
    if ($aHash{$aName} >= $limit) {
      printf (OUTFILE_writeIPStatisticFile "${aName}${sepChar}%s${sepChar}${count}${sepChar}\n",$aHash{$aName});
      $count++;
    }
  }
  close(OUTFILE_writeIPStatisticFile);
}

sub getYearDateFromFileName {
  my($fileName)    = @_;
  my($yearDateStr) = $fileName;
  $yearDateStr =~ s/access_log_/______/g;
  $yearDateStr =~ s/\./______/g;
  my(@parts)   = split("______",$yearDateStr);
  return $parts[1];
}

sub prepareLogfile {
  my($directory,$logFileName,$sepChar,$myTitle,$doVerify,$doTrace,$phase,$urlLimit,$ipLimit) = @_;

  my($yearMonthStr) = getYearDateFromFileName($logFileName);
  if ($directory ne "") {
     $directory = "${directory}/";
  }
  printf(unterstreichen("${myTitle} (${yearMonthStr})","="));
  if ($doVerify) {
    print("--> Verify Parsing\n");
    verifyPasing("${directory}${logFileName}");
  }

  my($structLogFileName) = "${directory}Done_${logFileName}.niceLog";

  if (($phase eq "1") || ($phase eq "")){
    print("--> Create structured logfile:${structLogFileName}\n");
    my(@reqfieldNames) = ("ClientNode","DateTime","RequestedURLWithNoParameter");
    writeNiceServerLogfile("${directory}${logFileName}",$structLogFileName,$sepChar,$FALSE,$doTrace,@reqfieldNames);
  }

  if (($phase eq "2") || ($phase eq "")) {
    my($hitsFileName) = "${directory}Done_${logFileName}.hits";
    print("--> Create hits file:${hitsFileName}\n");
    writeHitsStatisticFile($structLogFileName,$hitsFileName,$urlLimit,$sepChar,$doTrace);

    my($ipFileName) = "${directory}Done_${logFileName}.clientNodes";
    print("--> Create Client-Nodes file:${ipFileName}\n");
        print("structLogFileName:${structLogFileName}:<BR>\n");
        print("ipFileName:${ipFileName}:<BR>\n");
        print("ipLimit:${ipLimit}:<BR>\n");
        print("sepChar:${sepChar}:<BR>\n");
        print("doTrace:${doTrace}:<BR>\n");
    writeIPStatisticFile($structLogFileName,$ipFileName,$ipLimit,$sepChar,$doTrace);
  }
}

# definitions used for log-File parsing
%logFileHitsTitles = (
         "Hash"                               => "Hash",
         "RequestedURLWithNoParameter"        => "Dokument",
         "Hits"                               => "Hits",
         );
@logFileHitsDisplayOrder = ("RequestedURLWithNoParameter","Hits");

%logFileNodesTitles = (
         "Hash"              => "Hash",
         "ClientNode"        => "Client Nodes",
         "Hits"              => "Hits",
         );
@logFileNodesDisplayOrder = ("ClientNode","Hits");

# *****************************************************************************
# functions to use together with a Java-Applet
# *****************************************************************************

# --------------------------------------------------------------
# News-Applet
# --------------------------------------------------------------
# 
# use getLatestPublishedRecord() to get a msg from a flt file
#
sub formatTextForNewsApplet {
	my($text) = @_;
	$text =~ s/\<BR\>/\<N\>/g;

	$text =~ s/\<A HREF/\<L/g;
	$text =~ s/\<a href/\<L/g;

	$text =~ s/\<\/A\>/\<\/L\>/g;
	$text =~ s/\<\/a\>/\<\/L\>/g;

	return $text;
}

sub formatTextForNewsLED_Applet {
	my($text) = @_;
	$text =~ s/\<BR\>/\n/g;

	return $text;
}

# -----------------------------------------------------------------------------
# Bar-Chart     (needs the following *.class files: Chart.class)
# -----------------------------------------------------------------------------
# displayBarChart
# ---------------
# Displays some Value - Name pairs in a Barchart using an Java-Applet
# The %valuePairs hash has to look like:
#     %valuePairs = (
#      "1:10" => "Label 1",
#      "2:15" => "Label 2",
#      "3:15" => "Label 3",
#      "4:25" => "Label 4",
# );
#
# displayBarChart("http://www.sauterinformatik.ch/JavaClasses/BarChart","500","",$aTitle,"","",%valuePairs);
#
# If $height or $scale is not defined they will be calculated.
# The bar colors are alternated take out of the list defined
#   @colorList   = ("green","blue","pink","orange","magenta","cyan","white","yellow","gray");
#
sub displayBarChart {
	my($codeBase,$width,$height,$title,$scale,$striped,%valuePairs) = @_;

	my $definedColors = @colorList;
	if ($definedColors == 0) {
		@colorList   = ("green","blue","pink","orange","magenta","cyan","white","yellow","gray");
	}
	my @values = keys %valuePairs;
	my $count     = 1;
	my $barCounts = 0; $barCounts = @values;

	my $maxLabelStrLength = getMaxStrLengthFromHash($TRUE,$TRUE,%valuePairs);
	my $maxValue          = getMaxKeyValue(%valuePairs);
	if ($scale eq "") {
		$scale = trunc(($width - ($maxLabelStrLength * 10) - 0) / $maxValue);
	}
	if ($title ne "") {
		$height  = setDefault($height, (($barCounts + 1)*22) + 14);
	} else {
		$height  = setDefault($height, ($barCounts *22) + 14);
	}
	$striped = setDefault($striped,$FALSE);

	print("<applet codebase=\"${codeBase}\" code=\"Chart.class\" width=${width} height=${height}>\n");
	print("<param name=title value=\"${title}\">\n");
	print("<param name=orientation value=\"horizontal\">\n");
	print("<param name=scale value=\"${scale}\">\n");
	print("<param name=columns value=\"${barCounts}\">\n");


	foreach my $aValue (sort @values) {
		if ($striped) {
			print("<param name=c${count}_style value=\"striped\">\n");
		} else {
			print("<param name=c${count}_style value=\"solid\">\n");
		}
		printf("<param name=c${count}_color value=\"%s\">\n",getColorString($count,@colorList));
		printf("<param name=c${count}_label value=\"%s\">\n",$valuePairs{$aValue});
		my @keyParts = split(":",$aValue);
		printf("<param name=c${count} value=\"%s\">\n",$keyParts[1]);
		$count++;
	}
	print("</applet>\n");
}

sub getMaxKeyValue {
	my(%valuePairs) = @_;
	my $maxVal  = -10000000;
	my @allKeys = keys %valuePairs;

	foreach my $aKey (@allKeys) {
		my(@keyParts) = split(":",$aKey);
		if ($keyParts[1] > $maxVal) { $maxVal = $keyParts[1]; }
	}
	return $maxVal;
}

sub getColorString {
	my($colorCount,@colorList)  = @_;
	$colorCount--;
	my $maxColorInd = @colorList;
	return $colorList[$colorCount % $maxColorInd];
}

# getValuesForChart
# -----------------
#
sub getValuesForChart {
	my($fileName,$sepChar,$valueFieldName,$lableFieldName,$locWhereClause,$sortedBy,$distinct)   = @_;
	my @displayValuesList = getColumnValues($fileName,$sepChar,"${valueFieldName};${lableFieldName}",$locWhereClause,$sortedBy,$distinct);

	my %retValue   = ();
	my $count      = 1;
	foreach my $valuesListEntry (@displayValuesList) {
		my(@locParts) = split($sepChar,$valuesListEntry);
		%retValue = (%retValue,(sprintf("%s:%s",$count,$locParts[0]),$locParts[1]));
		$count++;
	}
	return %retValue;
}

# *****************************************************************************
# functions which uses other Perl modules
# *****************************************************************************

# returns YYYYMMDDHHMMSS or $ERROR
#
## use LWP::UserAgent;
## use HTTP::Request;
sub getModDateViaHttpHeader {
   my($url) = @_;
   ## $url    = URI::Heuristic::uf_urlstr($url);
   my $userAgent  = LWP::UserAgent->new();
   my $answer     = $userAgent->request(HTTP::Request->new("HEAD",$url));
   my $retStr     = "";
   if ($answer->is_success) {
      my $lDate = $answer->last_modified;
      $retStr = sprintf("%s%s",getModDate($lDate),getModTime($lDate));
   } else {
      displayError("Error accessing :${url}:\n");
      $retStr = $ERROR;
   }
   return $retStr;
}

# returns filecontent or $ERROR
#
## use LWP::Simple;
sub getHttpSimple {
    my($url,$saveFileName,$printIt,$verbal) = @_;
    $printIt = setDefault($printIt,$FALSE);
    $verbal  = setDefault($verbal ,$TRUE);
    my $retStr  = "";
    my $content = "";

    unless (defined ($content = LWP::Simple::get($url))) {
        if ($verbal) { displayError("Error accessing :${url}:\n"); }
        $retStr = $ERROR;     
    } else {
        $retStr = $content;
        if ($saveFileName ne "") {
          open(TEMPFILE_getHttpSimple,">${saveFileName}") || showError("Error (getHttpSimple): Can't open file : ${saveFileName}   $!");
          print(TEMPFILE_getHttpSimple "${retStr}");
          close(TEMPFILE_getHttpSimple);
        }
        if ($printIt) {
          print("${retStr}");
        }
    }        
    return $retStr;
}

## use LWP::Simple;
## use HTML::LinkExtor;
sub getLinksFromUrl {
    my($url,$distinct,$sorted) = @_;
    $distinct   = setDefault($distinct,$TRUE);
    $sorted     = setDefault($sorted,$TRUE);
    my(@retVal) = ();
    my $parser  = HTML::LinkExtor->new(undef,$url);
    $parser->parse(LWP::Simple::get($url))->eof;
    @links = $parser->links;
    foreach $linkarray (@links) {
       my @element = @$linkarray;
       my $elt_type = shift @element;
       while (@element) {
         my ($attr_name, $attr_value) = splice(@element,0,2);
         ### print("attr_name:${attr_name}:  attr_value:${attr_value}:\n");
         push(@retVal,$attr_value);
         ### $seen{$attr_value}++;
       }
    }
    if ($distinct) {
       @retVal = makeArrayEntriesDestinct($TRUE,@retVal);
    }
    if ($sorted) {
       @retVal = sort @retVal;
    }
    return sort @retVal;
}

# reads a file via http from another server
# if you use this function please
#    use Socket;
sub httpGet {
    my($remoteServer,$remotePort,$remoteFile,$tempFile,$printIt,$isHTML) = @_;
    $remotePort  = setDefault($remotePort,"80");
    $printIt     = setDefault($printIt,$FALSE);
    $isHTML      = setDefault($isHTML,$TRUE);

    $protocol = getprotobyname('tcp');
    $iaddr    = inet_aton($remoteServer) || showError("inet_aton : $!");
    $paddr    = sockaddr_in($remotePort,$iaddr);
    socket(CLIENT, AF_INET, SOCK_STREAM, $protocol) || showError("socket : $!");
    connect(CLIENT,$paddr) || showError("connect : $!");
    my($message) = "GET http://${remoteServer}/${remoteFile} HTTP/1.0\n\n\n";
    syswrite(CLIENT,$message,length($message));
    my($buffer) = "";
    my($first)  = "yes";
    my($outPutStream) = "";
    while(sysread(CLIENT,$buffer,1024) > 0) {
       if ($first eq "yes") {
         $first = $buffer;
       }
       $outPutStream = "${outPutStream}${buffer}";
    }
    close(CLIENT);

    if ($isHTML) {
       my(@outParts) = split("<HTML>",$outPutStream);
       $outPutStream = "<HTML>$outParts[1]";
    }

    if ($tempFile ne "") {
       open(TEMPFILE_httpGet,">${tempFile}") || showError("Error (httpGet): Can't open file : ${tempFile}   $!");
       print(TEMPFILE_httpGet "${outPutStream}");
       close(TEMPFILE_httpGet);
    }
    if ($printIt) {
       print("${outPutStream}");
    }        
    if (!($first =~ m/200/)) {
       showError("File does not exist : http://${remoteServer}/${remoteFile}");
    }
    return $outPutStream;
}

# some mappingTbl functions
# -------------------------
sub getHomeCurrencyForCitycode {
   my($cityCode,$notFoundStr) = @_;
   if (exists($CityCurrencyTbl{uc($cityCode)})) {
      return $CityCurrencyTbl{uc($cityCode)};
   } else {
      return $notFoundStr;
   }
}

###########################################################################
## Function Name : addJobtimeToFile()
## Added By      : Raghu
###########################################################################
sub addJobtimeToFile {
  my($msg, $fileName) = @_;
  my $logmsg = "";
  setLogfileName($fileName);

  if ($msg ne "") {
    $logmsg = "${msg}\n";
  }

  if ($fileName eq "") {
   if ($copyToSTDOUT) {
      print "${logmsg}";
   }
  } else {
      if (!open(LOGFILE_addToLogFile, ">>$fileName")) {
       print "Can't add to log file $fileName\n";
      } else {
          print LOGFILE_addToLogFile "$logmsg";

            if ($copyToSTDOUT) {
             print("${logmsg}");
            }
          close LOGFILE_addToLogFile;
        }
    }
}
## *** END OF Function Name : addJobtimeToFile() ***


###########################################################################
## File uploader functions
###########################################################################
sub fileUploader {
    my($topRemotePath, $destFileName, $pathVisabilityState, $destFilenameVisabilityState, $showTransferModeField, $showFileProtectionField, $transModeP, $fileProtP, $showCloseBtn, %transferModeMapping) = @_;
	$topRemotePath               = setDefault($topRemotePath,                "/tmp");
	$destFileName                = setDefault($destFileName,                 "");
	$pathVisabilityState         = setDefault($pathVisabilityState,          "HIDE");
	$destFilenameVisabilityState = setDefault($destFilenameVisabilityState,  "HIDE");
	$showTransferModeField       = setDefault($showTransferModeField,        "HIDE");
	$showFileProtectionField     = setDefault($showFileProtectionField,      "HIDE");
	$transModeP                  = setDefault($transModeP,                   "AUTO");
	$fileProtP                   = setDefault($fileProtP,                    "0755");
	$showCloseBtn                = setDefault($showCloseBtn,                 $FALSE);
	
	$destPath        = setDefault(getParam("destPath"       ,""),$topRemotePath);
	$destName        = setDefault(getParam("uploadName"     ,""),$destFileName);
	$transMode       = setDefault(getParam("transMode"      ,""),$transModeP);
	$fProt           = setDefault(getParam("fileProtection" ,""),$fileProtP);
	$serverLoginName = getParam("serverLoginName" ,"");

	if (getParam("Action","") ne "doUpload") {
		displayUploadForm($pathVisabilityState, $destFilenameVisabilityState, $showTransferModeField, $showFileProtectionField, $destPath, $destName, $transMode, $fProt);
	} else {
		my $sourceFile   = getParam("upfile"     ,""); 
		my $basename     = getFileNameOutOfFullName($sourceFile);
		my ($totBytes,$transferMode,$destinationFileName,$fileProtection) = uploadFile($sourceFile,"${destPath}/${destName}", $transMode,  $fProt, %transferModeMapping);
		displayFileUploadSuccessForm($sourceFile, $destinationFileName, $totBytes, $transferMode, $fileProtection, $showCloseBtn);
	}
}

sub uploadFile {
	my($localFileName, $destinationFileName, $transMode,  $fProt, %transferModeMapping) = @_;
	
	my @keyOfHash = keys %transferModeMapping;
	my $countOfMappings = @keyOfHash;
	
	my %defaultTransferModeMapping = (
		"TXT"   => "ASC",
		"JS"    => "ASC",
		"HTML"  => "ASC",
		"HTM"   => "ASC",
		"CSS"   => "ASC",
		"CSV"   => "ASC",
		"FLT"   => "ASC",
		"PL"    => "ASC",
		"PM"    => "ASC",
		"KSH"   => "ASC",
		"BASH"  => "ASC",
	);
	if ($countOfMappings == 0) {
		%transferModeMapping = %defaultTransferModeMapping;
	}
	
	my $fileExtension  = uc(getFileNameExtension($localFileName));
		
	my $transferMode = "BIN";
	if (($transMode eq "BIN") || ($transMode eq "ASC")) {
		$transferMode = $transMode;
	} else {
		print("<!-- countOfMappings:${countOfMappings}:    fileExtension:${fileExtension}:     SetMode:".$transferModeMapping{$fileExtension}."\n"); displayHashTable(%transferModeMapping); print(" -->\n");
		if (exists($transferModeMapping{$fileExtension})) {
			$transferMode = $transferModeMapping{$fileExtension};
		}
	}

	if (stringEndsWith($destinationFileName,"/")) {
		$destinationFileName = $destinationFileName.$localFileName;
	}

	print("<!--\n");
	print("Call uploadFile(\"${localFileName}\", \"${destinationFileName}\", \"${transferMode}\")\n");
	print("       fileExtension:${fileExtension}:    destinationFileName:${destinationFileName}:    \n");
	print("-->\n");

	if (! open(OUTFILE, ">${destinationFileName}") ) {
		print "Can't open ${destinationFileName} for writing - $!";
		exit(-1);
	}

	print("<!--Saving ${localFileName} to ${destinationFileName}-->\n");

	my $nBytes   = 0;
	my $totBytes = 0;
	my $buffer   = "";
	if ($transferMode eq "BIN") {
		print("<!--Set BIN transfer mode-->\n");
		binmode($localFileName);
	}

	while ( $nBytes = read($localFileName, $buffer, 1024) ) {
		print OUTFILE $buffer;
		$totBytes += $nBytes;
	}
	close(OUTFILE);
	
	if ($transferMode eq "ASC") {
		dos2unix($destinationFileName)
	}
	
	if ($fProt ne "") {
		$fProt = octal2Dec($fProt);
		chmod ($fProt,$destinationFileName);
	}
	
	return ($totBytes,$transferMode,$destinationFileName,$fProt);
}

sub displayUploadForm {
	my($displayUploadPath, $displayUploadFilename, $showTransferModeField, $showFileProtectionField,$destPath,$destName,$transMode,$fProt) = @_;
	$displayUploadPath       = uc(setDefault($displayUploadPath,        "DISABLED"));
	$displayUploadFilename   = uc(setDefault($displayUploadFilename,    "DISABLED"));
	$showTransferModeField   = uc(setDefault($showTransferModeField,    "DISABLED"));
	$showFileProtectionField = uc(setDefault($showFileProtectionField,  "DISABLED"));
	
	my                                            $uploadPathField     = " <tr><td>Destination-Path          </td><td><input TYPE=\"TEXT\"     SIZE=50  NAME=\"destPath\"  VALUE=\"${destPath}\"></td></tr>";
	if ($displayUploadPath eq "DISABLED")       { $uploadPathField     = " <tr><td>Destination-Path          </td><td>${destPath}</td></tr>;" }
	if ($displayUploadPath eq "HIDE")           { $uploadPathField     = " <input TYPE=\"HIDDEN\"   SIZE=50  NAME=\"destPath\"  VALUE=\"${destPath}\">"; }
  
	my                                            $uploadFilenameField = " <tr><td>Destination-Filename      </td><td><input TYPE=\"TEXT\"     SIZE=50  NAME=\"uploadName\"  VALUE=\"${destName}\"></td></tr>";
	if ($displayUploadFilename eq "DISABLED")   { $uploadFilenameField = " <tr><td>Destination-Filename      </td><td>${destName}</td></tr>;" }
	if ($displayUploadFilename eq "HIDE")       { $uploadFilenameField = " <input TYPE=\"HIDDEN\"   SIZE=50  NAME=\"uploadName\"  VALUE=\"${destName}\">"; }

	my                                            $transferModeField   = " <tr><td>Transfer-Mode      </td><td><SELECT SIZE=1  NAME=\"transMode\">  <OPTION VALUE=AUTO>AUTO<OPTION VALUE=ASC>ASC<OPTION VALUE=BIN>BIN</SELECT></td></tr>";
	if ($transMode eq "ASC") {                    $transferModeField   = " <tr><td>Transfer-Mode      </td><td><SELECT SIZE=1  NAME=\"transMode\">  <OPTION VALUE=AUTO>AUTO<OPTION VALUE=ASC SELECTED>ASC<OPTION VALUE=BIN>BIN</SELECT></td></tr>"; }
    if ($transMode eq "BIN") {                    $transferModeField   = " <tr><td>Transfer-Mode      </td><td><SELECT SIZE=1  NAME=\"transMode\">  <OPTION VALUE=AUTO>AUTO<OPTION VALUE=ASC>ASC<OPTION VALUE=BIN SELECTED>BIN</SELECT></td></tr>"; }
	
	
	if ($showTransferModeField eq "DISABLED")   { $transferModeField   = " <tr><td>Transfer-Mode      </td><td>${transMode}</td></tr>;" }
	if ($showTransferModeField eq "HIDE")       { $transferModeField   = " <input TYPE=\"HIDDEN\"   SIZE=50  NAME=\"transMode\"  VALUE=\"${transMode}\">"; }
	
	my                                            $fileProtectionField = " <tr><td>File-Protection      </td><td><input TYPE=\"TEXT\"     SIZE=5  NAME=\"fileProtection\"  VALUE=\"${fProt}\"></td></tr>";
	if ($showFileProtectionField eq "DISABLED") { $fileProtectionField = " <tr><td>File-Protection      </td><td>${fProt}</td></tr>;" }
	if ($showFileProtectionField eq "HIDE")     { $fileProtectionField = " <input TYPE=\"HIDDEN\"   SIZE=50  NAME=\"fileProtection\"  VALUE=\"${fProt}\">"; }
	print <<"HTML";
	<form method="post" action="${myCgiFormName}" enctype="multipart/form-data">
		<table border="3" bgcolor="Gainsboro">
			<tr><td>Select file to upload</td><td><input TYPE="FILE"           NAME="upfile"></td></tr>
			${uploadPathField}
			${uploadFilenameField}
			${transferModeField}
			${fileProtectionField}
			<tr><td colspan=2><center><input type="submit" name="button" value="Upload File"></center></td></tr>
		</table>
		<INPUT TYPE=HIDDEN NAME="Action"         VALUE="doUpload">
		<INPUT TYPE=HIDDEN NAME="loginUserId"    VALUE="${loginUserId}">
	</form>
HTML
}

sub displayFileUploadSuccessForm {
	my($localFileName, $destinationFileName, $bytesUploaded, $transferMode, $fileProtection, $withCloseBtn) = @_;
	
	my $sourceBasename     = getFileNameOutOfFullName($localFileName);
	my $destinBasename     = getFileNameOutOfFullName($destinationFileName);
	my $withCloseBtn       = setDefault($withCloseBtn,$TRUE);
	
	my $closeBtnStr = "";
	if ($withCloseBtn) { $closeBtnStr = "<INPUT TYPE=\"BUTTON\" VALUE=\"Close\" onClick=self.close()>"; }
	
	$fileProtection = dec2Octal($fileProtection);
	
print <<"HTML";
	<table border="3" bgcolor="Gainsboro">
		<tr><td>Local-File</td><td>${localFileName}</td></tr>
		<tr><td>Remote-File</td><td>${destinationFileName}</td></tr>
		<tr><td>Bytes-Uploaded</td><td>${bytesUploaded}</td></tr>
		<tr><td>Transfered</td><td>${transferMode}</td></tr>
		<tr><td>File-Protection</td><td>${fileProtection}</td></tr>
		<tr><td colspan=2><center>
			<FORM> 
				${closeBtnStr}
				<INPUT TYPE="BUTTON" VALUE="Back"  onClick=window.history.back()>
			</FORM>
			</center></td></tr>
	</table>
HTML
}


return 1;