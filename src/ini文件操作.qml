[General]
SyntaxVersion=2
MacroID=98a18cc8-d3d8-4a70-89d5-95bda22e587a
[Comment]

[Script]

//Դ����Դ��https://bbs.anjian.com/showtopic-702425-1.aspx

//��������д�������ӳ������
//д�걣�������һ������ϵ���Ҽ���ѡ��ˢ�¡�����
Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As String, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long
Declare Function GetPrivateProfileSection Lib "kernel32" Alias "GetPrivateProfileSectionA" (ByVal lpApplicationName As String, ByVal lpReturnedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long
Declare Function GetPrivateProfileSectionNames Lib "kernel32" Alias "GetPrivateProfileSectionNamesA" (ByVal lpReturnedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long
Declare Function WritePrivateProfileString Lib "kernel32" Alias "WritePrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpString As String, ByVal lpFileName As String) As Long
Declare Function WritePrivateProfileSection Lib "kernel32" Alias "WritePrivateProfileSectionA" (ByVal lpApplicationName As String, ByVal lpString As String, ByVal lpFileName As String) As Long

/*Dim Section, Key, Value, FilePath
Section = "section"
Key = "key"
Value = "value"
FilePath = "D:\test.ini"
TracePrint "д������" & WriteIni(Section, Key, Value, FilePath)
TracePrint "����д������" & OverwriteIni(Section, "key=123|abc=456", FilePath)
TracePrint "��ȡ�����" & ReadIni(Section, Key, FilePath)
TracePrint "ö��С�ڽ����" & EnumIniSection(FilePath)
TracePrint "ö�ټ������" & EnumIniKey(Section, FilePath)
TracePrint "ö�ټ���ֵ�����" & EnumIniKeyEx(Section, FilePath)
TracePrint "ɾ���������" & DeleteIni(Section, Key, FilePath)
TracePrint "ɾ�����м������" & DeleteIni(Section, "", FilePath)*/

Function ReadIni(Section, Key, FilePath) '�������ļ��л�ȡָ��С��ָ������ֵ
	str = space(32767)
	Dim ret
	ret = GetPrivateProfileString(Section, Key, "", str, Len(str), FilePath)
	If ret = 0 Then
		ReadIni = ""
	Else
		ReadIni = Left(str, ret)
	End If
End Function

Function WriteIni(Section, Key, Value, FilePath) '�������ļ���ָ��С��д�������ֵ
	WriteIni = WritePrivateProfileString(Section, Key, Value, FilePath)
End Function

Function OverwriteIni(Section, Key, FilePath) '�������ļ���ָ��С�ڸ���д�������ֵ
	Key = Replace(Key, "|", Chr(0))
	Key = Key & Chr(0)
	OverwriteIni = WritePrivateProfileSection(Section, Key, FilePath)
End Function

Function EnumIniSection(FilePath) '�������ļ��л�ȡ����С��
	str = space(32767)
	Dim ret
	ret = GetPrivateProfileSectionNames(str, Len(str), FilePath)
	If ret = 0 Then
		EnumIniSection = ""
	Else
		str = Replace(Left(str, InStr(str, Chr(0) & Chr(0))), Chr(0), "|")
		EnumIniSection = Left(str, Len(str) - 1)
	End If
End Function

Function EnumIniKey(Section, FilePath) '�������ļ��л�ȡָ��С�����м�
	str = space(32767)
	Dim ret
	ret = GetPrivateProfileString(Section, vbNullString, "", str, Len(str), FilePath)
	If ret = 0 Then
		EnumIniKey = ""
	Else
		str = Replace(Left(str, InStr(str, Chr(0) & Chr(0))), Chr(0), "|")
		EnumIniKey = Left(str, Len(str) - 1)
	End If
End Function

Function EnumIniKeyEx(Section, FilePath) '�������ļ��л�ȡָ��С�����м�����ֵ
	str = space(32767)
	Dim ret
	ret = GetPrivateProfileSection(Section, str, Len(str), FilePath)
	If ret = 0 Then
		EnumIniKeyEx = ""
	Else
		str = Replace(Left(str, InStr(str, Chr(0) & Chr(0))), Chr(0), "|")
		EnumIniKeyEx = Left(str, Len(str) - 1)
	End If
End Function

Function DeleteIni(Section, Key, FilePath) '�������ļ���ɾ��ָ��С�ڵļ�����ֵ
	If Key = "" Then
		DeleteIni = WritePrivateProfileString(Section, vbNullString, vbNullString, FilePath)
	Else
		DeleteIni = WritePrivateProfileString(Section, Key, vbNullString, FilePath)
	End If
End Function