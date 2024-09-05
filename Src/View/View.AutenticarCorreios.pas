unit View.AutenticarCorreios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, System.JSON, System.NetEncoding, System.Net.HttpClient,
  System.Net.HttpClientComponent, System.Net.URLClient;

type
  TAutenticarCorreios = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EditUsuario: TEdit;
    EditToken: TEdit;
    EditCartaoPostagem: TEdit;
    Button1: TButton;
    Button2: TButton;
    DadosCredencial: TMemo;
    Label4: TLabel;
    Image1: TImage;
    NetHTTPClient1: TNetHTTPClient;
    NetHTTPRequest1: TNetHTTPRequest;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    function GerarTokenBasic(const Usuario, Senha: string): string;
    function FormatJson(const JsonString: string): string;
    procedure ExecutarAutenticacao;
  public
    { Public declarations }
  end;

var
  AutenticarCorreios: TAutenticarCorreios;

implementation

{$R *.dfm}

function TAutenticarCorreios.GerarTokenBasic(const Usuario, Senha: string): string;
var
  Credenciais: string;
begin
  Credenciais := Usuario + ':' + Senha;
  Result := TNetEncoding.Base64.Encode(Credenciais);
end;

function TAutenticarCorreios.FormatJson(const JsonString: string): string;
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

procedure TAutenticarCorreios.Button2Click(Sender: TObject);
begin
  EditUsuario.Clear;
  EditToken.Clear;
  EditCartaoPostagem.Clear;
  DadosCredencial.Clear;
  EditUsuario.SetFocus;
end;

procedure TAutenticarCorreios.ExecutarAutenticacao;
var
  JSONBody: TJSONObject;
  Token, ResponseText, JsonResponse: string;
  Response: IHTTPResponse;
begin
  DadosCredencial.Clear;

  // Gerar token de autentica��o Basic
  Token := GerarTokenBasic(Trim(EditUsuario.Text), Trim(EditToken.Text));

  // Criar o corpo JSON
  JSONBody := TJSONObject.Create;
  try
    JSONBody.AddPair('numero', EditCartaoPostagem.Text);

    // Configurar a requisi��o HTTP
    NetHTTPClient1.ContentType := 'application/json';
    NetHTTPRequest1.CustomHeaders['Authorization'] := 'Basic ' + Token;

    try
      // Executar a requisi��o POST
      Response := NetHTTPRequest1.Post('https://api.correios.com.br/token/v1/autentica/cartaopostagem', TStringStream.Create(JSONBody.ToString));

      // Exibir a resposta
      ResponseText := Response.ContentAsString();

      // Verificar o c�digo de status da resposta
      if Response.StatusCode = 201 then
      begin
        // Autentica��o bem-sucedida
        DadosCredencial.Lines.Add('==== AUTENTICADO COM SUCESSO ====');
        JsonResponse := FormatJson(ResponseText);
        DadosCredencial.Lines.Add(JsonResponse);
      end
      else
      begin
        // Falha de autentica��o
        DadosCredencial.Lines.Add('Falha de autentica��o. Status: ' + Response.StatusCode.ToString);
        DadosCredencial.Lines.Add('Resposta: ' + FormatJson(ResponseText));
      end;

      // Exibir dados da requisi��o para confer�ncia
      DadosCredencial.Lines.Add('');
      DadosCredencial.Lines.Add('==== REQUISI��O ENVIADA PARA CONFER�NCIA ====');
      DadosCredencial.Lines.Add('Token gerado: ' + Token);
      DadosCredencial.Lines.Add('JSON gerado: ' + FormatJson(JSONBody.ToString));

    except
      on E: ENetHTTPRequestException do
        DadosCredencial.Lines.Add('Falha de autentica��o ou erro na requisi��o: ' + E.Message);
      on E: Exception do
        DadosCredencial.Lines.Add('Falha de autentica��o ou erro na requisi��o: ' + E.Message);
    end;

  finally
    JSONBody.Free;
  end;
end;

procedure TAutenticarCorreios.Button1Click(Sender: TObject);
begin
  // Executar o processo de autentica��o
  ExecutarAutenticacao;
end;

procedure TAutenticarCorreios.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

end.

