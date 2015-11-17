program OBSim;

uses
  Forms,
  OBSimMain in 'OBSimMain.pas' {MainFrm},
  PrintUnit in 'PrintUnit.pas' {PrintFrm},
  SHARED in 'SHARED.PAS',
  NewExperimentUnit in 'NewExperimentUnit.pas' {NewExperimentFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Organ Bath Simulation';
  Application.HelpFile := 'C:\Program Files\Borland\Delphi7\OBSim\OBSIM.HLP';
  Application.CreateForm(TMainFrm, MainFrm);
  Application.CreateForm(TPrintFrm, PrintFrm);
  Application.CreateForm(TNewExperimentFrm, NewExperimentFrm);
  Application.Run;
end.
