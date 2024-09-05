unit View.ConsultaOcorrenciaBuslog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.JSON, System.Net.HttpClient,
  System.Net.URLClient, System.Net.HttpClientComponent, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  TConsultaOcorrenciaBuslog = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    EditToken: TEdit;
    EditChaveNf: TEdit;
    BtnConsultar: TButton;
    BtnLimpar: TButton;
    MemoDadosBuslog: TMemo;
    Label3: TLabel;
    NetHTTPClient1: TNetHTTPClient;
    NetHTTPRequest1: TNetHTTPRequest;
    Image1: TImage;
    procedure BtnConsultarClick(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    function ObterSessao(const Token: string): string;
    function FormatJson(const JsonString: string): string;
    procedure ConsultarOcorrencias(const Sessao, ChaveNF: string);
  public
    { Public declarations }
  end;

var
  ConsultaOcorrenciaBuslog: TConsultaOcorrenciaBuslog;

implementation

{$R *.dfm}

function TConsultaOcorrenciaBuslog.FormatJson(const JsonString: string): string;
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

// Função para obter a sessão utilizando o token
function TConsultaOcorrenciaBuslog.ObterSessao(const Token: string): string;
var
  Response: IHTTPResponse;
  SessaoJSON: TJSONObject;
  Sessao: string;
begin
  MemoDadosBuslog.Lines.Add('Consultando Sessão...');

  // Realizando a requisição GET para obter a sessão
  Response := NetHTTPRequest1.Get('http://api.track3r.com.br/v2/api/Autenticacao?token=' + Token);

  // Verificando o código de resposta
  if Response.StatusCode = 200 then
  begin
    // Parse da resposta JSON para extrair a sessão
    SessaoJSON := TJSONObject.ParseJSONValue(Response.ContentAsString) as TJSONObject;
    try
      Sessao := SessaoJSON.GetValue<string>('sessao');
      MemoDadosBuslog.Lines.Add('Sessão obtida: ' + Sessao);
      Result := Sessao;
    finally
      SessaoJSON.Free;
    end;
  end
  else
  begin
    MemoDadosBuslog.Lines.Add('Erro ao obter Sessão: ' + Response.StatusText);
    Result := '';
  end;
end;

// Procedimento para consultar ocorrências usando a Sessão e a Chave NF
procedure TConsultaOcorrenciaBuslog.ConsultarOcorrencias(const Sessao, ChaveNF: string);
var
  Response: IHTTPResponse;
  BodyJSON: TJSONObject;
  PedidosArray: TJSONArray;
begin
  MemoDadosBuslog.Lines.Add('Consultando Ocorrências...');

  // Montando o corpo da requisição JSON
  BodyJSON := TJSONObject.Create;
  try
    BodyJSON.AddPair('Sessao', Sessao);
    BodyJSON.AddPair('CodigoServico', TJSONNumber.Create(1));

    // Criando o array de pedidos
    PedidosArray := TJSONArray.Create;
    PedidosArray.AddElement(TJSONObject.Create.AddPair('ChaveNfe', ChaveNF));
    BodyJSON.AddPair('Pedidos', PedidosArray);

    // Enviando a requisição POST
    NetHTTPRequest1.CustomHeaders['Content-Type'] := 'application/json';
    Response := NetHTTPRequest1.Post('http://api.track3r.com.br/v2/api/Tracking', TStringStream.Create(BodyJSON.ToString));

    // Verificando o código de resposta
    if Response.StatusCode = 200 then
    begin
      MemoDadosBuslog.Lines.Add('Ocorrências encontradas:');
      MemoDadosBuslog.Lines.Add(FormatJson(Response.ContentAsString));
    end
    else
    begin
      MemoDadosBuslog.Lines.Add('Erro ao consultar ocorrências: ' + Response.StatusText);
    end;

  finally
    BodyJSON.Free;
  end;
end;

procedure TConsultaOcorrenciaBuslog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

// Evento de clique no botão Consultar
procedure TConsultaOcorrenciaBuslog.BtnConsultarClick(Sender: TObject);
var
  Token, ChaveNF, Sessao: string;
begin
  MemoDadosBuslog.Clear;

  // Pegando os valores inseridos nos edits
  Token := Trim(EditToken.Text);
  ChaveNF := Trim(EditChaveNf.Text);

  // Verificando se o Token e a Chave estão preenchidos
  if (Token = '') or (ChaveNF = '') then
  begin
    MemoDadosBuslog.Lines.Add('Por favor, preencha todos os campos.');
    Exit;
  end;

  // Obter a Sessão
  Sessao := ObterSessao(Token);
  if Sessao = '' then
  begin
    MemoDadosBuslog.Lines.Add('Erro ao obter a sessão. Verifique o token.');
    Exit;
  end;

  // Consultar as ocorrências com a Chave NF e a Sessão obtida
  ConsultarOcorrencias(Sessao, ChaveNF);
end;

// Evento de clique no botão Limpar
procedure TConsultaOcorrenciaBuslog.BtnLimparClick(Sender: TObject);
begin
  // Limpa todos os campos
  EditToken.Clear;
  EditChaveNf.Clear;
  MemoDadosBuslog.Clear;
end;

end.

