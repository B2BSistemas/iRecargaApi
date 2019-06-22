program API_iRecarga;

uses
  Vcl.Forms,
  uRecarga in 'uRecarga.pas' {frmRecarga};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmRecarga, frmRecarga);
  Application.Run;
end.
