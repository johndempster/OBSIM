unit NewExperimentUnit;
// ---------------------
// Select new experiment
// ---------------------

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TNewExperimentFrm = class(TForm)
    cbTissue: TComboBox;
    bOK: TButton;
    bCancel: TButton;
    procedure bOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NewExperimentFrm: TNewExperimentFrm;

implementation

uses OBSimMain;

{$R *.dfm}


procedure TNewExperimentFrm.bOKClick(Sender: TObject);
// ------------------------
// New tissue type selected
// ------------------------
begin
     // Select type of tissue
     MainFrm.TissueType := Integer(cbTissue.Items.Objects[cbTissue.ItemIndex]) ;
     end;

procedure TNewExperimentFrm.FormShow(Sender: TObject);
// ------------------------------------------
// Initialise controls when form is displayed
// ------------------------------------------
begin
     // Available experimental tissues
     cbTissue.Clear ;
     cbTissue.Items.AddObject('Guinea Pig Ileum',TObject(tGPIleum)) ;
     cbTissue.Items.AddObject('Chick Biventer',TObject(tChickBiventer)) ;
     cbTissue.Items.AddObject('Rabbit Arterial Ring',TObject(tArterialRing)) ;
     cbTissue.Items.AddObject('Rabbit Jejunum',TObject(tJejunum)) ;
     cbTissue.ItemIndex := cbTissue.Items.IndexOfObject(TObject(MainFrm.TissueType)) ;

     end;

end.
