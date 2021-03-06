; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Zak"
#define MyAppVersion "1.5"
#define MyAppPublisher "Zak"
#define MyAppURL "https://www.zak.app"
#define MyAppExeName "helloworld.exe"
#define MyAppAssocName MyAppName + " File"
#define MyAppAssocExt ".exe"
#define MyAppAssocKey StringChange(MyAppAssocName, " ", "") + MyAppAssocExt

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{2E0E8E16-A966-4070-AE3F-99E539CF6B3B}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
ChangesAssociations=yes
DisableProgramGroupPage=yes
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputDir=D:\inno
OutputBaseFilename=zak
Compression=lzma
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=admin

[Languages]
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "C:\Users\kevin\Downloads\helloworld-win32-x64\helloworld-win32-x64\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\kevin\Downloads\helloworld-win32-x64\helloworld-win32-x64\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
;Source: "C:\Users\kevin\Downloads\TeamViewer_Setup_x64.exe"; DestDir: "{app}"; AfterInstall: RunTeamViewerInstaller; Flags: onlyifdoesntexist
;Source: "C:\Users\kevin\Downloads\Docker_Desktop_Installer.exe"; DestDir: "{app}"; AfterInstall: RunDockerDesktopInstaller; Flags: onlyifdoesntexist

; NOTE: Don't use "Flags: ignoreversion" on any shared system files                                                                  

[Registry]
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocExt}\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppAssocKey}"; ValueData: ""; Flags: uninsdeletevalue
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey}"; ValueType: string; ValueName: ""; ValueData: "{#MyAppAssocName}"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey}\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{#MyAppExeName},0"
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey}\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{#MyAppExeName}"" ""%1"""
Root: HKA; Subkey: "Software\Classes\Applications\{#MyAppExeName}\SupportedTypes"; ValueType: string; ValueName: ".myp"; ValueData: ""

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Code]
procedure RunTeamViewerInstaller;
var
  ResultCode: Integer;
begin
  if not Exec(ExpandConstant('{app}\TeamViewer_Setup_x64.exe'), '', '', SW_SHOWNORMAL,
    ewWaitUntilTerminated, ResultCode)
  then
    MsgBox('TeamViewer instalation failed!' + #13#10 +
      SysErrorMessage(ResultCode), mbError, MB_OK);
end;

procedure RunDockerDesktopInstaller;
var
  ResultCode: Integer;
begin
  if not Exec(ExpandConstant('{app}\Docker_Desktop_Installer.exe'), '', '', SW_SHOWNORMAL,
    ewWaitUntilTerminated, ResultCode)
  then
    MsgBox('Docker Desktop instalation failed!' + #13#10 +
      SysErrorMessage(ResultCode), mbError, MB_OK);
end;

procedure installWSL;
var 
  ErrorCode: Integer;
begin
  if not ShellExec('', ExpandConstant('wsl --install'), '', '', SW_SHOW, ewNoWait, ErrorCode)
  then
  begin
   MsgBox('Wsl instalation failed!' + #13#10 +
      SysErrorMessage(ErrorCode), mbError, MB_OK);
  end;
end;

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent
;Filename: "{app}\{#MyAppExeName}"; AfterInstall: installWSL
Filename: "powershell.exe"; Parameters: "/c ""wsl --install -d Ubuntu"""; Flags: runascurrentuser shellexec waituntilterminated
;Filename: "D:\inno\installwsl.bat"; Flags: runascurrentuser shellexec waituntilterminated