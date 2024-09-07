unit View.ConsultaOcorrenciaOpenlog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, System.JSON, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, Soap.InvokeRegistry, Soap.Rio,
  Soap.SOAPHTTPClient, Soap.SOAPHTTPTrans;

type
  TConsultaOcorrenciaOpenlog = class(TForm)
    Label2: TLabel;
    Label1: TLabel;
    EditChaveNF: TEdit;
    MemoTokenEngloba: TMemo;
    BtnConsultar: TButton;
    BtnLimpar: TButton;
    Label3: TLabel;
    DadosOpenlog: TMemo;
    Image1: TImage;
    HTTPRIO1: THTTPRIO;
    HTTPReqResp1: THTTPReqResp;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnConsultarClick(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
  private
    function DecodeXML(const AText: string): string;
    function FormatJson(const JsonString: string): string;
    function CleanInput(const AText: string): string;
    function FormatXML(const AText: string): string;
  public
    { Public declarations }
  end;

var
  ConsultaOcorrenciaOpenlog: TConsultaOcorrenciaOpenlog;

implementation

function TConsultaOcorrenciaOpenlog.CleanInput(const AText: string): string;
begin
  // Remove pontos, traços e espaços do texto, mantendo apenas números
  Result := Trim(StringReplace(AText, '.', '', [rfReplaceAll]));
  Result := StringReplace(Result, '-', '', [rfReplaceAll]);
  Result := StringReplace(Result, '/', '', [rfReplaceAll]);
  Result := StringReplace(Result, ' ', '', [rfReplaceAll]);
end;


// Função para formatar JSON com indentação
function TConsultaOcorrenciaOpenlog.FormatJson(const JsonString: string): string;
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


procedure TConsultaOcorrenciaOpenlog.BtnConsultarClick(Sender: TObject);
var
  RequestXML, ResponseXML: TStringStream;
  ResponseStr: string;
begin
  // Limpa e converte valores para garantir que utilizem ponto como separador decimal
  EditChaveNF.Text := Trim(EditChaveNF.Text);
  MemoTokenEngloba.Lines.Text := Trim(MemoTokenEngloba.Lines.Text);

  // Verificação básica dos campos obrigatórios
  if (EditChaveNF.Text = '') or (MemoTokenEngloba.Lines.Text = '') then
  begin
    ShowMessage('Por favor, preencha a Chave NF e o Token de Acesso.');
    Exit;
  end;

  // Monta o XML de requisição
  RequestXML := TStringStream.Create(
    '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" ' +
    'xmlns:eng="https://www.englobasistemas.com.br/">' +
    '<soapenv:Header/>' +
    '<soapenv:Body>' +
      '<eng:ConsultaRastreamentoChaveNfe>' +
         '<eng:chave>' + EditChaveNF.Text + '</eng:chave>' +
         '<eng:chaveAcesso>' + MemoTokenEngloba.Lines.Text + '</eng:chaveAcesso>' +
      '</eng:ConsultaRastreamentoChaveNfe>' +
   '</soapenv:Body>' +
   '</soapenv:Envelope>'
  );

  ResponseXML := TStringStream.Create;

  try
    // Define o URL correto do serviço SOAP
    HTTPRIO1.HTTPWebNode.URL := 'https://englobasistemas.com.br/webservices/pedidos.asmx';

    // Define o valor do cabeçalho SOAPAction
    (HTTPRIO1.HTTPWebNode as THTTPReqResp).SOAPAction := '"https://www.englobasistemas.com.br/ConsultaRastreamentoChaveNfe"';

    // Envia a requisição SOAP
    HTTPRIO1.HTTPWebNode.Execute(RequestXML, ResponseXML);

    // Recebe a resposta como string
    ResponseStr := ResponseXML.DataString;

    // Exibe a resposta no Memo
    ResponseStr := DecodeXML(ResponseStr);
    ResponseStr := FormatXML(ResponseStr);
    DadosOpenlog.Clear;
    DadosOpenlog.Lines.Text := ResponseStr;

  except
    on E: Exception do
      ShowMessage('Erro ao enviar requisição: ' + E.Message);
  end;

  // Libera os objetos TStringStream
  RequestXML.Free;
  ResponseXML.Free;
end;


procedure TConsultaOcorrenciaOpenlog.BtnLimparClick(Sender: TObject);
begin
  EditChaveNF.Clear;
  MemoTokenEngloba.Clear;
  DadosOpenlog.Clear;
  EditChaveNF.SetFocus;
end;

function TConsultaOcorrenciaOpenlog.DecodeXML(const AText: string): string;
begin
  // Decodifica entidades XML para caracteres normais
  Result := StringReplace(AText, '&lt;', '<', [rfReplaceAll]);
  Result := StringReplace(Result, '&gt;', '>', [rfReplaceAll]);
  Result := StringReplace(Result, '&amp;', '&', [rfReplaceAll]);
  Result := StringReplace(Result, '&quot;', '"', [rfReplaceAll]);
end;

function TConsultaOcorrenciaOpenlog.FormatXML(const AText: string): string;
var
  I: Integer;
  IndentLevel: Integer;
  InsideTag: Boolean;
  InTagName: Boolean;
  TagContent: Boolean;
  LastChar: Char;
begin
  Result := '';
  IndentLevel := 0;
  InsideTag := False;
  InTagName := False;
  TagContent := False;
  LastChar := #0;

  for I := 1 to Length(AText) do
  begin
    case AText[I] of
      '<':
        begin
          if InsideTag and TagContent then
          begin
            // Add a line break before starting a new tag
            Result := Result + sLineBreak;
          end;
          if (I > 1) and (AText[I-1] = '>') then
          begin
            // Add a line break before closing tag if it was inside a tag
            Result := Result + sLineBreak;
          end;

          if (I < Length(AText)) and (AText[I+1] = '/') then
          begin
            // Closing tag
            Dec(IndentLevel);
            Result := Result + StringOfChar(' ', IndentLevel * 2) + AText[I];
            InsideTag := True;
            InTagName := False;
            TagContent := False;
          end
          else if (I < Length(AText)) and (AText[I+1] = '?') then
          begin
            // Processing instruction
            Result := Result + StringOfChar(' ', IndentLevel * 2) + AText[I];
            InsideTag := True;
            InTagName := False;
            TagContent := False;
          end
          else
          begin
            // Opening tag
            Result := Result + StringOfChar(' ', IndentLevel * 2) + AText[I];
            Inc(IndentLevel);
            InsideTag := True;
            InTagName := True;
            TagContent := False;
          end;
          LastChar := AText[I];
        end;

      '>':
        begin
          Result := Result + AText[I];
          if InsideTag then
          begin
            InsideTag := False;
            if not TagContent and not InTagName then
            begin
              // Add line break after tag content if it was inside a tag
              Result := Result;
            end;
            TagContent := True;
          end;
          LastChar := AText[I];
        end;

      #10, #13:
        begin
          // Skip line breaks in the source text
          continue;
        end;

      else
        if (LastChar = '>') and (AText[I] = ' ') then
        begin
          // Avoid extra spaces after tags
          continue;
        end;
        Result := Result + AText[I];
        LastChar := AText[I];
    end;
  end;
end;




{$R *.dfm}

procedure TConsultaOcorrenciaOpenlog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

end.
