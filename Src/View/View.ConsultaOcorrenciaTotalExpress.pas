unit View.ConsultaOcorrenciaTotalExpress;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, System.Net.URLClient, System.Net.HttpClient, System.JSON, System.NetEncoding,
  System.Net.HttpClientComponent;

type
  TConsultaOcorrenciaTotalExpress = class(TForm)
    DadosOcorrenciaTotal: TMemo;
    Label2: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EditUsuario: TEdit;
    EditSenha: TEdit;
    EditREID: TEdit;
    EditNumeroNF: TEdit;
    Label7: TLabel;
    BtnConsultar: TButton;
    BtnLimpar: TButton;
    Image1: TImage;
    NetHTTPClient1: TNetHTTPClient;
    NetHTTPRequest1: TNetHTTPRequest;
    NetHTTPClient2: TNetHTTPClient;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnConsultarClick(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
  private
    { Private declarations }
    function FormatJson(const JsonString: string): string;
    function GerarTokenBasic(const Usuario, Senha: string): string;
  public
    { Public declarations }
  end;

var
  ConsultaOcorrenciaTotalExpress: TConsultaOcorrenciaTotalExpress;

implementation

{$R *.dfm}

procedure TConsultaOcorrenciaTotalExpress.BtnLimparClick(Sender: TObject);
begin
  EditUsuario.Clear;
  EditSenha.Clear;
  EditREID.Clear;
  EditNumeroNF.Clear;
  EditUsuario.SetFocus;
end;

function TConsultaOcorrenciaTotalExpress.FormatJson(const JsonString: string): string;
var
  JSONValue: TJSONValue;
begin
  JSONValue := TJSONObject.ParseJSONValue(JsonString);
  try
    if JSONValue <> nil then
      Result := JSONValue.Format(2)  // Formata com 2 espaços de indentação
    else
      Result := JsonString; // Retorna o original se não for JSON válido
  finally
    JSONValue.Free;
  end;
end;

function TConsultaOcorrenciaTotalExpress.GerarTokenBasic(const Usuario, Senha: string): string;
var
  Credenciais: string;
begin
  Credenciais := Usuario + ':' + Senha;
  Result := TNetEncoding.Base64.Encode(Credenciais);
end;

procedure TConsultaOcorrenciaTotalExpress.BtnConsultarClick(Sender: TObject);
var
  Response: IHTTPResponse;
  BodyJSON: TJSONObject;
  UserFormatatado, REIDFormatado, PasswordFormatado, Token, NumeroNotaFormatado: string;

begin
  DadosOcorrenciaTotal.Lines.Add('Consultando...');

  UserFormatatado := Trim(StringReplace(EditUsuario.Text, ' ', '', [rfReplaceAll]));
  PasswordFormatado := Trim(StringReplace(EditSenha.Text, ' ', '', [rfReplaceAll]));
  REIDFormatado := Trim(StringReplace(EditREID.Text, ' ', '', [rfReplaceAll]));
  NumeroNotaFormatado := Trim(StringReplace(EditNumeroNF.Text, ' ', '', [rfReplaceAll]));

  NetHTTPRequest1.Client := NetHTTPClient1;

  // Montando o corpo da requisição JSON
  BodyJSON := TJSONObject.Create;

  try
  try

    Token := GerarTokenBasic(UserFormatatado, PasswordFormatado);

    BodyJSON.AddPair('remetenteId', REIDFormatado);
    BodyJSON.AddPair('nfiscal', NumeroNotaFormatado);

    // Enviando a requisição POST
    NetHTTPRequest1.CustomHeaders['Content-Type'] := 'application/json';
    NetHTTPRequest1.CustomHeaders['Authorization'] := 'Basic ' + Token;

    Response := NetHTTPRequest1.Post('https://edi.totalexpress.com.br/previsao_entrega_atualizada.php', TStringStream.Create(BodyJSON.ToString));

    // Verificando o código de resposta
    if Response.StatusCode = 200 then
    begin
      DadosOcorrenciaTotal.Lines.Add('Ocorrência Localizada com Suscesso!');
      DadosOcorrenciaTotal.Lines.Add('');
      DadosOcorrenciaTotal.Lines.Add(FormatJson(Response.ContentAsString));
    end
    else
    begin
      DadosOcorrenciaTotal.Lines.Add('Erro ao realizar busca: ' + Response.StatusText);
    end;
    except
      on E: Exception do
      begin
        // Tratamento de erro
        DadosOcorrenciaTotal.Lines.Add('Ocorreu um erro durante a consulta: ' + E.Message);
      end;
    end;

  finally
    BodyJSON.Free;
  end;

end;

procedure TConsultaOcorrenciaTotalExpress.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

end.
