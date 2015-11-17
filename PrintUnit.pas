unit PrintUnit;
// ---------------------------
// Print displayed chart trace
// ---------------------------
// 8/11/11 ... DeviceName etc. now assigned using GetMem

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Printers ;

type
  TPrintFrm = class(TForm)
    GroupBox6: TGroupBox;
    bPrinterSetup: TButton;
    edPrinterName: TEdit;
    bOK: TButton;
    bCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure bPrinterSetupClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintFrm: TPrintFrm;

implementation

uses OBSimMain;

{$R *.dfm}

procedure TPrintFrm.FormShow(Sender: TObject);
// ---------------------------------------
// Initialise controls when form displayed
// ---------------------------------------
const
    MaxSize = 100 ;
var
    DeviceName,DeviceDriver,Port : PChar ;
    DeviceMode : THandle ;
begin

     GetMem( DeviceName, MaxSize*SizeOf(WideChar) ) ;
     GetMem( DeviceDriver, MaxSize*SizeOf(WideChar) ) ;
     GetMem( Port, MaxSize*SizeOf(WideChar) ) ;

     Printer.GetPrinter( DeviceName,
                         DeviceDriver,
                         Port,
                         DeviceMode);

     edPrinterName.Text := String(DeviceName) ;

     FreeMem(DeviceName) ;
     FreeMem(DeviceDriver) ;
     FreeMem(Port) ;
     end;

procedure TPrintFrm.bPrinterSetupClick(Sender: TObject);
// --------------------------------
// Display printer setup dialog box
// --------------------------------
const
    MaxSize = 100 ;
var
    DeviceName,DeviceDriver,Port : PChar ;
    DeviceMode : THandle ;
begin
     MainFrm.PrinterSetupDialog.Execute ;

     GetMem( DeviceName, MaxSize*SizeOf(WideChar) ) ;
     GetMem( DeviceDriver, MaxSize*SizeOf(WideChar) ) ;
     GetMem( Port, MaxSize*SizeOf(WideChar) ) ;

     Printer.GetPrinter( DeviceName,
                         DeviceDriver,
                         Port,
                         DeviceMode);

     edPrinterName.Text := String(DeviceName) ;

     FreeMem(DeviceName) ;
     FreeMem(DeviceDriver) ;
     FreeMem(Port) ;

     end;

end.
