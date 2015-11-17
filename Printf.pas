unit Printf;
{ ===============================================
  BIOGRAPH - Graph hard copy printing module
  (c) J. Dempster, University of Strathclyde 1997
  ===============================================}
// 15/10/02 ... Lines now sorted by X value before plotting
//              to avoid lines doubling back
interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Spin, global, shared, plotlib, printers, ssqunit;

type
  TPrintFrm = class(TForm)
    bOK: TButton;
    bCancel: TButton;
    MarginGrp: TGroupBox;
    edLeft: TEdit;
    Label1: TLabel;
    edRight: TEdit;
    Label4: TLabel;
    edTop: TEdit;
    Label5: TLabel;
    EdBottom: TEdit;
    Label6: TLabel;
    GroupBox6: TGroupBox;
    bPrinterSetup: TButton;
    edPrinterName: TEdit;
    procedure FormShow(Sender: TObject);
    procedure bOKClick(Sender: TObject);
    procedure edLeftKeyPress(Sender: TObject; var Key: Char);
    procedure bPrinterSetupClick(Sender: TObject);
  private
    { Private declarations }
    DeviceName : Array[0..100] of Char ;
    DeviceDriver : Array[0..100] of Char ;
    Port : Array[0..100] of Char ;
    DeviceMode : Cardinal ;

    procedure UpdateParameters ;
    procedure PrintGraph ;
  public
    { Public declarations }
  end;

var
  PrintFrm: TPrintFrm;

implementation

{$R *.DFM}

uses mdimain,graf ;

var
   Initialised : Boolean ;

procedure TPrintFrm.FormShow(Sender: TObject);
{ ------------------------------------------
  Initialisation each time form is displayed
  ------------------------------------------}
begin

     Printer.GetPrinter( DeviceName, DeviceDriver,Port,DeviceMode);
     edPrinterName.Text := String(DeviceName) ;

     { Initialise plot margins text boxes }
     Initialised := False ;
     UpdateParameters ;

     end;

{ --------------------------------------------
  Update plot margin parameters and text boxes
  --------------------------------------------}
procedure TPrintFrm.UpdateParameters ;
begin

     if Initialised then Plot.LeftMargin := ExtractFloat(edLeft.Text,Plot.LeftMargin) ;
     edLeft.text := format( '%5.1g cm', [Plot.LeftMargin] ) ;

     if Initialised then Plot.RightMargin := ExtractFloat(edRight.Text,Plot.RightMargin) ;
     edRight.text := format( '%5.1g cm', [Plot.RightMargin] ) ;

     if Initialised then Plot.TopMargin := ExtractFloat(edTop.Text,Plot.TopMargin) ;
     edTop.text := format( '%5.1g cm', [Plot.TopMargin] ) ;

     if Initialised then Plot.BottomMargin := ExtractFloat(edBottom.Text,Plot.BottomMargin) ;
     edBottom.text := format( '%5.1g cm', [Plot.BottomMargin] ) ;

     Initialised := True ;

     end ;

procedure TPrintFrm.bOKClick(Sender: TObject);
{ -------------------------------------------
  Update plot settings when OK button clicked
  -------------------------------------------}
begin

     UpdateParameters ;
     PrintGraph ;

     end;

procedure TPrintFrm.edLeftKeyPress(Sender: TObject; var Key: Char);
var
   Value : single ;
begin
     if key = chr(13) then UpdateParameters ;
     end;


procedure TPrintFrm.PrintGraph ;
{ -----------------------------------------
  Print currently display graph on printer
  ----------------------------------------}
var
   Grf : Integer ;
   PrGraph : TXYBuf ;
   PrPlot : TPlot ;
begin

     Screen.Cursor := crHourGlass ;

     PrPlot := Plot ;
     PrGraph := TXYBuf.Create ; { Working copy of graph being printed}

     { Set plot size/fonts }
     Printer.canvas.font.name := Plot.FontName  ;
     Printer.canvas.font.size := Plot.FontSize ;

     PrPlot.Left := PrinterCmToPixels('H',Plot.LeftMargin) ;
     PrPlot.Right := Printer.pagewidth - PrinterCmToPixels('H',Plot.RightMargin) ;
     PrPlot.Top := PrinterCmToPixels('V',Plot.TopMargin) ;
     PrPlot.Bottom := Printer.pageheight - PrinterCmToPixels('V',Plot.BottomMargin) ;
     PrPlot.MarkerSize := PrinterPointsToPixels(Plot.MarkerSize);
     PrPlot.LineThickness := PrinterPointsToPixels(Plot.LineThickness);
     Printer.Canvas.Pen.Width := PrinterPointsToPixels(Plot.LineThickness);

     PrPlot.FontSize := Plot.FontSize ;
     PrPlot.LabelFontSize := Plot.LabelFontSize ;
     PrPlot.LegendFontSize := Plot.LegendFontSize ;

     { ** Print hard copy of graph **}

     Printer.BeginDoc ;

     GraphChild.DrawLegend( Printer.Canvas, PrPlot ) ;
     { Draw X and Y axes }
     DrawAxes( Printer.Canvas, PrPlot, Graph[0] ) ;

     { Draw graphs }
     for grf := 0 to High(Graph) do begin

         if Graph[Grf] <> Nil then begin

            PrGraph.NumPoints := Graph[Grf].NumPoints ;
            PrGraph.x := Graph[Grf].x ;
            PrGraph.y := Graph[Grf].y ;
            PrGraph.ErrBar := Graph[Grf].ErrBar ;
            PrGraph.Signif := Graph[Grf].Signif ;
            PrGraph.ErrorBars := Graph[Grf].ErrorBars ;
            PrGraph.DrawMarker := Graph[Grf].DrawMarker ;
            PrGraph.DrawLine := Graph[Grf].DrawLine ;
            PrGraph.LineColor := Graph[Grf].LineColor ;
            PrGraph.LineType := Graph[Grf].LineType ;
            PrGraph.LineStyle := Graph[Grf].LineStyle ;
            PrGraph.LineThickness := Graph[Grf].LineThickness ;
            PrGraph.MarkerType := Graph[Grf].MarkerType ;
            PrGraph.MarkerStyle := Graph[Grf].MarkerStyle ;
            PrGraph.MarkerSize := Graph[Grf].MarkerSize ;
            PrGraph.MarkerSolid := Graph[Grf].MarkerSolid ;
            PrGraph.MarkerColor := Graph[Grf].MarkerColor ;
            PrGraph.Title := Graph[Grf].Title ;
            PrGraph.Number := Graph[Grf].Number ;
            PrGraph.Equation := Graph[Grf].Equation ;

            PrGraph.MarkerSize := PrinterPointsToPixels(Graph[Grf].MarkerSize);
            PrGraph.LineThickness := PrinterPointsToPixels(Graph[Grf].LineThickness);

            { Plot markers }
            if PrGraph.MarkerType <> mkNone then
               DrawMarkers( Printer.Canvas, PrPlot, PrGraph ) ;
            { Plot fitted curve to data points }
            if PrGraph.Equation.Available and
               (PrGraph.LineType = ltFittedCurve) then
               DrawFunction( Printer.Canvas, PrPlot, PrGraph ) ;
            { Join data points with straight lines }
            if PrGraph.LineType = ltLinear then begin
               Sort( PrGraph.x, PrGraph.y, PrGraph.NumPoints ) ;
               DrawLine( Printer.Canvas, PrPlot, PrGraph ) ;
               end ;
            { Plot Error bars }
            if Graph[Grf].ErrorBars then
               DrawErrorBars( Printer.Canvas, PrPlot, PrGraph ) ;

            end ;
         end ;

     { Date and file name at bottom of page }
     Printer.canvas.font.name := 'Arial'  ;
     Printer.canvas.font.Size := 8 ;
     Printer.Canvas.TextOut( Printer.Canvas.TextWidth('XX'),
                             Printer.PageHeight - Printer.Canvas.TextHeight('X'),
                             DateTimeToStr(Now) + ' ' + Main.Caption ) ;

     Printer.EndDoc ;

     PrGraph.Free ;

     Screen.Cursor := crDefault ;
     end ;


procedure TPrintFrm.bPrinterSetupClick(Sender: TObject);
// --------------------------------
// Display printer setup dialog box
// --------------------------------
begin
     Main.PrinterSetupDialog.Execute ;
     Printer.GetPrinter( DeviceName, DeviceDriver,Port,DeviceMode);
     edPrinterName.Text := String(DeviceName) ;
     end;

end.
