unit View.CotacaoOpenlogEngloba;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.JSON;

type
  TCotacaoOpenlogEngloba = class(TForm)
    Label3: TLabel;
    Label1: TLabel;
    EditCep: TEdit;
    EditValor: TEdit;
    Label2: TLabel;
    Label4: TLabel;
    EditPeso: TEdit;
    EditAltura: TEdit;
    Label5: TLabel;
    EditLargura: TEdit;
    Label6: TLabel;
    EditComprimento: TEdit;
    Label7: TLabel;
    MemoTokenAPI: TMemo;
    Image1: TImage;
    Label8: TLabel;
    DadosOpenlog: TMemo;
    BtnConsultar: TButton;
    BtnLimpar: TButton;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnConsultarClick(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
  private
    function FormatJson(const JsonString: string): string;
    function CleanInput(const AText: string): string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CotacaoOpenlogEngloba: TCotacaoOpenlogEngloba;

implementation
{$R *.dfm}

procedure TCotacaoOpenlogEngloba.BtnLimparClick(Sender: TObject);
begin
  EditCep.Clear;
  EditValor.Clear;
  EditPeso.Clear;
  EditAltura.Clear;
  EditLargura.Clear;
  EditComprimento.Clear;

  MemoTokenAPI.Clear;
  DadosOpenlog.Clear;

  EditCep.SetFocus;
end;


function TCotacaoOpenlogEngloba.CleanInput(const AText: string): string;
begin
  // Remove pontos, traços e espaços do texto, mantendo apenas números
  Result := Trim(StringReplace(AText, '.', '', [rfReplaceAll]));
  Result := StringReplace(Result, '-', '', [rfReplaceAll]);
  Result := StringReplace(Result, '/', '', [rfReplaceAll]);
  Result := StringReplace(Result, ' ', '', [rfReplaceAll]);
end;

// Função para formatar JSON com indentação
function TCotacaoOpenlogEngloba.FormatJson(const JsonString: string): string;
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

procedure TCotacaoOpenlogEngloba.BtnConsultarClick(Sender: TObject);
var
  url, peso, valor, altura, largura, comprimento, cep, token: string;
begin
  DadosOpenlog.Clear;

  // Coletando os dados dos edits
  peso := Trim(EditPeso.Text);
  valor := Trim(EditValor.Text);
  altura := Trim(EditAltura.Text);
  largura := Trim(EditLargura.Text);
  comprimento := Trim(EditComprimento.Text);
  cep := CleanInput(EditCep.Text);
  token := MemoTokenAPI.Lines.Text.Trim; // Obtendo o token do Memo

  // Montando a URL base da requisição
  url := 'https://englobasistemas.com.br/financeiro/api/fretes/calcularFrete';

  // Configurando o RESTClient e o RESTRequest
  RESTClient1.BaseURL := url;
  RESTRequest1.Params.Clear;

  // Definindo os parâmetros da requisição
  RESTRequest1.AddParameter('peso', peso);
  RESTRequest1.AddParameter('valor', valor);
  RESTRequest1.AddParameter('altura', altura);
  RESTRequest1.AddParameter('largura', largura);
  RESTRequest1.AddParameter('comprimento', comprimento);
  RESTRequest1.AddParameter('cep', cep);
  RESTRequest1.AddParameter('apikey', token);
  RESTRequest1.AddParameter('local', 'BR');

  // Executando a requisição
  try
    RESTRequest1.Execute;
    DadosOpenlog.Lines.Text := FormatJson(RESTResponse1.Content); // Exibindo a resposta no Memo1
  except
    on E: Exception do
      DadosOpenlog.Lines.Text := 'Erro: ' + E.Message;
  end;
end;


procedure TCotacaoOpenlogEngloba.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

end.
