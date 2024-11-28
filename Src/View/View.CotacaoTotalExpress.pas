unit View.CotacaoTotalExpress;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, System.JSON;

type
  TCotacaoTotalExpress = class(TForm)
    DadosCotataoTotalExpress: TMemo;
    Label9: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    BtnConsultar: TButton;
    BtnLimpar: TButton;
    Image1: TImage;
    EditToken: TEdit;
    EditCep: TEdit;
    EditPeso: TEdit;
    EditValor: TEdit;
    EditAltura: TEdit;
    EditLargura: TEdit;
    EditComprimento: TEdit;
    NetHTTPClient1: TNetHTTPClient;
    NetHTTPRequest1: TNetHTTPRequest;
    Label3: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    EditUsuario: TEdit;
    EditSenha: TEdit;
    EditAPIKey: TEdit;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnConsultarClick(Sender: TObject);
  private
    { Private declarations }
    function FormatJson(const JsonString: string): string;
    function CleanInput(const AText: string): string;
  public
    { Public declarations }
  end;

var
  CotacaoTotalExpress: TCotacaoTotalExpress;

implementation

{$R *.dfm}

procedure TCotacaoTotalExpress.BtnConsultarClick(Sender: TObject);
var
  Response, TokenResponse: IHTTPResponse;
  BodyJSON, TokenSession, BodyJSONAtutenticacao, JSONRequest: TJSONObject;
  RequestStream: TStringStream;
  UserFormatatado, PasswordFormatado, ApiKeyFormatado, TokenFormatado, TokenAuth: string;
begin
  DadosCotataoTotalExpress.Lines.Add('Consultando...');
  try
    // Inicialização
    BodyJSONAtutenticacao := TJSONObject.Create;
    try
      BodyJSONAtutenticacao.AddPair('grant_type', 'password');
      BodyJSONAtutenticacao.AddPair('username', Trim(EditUsuario.Text));
      BodyJSONAtutenticacao.AddPair('password', Trim(EditSenha.Text));

      NetHTTPRequest1.CustomHeaders['Content-Type'] := 'application/json';
      NetHTTPRequest1.CustomHeaders['apikey'] := Trim(EditAPIKey.Text);
      NetHTTPRequest1.CustomHeaders['token'] := Trim(EditToken.Text);

      RequestStream := TStringStream.Create(BodyJSONAtutenticacao.ToString, TEncoding.UTF8);
      try
        TokenResponse := NetHTTPRequest1.Post('https://api.godigibee.io/pipeline/totalexpress/v1/plataformas/encomendas/oauth', RequestStream);
      finally
        RequestStream.Free;
      end;

      if (TokenResponse.StatusCode = 200) then
      begin
        TokenSession := TJSONObject.ParseJSONValue(TokenResponse.ContentAsString) as TJSONObject;
        if Assigned(TokenSession) then
        begin
          try
            TokenAuth := TokenSession.GetValue<string>('access_token');
          finally
            TokenSession.Free;
          end;
        end
        else
          raise Exception.Create('Erro: Resposta inválida.');
      end;

      // Cotação
      BodyJSON := TJSONObject.Create;
      try
        BodyJSON.AddPair('TipoServico', 'EXP');
        BodyJSON.AddPair('CepDestino', CleanInput(EditCep.Text));
        BodyJSON.AddPair('Peso', Trim(EditPeso.Text));
        BodyJSON.AddPair('ValorDeclarado', Trim(EditValor.Text));
        BodyJSON.AddPair('Altura', TJSONNumber.Create(StrToInt(Trim(EditAltura.Text))));
        BodyJSON.AddPair('Largura', TJSONNumber.Create(StrToInt(Trim(EditLargura.Text))));
        BodyJSON.AddPair('Profundidade', TJSONNumber.Create(StrToInt(Trim(EditComprimento.Text))));

        RequestStream := TStringStream.Create(BodyJSON.ToString, TEncoding.UTF8);

        NetHTTPRequest1.CustomHeaders['Content-Type'] := 'application/json';
        NetHTTPRequest1.CustomHeaders['apikey'] := Trim(EditAPIKey.Text);
        NetHTTPRequest1.CustomHeaders['token'] := Trim(EditToken.Text);
        NetHTTPRequest1.CustomHeaders['Authorization'] := TokenAuth;

        JSONRequest := TJSONObject.ParseJSONValue(BodyJSON.ToString) as TJSONObject;
        try
          Response := NetHTTPRequest1.Post('https://api.godigibee.io/pipeline/totalexpress/v1/plataformas/encomendas/cotacaoFrete', RequestStream);
        finally
          RequestStream.Free;
        end;

        if Response.StatusCode = 200 then
          DadosCotataoTotalExpress.Lines.Text := FormatJson(Response.ContentAsString);
          DadosCotataoTotalExpress.Lines.Add('');
          DadosCotataoTotalExpress.Lines.Add('ABAIXO SEGUE PAYLOAD DA REQUISIÇÃO ENVIADA, PARA CONFERÊNCIA: ');
          DadosCotataoTotalExpress.Lines.Add(JSONRequest.Format(2));
      finally
        BodyJSON.Free;
      end;

    finally
      BodyJSONAtutenticacao.Free;
    end;

  except
    on E: Exception do
      DadosCotataoTotalExpress.Lines.Add('Erro: ' + E.Message);
  end;
end;


function TCotacaoTotalExpress.CleanInput(const AText: string): string;
begin
  // Remove pontos, traços e espaços do texto, mantendo apenas números
  Result := Trim(StringReplace(AText, '.', '', [rfReplaceAll]));
  Result := StringReplace(Result, '-', '', [rfReplaceAll]);
  Result := StringReplace(Result, '/', '', [rfReplaceAll]);
  Result := StringReplace(Result, ' ', '', [rfReplaceAll]);
end;

// Função para formatar JSON com indentação
function TCotacaoTotalExpress.FormatJson(const JsonString: string): string;
var
  JsonValue: TJSONValue;
begin
  JsonValue := TJSONObject.ParseJSONValue(JsonString);
  try
    if Assigned(JsonValue) then
      Result := JsonValue.Format(2) // Formata com indentação de 2 espaços
    else
      Result := JsonString; // Caso não seja um JSON válido, retorna o original
  finally
    JsonValue.Free;
  end;
end;

procedure TCotacaoTotalExpress.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

end.
