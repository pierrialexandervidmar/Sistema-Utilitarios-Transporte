unit View.ConsultaServicosKangu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  TConsultaServicosKangu = class(TForm)
    EditToken: TEdit;
    Label1: TLabel;
    DadosRespostaKangu: TMemo;
    Label2: TLabel;
    BtnConsultar: TButton;
    BtnLimpar: TButton;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Image1: TImage;
    procedure BtnLimparClick(Sender: TObject);
    procedure BtnConsultarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConsultaServicosKangu: TConsultaServicosKangu;

implementation

{$R *.dfm}

procedure TConsultaServicosKangu.BtnConsultarClick(Sender: TObject);
var
  TokenLimpo: string;
begin
  DadosRespostaKangu.Clear;
  try
    TokenLimpo := StringReplace(EditToken.Text, ' ', '', [rfReplaceAll]);

    // Definir a URL base do cliente REST
    RESTClient1.BaseURL := 'https://portal.kangu.com.br/tms/transporte/servicos';

    // Limpar parâmetros existentes para evitar conflitos
    RESTRequest1.Params.Clear;

    // Adicionar parâmetros de header
    RESTRequest1.Params.AddItem('User-Agent', 'insomnia/9.3.3', TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);
    RESTRequest1.Params.AddItem('token', TokenLimpo, TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);

    // Definir o método de requisição como GET
    RESTRequest1.Method := TRESTRequestMethod.rmGET;


    // Tentamos fazer a requisição
    try
      // Executar a requisição REST
      RESTRequest1.Execute;

      if RESTResponse1.StatusCode = 200 then
      begin
        DadosRespostaKangu.Lines.Add(RESTRequest1.Response.JSONText);
      end
      else
      begin
         DadosRespostaKangu.Lines.Add('Dados inválidos -> Código de status: ' + IntToStr(RESTResponse1.StatusCode));
      end;

    except
      on E: ERESTException do
      begin
        DadosRespostaKangu.Lines.Add('Dados inválidos -> ' + E.Message);
      end;
      on E: Exception do
      begin
        DadosRespostaKangu.Lines.Add('Dados inválidos! -> ' + E.Message);
      end;
    end;
  finally

  end;

end;

procedure TConsultaServicosKangu.BtnLimparClick(Sender: TObject);
begin
  EditToken.Clear;
  DadosRespostaKangu.Clear;
  EditToken.SetFocus;
end;

procedure TConsultaServicosKangu.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

end.
