unit View.ConsultaOcorrenciaBraspress;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, System.JSON, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, System.NetEncoding, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope;

type
  TConsultaOcorrenciaBraspress = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EditUsuario: TEdit;
    EditSenha: TEdit;
    EditCNPJ: TEdit;
    EditNumeroNF: TEdit;
    BtnConsultar: TButton;
    BtnLimpar: TButton;
    DadosOcorrenciaBraspress: TMemo;
    Label5: TLabel;
    Image1: TImage;
    NetHTTPClient1: TNetHTTPClient;
    NetHTTPRequest1: TNetHTTPRequest;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnLimparClick(Sender: TObject);
    procedure BtnConsultarClick(Sender: TObject);
  private
    function GerarTokenBasic(const Usuario, Senha: string): string;
    function FormatJson(const JsonString: string): string;
    function LimparTexto(const Text: string): string;
  public
    { Public declarations }
  end;

var
  ConsultaOcorrenciaBraspress: TConsultaOcorrenciaBraspress;

implementation

{$R *.dfm}

function TConsultaOcorrenciaBraspress.LimparTexto(const Text: string): string;
begin
  Result := StringReplace(Text, '.', '', [rfReplaceAll]);
  Result := StringReplace(Result, '-', '', [rfReplaceAll]);
  Result := StringReplace(Result, '/', '', [rfReplaceAll]);
  Result := StringReplace(Result, ' ', '', [rfReplaceAll]);
end;

function TConsultaOcorrenciaBraspress.GerarTokenBasic(const Usuario, Senha: string): string;
var
  Credenciais: string;
begin
  Credenciais := Usuario + ':' + Senha;
  Result := TNetEncoding.Base64.Encode(Credenciais);
end;

function TConsultaOcorrenciaBraspress.FormatJson(const JsonString: string): string;
var
  JSONValue: TJSONValue;
begin
  JSONValue := TJSONObject.ParseJSONValue(JsonString);
  try
    if JSONValue <> nil then
      Result := JSONValue.Format(2)  // Formata com 2 espa�os de indenta��o
    else
      Result := JsonString; // Retorna o original se n�o for JSON v�lido
  finally
    JSONValue.Free;
  end;
end;

procedure TConsultaOcorrenciaBraspress.BtnConsultarClick(Sender: TObject);
var
  HttpClient: TNetHTTPClient;
  Response: IHTTPResponse;
  Token, URL, JsonResponse: string;
begin
  HttpClient := TNetHTTPClient.Create(nil);
  try
    Token := GerarTokenBasic(Trim(EditUsuario.Text), Trim(EditSenha.Text));

    URL := 'https://api.braspress.com/v3/tracking/byNf/' +
           Trim(LimparTexto(EditCNPJ.Text)) + '/' +
           Trim(EditNumeroNF.Text) + '/json';

    HttpClient.CustomHeaders['Authorization'] := 'Basic ' + Token;

    try
      Response := HttpClient.Get(URL);

      JsonResponse := FormatJson(Response.ContentAsString);
      DadosOcorrenciaBraspress.Lines.Text := JsonResponse;

      DadosOcorrenciaBraspress.Lines.Add('');
      DadosOcorrenciaBraspress.Lines.Add('');
      DadosOcorrenciaBraspress.Lines.Add('=== PAYLOAD DA REQUISI��O ENVIADA PARA CONFER�NCIA ===');
      DadosOcorrenciaBraspress.Lines.Add('M�todo: GET');
      DadosOcorrenciaBraspress.Lines.Add('URL: ' + URL);
      DadosOcorrenciaBraspress.Lines.Add('Authorization: Basic ' + Token);

    except
      on E: ENetHTTPClientException do
      begin
        DadosOcorrenciaBraspress.Lines.Text := 'Erro na requisi��o: ' + E.Message;
      end;
      on E: Exception do
      begin
        DadosOcorrenciaBraspress.Lines.Text := 'Erro inesperado: ' + E.Message;
      end;
    end;

  finally
    HttpClient.Free;
  end;
end;

procedure TConsultaOcorrenciaBraspress.BtnLimparClick(Sender: TObject);
begin
  EditUsuario.Clear;
  EditSenha.Clear;
  EditCNPJ.Clear;
  EditNumeroNF.Clear;
  DadosOcorrenciaBraspress.Clear;
  EditUsuario.SetFocus;
end;

procedure TConsultaOcorrenciaBraspress.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

end.

