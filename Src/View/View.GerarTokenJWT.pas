unit View.GerarTokenJWT;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.JSON;

type
  TGerarTokenJWT = class(TForm)
    Label1: TLabel;
    EditToken: TEdit;
    Button1: TButton;
    DadosLink: TMemo;
    Label2: TLabel;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Label3: TLabel;
    EditIdentificador: TEdit;
    BtnLimpar: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnLimparClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GerarTokenJWT: TGerarTokenJWT;

implementation

{$R *.dfm}

procedure TGerarTokenJWT.BtnLimparClick(Sender: TObject);
begin
  EditToken.Clear;
  EditIdentificador.Clear;
  DadosLink.Clear;
  EditIdentificador.SetFocus;
end;

procedure TGerarTokenJWT.Button1Click(Sender: TObject);
var
  JSONResponse: TJSONObject;
  Token, TokenAdminFormatado, IdentificadorFormatado: string;
  URL: string;
begin
  DadosLink.Clear;

  IdentificadorFormatado := Trim(StringReplace(EditIdentificador.Text, ' ', '', [rfReplaceAll]));
  TokenAdminFormatado := Trim(StringReplace(EditToken.Text, ' ', '', [rfReplaceAll]));

  // Configura o RESTClient com a URL base
  RESTClient1.BaseURL := 'https://api-transporte.magazord.com.br/api/autenticar';

  // Configura o m�todo HTTP para POST
  RESTRequest1.Method := rmPOST;

  // Limpa quaisquer par�metros existentes
  RESTRequest1.Params.Clear;

  // Adiciona os cabe�alhos necess�rios
  RESTRequest1.Params.AddHeader('client_id', IdentificadorFormatado);
  RESTRequest1.Params.AddHeader('client_secret', TokenAdminFormatado);

  // Remove qualquer corpo da requisi��o
  RESTRequest1.ClearBody;

  try
    // Executa a requisi��o
    RESTRequest1.Execute;

    // Verifica o c�digo de status da resposta
    case RESTResponse1.StatusCode of
      200:
        begin
          // Analisar o conte�do da resposta JSON
          JSONResponse := TJSONObject.ParseJSONValue(RESTResponse1.Content) as TJSONObject;
          try
            // Extrai o valor do par�metro "token"
            if Assigned(JSONResponse) and JSONResponse.TryGetValue('token', Token) then
            begin
              // Constr�i a URL com o token
              URL := 'https://portal.transportes.magazord.com.br/authToken?token=' + Token;
              // Exibe a URL no Memo
              DadosLink.Lines.Add(URL);
            end
            else
            begin
              DadosLink.Lines.Add('Token n�o encontrado na resposta.');
            end;
          finally
            JSONResponse.Free;
          end;
        end;
      500:
        begin
          ShowMessage('Identificador ou token inv�lidos');
        end;
      else
        begin
          ShowMessage('Erro: C�digo de status desconhecido (' + IntToStr(RESTResponse1.StatusCode) + ')');
        end;
    end;
  except
    on E: ERESTException do
      begin
        DadosLink.Lines.Add('Erro na requisi��o: ' + E.Message);
      end;
    on E: Exception do
      begin
        DadosLink.Lines.Add('Erro inesperado: ' + E.Message);
      end;
  end;

  // Limpa a configura��o dos componentes REST
  RESTRequest1.Params.Clear;
  RESTResponse1.ResetToDefaults;
end;


procedure TGerarTokenJWT.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

end.
