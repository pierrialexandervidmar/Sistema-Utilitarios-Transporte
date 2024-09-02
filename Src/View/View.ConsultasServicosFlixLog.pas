unit View.ConsultasServicosFlixLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.JSON;

type
  TConsultasServicosFlixLog = class(TForm)
    EditToken: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EditCepOrigem: TEdit;
    BtnConsultar: TButton;
    BtnLimpar: TButton;
    Label3: TLabel;
    DadosRespostaFlixlog: TMemo;
    Image1: TImage;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnConsultarClick(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConsultasServicosFlixLog: TConsultasServicosFlixLog;

implementation

{$R *.dfm}



procedure TConsultasServicosFlixLog.BtnConsultarClick(Sender: TObject);
var
  TokenFormatado, CEPOrigemFormatado: string;
begin
  // Lê o Token e o Cep de origem a partir dos Edit components e formata
  TokenFormatado := StringReplace(EditToken.Text, ' ', '', [rfReplaceAll]);

  CEPOrigemFormatado := StringReplace(EditCepOrigem.Text, '.', '', [rfReplaceAll]);
  CEPOrigemFormatado := StringReplace(CEPOrigemFormatado, '-', '', [rfReplaceAll]);
  CEPOrigemFormatado := StringReplace(CEPOrigemFormatado, '/', '', [rfReplaceAll]);
  CEPOrigemFormatado := StringReplace(CEPOrigemFormatado, ' ', '', [rfReplaceAll]);

  // Configura o RESTClient com a URL base
  RESTClient1.BaseURL := 'https://freight.flixlog.com/quotation';

  // Configura o RESTRequest com o método POST
  RESTRequest1.Method := rmPOST;

  // Limpa quaisquer parâmetros existentes
  RESTRequest1.Params.Clear;

  // Adiciona o cabeçalho de autorização com o token fornecido
  RESTRequest1.Params.AddHeader('Authorization', 'Token ' + TokenFormatado);
  RESTRequest1.Params.AddHeader('Content-Type', 'application/json');

  // Configura o corpo da requisição JSON
  // RESTRequest1.Body.Clear;
  RESTRequest1.Body.Add(
    Format(
      '{' +
      '"from": "%s",' +
      '"to": "01501010",' +
      '"parcels": [' +
      '{' +
      '"width": 0.10,' +
      '"length": 0.60,' +
      '"height": 0.10,' +
      '"weight": 0.10,' +
      '"quantity": 1,' +
      '"cargo_value": 0.2,' +
      '"reference": "TRAMFE010"' +
      '}' +
      '],' +
      '"show_all": true' +
      '}',
      [CEPOrigemFormatado]
    ), TRESTContentType.ctAPPLICATION_JSON
  );

  // Associa a resposta ao componente RESTResponse
  RESTRequest1.Response := RESTResponse1;

  try
    // Executa a requisição
    RESTRequest1.Execute;

    // Exibe a resposta no componente Memo
    DadosRespostaFlixlog.Lines.Text := RESTResponse1.Content;
  except
    on E: ERESTException do
    begin
      ShowMessage('Erro na requisição: ' + E.Message);
    end;
  end;
end;

procedure TConsultasServicosFlixLog.BtnLimparClick(Sender: TObject);
begin
  EditToken.Clear;
  EditCepOrigem.Clear;
  DadosRespostaFlixlog.Clear;
  EditToken.SetFocus;
end;

procedure TConsultasServicosFlixLog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

end.
