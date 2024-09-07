unit View.CotacaoJadlog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, System.JSON;

type
  TCotacaoJadlog = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    EditCNPJ: TEdit;
    EditCepOrigem: TEdit;
    EditCepDestino: TEdit;
    EditPeso: TEdit;
    EditModalidade: TEdit;
    EditValor: TEdit;
    BtnConsultar: TButton;
    BtnLimpar: TButton;
    Label9: TLabel;
    Label10: TLabel;
    MemoTokenJadlog: TMemo;
    DadosJadlog: TMemo;
    Image1: TImage;
    NetHTTPClient1: TNetHTTPClient;
    NetHTTPRequest1: TNetHTTPRequest;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnConsultarClick(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
  private
    function FormatJson(const JsonString: string): string;
    function CleanInput(const AText: string): string;
  public
    { Public declarations }
  end;

var
  CotacaoJadlog: TCotacaoJadlog;

implementation

{$R *.dfm}

procedure TCotacaoJadlog.BtnLimparClick(Sender: TObject);
begin
    // Limpando os campos de entrada
  EditCNPJ.Clear;
  EditCepOrigem.Clear;
  EditCepDestino.Clear;
  EditPeso.Clear;
  EditModalidade.Clear;
  EditValor.Clear;
  MemoTokenJadlog.Clear;
  DadosJadlog.Clear;

  EditCNPJ.SetFocus;
end;

function TCotacaoJadlog.CleanInput(const AText: string): string;
begin
  // Remove pontos, traços e espaços do texto, mantendo apenas números
  Result := Trim(StringReplace(AText, '.', '', [rfReplaceAll]));
  Result := StringReplace(Result, '-', '', [rfReplaceAll]);
  Result := StringReplace(Result, '/', '', [rfReplaceAll]);
  Result := StringReplace(Result, ' ', '', [rfReplaceAll]);
end;

procedure TCotacaoJadlog.BtnConsultarClick(Sender: TObject);
var
  Response: IHTTPResponse;
  BodyJSON, ObjFrete: TJSONObject;
  FreteArray: TJSONArray;
  JSONStream: TStringStream;
begin
  DadosJadlog.Clear;
  // Montando o corpo da requisição JSON
  BodyJSON := TJSONObject.Create;
  FreteArray := TJSONArray.Create;
  ObjFrete := TJSONObject.Create;

  try
    try
      // Adicionando os dados no objeto Frete
      ObjFrete.AddPair('cepori', CleanInput(EditCepOrigem.Text));
      ObjFrete.AddPair('cepdes', CleanInput(EditCepDestino.Text));
      ObjFrete.AddPair('frap', TJSONNull.Create);
      ObjFrete.AddPair('peso', TJSONNumber.Create(StrToFloat(EditPeso.Text)));
      ObjFrete.AddPair('cnpj', CleanInput(EditCNPJ.Text));
      ObjFrete.AddPair('conta', '');
      ObjFrete.AddPair('contrato', TJSONNull.Create);
      ObjFrete.AddPair('modalidade', TJSONNumber.Create(StrToInt(EditModalidade.Text)));
      ObjFrete.AddPair('tpentrega', 'D');
      ObjFrete.AddPair('tpseguro', 'N');
      ObjFrete.AddPair('vldeclarado', TJSONNumber.Create(StrToFloat(EditValor.Text)));
      ObjFrete.AddPair('vlcoleta', TJSONNumber.Create(0));

      // Adicionando o objeto Frete ao array FreteArray
      FreteArray.AddElement(ObjFrete);

      // Adicionando o array Frete ao BodyJSON
      BodyJSON.AddPair('frete', FreteArray);

      // Requisição
      NetHTTPRequest1.CustomHeaders['Content-Type'] := 'application/json';
      NetHTTPRequest1.CustomHeaders['Authorization'] := 'Bearer ' + Trim(MemoTokenJadlog.Lines.Text);

      JSONStream := TStringStream.Create(BodyJSON.ToString, TEncoding.UTF8);
      try
        Response := NetHTTPRequest1.Post('https://www.jadlog.com.br/embarcador/api/frete/valor', JSONStream);

        // Verificando o código de resposta
        if Response.StatusCode = 200 then
        begin
          DadosJadlog.Lines.Add('Resposta:');
          DadosJadlog.Lines.Add(FormatJson(Response.ContentAsString));
        end
        else
        begin
          DadosJadlog.Lines.Add('Erro ao consultar: ' + Response.StatusText);
        end;

      finally
        JSONStream.Free;
      end;

    except
      on E: Exception do
      begin
        // Tratamento de erro
        DadosJadlog.Lines.Add('Ocorreu um erro durante a consulta: ' + E.Message);
      end;
    end;

  finally
    BodyJSON.Free;
  end;
end;

procedure TCotacaoJadlog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

// Função para formatar JSON com indentação
function TCotacaoJadlog.FormatJson(const JsonString: string): string;
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

end.

