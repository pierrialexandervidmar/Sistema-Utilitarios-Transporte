unit View.ConsultaOcorrenciaJadlog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, System.JSON, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent;

type
  TFormConsultaOcorrenciaJadlog = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EditCNPJ: TEdit;
    EditChaveNF: TEdit;
    BtnConsultar: TButton;
    BtnLimpar: TButton;
    Label4: TLabel;
    DadosRespostaJadlog: TMemo;
    Image1: TImage;
    MemoToken: TMemo;
    NetHTTPClient1: TNetHTTPClient;
    NetHTTPRequest1: TNetHTTPRequest;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnLimparClick(Sender: TObject);
    procedure BtnConsultarClick(Sender: TObject);
  private
    function FormatJson(const JsonString: string): string;
    function CleanInput(const AText: string): string;
  public
    { Public declarations }
  end;

var
  FormConsultaOcorrenciaJadlog: TFormConsultaOcorrenciaJadlog;

implementation

{$R *.dfm}

function TFormConsultaOcorrenciaJadlog.FormatJson(const JsonString: string): string;
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

function TFormConsultaOcorrenciaJadlog.CleanInput(const AText: string): string;
begin
  // Remove pontos, traços e espaços do texto, mantendo apenas números
  Result := Trim(StringReplace(AText, '.', '', [rfReplaceAll]));
  Result := StringReplace(Result, '-', '', [rfReplaceAll]);
  Result := StringReplace(Result, '/', '', [rfReplaceAll]);
  Result := StringReplace(Result, ' ', '', [rfReplaceAll]);
end;

procedure TFormConsultaOcorrenciaJadlog.BtnConsultarClick(Sender: TObject);
var
  Response: IHTTPResponse;
  BodyJSON: TJSONObject;
  ConsultaArray: TJSONArray;
  Df: TJSONObject;
begin
  // Montando o corpo da requisição JSON
  BodyJSON := TJSONObject.Create;
  try
    try
      // Criando o array de consulta
      ConsultaArray := TJSONArray.Create;

      // Criando o objeto df
      Df := TJSONObject.Create;
      Df.AddPair('danfe', CleanInput(EditChaveNF.Text));  // Chave da NF
      Df.AddPair('cnpjRemetente', CleanInput(EditCNPJ.Text)); // CNPJ do remetente

      // Adicionando o objeto df dentro de um novo objeto que será parte do array
      ConsultaArray.AddElement(TJSONObject.Create.AddPair('df', Df));

      // Adicionando o array consulta no objeto BodyJSON
      BodyJSON.AddPair('consulta', ConsultaArray);

      // Requisição
      NetHTTPRequest1.CustomHeaders['Content-Type'] := 'application/json';
      NetHTTPRequest1.CustomHeaders['Authorization'] := 'Bearer ' + Trim(MemoToken.Lines.Text);
      Response := NetHTTPRequest1.Post('https://prd-traffic.jadlogtech.com.br/embarcador/api/tracking/consultar', TStringStream.Create(BodyJSON.ToString));

      // Verificando o código de resposta
      if Response.StatusCode = 200 then
      begin
        DadosRespostaJadlog.Lines.Add('Ocorrências encontradas:');
        DadosRespostaJadlog.Lines.Add(FormatJson(Response.ContentAsString));
      end
      else
      begin
        DadosRespostaJadlog.Lines.Add('Erro ao consultar ocorrências: ' + Response.StatusText);
      end;

    except
      on E: Exception do
      begin
        // Tratamento de erro
        DadosRespostaJadlog.Lines.Add('Ocorreu um erro durante a consulta: ' + E.Message);
      end;
    end;

  finally
    BodyJSON.Free;
  end;
end;



procedure TFormConsultaOcorrenciaJadlog.BtnLimparClick(Sender: TObject);
begin
  EditCNPJ.Clear;
  EditChaveNF.Clear;
  MemoToken.Clear;
  DadosRespostaJadlog.Clear;
  EditCNPJ.SetFocus;
end;

procedure TFormConsultaOcorrenciaJadlog.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

end.
