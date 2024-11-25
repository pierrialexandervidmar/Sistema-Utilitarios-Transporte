unit View.AutenticarTotalExpress;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent, System.JSON,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TTesteAutenticacaoTotalExpress = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    DadosAutenticacaoTotal: TMemo;
    Label4: TLabel;
    Label3: TLabel;
    EditUsuario: TEdit;
    EditSenha: TEdit;
    EditAPIKey: TEdit;
    EditToken: TEdit;
    BtnConsultar: TButton;
    BtnLimpar: TButton;
    Label5: TLabel;
    NetHTTPClient1: TNetHTTPClient;
    NetHTTPRequest1: TNetHTTPRequest;
    Image1: TImage;
    procedure BtnConsultarClick(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    function FormatJson(const JsonString: string): string;
  public
    { Public declarations }
  end;

var
  TesteAutenticacaoTotalExpress: TTesteAutenticacaoTotalExpress;

implementation

{$R *.dfm}

procedure TTesteAutenticacaoTotalExpress.BtnLimparClick(Sender: TObject);
begin
  EditUsuario.Clear;
  EditSenha.Clear;
  EditAPIKey.Clear;
  EditToken.Clear;
  DadosAutenticacaoTotal.Clear;
  EditUsuario.SetFocus;
end;

function TTesteAutenticacaoTotalExpress.FormatJson(const JsonString: string): string;
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

procedure TTesteAutenticacaoTotalExpress.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

procedure TTesteAutenticacaoTotalExpress.BtnConsultarClick(Sender: TObject);
var
  Response: IHTTPResponse;
  BodyJSON: TJSONObject;
  UserFormatatado, PasswordFormatado, ApiKeyFormatado, TokenFormatado: string;

begin
  DadosAutenticacaoTotal.Lines.Add('Consultando...');

  UserFormatatado := Trim(StringReplace(EditUsuario.Text, ' ', '', [rfReplaceAll]));
  PasswordFormatado := Trim(StringReplace(EditSenha.Text, ' ', '', [rfReplaceAll]));
  ApiKeyFormatado := Trim(StringReplace(EditAPIKey.Text, ' ', '', [rfReplaceAll]));
  TokenFormatado := Trim(StringReplace(EditToken.Text, ' ', '', [rfReplaceAll]));

  NetHTTPRequest1.Client := NetHTTPClient1;

  // Montando o corpo da requisi��o JSON
  BodyJSON := TJSONObject.Create;

  try
  try
    BodyJSON.AddPair('grant_type', 'password');
    BodyJSON.AddPair('username', UserFormatatado);
    BodyJSON.AddPair('password', PasswordFormatado);

    // Enviando a requisi��o POST
    NetHTTPRequest1.CustomHeaders['Content-Type'] := 'application/json';
    NetHTTPRequest1.CustomHeaders['apikey'] := ApiKeyFormatado;
    NetHTTPRequest1.CustomHeaders['token'] := TokenFormatado;

    Response := NetHTTPRequest1.Post('https://api.godigibee.io/pipeline/totalexpress/v1/plataformas/encomendas/oauth', TStringStream.Create(BodyJSON.ToString));

    // Verificando o c�digo de resposta
    if Response.StatusCode = 200 then
    begin
      DadosAutenticacaoTotal.Lines.Add('Autentica��o Realizada com Suscesso!');
      DadosAutenticacaoTotal.Lines.Add('');
      DadosAutenticacaoTotal.Lines.Add(FormatJson(Response.ContentAsString));
    end
    else
    begin
      DadosAutenticacaoTotal.Lines.Add('Erro ao realizar autentica��o: ' + Response.StatusText);
    end;
    except
      on E: Exception do
      begin
        // Tratamento de erro
        DadosAutenticacaoTotal.Lines.Add('Ocorreu um erro durante a consulta: ' + E.Message);
      end;
    end;

  finally
    BodyJSON.Free;
  end;

end;


end.
