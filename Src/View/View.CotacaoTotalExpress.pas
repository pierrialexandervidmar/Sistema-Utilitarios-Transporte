unit View.CotacaoTotalExpress;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
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
  Response: IHTTPResponse;
  BodyJSON: TJSONObject;
begin

  BodyJSON := TJSONObject.Create;

  try
    // Adicionando os dados no objeto Frete
      BodyJSON.AddPair('TipoServico', 'EXP');

      BodyJSON.AddPair('CepDestino', CleanInput(EditCep.Text));
      BodyJSON.AddPair('Peso', Trim(StringReplace(EditPeso.Text, ',', '.', [rfReplaceAll])));
      BodyJSON.AddPair('ValorDeclarado', Trim(StringReplace(EditValor.Text, ',', '.', [rfReplaceAll])));

      BodyJSON.AddPair('Altura', TJSONNumber.Create(StrToFloat(EditAltura.Text)));
      BodyJSON.AddPair('Largura', TJSONNumber.Create(StrToFloat(EditLargura.Text)));
      BodyJSON.AddPair('Profundidade', TJSONNumber.Create(StrToFloat(EditComprimento.Text)));

      NetHTTPRequest1.CustomHeaders['Content-Type'] := 'application/json';
//      NetHTTPRequest1.CustomHeaders['Authorization'] := 'Bearer ' + Trim(DadosCotataoTotalExpress.Lines.Text);

  finally

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
  if key = VK_ESCAPE then
    Close;
end;

end.
