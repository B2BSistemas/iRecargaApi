unit uRecarga;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  REST.Response.Adapter,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Rest.Json, JSON;



//LISTA OPERADORAS...
type
  TLisOpr = class
    private
      FListCompanies: TArray<String>;
      FMessage: String;
      FStatus: Boolean;
    public
      property ListCompanies: TArray<String> read FListCompanies write FListCompanies;
      property Message: String read FMessage write FMessage;
      property Status: Boolean read FStatus write FStatus;
      function ToJsonString: string;
      class function FromJsonString(AJsonString: string): TLisOpr;
    end;

//LISTA VALOR DO CRÉDITO...
type
  TLisVlr = class
    private
      FListValues: TArray<String>;
      FMessage: String;
      FStatus: Boolean;
    public
      property ListValues: TArray<String> read FListValues write FListValues;
      property Message: String read FMessage write FMessage;
      property Status: Boolean read FStatus write FStatus;
      function ToJsonString: string;
      class function FromJsonString(AJsonString: string): TLisVlr;
    end;


type
  TfrmRecarga = class(TForm)
    mmResultado: TMemo;
    HTTP: TIdHTTP;
    Button2: TButton;
    edtDDD: TEdit;
    Button3: TButton;
    Button4: TButton;
    edtNum: TEdit;
    cbbOperadora: TComboBox;
    cbbVlr: TComboBox;
    lblDDD: TLabel;
    lblNumero: TLabel;
    lblOperadora: TLabel;
    lblVlrCredito: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    lMetodo : string;
    lToken : string;
    function GetListaOperadora(AControl: TCustomListControl): TArray<String>;     //CARREGA A LISTA OPERADORA...
    function GetListaValorCredito(AControl: TCustomListControl): TArray<String>;  //CARREGA A LISTA DE CREDIRTO...
    { Public declarations }
  end;

var
  frmRecarga: TfrmRecarga;

implementation


//LISTA OPERADORA...
function TLisOpr.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TLisOpr.FromJsonString(AJsonString: string): TLisOpr;
begin
  result := TJson.JsonToObject<TLisOpr>(AJsonString)
end;

//LISTA VALOR CRÉDITO...
function TLisVlr.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TLisVlr.FromJsonString(AJsonString: string): TLisVlr;
begin
  result := TJson.JsonToObject<TLisVlr>(AJsonString)
end;

{$R *.dfm}

procedure TfrmRecarga.Button2Click(Sender: TObject);
var
  code       : Integer;
  sResponse  : String;
  Json       : String;
  JsonToSend : TStringStream;


begin
  Json       := '{"ddd" : "'+ edtDDD.Text +'", "token" : "' + lToken +'"}';
  JsonToSend := TStringStream.Create((Json));
  try
    HTTP.Request.Accept          := 'application/json';
    HTTP.Request.ContentType     := 'application/json';
    HTTP.Request.ContentEncoding := 'utf-8';
    HTTP.Request.Method          := 'POST';

    try
      sResponse := HTTP.Post('http://qaapi.irecarga.com.br/Service.svc/ListCompanies/', JsonToSend);

    except
      on E: Exception do
      begin
        mmResultado.Lines.Add('Error on request: '#13#10 + e.Message);
        Exit;
      end;
    end;

    mmResultado.lines.clear;
    mmResultado.lines.add(sResponse);

    lMetodo :=  sResponse;

    GetListaOperadora( cbbOperadora );

  finally
    JsonToSend.Free();
  end;
end;

procedure TfrmRecarga.Button3Click(Sender: TObject);
var
  code       : Integer;
  sResponse  : String;
  Json       : String;
  JsonToSend : TStringStream;


begin
  Json       := '{"token" : "' + lToken +'", "ddd" : "'+ edtDDD.Text +'", "company" : "'+ cbbOperadora.Text +'" }';
  JsonToSend := TStringStream.Create( UTF8Encode(Json) );
  try
    HTTP.Request.Accept          := 'application/json';
    HTTP.Request.ContentType     := 'application/json';
    HTTP.Request.ContentEncoding := 'utf-8';
    HTTP.Request.Method          := 'POST';

    try
      sResponse := HTTP.Post('http://qaapi.irecarga.com.br/Service.svc/ListValues/', JsonToSend);
    except
      on E: Exception do
      begin
        mmResultado.Lines.Add('Error on request: '#13#10 + e.Message);
        Exit;
      end;
    end;

    mmResultado.lines.clear;
    mmResultado.lines.add(sResponse);

    lMetodo :=  sResponse;

    GetListaValorCredito(cbbVlr);

  finally
    JsonToSend.Free();
  end;
end;

procedure TfrmRecarga.Button4Click(Sender: TObject);
var
  code       : Integer;
  sResponse  : String;
  Json       : String;
  JsonToSend : TStringStream;
begin
  Json       := '{"token" : "' + lToken +'", "pin" : "SEU PIN", "ddd" : "'+ edtDDD.Text +
                '", "company" : "'+ cbbOperadora.Text +'", "phoneNumber" : "'+ edtNum.Text +'", "value" : "'+ cbbVlr.Text +
                '", "source" : "NOME CADASTRADO NO IRECARGA" }';
  JsonToSend := TStringStream.Create( UTF8Encode(Json) );
  try
    HTTP.Request.Accept          := 'application/json';
    HTTP.Request.ContentType     := 'application/json';
    HTTP.Request.ContentEncoding := 'utf-8';
    HTTP.Request.Method          := 'POST';

    try
      sResponse := HTTP.Post('http://qaapi.irecarga.com.br/Service.svc/ReloadPhone/', JsonToSend);
    except
      on E: Exception do
      begin
        mmResultado.Lines.Add('Error on request: '#13#10 + e.Message);
        Exit;
      end;
    end;

    mmResultado.lines.clear;
    mmResultado.lines.add(sResponse);
  finally
    JsonToSend.Free();
  end;
end;

procedure TfrmRecarga.FormShow(Sender: TObject);
var
  code       : Integer;
  sResponse  : String;
  Json       : String;
  JsonToSend : TStringStream;

  arrey_foto : TJSONArray;
  x : Integer;
  lJson : string;
begin
  Json       := '{"email" : "SEU E-MAIL", "password" : "SUA SENHA"}'; //E-MAIL E SENHA CADASTRADOS NO IRECARGA...
  JsonToSend := TStringStream.Create( TEncoding.UTF8.GetBytes(Json) );
  try
    HTTP.Request.Accept          := 'application/json';
    HTTP.Request.ContentType     := 'application/json';
    HTTP.Request.ContentEncoding := 'utf-8';
    HTTP.Request.Method          := 'POST';

    try
      sResponse := HTTP.Post('http://qaapi.irecarga.com.br/Service.svc/Login/', JsonToSend);
    except
      on E: Exception do
      begin
        mmResultado.Lines.Add('Error on request: '#13#10 + e.Message);
        Exit;
      end;
    end;

    mmResultado.lines.clear;
    mmResultado.lines.add(sResponse);

    lJson := '[' + sResponse + ']';

    arrey_foto := TJSONArray.Create;
    arrey_foto := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(lJson), 0) as TJSONArray;


    x := 0;

    //CARREGA A VARIAVEL TOKEN
    lToken := arrey_foto.Get(x).GetValue<string>('Token');



  finally
    JsonToSend.Free();
  end;
end;

function TfrmRecarga.GetListaOperadora(AControl: TCustomListControl): TArray<String>;
var X: String;
  I: Integer;
  LJsonResponse: TJSONObject;
  S: TArray<String>;
  ThisRoot: TLisOpr;
begin
  if not Assigned(ThisRoot) then
    ThisRoot:= TLisOpr.Create;

  X:=  lMetodo;
        LJsonResponse := TJSONObject.ParseJSONValue(x) as TJSONObject;

      S:= ThisRoot.FromJsonString(LJsonResponse.ToString).ListCompanies;

  AControl.Clear;
   for I := Low(S) to High(S) do
   begin
      AControl.AddItem(S[i],AControl);
   end;

 Result:= S;

 if Assigned(ThisRoot) then
   FreeAndNil(ThisRoot);

end;

function TfrmRecarga.GetListaValorCredito(AControl: TCustomListControl): TArray<String>;
  var X: String;
  I: Integer;
  LJsonResponse: TJSONObject;
  S: TArray<String>;
  ThisRoot: TLisVlr;
begin
  if not Assigned(ThisRoot) then
    ThisRoot:= TLisVlr.Create;

  X:=  lMetodo;
        LJsonResponse := TJSONObject.ParseJSONValue(x) as TJSONObject;

      S:= ThisRoot.FromJsonString(LJsonResponse.ToString).ListValues;

  AControl.Clear;
   for I := Low(S) to High(S) do
   begin
      AControl.AddItem(S[i],AControl);
   end;

 Result:= S;

 if Assigned(ThisRoot) then
   FreeAndNil(ThisRoot);
end;

end.
