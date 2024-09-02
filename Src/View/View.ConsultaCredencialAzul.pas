unit View.ConsultaCredencialAzul;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.JSON, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls;

type
  TConsultaCredencialAzul = class(TForm)
    Label1: TLabel;
    EditIdentificador: TEdit;
    Label2: TLabel;
    EditSenha: TEdit;
    DadosRespostaAzul: TMemo;
    Label3: TLabel;
    BtnPesquisar: TButton;
    BtnLimpar: TButton;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Image1: TImage;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConsultaCredencialAzul: TConsultaCredencialAzul;

implementation

{$R *.dfm}

procedure TConsultaCredencialAzul.BtnLimparClick(Sender: TObject);
begin
  DadosRespostaAzul.Clear;
  EditIdentificador.Clear;
  EditSenha.Clear;
  EditIdentificador.SetFocus;
end;

procedure TConsultaCredencialAzul.BtnPesquisarClick(Sender: TObject);
var
  JSONBody: TJSONObject;
begin
  DadosRespostaAzul.Clear;

  RESTClient1.BaseURL := 'https://ediapi.onlineapp.com.br/apicoletor/api/Autenticacao';
  // Configurar o método HTTP para POST
  RESTRequest1.Method := TRESTRequestMethod.rmPOST;

  // Definir o tipo de conteúdo como JSON
  RESTRequest1.Params.Clear;
  RESTRequest1.Params.AddItem('body', '', TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);
  RESTRequest1.Params.ParameterByName('body').Value := 'application/json';

  // Criar um objeto JSON para o corpo da requisição
  JSONBody := TJSONObject.Create;
  try
    JSONBody.AddPair('identificacaoUsuario', EditIdentificador.Text);
    JSONBody.AddPair('password', EditSenha.Text);

    // Definir o corpo da requisição
    RESTRequest1.AddBody(JSONBody.ToString, TRESTContentType.ctAPPLICATION_JSON);

    try
      // Executar a requisição
      RESTRequest1.Execute;

      // Verificar o código de status da resposta
      case RESTResponse1.StatusCode of
        200:
          begin
            // Setar a resposta no Memo
            DadosRespostaAzul.Lines.Add(RESTRequest1.Response.JSONText);
          end;
        500:
          begin
            ShowMessage('Usuário ou senha inválidos');
          end;
        else
          begin
            ShowMessage('Erro: Código de status desconhecido (' + IntToStr(RESTResponse1.StatusCode) + ')');
          end;
      end;

    except
      on E: ERESTException do
      begin
        DadosRespostaAzul.Lines.Add('Usuário ou senha inválidos! -> ' + E.Message);
      end;
      on E: Exception do
      begin
        DadosRespostaAzul.Lines.Add('Usuário ou senha inválidos! -> ' + E.Message);
      end;
    end;

  finally
    // Limpar a memória e resetar o estado dos componentes REST
    JSONBody.Free;
    RESTRequest1.Params.Clear;
    RESTRequest1.ClearBody;
    RESTResponse1.ResetToDefaults;
  end;
end;


procedure TConsultaCredencialAzul.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

end.
