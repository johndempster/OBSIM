unit NewExperimentFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TSetExperimentFrm = class(TForm)
    cbTissue: TComboBox;
    bOK: TButton;
    bCancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SetExperimentFrm: TSetExperimentFrm;

implementation

{$R *.dfm}

end.
