unit View.ConsultaOcorrenciaCarriers;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.JSON,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TConsultaOcorrenciaCarriers = class(TForm)
    Label3: TLabel;
    EditChaveNF: TEdit;
    Label1: TLabel;
    MemoToken: TMemo;
    BtnConsultar: TButton;
    BtnLimpar: TButton;
    Label2: TLabel;
    DadosCarriers: TMemo;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Image1: TImage;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnConsultarClick(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
  private
    function CleanInput(const AText: string): string;
    function FormatJson(const JsonString: string): string;
  public
    { Public declarations }
  end;

var
  ConsultaOcorrenciaCarriers: TConsultaOcorrenciaCarriers;

implementation

{$R *.dfm}

function TConsultaOcorrenciaCarriers.CleanInput(const AText: string): string;
begin
  Result := Trim(StringReplace(AText, ' ', '', [rfReplaceAll]));
end;

// Função para formatar JSON com indentação
function TConsultaOcorrenciaCarriers.FormatJson(const JsonString: string): string;
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

procedure TConsultaOcorrenciaCarriers.BtnConsultarClick(Sender: TObject);
var
  chaveNota, token: string;
begin
  // Coleta a chave da nota fiscal e o token da API
  chaveNota := CleanInput(EditChaveNF.Text);
  token := MemoToken.Lines.Text.Trim;

  // Define a URL base
  RESTClient1.BaseURL := 'http://api.carriers.com.br/client/Carriers/searchTracking';

  // Limpa parâmetros antigos e adiciona o parâmetro ChaveNota
  RESTRequest1.Params.Clear;
  RESTRequest1.AddParameter('ChaveNota', chaveNota, pkGETorPOST);

  // Define o cabeçalho de autorização com o token Bearer
  RESTRequest1.Params.AddItem('Authorization', 'Bearer ' + token, pkHTTPHEADER, [poDoNotEncode]);

  // Executa a requisição
  try
    RESTRequest1.Execute;
    DadosCarriers.Lines.Text := FormatJson(RESTResponse1.Content); // Exibe a resposta no Memo
  except
    on E: Exception do
      DadosCarriers.Lines.Text := 'Erro: ' + E.Message;
  end;
end;

procedure TConsultaOcorrenciaCarriers.BtnLimparClick(Sender: TObject);
begin
  EditChaveNF.Clear;
  MemoToken.Clear;
  DadosCarriers.Clear;
  EditChaveNF.SetFocus;
end;

procedure TConsultaOcorrenciaCarriers.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

end.
